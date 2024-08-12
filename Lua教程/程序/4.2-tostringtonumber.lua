--将一个字符串转换为数值
local str1 = "-1"
local str1tonum = tonumber(str1)
--当一个值含有非法字符时 无法转换成数值
local errnum = tonumber("13924awa") --errnum是空值

--将一个其他类型的值转换为字符串
print(tostring(a)) -- a没有被定义过 会得到"nil"
print(tostring(true)) --得到 "true"
