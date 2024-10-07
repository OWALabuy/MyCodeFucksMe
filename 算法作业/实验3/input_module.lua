--取得用户输入的模块 请注意 从第3次实验开始 每次作业都需要打包上这个模块文件

local input_module = {}

-- 获取用户输入的函数
function input_module.get_input()
    -- 取输入的数组 (此时还是字符串)
    local str_arr = io.read()

    -- 处理这个字符串，把所有的数都拎出来，并塞进一个数组里面
    local myArray = {}
    for s in string.gmatch(str_arr, "%d+") do
        s = tonumber(s)
        table.insert(myArray, s)
    end
    return myArray
end

return input_module

