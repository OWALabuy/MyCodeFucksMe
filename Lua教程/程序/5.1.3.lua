local input = "d"

if(input == "a") -- ==是比较运算符 在下一节会讲到 这里是比较两者是否相等
then
    print("调整移动速度") --我们还没有学到游戏内的逻辑 所以这里用输出字符串来代替
elseif(input == "b")
then
    print("调整模型大小")
elseif(input == "c")
then
    print("调整血量")
else
    print("没有这个动作")
end
