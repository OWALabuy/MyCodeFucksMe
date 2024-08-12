local function recursion(num)
    if(num <= 1)
    then
        --0和1的阶乘是1 直接返回1
        --负数也可以在这里处理掉
        return 1
    else--如果参数不是0或1
        --就用参数乘以参数减1的阶乘
        return num * recursion(num - 1)
    end
end

--调用函数计算4的阶乘
local rec = recursion(5)

print(rec)
