local a = '我是一个字符串'
local type_of_a = type(a)
print(type_of_a) --这将输出 string

--对一个没有定义过的变量求类型 会返回"nil"
print(type(awa)) --awa是没有定义过的变量

--同样 也可以对一个值检测数据类型
print(type(114514)) --输出 number
