--设定方块相关信息的表
local replace_info = {
    before = {
        { id = 677, data = 12 },
        { id = 676, data = 10 },
    },
    after = {
        id = 681, data = 6
    }
}
--检测一个方块的id和data是不是替换的目标方块 参数是id和data 返回值是一个布尔值
local function replace_judge(id, data)
    for key, blo in pairs(replace_info.before) do
        if id == blo.id then
            if data == blo.data then
                return true
            end
        end
    end
    return false
end

--玩家离开区域 eventobjid areaid
ScriptSupportEvent:registerEvent([=[Player.AreaOut]=], function(e)
    --判断区域的id是不是指定的id (你把这里改成你地图中指定的区域id 或者存储区域id的变量)
    if e.areaid ~= 12345 then
        return 0 --不是指定的id 结束这个函数
    end
    --获取指定区域的起点和终点坐标
    local result, posBeg, posEnd = Area:getAreaRectRange(e.areaid)

    --获取区域的方向
    local xdir, ydir, zdir = 1, 1, 1
    if posBeg.x > posEnd.x then
        xdir = -1
    end
    if posBeg.y > posEnd.y then
        ydir = -1
    end
    if posBeg.z > posEnd.z then
        zdir = -1
    end

    --遍历这个区域
    for x = posBeg.x, posEnd.x, xdir do
        for y = posBeg.y, posEnd.y, ydir do
            for z = posBeg.z, posEnd.z, zdir do
                --获取当前方块的id和data
                local result, id = Block:getBlockID(x, y, z)
                local result, data = Block:getBlockData(x, y, z)

                --若当前方块需要替换 则替换之
                if replace_judge(id, data) then
                    local result = Block:setBlockAll(x, y, z, replace_info.after.id, replace_info.after.data)
                end
            end
        end
    end
end)
