for i = 1, 9
do
    local str = ""
    for j = 1, i do
        str = str .. j .. "*" .. i .. "=" .. i * j .. "\t"
    end
    print(str)
end
