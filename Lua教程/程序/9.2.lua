--定义一个局部函数
local function sayhi(name)
    print("hi! " .. name)
    return "与" .. name .."打招呼了喵"
end

--调用此函数 传递一个参数 并获得返回值
local msg = sayhi("OWALabuy")

--查看其返回值
print(msg)
