local function ClickBlock(obj)
    local blockid = 707--方块ID
    local x,y,z = obj.x,obj.y,obj.z--方块坐标
    local result,data=Block:getBlockData(x,y,z)
    
    if(obj.x%16==0)
    then 
        Block:setBlockAll(x,y-1,z,blockid,0)
        local result,x,y,z=Actor:getPosition(obj.eventobjid)
        Actor:setPosition(obj.eventobjid,x,y,z+16)
    end 
end

ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=], ClickBlock)--点击方块
