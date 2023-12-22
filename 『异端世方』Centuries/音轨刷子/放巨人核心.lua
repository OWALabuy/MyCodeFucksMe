
local x1, y1 = -5, 72  --第一个坐标
local x2, y2 = -7, 68  --第二个坐标

--要刷的乐器方块id和data 693鼓 694电子 695综合
local mid, mdata = 1059, 0

local function replace(z)
    if(z>=0)
    then 
        local result,id = Block:getBlockID(x1,y1,z)
        if(id==351)
        then 
            
            Block:setBlockAll(x1,y1,z,mid,mdata)
        end 
        local result,id = Block:getBlockID(x2,y2,z)
        if(id==351)
        then 
            
            Block:setBlockAll(x2,y2,z,mid,mdata)
        end
    end 
end

ScriptSupportEvent:registerEvent([=[Player.MoveOneBlockSize]=], function(e) 
    for c = e.z-2, e.z+2 
    do 
        replace(c)
    end 
end) --eventobjid,shortix,x,y,z
