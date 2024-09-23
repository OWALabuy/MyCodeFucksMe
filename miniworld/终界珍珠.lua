--[[思路
1. 监听投掷物击中事件
2. 进行道具种类的判断
3. 将玩家传送到事件的位置
]]

--定义末影珍珠的道具id
local enderPearlId = 11111

--投掷物击中事件 eventobjid toobjid itemid targetactorid x y z helperobjid
ScriptSupportEvent:registerEvent([=[Actor.Projectier.Hit]=], function(e)
    --判断道具种类
    if(e.itemid == enderPearlId)
    then
        --传送事件玩家
        Actor:setPosition(e.helperobjid, e.x, e.y, e.z)
    end
end)
