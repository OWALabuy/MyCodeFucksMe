local myTable = {11, 22, 33, 44, 55, 66}
print(table.concat(myTable, ", ")) --输出表的预览

table.insert(myTable, 77) --不指定插入的位置 默认为尾部
print(table.concat(myTable, ", "))

table.insert(myTable, 5, 52) --指定插入的位置 会把后面的元素后移
print(table.concat(myTable, ", "))
