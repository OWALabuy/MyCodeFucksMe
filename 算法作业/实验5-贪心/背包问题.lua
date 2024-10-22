-- 贪心算法求背包问题(不是01背包)

-- 获取用户输入的物品种类数
local kind = tostring(io.read())

--获取背包容量
local volume = tostring(io.read())

--循环获取每件物品的重量和价值(前面是重量 后面是价值 用逗号隔开)
local objInfo = {} --初始化一个空表来存放数据
local pattern = ""
for i = 1, kind do
    local temp = io.read()
    --提取每个物品的相关信息 塞进表里面
    local weight, value = 
end
