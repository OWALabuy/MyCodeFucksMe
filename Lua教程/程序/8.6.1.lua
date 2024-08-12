local myTable = {11, 22, 33, 44, 55, 66}

print(table.concat(myTable)) --省略情况下
print(table.concat(myTable, ", ")) --指定其分隔符
print(table.concat(myTable, ", ", 2, 4)) --指定其首尾
