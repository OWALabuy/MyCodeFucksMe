local function awa()
    local str --在父代码块中声明这个局部变量
    if(true)
    then
        str = "我在if语句中被赋值"
        print("在if语句中访问")
        print(str)
    end
    print("在函数中访问")
    print(str)
end

--调用这个函数
awa()
