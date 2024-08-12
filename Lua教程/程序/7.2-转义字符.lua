local str = "Hello\tWorld"  -- 水平制表符
print(str)

--ascii字符示例
local str = "Hello\97World"  -- 八进制表示（\97 表示字符 'a'）
print(str)
local str = "Hello\x61World"  -- 十六进制表示（\x61 表示字符 'a'）
print(str)
local str = "Hello\u{61}World"  -- Unicode 码点表示（\u{61} 表示字符 'a'）
print(str)
