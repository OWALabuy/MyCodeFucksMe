-- version: 2022-04-20
-- mini: 528278703
--因为我的疏忽 要写这一段修正我的错误。。。。
--检测方块的区域
local xylist = {
    {x=-5,y=69},
    {x=-7,y=72},
    {x=-7,y=65},
    {x=-9,y=68},
}

--要刷的乐器方块id和data 693鼓 694电子 695综合
local mid, mdata = 695, 5

local function replace(z)
    if(z%2==0)
    then 
        for i = 1,4 
        do
            
            local result,id = Block:getBlockID(xylist[i].x,xylist[i].y,z)
            if(id==694)
            then 
                Block:setBlockAll(xylist[i].x, xylist[i].y, z, mid, mdata)
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
