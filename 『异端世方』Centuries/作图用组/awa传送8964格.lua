ScriptSupportEvent:registerEvent([=[Player.NewInputContent]=],function(e)
    if(e.content == "awa")
    then
        local code, pos = Actor:getPositionV2(e.eventobjid)
        Actor:setPosition(e.eventobjid,pos.x,pos.y,pos.z+64)
    end 
end )
