-- version: 2022-04-20
-- mini: 528278703
--检测方块的区域
local x1, y1 = 3, 64  --第一个坐标
local x2, y2 = 7, 71  --第二个坐标

--要刷的乐器方块id和data 693鼓 694电子 695综合
local mid, mdata = 695, 2

local function replace(z)
    if(z%2==0)
    then 
        for x = x1,x2
        do
            for y = y1, y2 
            do 
                local result,id = Block:getBlockID(x,y,z)
                if(id>=690 and id<=692)--若是音调方块 检测上面的id
                then 
                    local result,id2 = Block:getBlockID(x,y+1,z)
                    if(id2==0 or id2==351)--若是空气或光束线
                    then 
                        Block:setBlockAll(x,y+1,z,mid,mdata)
                    end 
                end 
            end 
        end 
    end 
end

ScriptSupportEvent:registerEvent([=[Player.MoveOneBlockSize]=], function(e) 
    for c = e.z-2, e.z+2 
    do 
        replace(c)
    end 
end) --eventobjid,shortix,x,y,z
