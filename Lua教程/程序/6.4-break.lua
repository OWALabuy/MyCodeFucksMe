while(true) --条件永远为真 循环不会结束 这是一个死循环
do
    --在1到200这个区间生成一个随机数 并存放在变量中
    local ranNum = math.random(1, 200)
    print(ranNum)

    --如果生成的数大于100 使用break退出循环
    if(ranNum > 100)
    then
        break
    end
end
