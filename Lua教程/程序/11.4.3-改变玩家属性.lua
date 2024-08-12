local function playerNewInputContent(event)
    --检测玩家手持的道具
    local result, toolid = Player:getCurToolID(event.eventobjid)

    --如果玩家手持的是指定道具(这里是草块 id为100) 进行下一步的判定
    if(toolid == 100) then
        --判断玩家的输入内容
        if(event.content == "a") then
            --增加移动速度 这里的PLAYERATTR.WALK_SPEED是玩家属性的枚举值 代表玩家的移动速度 值是10 可以在官方文档中查阅所有属性对应的枚举值
            Player:setAttr(event.eventobjid, PLAYERATTR.WALK_SPEED, 50)
        elseif event.content == 'b' then
            --使玩家模型变大
            Player:setAttr(event.eventobjid, PLAYERATTR.DIMENSION, 2)
        elseif event.content == [[c]] then
            --回复玩家的血量
            Player:setAttr(event.eventobjid, PLAYERATTR.CUR_HP, 100)
        end
    end
end

--注册玩家在聊天框输入字符串的监听器
ScriptSupportEvent:registerEvent([=[Player.NewInputContent]=], playerNewInputContent)

