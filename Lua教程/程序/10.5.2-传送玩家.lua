--和10.5.1一样 监听游戏开始的事件 把指定的玩家(房主)传送到指定的位置


local function gameStart()
    --定义要传送的目标位置
    local x, y, z = 5, 8, 5

    --将玩家传送过去 第一个参数是玩家的迷你号 0代表房主 你也可以写成自己的迷你号
    local result = Actor:setPosition(0, x, y, z)
end

--注册游戏开始的监听器 保证这个放置方块的动作被执行
ScriptSupportEvent:registerEvent([=[Game.Start]=], gameStart)
