local str = "/to 43 67 103"

--截取其第一个字符 若是/ 就是命令
local head = string.sub(str, 1, 1)
if(head == "/")
then
    local pattern = "/(%a+)%s(%d+)%s+(%d+)%s+(%d+)"
    local order, x, y, z = string.match(str, pattern)
    print(order, x, y, z)
end
