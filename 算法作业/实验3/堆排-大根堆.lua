-- 取得用户输入的模块
function get_input()
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

local function BinaryHeap(arr)
    for i = #arr, 1, -1 do
        parentIndex = math.floor(i / 2)
        currentIndex = i

        --这里要先比较一下两个子节点的值 再与父节点比较 不然无法确定哪个子节点更小
        while arr[parentIndex] ~= nil and arr[currentIndex] > arr[parentIndex] do
            Exchange(arr, currentIndex, parentIndex)
            currentIndex = parentIndex
            parentIndex = math.floor(currentIndex / 2)
        end
    end

    local lastIndex = #arr
    for i = 1, lastIndex do
        local left = currentIndex * 2
        if left >= lastIndex then
            break
        end

        local right = currentIndex * 2 + 1
        if right >= lastIndex then
            targetIndex = left
        else
            targetIndex = GetMaxChild(arr, left, right)
        end

        if(arr[currentIndex] < arr[targetIndex])
        then
            Exchange(arr, currentIndex, targetIndex)   
        else
            break
        end

        currentIndex = targetIndex
    end
    lastIndex = lastIndex - 1
end

--查找最小子节点
function GetMaxChild(arr, left, right)
    if arr[left] >= arr[right] then
        return left
    end
    return right
end

--交换数组中的两个元素 参数是数组和两个元素的索引
function Exchange(arr, a, b)
    local temp = arr[a]
    arr[a] = arr[b]
    arr[b] = temp
end

--local arr = {3, 1, 4, 2, 5}
local arr = get_input()
BinaryHeap(arr)

print(table.concat(arr, ", "))
