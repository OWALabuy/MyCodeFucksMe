-- 找零钱的函数
local function make_change(n)
    local denominations = {100, 50, 20, 10, 5, 2, 1} -- 定义纸币面值
    local result = {} -- 存储每种面值的张数

    for _, denom in ipairs(denominations) do
        local count = math.floor(n / denom) -- 使用尽可能多的该面值纸币
        table.insert(result, count) -- 将张数加入结果表中
        n = n % denom -- 更新剩余的找零金额
    end

    return result
end

-- 显示找零结果
local function display_change(n)
    local result = make_change(n)
    local denominations = {100, 50, 20, 10, 5, 2, 1}
    io.write("贪心法最终的找零钱方案为：")
    for i, count in ipairs(result) do
        io.write(string.format("%d元 %d张", denominations[i], count))
        if i < #result then
            io.write(", ")
        end
    end
    io.write("\n")
end

-- 读取用户输入
io.write("请输入需要找的零钱金额: ")
local n = tonumber(io.read())
display_change(n)

