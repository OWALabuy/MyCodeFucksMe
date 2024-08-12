local myTable = {11, 22, 33, 44, 55, 66}
print(table.concat(myTable, ", ")) --输出表的预览

local delete = table.remove(myTable) --删除尾部元素
print(table.concat(myTable, ", "))
print("被删除的元素是" .. delete)

delete = table.remove(myTable, 2) --删除指定元素 后面的元素会前移
print(table.concat(myTable, ", "))
print("被删除的元素是" .. delete)
