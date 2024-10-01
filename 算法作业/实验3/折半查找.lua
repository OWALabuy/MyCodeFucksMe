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

--折半查找 参数是一个有序数组和待查找的元素 返回值是待查找的元素在有序数组中的排序 如果没找到 返回-1
local function find(arr, n)
    --将参数中的数与中间
end

-- 取得用户输入 (一个有序数组 和一个查找的数字)
local arr = get_input()
local n = tonumber(io.read))

