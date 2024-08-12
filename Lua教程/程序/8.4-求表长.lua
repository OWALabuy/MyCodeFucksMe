local myTable = {
    cat = {"eat", "play", "sleep"},
    dog = {"owner", "love", "eat", "walking"}
}

print(#myTable) --是0 因为它里面的cat和dog都是键值形式的元素
print(#myTable.cat) --是3 cat是一个数组 其中有三个字符串作为它的元素
