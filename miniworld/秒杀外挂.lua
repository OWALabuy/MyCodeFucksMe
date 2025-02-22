--监听玩家攻击事件 eventobjid,targetactorid
ScriptSupportEvent.registerEvent([=[Player.AttackHit]=],function (e)
    --对击中的对象实现秒杀
    Actor:killSelf(e.targetactorid)
end)
