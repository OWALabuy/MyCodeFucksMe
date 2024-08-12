local myTable = {11, 22, 33}

myTable[4] = 44

--原有的元素和新增的元素都能被正常访问
print(myTable[2])
print(myTable[4])

--修改其索引中的值
myTable[2] = 24
print(myTable[2])
