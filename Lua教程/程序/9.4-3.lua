local str = "我是在主流程中的局部变量"
local function awa()
    local str = "我是在函数中的局部变量"
    if(true)
    then
        local str = "我是在if语句中的局部变量"
        print("在if语句中访问")
        print(str)
    end
    print("在函数中访问")
    print(str)
end

--调用这个函数
awa()

print("在主流程中访问")
print(str)
