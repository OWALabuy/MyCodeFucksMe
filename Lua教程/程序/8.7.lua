local tab1 = {11, 22, 33, 44, 55}
local tab2 = tab1 --这里把tab1指向的表赋值给tab2

--尝试索引和改变tab2中的值
print(tab2[2])
tab2[2] = 24
print(tab2[2])

--现在去检查tab1中的值 会发现其已经被改变了
print(tab1[2])
