local function awa(e)
    print(e.eventobjid, toobjid, actorid)
end

ScriptSupportEvent:registerEvent([=[Player.MoveOneBlockSize]=], awa)
