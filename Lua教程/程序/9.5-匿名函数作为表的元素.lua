--匿名函数作为表的元素 示例
local myTable = {}

myTable[1] = function(str)
    print(str)
end

--通过表来调用函数
myTable[1]("hello")
