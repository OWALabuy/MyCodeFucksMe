local year, month, day = 1995, 3, 6
-- 格式化为 YYYY/MM/DD
local formatted_date = string.format("%04d/%02d/%02d", year, month, day)
print(formatted_date)  -- 输出 "1995/03/06"

-- 更多示例
print(string.format("%4d", 7))    -- 输出 "   7"
print(string.format("%04d", 7))   -- 输出 "0007"
print(string.format("%-10s", "hi")) -- 输出 "hi        "
print(string.format("%.3f", 3.14159))   -- 输出 "3.142"
