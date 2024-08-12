--定义格式化的字符串模板
local formatStr = "生物名称: %d, 在存档中的id: %d, actorid: %d"

--定义动作函数
local function displayCreatureInfo(event)
    Chat:sendSystemMsg("一个生物被玩家攻击了")
    --判断被击中的生物是不是玩家 如果不是玩家 则可以进入这个逻辑
    local result = Actor:isPlayer(event.toobjid)
    if(result == 0)
    then
        Chat:sendSystemMsg("这是玩家")
    else
        --根据id获取它的actorid
        local result, actorId = Creature:getActorID(event.toobjid)
        
        --获取它的名字
        local result, name = Creature:getMonsterDefName(actorId)

        --使用字符串格式化 将这些信息生成一个用于输出的字符串
        local str = string.format(formatStr, name, event.toobjid, actorId)

        --将信息打印到聊天框和控制台
        print(str)
        Chat:sendSystemMsg(str)
    end
end

ScriptSupportEvent:registerEvent([=[Player.AttackHit]=], displayCreatureInfo)