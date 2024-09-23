-- 归并两个有序的子数组
local function merge(arr, left, mid, right)
    local leftArr = {}   -- 左子数组
    local rightArr = {}  -- 右子数组

    -- 将左半部分复制到 leftArr
    for i = left, mid do
        table.insert(leftArr, arr[i])
    end

    -- 将右半部分复制到 rightArr
    for i = mid + 1, right do
        table.insert(rightArr, arr[i])
    end

    local i, j = 1, 1  -- 初始化两个数组的指针
    local k = left     -- arr 的索引从 left 开始

    -- 合并两个有序子数组
    while i <= #leftArr and j <= #rightArr do
        if leftArr[i] <= rightArr[j] then
            arr[k] = leftArr[i]
            i = i + 1
        else
            arr[k] = rightArr[j]
            j = j + 1
        end
        k = k + 1
    end

    -- 如果左子数组还有剩余元素，继续插入
    while i <= #leftArr do
        arr[k] = leftArr[i]
        i = i + 1
        k = k + 1
    end

    -- 如果右子数组还有剩余元素，继续插入
    while j <= #rightArr do
        arr[k] = rightArr[j]
        j = j + 1
        k = k + 1
    end
end

-- 归并排序的递归函数
local function mergeSort(arr, left, right)
    if left < right then
        local mid = math.floor((left + right) / 2)

        -- 对左半部分递归排序
        mergeSort(arr, left, mid)

        -- 对右半部分递归排序
        mergeSort(arr, mid + 1, right)

        -- 合并两个有序子数组
        merge(arr, left, mid, right)
    end
end

-- 测试归并排序算法
--取得用户之输入 并将其做为一个数组... 干脆封装成一个函数
local function get_input()
    --取输入的数组(此时还是字符串)
    local str_arr = io.read()

    --处理这个字符串 把所有的数都拎出来 并塞进一个数组里面
    local myArray = {}
    for s in string.gmatch(str_arr, "%d+") do
        s = tonumber(s)
        table.insert(myArray, s)
    end
    return myArray
end

--取得用户之输入
local arr = get_input()

-- 调用归并排序
mergeSort(arr, 1, #arr)

print(table.concat(arr, " "))
