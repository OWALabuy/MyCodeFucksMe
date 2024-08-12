local a, b = "hello", "world"
local c = a .. b --这将生成一个新的字符串 放入c中

print(c)
print(a) --可以看到 a和b都还是原来的值
print(b) --不会改变原变量中的字符串 除非为它们重新赋值 像下面这样

a = a .. b
print(a)
