--匿名函数作为调用函数时的参数 示例
local function oper(num1, num2, func)
    print(func(num1, num2))
end

--定义一个函数plus
local function plus(a1, a2)
    return a1 + a2
end

--调用函数
oper(1, 2, plus)
