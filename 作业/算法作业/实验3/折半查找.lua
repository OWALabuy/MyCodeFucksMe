-- 取得用户输入的模块
local function get_input()
    -- 取输入的数组(此时还是字符串)
    local str_arr = io.read()

    -- 处理这个字符串 把所有的数都拎出来 并塞进一个数组里面
    local myArray = {}
    for s in string.gmatch(str_arr, "%d+") do
        s = tonumber(s)
        table.insert(myArray, s)
    end
    return myArray
end

-- 折半查找 参数是一个有序数组和待查找的元素 返回值是待查找的元素在有序数组中的索引 如果没找到 返回 -1
local function find(arr, n, findMinIndex, findMaxIndex)
    -- 确定查找的范围
    if findMinIndex > findMaxIndex then
        return -1  -- 如果范围无效，返回 -1
    end

    -- 计算中间索引
    local midIndex = math.floor((findMinIndex + findMaxIndex) / 2)

    -- 比较中间值与目标值
    if n < arr[midIndex] then
        return find(arr, n, findMinIndex, midIndex - 1)  -- 在前半部分查找
    elseif n > arr[midIndex] then
        return find(arr, n, midIndex + 1, findMaxIndex)  -- 在后半部分查找
    else
        return midIndex  -- 找到元素，返回其索引
    end
end

-- 调用折半查找
local arr = get_input()
local n = tonumber(io.read())
local index = find(arr, n, 1, #arr)

if index == -1 then
    print("未找到元素")
else
    print("元素的索引是:", index)
end

