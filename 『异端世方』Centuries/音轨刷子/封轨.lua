local xy_list = {
    {x=0,y=69},
    {x=5,y=70},
    {x=7,y=66},
    {x=5,y=61},
    {x=2,y=59},
    {x=0,y=57}
}

--检测的方块id和替换的方块id
--local BID, AID = 351, 636 --可以将第二个数改成你要的方块的id
--local BID, AID = 636, 641
--local BID, AID, AID2 = 636, 641, 632 --632是透明的
--local BID, AID = 632, 636
local BID, AID = 636, 632

local function replace(z)
    if(z>=-8)
    then 
        for i = 1,#xy_list
        do
            local nx, x, y = -xy_list[i].x, xy_list[i].x, xy_list[i].y 
            local litlist = {nx-1, nx+1, x-1 ,x+1}
            for j = 1, 4 
            do 
                local result,id = Block:getBlockID(litlist[j],y,z)
                if(id==BID)
                then 
                    Block:placeBlock(AID,litlist[j],y,z,0)
                    --Block:destroyBlock(litlist[j],y,z,false)
                end 
            end 
        end 
        --空气墙
        for x = -6, 6 
        do 
            Block:placeBlock(1001,x,63,z,0)
        end 
    end 
end

local function awa(e) 
    for c = e.z-2, e.z+2 
    do 
        replace(c)
    end 
end

ScriptSupportEvent:registerEvent([=[Player.MoveOneBlockSize]=], awa) --eventobjid,shortix,x,y,z
