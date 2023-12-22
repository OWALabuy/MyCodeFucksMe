-- version: 2022-04-20
-- mini: 528278703
--检测方块的区域
local xylist = {
    {x=-6,y=71},
    {x=-6,y=70},
    {x=-6,y=69},
    {x=-6,y=68},
    {x=-7,y=70},
    {x=-7,y=69},
}


local function replace(z)
    if(z%2==0)
    then 
        local result,id = Block:getBlockID(-3,70,z)
        if(id~=0 and id~=351)
        then 
            for i = 1,6 
            do
                Block:destroyBlock(xylist[i].x, xylist[i].y, z,false)
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
