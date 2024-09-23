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

-- 分区函数：将数组划分为两部分
local function partition(arr, left, right)
    -- 选择最右边的元素作为枢轴
    local pivot = arr[right]
    local i = left - 1  -- `i`是用于划分小于枢轴和大于枢轴元素的索引

    for j = left, right - 1 do
        if arr[j] <= pivot then
            i = i + 1
            -- 交换 arr[i] 和 arr[j]
            arr[i], arr[j] = arr[j], arr[i]
        end
    end

    -- 将枢轴放到正确的位置上
    arr[i + 1], arr[right] = arr[right], arr[i + 1]
    return i + 1  -- 返回枢轴的位置
end

-- 快速排序函数（递归实现）
local function quicksort(arr, left, right)
    if left < right then
        -- 分区操作，返回枢轴索引
        local pivot = partition(arr, left, right)
        
        -- 递归地排序左边部分
        quicksort(arr, left, pivot - 1)
        
        -- 递归地排序右边部分
        quicksort(arr, pivot + 1, right)
    end
end

-- 打印数组
local function print_array(arr)
    for _, v in ipairs(arr) do
        io.write(v .. " ")
    end
    io.write("\n")
end

-- 取得用户输入
local arr = get_input()

-- 调用快速排序算法
quicksort(arr, 1, #arr)

-- 输出排序后的结果
print("排序后的数组：")
print_array(arr)

