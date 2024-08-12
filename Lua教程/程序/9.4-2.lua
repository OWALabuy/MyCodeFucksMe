local function awa(a)
    local b = a + 1 --对参数进行访问 参数也是一个局部变量
    if(true)
    then
        local c = b + 1 --对父代码块中的b进行访问
        print(c)
    end
    --尝试对子代码块中的c进行访问 无法访问
    print(c)
end

--调用函数 使函数内的代码执行 随便给个参数就可以了
awa(1)
--尝试对函数中的局部变量进行访问 会发现无法访问
print(b)
