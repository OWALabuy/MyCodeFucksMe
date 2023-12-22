--检测方块的区域
local x1, y1 = -9, 64  --第一个坐标
local x2, y2 = -4, 72  --第二个坐标

local function replace(z)
    if(z%2==0)
    then 
        for x = x1,x2
        do
            for y = y1, y2 
            do 
                local result,id = Block:getBlockID(x,y,z)
                if(id>=690 and id<=692)--若是音调方块 检测下面的id
                then 
                    local result,id2 = Block:getBlockID(x,y-1,z)
                    if(id2==0 or id2==351)--若是空气或光束线（单着的）看看上面的id
                    then 
                        local result,hid = Block:getBlockID(x,y+2,z)
                        if(hid==0) --上面没有方块
                        then 
                            local result,mid = Block:getBlockID(x,y+1,z) --乐器方块
                            local result,data=Block:getBlockData(x,y,z)
                            local result,mdata=Block:getBlockData(x,y+1,z)
                            Block:setBlockAll(x,y-1,z,mid,mdata) --乐器方块
                            Block:setBlockAll(x,y-2,z,id,data) --音调方块
                        end 
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
