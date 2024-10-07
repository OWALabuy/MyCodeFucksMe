local function heapify(arr, n, i)
    local largest = i      -- 初始化最大值为根
    local left = 2 * i + 1 -- 左子节点
    local right = 2 * i + 2 -- 右子节点

    -- 如果左子节点比根节点大
    if left < n and arr[left] > arr[largest] then
        largest = left
    end

    -- 如果右子节点比当前最大值大
    if right < n and arr[right] > arr[largest] then
        largest = right
    end

    -- 如果最大值不是根节点
    if largest ~= i then
        arr[i], arr[largest] = arr[largest], arr[i] -- 交换

        -- 递归调用 heapify
        heapify(arr, n, largest)
    end
end

local function heap_sort(arr)
    local n = #arr

    -- 构建最大堆
    for i = math.floor(n / 2) - 1, 1, -1 do
        heapify(arr, n, i)
    end

    -- 一个个从堆中取出元素
    for i = n, 2, -1 do
        arr[1], arr[i] = arr[i], arr[1] -- 交换
        heapify(arr, i - 1, 1) -- 重新调整堆
    end
end

-- 示例用法
local arr = {3, 1, 4, 2, 5}
heap_sort(arr)

for _, v in ipairs(arr) do
    print(v)
end

