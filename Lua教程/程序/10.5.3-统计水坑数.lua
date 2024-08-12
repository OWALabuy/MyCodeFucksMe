--[[10.5.3 统计水坑数/dfs
在演示视频中 草地的范围(x, z)是0到9 y是6
在这个代码中 我们先定义好dfs的函数和相关的变量 再通过注册游戏开始的事件的监听器来调用这个函数
]]

--创建算法中需要的一些变量

--用于记录访问情况的二维表
local visitedTable = {}

--采用循环为这个表创建子元素
for i = 0, 9 do
    visitedTable[i] = {}
end

--dfs所用的方向表 分别是当前方块的北 南 西 东
local direction = {
    {x = 1, z = 0},
    {x = -1, z = 0},
    {x = 0, z = 1},
    {x = 0, z = -1},
}

--全局变量Y 也算是常量了
Y = 6

--水坑的计数 也是全局变量 默认是0
Count = 0

--DFS函数 参数是当前方块的x坐标和z坐标
local function DFS(x, z)
    --如果当前检测到的格子超过了范围 就退出这个函数
    if(x < 0 or x > 9 or z < 0 or z > 9) then
        --返回1001 因为ERRORCODE的失败返回码是1001
        return 1001
    end

    --检测当前格子有没有被访问
    if(visitedTable[x][z] == 1)
    then
        --当前格子已经被访问过 直接返回0 结束这个函数
        return 0
    else
        --当前格子没有被访问 将此格子标记为已访问 也就是置为1
        visitedTable[x][z] = 1

        --调用接口 检测当前格子的方块类型
        local result, blockId = Block:getBlockID(x, Y, z)--Y是常量 x和z是来自参数的变量

        --检测当前方块是不是水 静态水id是3 动态水id是4
        if(blockId == 3 or blockId == 4) then
            --如果是水 对其四周方块进行dfs 这可以用到前面定义的那个表
            for key, value in pairs(direction) do
                DFS(x + value.x, z + value.z)
            end
        else
            --如果不是水 直接返回0 结束这个函数
            return 0
        end
    end
end

--编写监听器使用的函数 相当于主流程
local function gameStart()
    --通过二重循环遍历整个草地
    for x = 0, 9 do
        for z = 0, 9 do
            --如果当前格子没有被访问过
            if(visitedTable[x][z] ~= 1) then
                --检测当前方块是不是水
                local result, blockId = Block:getBlockID(x, Y, z)
                if(blockId == 3 or blockId == 4) then
                    --如果是水 将水坑的记数加1 并开始dfs
                    Count = Count + 1
                    DFS(x, z)
                end

                --将此格子标记为已访问
                visitedTable[x][z] = 1
            end
        end
    end

    --将最终得到的水坑数量输出
    Chat:sendSystemMsg(tostring(Count))
end

--注册游戏开始的监听器
ScriptSupportEvent:registerEvent([=[Game.Start]=], gameStart)

