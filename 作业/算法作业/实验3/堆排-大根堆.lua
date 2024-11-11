-- 取得用户输入的模块
function get_input()
    local str_arr = io.read()

    local myArray = {}
    for s in string.gmatch(str_arr, "%d+") do
        s = tonumber(s)
        table.insert(myArray, s)
    end
    return myArray
end

-- 交换数组中的两个元素
function Exchange(arr, a, b)
    local temp = arr[a]
    arr[a] = arr[b]
    arr[b] = temp
end

-- 查找最大子节点
function GetMaxChild(arr, left, right)
    if arr[right] ~= nil and arr[right] > arr[left] then
        return right
    else
        return left
    end
end

-- 调整堆的函数，使得堆满足最大堆的性质
local function Heapify(arr, currentIndex, heapSize)
    local left = currentIndex * 2
    local right = currentIndex * 2 + 1
    local largest = currentIndex

    -- 比较左右子节点，找出最大的
    if left <= heapSize and arr[left] > arr[largest] then
        largest = left
    end
    if right <= heapSize and arr[right] > arr[largest] then
        largest = right
    end

    -- 如果子节点比父节点大，交换它们并递归调用 Heapify
    if largest ~= currentIndex then
        Exchange(arr, currentIndex, largest)
        Heapify(arr, largest, heapSize)
    end
end

-- 构建最大堆
local function BuildMaxHeap(arr)
    local heapSize = #arr
    -- 从最后一个非叶子节点开始向上调整
    for i = math.floor(heapSize / 2), 1, -1 do
        Heapify(arr, i, heapSize)
    end
end

-- 堆排序函数
local function HeapSort(arr)
    BuildMaxHeap(arr)
    local heapSize = #arr
    -- 逐步将堆顶元素和堆的最后一个元素交换，并调整堆
    for i = heapSize, 2, -1 do
        Exchange(arr, 1, i)
        heapSize = heapSize - 1
        Heapify(arr, 1, heapSize)
    end
end

-- 测试数据
--local arr = {3, 1, 4, 2, 5}
local arr = get_input()
HeapSort(arr)

print(table.concat(arr, ", "))

