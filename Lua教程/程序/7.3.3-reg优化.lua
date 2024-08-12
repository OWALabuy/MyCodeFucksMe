--eventobjid, content
ScriptSupportEvent:registerEvent([=[Player.NewInputContent]=], function(e)
    local str = e.content

    local head = string.sub(str, 1, 1)
    if(head == "/")
    then
        --local pattern = "/(%a+)%s(%d+)%s+(%d+)%s+(%d+)"
        local pattern = "/(%a+)%s(%-?%d+)%s+(%-?%d+)%s+(%-?%d+)"
        local order, x, y, z = string.match(str, pattern)
        print(order, x, y, z)

        --处理x, y, z 使它们转换成数值
        x = tonumber(x)
        y = tonumber(y)
        z = tonumber(z)

        Actor:setPosition(e.eventobjid, x, y, z)
    end
end)
