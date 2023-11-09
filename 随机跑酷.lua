--对玩家显示聊天框系统消息(重构) 参数是字符串和玩家迷你号 规范化参数避免缺参
local function msg(content, UIN)
    if(content and UIN == nil) --检查参数是否完整
    then 
        Chat:sendSystemMsg('msg:参数不完整！')
        return 1001 
    end
    Trigger:wait(0.1) --一个小的延迟
    Chat:sendSystemMsg(content, UIN)
    return 0 
end 

local PDB = {--player data base玩家数据库 用于记录每个玩家在地图中的位置
    --[[
        [UIN] = {
            lastBloPos = {x = 0, y = 0, z = 0}--上次生成方块的位置
            blockIdList = {}--玩家可自选方块
            level = 1 --玩家选用的难度等级 默认为1 有1 2 3
        }

    --]]
}

local randomXYZ = {}

--以z正方向为前方
--返回xyz作为下一个生成的坐标加值
randomXYZ[1] = function ()
    local z = 0
    local y = 0 --定义一下awa
    local ran = math.random(1, 3)--是否上下 1/3概率上下
    if(ran == 3)--上下
    then
        y = math.random(0, 1) --取-1 或1 这两个值
        if(y == 0)
        then
            y = y - 1
        end
    else --不上下
        y = 0
    end
    
    if(y == 1 or y == 0)
    then
        z = math.random(1, 2)
    else
        z = math.random(1, 3)
    end
    local x = math.random(-1, 1)
    return x, y, z
end

local siameseStyle = { --连体的五个样式
    [1] = {
        {x = 0, z = 1},
        {x = 0, z = 2},
    },
    [2] = {
        {x = 1, z = 1},
        {x = 1, z = 2},
    },
    [3] = {
        {x = -1, z = 1},
        {x = -1, z = 2},
    },
    [4] = {
        {x = 0, z = 1},
        {x = -1, z = 1},
        {x = -1, z = 2},
    },
    [5] = {
        {x = 0, z = 1},
        {x = 1, z = 1},
        {x = 1, z = 2},
    },
}

--向前生成方块的函数 参数是玩家的迷你号
local function genBlock(UIN)
    local ind = math.random(1, #PDB[UIN].blockIdList)--随机选一种方块的索引
    local bloId = PDB[UIN].blockIdList[ind] --获取这次要生成的id

    local isSiamese = math.random(1, 4) --是否连体（1/4概率连体）
    if(isSiamese == 1) --连体
    then
        local siaInd = math.random(1, 5)
        for i = 1, #siameseStyle[siaInd]
        do
            --记入坐标增量
            PDB[UIN].lastBloPos.x = PDB[UIN].lastBloPos.x + siameseStyle[siaInd].x
            PDB[UIN].lastBloPos.z = PDB[UIN].lastBloPos.z + siameseStyle[siaInd].z

            --生成方块
            local result = Block:placeBlock(bloId, PDB[UIN].lastBloPos.x, PDB[UIN].lastBloPos.y, PDB[UIN].lastBloPos.z,0)
            if(result == 1001)
            then
                msg("生成方块失败！", UIN)
            end
        end
    else
        local xp, yp, zp = randomXYZ[PDB[UIN].level]() --获取坐标增量
        --记入坐标增量
        PDB[UIN].lastBloPos.x = PDB[UIN].lastBloPos.x + xp
        PDB[UIN].lastBloPos.y = PDB[UIN].lastBloPos.y + yp
        PDB[UIN].lastBloPos.z = PDB[UIN].lastBloPos.z + zp

        --生成方块
        local result = Block:placeBlock(bloId, PDB[UIN].lastBloPos.x, PDB[UIN].lastBloPos.y, PDB[UIN].lastBloPos.z,0)
        if(result == 1001)
        then
            msg("生成方块失败！", UIN)
        end
    end
end


local intro = {
    "欢迎来到随机跑酷",
    "点击任意方块可将该种方块拉入跑酷赛道清单",
    "输入1/2/3可选择难度 1最简单 3最难",
    "输入4将方块清单清空",
    "支持多人联机比赛awa",
}

--玩家进入游戏
ScriptSupportEvent:registerEvent([=[Game.AnyPlayer.EnterGame]=], function(event) --eventobjid,shortix,x,y,z
    local UIN = event.eventobjid
    local result,x,y,z=Actor:getPosition(event.eventobjid) --获取玩家的位置
    PDB[event.eventobjid] = { --在数据库中创建玩家的索引
        lastBloPos = {x = x, y = y - 1, z = z},
        blockIdList = {536},--一个曙光石块
        level = 1,
    }
    for i = 1, #intro
    do
        msg(intro[i], event.eventobjid)
    end
end)

--玩家死亡（重置他的数据）
ScriptSupportEvent:registerEvent([=[Player.Die]=], function(event) --eventobjid,shortix,x,y,z
    local UIN = event.eventobjid
end)

--玩家点击方块（选择方块）
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=], function(event) --eventobjid,blockid,x,y,z
    local UIN = event.eventobjid
    PDB[UIN].blockIdList[#PDB[UIN].blockIdList + 1] = event.blockid
    msg(string.format("已将%d方块拉清单",event.blockid), event.eventobjid)
end)

--玩家输入字符串
ScriptSupportEvent:registerEvent([=[Player.NewInputContent]=], function (event) -- eventobjid,content
    local UIN = event.eventobjid
    if(event.content == "1" or event.content == "2" or event.content == "3")
    then--改变难度
        PDB[UIN].level = tonumber(event.content)
        msg(string.format("您的难度已设置为%d", PDB[UIN].level), UIN)
    elseif(event.content == "4")--清空清单
    then
        PDB[UIN].blockIdList = {}
        msg("您的清单已经清空", UIN)
    end
end)

--玩家行走一格
ScriptSupportEvent:registerEvent([=[Player.MoveOneBlockSize]=], function (event)--eventobjid,shortix,x,y,z
    local UIN = event.eventobjid
    if(event.z >= 10) --不在起点内 可以开始游戏
    then
        if(PDB[event.eventobjid].lastBloPos.z - event.z <= 8)--小于8格 向前随机生成方块
        then
            genBlock(event.eventobjid)
        end
    end
end)

--方块被放置 等待多少秒 将那个方块移除
local waitTime = 10
ScriptSupportEvent:registerEvent([=[Block.Add]=], function(event)--blockid,x,y,z
    Trigger:wait(waitTime)
    Block:destroyBlock(event.x, event.y, event.z, false)
end)
