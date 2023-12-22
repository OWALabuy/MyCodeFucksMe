local xylist = {{x=-5,y=70},{x=-7,y=66}}

local function replace(z)
    if(z%2==0)
    then 
        for i = 1,2 
        do 
            local x,y = xylist[i].x, xylist[i].y
            local bx = {x+1,x+1,x+1,x+1,x+2,x+2}
            local ax = {x-1,x-1,x-1,x-1,x-2,x-2}
            local by = {y+1,y,y-1,y-2,y,y-1}
            for j = 1, 6 do 
                local result,id = Block:getBlockID(bx[j],by[j],z)
                if(id>=690 and id<=695)--若是音乐方块
                then 
                    local result,data=Block:getBlockData(bx[j],by[j],z)
                    Block:setBlockAll(ax[j],by[j],z,id,data)
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
