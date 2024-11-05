--玩家状态的表 每个玩家的数据用其迷你号作为索引
PL = {}

--玩家进入游戏 将玩家塞入PL表中
ScriptSupportEvent:registerEvent([=[Game.AnyPlayer.EnterGame]=], function(event)
    PL[event.eventobjid] = {
        canFly = true
    }
end)

local function coll(e)                      --创建一个名字为coll、入口(参数)为e的盒子(函数)
    local r1 = Actor:isPlayer(e.eventobjid) --获取碰撞物1是不是玩家
    local r2 = Actor:isPlayer(e.toobjid)    --获取碰撞物2是不是玩家
    local p1, p2

    if (r1 == 0) and (r2 ~= 0) then                            --如果碰撞物1是玩家，2不是玩家
        p1 = e.eventobjid                                      --让p1等于被碰撞的玩家迷你号
        p2 = e.toobjid                                         --让p2等于被碰撞的生物对象id
    elseif (r1 ~= 0) and (r2 == 0) then                        --如果碰撞物1不是玩家，2是玩家
        p1 = e.toobjid                                         --让p1等于被碰撞的玩家迷你号
        p2 = e.eventobjid                                      --让p2等于被碰撞的生物对象
    end                                                        --结束碰撞物1和2所属类型的判断

    local result, actorid = Creature:getActorID(p2)                 --获取碰撞生物的 id
    print("生物id=", p2, "生物actorid=", actorid, "玩家的弹飞状态", PL[p1].canFly)
    if actorid == 3 and PL[p1].canFly then
        --将该玩家的可触发设置为false
        PL[p1].canFly = false
        --获取玩家面朝方向
        local r, dirx, diry, dirz = Actor:getFaceDirection(p1)
        --设定弹飞力度 可调整(负数是面朝反方向)
        local force = -1
        --计算各方向的参数
        dirx, diry, dirz = dirx * force, diry * force, dirz * force
        --弹飞玩家
        print("弹飞玩家的参数(xyz)", dirx, diry, dirz)
        Actor:appendSpeed(p1, dirx, diry, dirz)

        --完毕后冷却1.5秒后将该玩家的可触发标记设置为真
        PL[p1].canFly = true
    end
end

ScriptSupportEvent:registerEvent([=[Actor.Collide]=], coll)
