local xylist = {
    eight_th = {
        {x=-5,y=68},
        {x=-7,y=71}
    },
    sixteen_th = {
        {x=-7,y=64},
        {x=-9,y=67}
    }
}

local function replace(z)
    if(z%2==0) --偶数 是放音乐方块的地方
    then 
        local result,yid = Block:getBlockID(-5,71,z) --看看有没有长笛标识
        if(yid == 351) --有 进入循环
        then 
            for i = 1, 2 --八分音符的
            do 
                local x, y = xylist.eight_th[i].x, xylist.eight_th[i].y
                local result,zid = Block:getBlockID(x, y, z)
                if(zid==0 or zid==351)--没有被放方块
                then 
                    local result,id = Block:getBlockID(-4, 70, z)--标准的id和data
                    if(id>=690 and id<=692) --若此处有主方块
                    then
                        local result,data=Block:getBlockData(-4, 70, z)
                        Block:setBlockAll(xylist.eight_th[i].x, xylist.eight_th[i].y,z,690,data)
                    else --没有 就看前一个的
                        local result,id = Block:getBlockID(xylist.eight_th[i].x, xylist.eight_th[i].y, z-2)
                        local result,data=Block:getBlockData(xylist.eight_th[i].x, xylist.eight_th[i].y, z-2)
                        if(id>=690 and id<=692)
                        then 
                            Block:setBlockAll(xylist.eight_th[i].x, xylist.eight_th[i].y,z,690,data)
                        end 
                    end 
                end
            end 
            
            for i = 1, 2 --十六分音符的
            do 
                local result,zid = Block:getBlockID(xylist.sixteen_th[i].x, xylist.sixteen_th[i].y, z)
                if(zid==0 or zid ==351)--没有被放方块
                then 
                    local result,id = Block:getBlockID(-6, 66, z)--标准的id和data
                    if(id>=690 and id<=692) --若此处有主方块
                    then
                        local result,data=Block:getBlockData(-6, 66, z)
                        Block:setBlockAll(xylist.sixteen_th[i].x, xylist.sixteen_th[i].y,z,690,data)
                    else --没有 就看八分的
                        local result,id = Block:getBlockID(xylist.eight_th[i].x, xylist.eight_th[i].y, z)
                        local result,data=Block:getBlockData(xylist.eight_th[i].x, xylist.eight_th[i].y, z)
                        if(id>=690 and id<=692)
                        then 
                            Block:setBlockAll(xylist.sixteen_th[i].x, xylist.sixteen_th[i].y,z,690,data)
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
