local player = {
    {name = "杀手没有恨", score = 29},
    {name = "欧阳闻奕", score = 19},
    {name = "涟漪云帆", score = 20},
    {name = "忠鉴", score = 25}
}

table.sort(player, function(a, b) return a.score < b.score end)

--倒序遍历这个数组并输出玩家和分数(因为会升序排序)
for i = #player, 1, -1 do
    print(player[i].name, player[i].score)
end
