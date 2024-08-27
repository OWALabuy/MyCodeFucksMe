local function get_min_num(array)
    local min = 1
    for i = 2, #array do
        if(array[i] < array[min]) then
            min = i
        end
    end
    return min
end

--取得用户之输入 并将其做为一个数组... 干脆封装成一个函数
local function get_input()
    --取得n 完全是不必要的...
    local n = tonumber(io.read())

    --取其后输入的数组(此时还是字符串)
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
local myArray = get_input()

--调用函数找到这个数组中最小的数
local min_index = get_min_num(myArray)

--将其与第一个元素交换
local temp = myArray[1]
myArray[1] = myArray[min_index]
myArray[min_index] = temp

--输出 用空格隔开
print(table.concat(myArray, " "))
