--这虽然是第十章的内容 但是这些接口可能只能在监听器调用时生效 我就单独写出来给大家做参考

local function gameStart()
    --定义要放置方块的地点
    local x, y, z = 5, 8, 5

    --调用放置方块的接口 在预设的位置放置一个id为404的方块(其实是钻石) 最后一个参数是朝向 0西 1东 2南 3北 4下 5上
    local result = Block:placeBlock(404, x, y, z, 0)
end

--注册游戏开始的监听器 保证这个放置方块的动作被执行
ScriptSupportEvent:registerEvent([=[Game.Start]=], gameStart)
