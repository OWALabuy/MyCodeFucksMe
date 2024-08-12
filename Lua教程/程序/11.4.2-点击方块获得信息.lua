--模板字符串
local temp1 = "名称: %s, ID: %d"
local temp2 = "坐标: (%d, %d, %d), Data: %d"

--动作函数
local function ClickBlock(event)
    --在事件参数中已经有id和坐标 只需要获取其名字 data即可
    local result,name=Item:getItemName(event.blockid)
    local result,data=Block:getBlockData(event.x,event.y,event.z)

    --制作消息字符串
    local str1 = string.format(temp1, name, event.blockid)
    local str2 = string.format(temp2, event.x, event.y, event.z, data)

    --输出消息
    Chat:sendSystemMsg(str1)
    Chat:sendSystemMsg(str2)
end


--注册玩家点击方块监听器
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=], ClickBlock)--{eventobjid, blockid, x, y, z}

