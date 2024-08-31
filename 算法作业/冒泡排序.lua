local function bubble_sort(array)
    for i = 1, #array - 1 do
        for j = 0, #array - 1 do
            if(array[j] > array[j + 1])then
                local temp = array[j]
                array[j] = array[j + 1]
                array[j + 1] = temp
            end
        end
        print(table.concat(array, " "))
    end
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

--调用排序函数
bubble_sort(myArray)

