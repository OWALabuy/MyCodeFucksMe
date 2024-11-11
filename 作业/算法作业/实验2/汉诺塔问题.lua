local function towers(n, a, b, c)
    if(n == 1)
    then
        print(string.format("把第%d个盘子 %s -> %s", n, a, c))
    else
        towers(n - 1, a, c, b)
        print(string.format("把第%d个盘子 %s -> %s", n, a, c))
        towers(n - 1, b, a, c)
    end
end

--主流程

--读取用户输入数据
local n = tonumber(io.read())

towers(n, "A", "B", "C")
