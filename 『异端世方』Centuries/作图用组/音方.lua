--[[        『异端世方』音乐方块生成器v1.11  
音乐玩家一天7张图的秘密 此程序包含音调方块的生成和乐器方块的生成 告别手撸方块 拯救肝脏 让你的音乐创作更加高效且准确
直接粘贴在游戏中 转换玩法地图即可使用（有部分可修改 详见下文） 若要保留玩法模式下的创作 请开启玩法模式退出不重置地图
1.5以上版本 联机房间中可以正常使用 玩家数据分别存储 互不干扰
作者：异端 世方府 欧阳闻奕-528278703   异端 世方府工作室版权所有 严禁未经授权用于商业用途！！！
请关注轨心夕（杀手没有恨）他迷你号139246171 他是异端的老大    我作为他的小弟 可喜欢他了！！！
--]]
-----------------------------------------------------------------------------------------------------------------------------------------
--通用功能
--[[
1.输入“飞” “落” 可以起飞和降落
2.音乐组（音调+乐器）复制功能
    手持石矛《撸》（一定是撸 不是点一下）一下乐器方块可以录入音组数据（乐器方块与其下的音调方块（若有））
    手持石矛对准目标位置再次选择该快捷栏 粘贴音组
3.手持道具收割者点击方块可将其清除
4.手持非收割者道具点击方块 检测方块的属性
5.使用石矛 瞬移到准星位置
6.
7.输入“使用说明”获得使用提示
--]]
-----------------------------------------------------------------------------------------------------------------------------------------
--音调方块的生成
--[[
根据玩家当前位置、手持道具（高中低音块）、聊天框输入数字或音名 在玩家当前位置生成对应的音调方块 提高玩家制作音乐地图的效率
生成音调方块后 将玩家做一个位置偏移 避免其被方块卡住 玩家可以在下面设置偏移的方向与格数
使用方法：手持道具（高中低音块）站在目标位置上输入音块的点击次数(0~12)或音名(CDEFGAB 不限大小写) 自动生成音调方块awa
如需使用音名功能 请在编辑调性处根据所需调性设置音块的点击次数 本程序默认C大调（0,2,4,5,7,9,11）
--]]
local p_x,p_y,p_z=0,0,2--在此处设置偏移的方向与格数
local C,D,E,F,G,A,B=0,2,4,5+1,7,9,11--在此处编辑调性
-----------------------------------------------------------------------------------------------------------------------------------------
--乐器方块的生成
--[[
根据玩家手持道具（鼓 电子 综合 乐器方块）、聊天框输入数字（音块的点击次数）存储相应的数据
使用方法：手持道具（鼓 电子 综合 乐器方块）输入音块的点击次数 手持石矛对准目标位置再次选择该快捷栏 自动生成对应的音乐方块
需切换音色 手持对应乐器方块重新输入数字即可 （这也会把复制的音组数据覆盖掉）
可以清除保存的数据 清除后手持石矛对准目标位置再次选择该快捷栏不会生成方块 方法：在聊天框输入“清除乐器方块数据”（引号不用输入）
--]]
-----------------------------------------------------------------------------------------------------------------------------------------

---------------------- 变量及数据库 ----------------------
local M_I_list={}
    --[[玩家数据库 每个玩家有一个以其迷你号为key的val val是一个tab 那个tab的索引形如 M_I_list[528278703] 
    里面有switch(音乐方块的特效提示开关)
    block_id(乐器方块的id) 
    click_num(乐器方块的点击次数) 
    z_bloid z_num(复制音组时 音调方块的id和点击次数 可能没有此数据)
    copy(复制区域内音乐方块用的数据库 里面有
        way <粘贴的方法枚举  1:无视光束线粘贴(默认) 2.无视除电路外任何方块粘贴 3:无视任何方块粘贴> 
        pos <里面有两个table 分别为 strpos endpos 格式形如{x=2,y=3,z=4}>
        vector<向量坐标 代表区域的大小和相对于起点坐标的方向 形如{x=2,y=3,z=4} 末位置减去初位置> 
        direction<向量的方向 如 {x=1,y=1,z=1}>
        areadata<区域的数据 是一个三维的tab 每个元素的索引为其在向量中的相对坐标 形如M_I_list[528278703]["copy"]["areadata"][3][1][2] val为一个tab 里面有id和data 形如M_I_list[528278703]["copy"]["areadata"][3][1][2][id] 从起点坐标开始遍历整个区域 录入每个方块的id的data>
        )
    --]]
local Itemid_List={690,691,692,12002,693,694,695,12009,11582,11668}--要检测和添加的初始道具列表

--使用说明列表
local readme = {
    "#c8bf6ab『异端世方』音乐方块生成器★v1.11\n            使 ★ 用 ★ 说 ★ 明",
    "#c66ccff==========================",
    "#cFFFF81通用功能：",
    "#cFFF5E41. 输入“飞”“落”可起飞和降落。",
    "#cFFE3E12. 音乐组复制功能：手持石矛撸一下乐器方块来录入音组数据，手持石矛再次选择该快捷栏可在准星位置粘贴音组。",
    "#cFFD1D13. 手持道具收割者点击方块可将其清除。",
    "#cFF94944. 手持非收割者道具点击方块，检测方块的属性",
    "#cFF7E855. 使用石矛，瞬移到准星位置",
    "#cFFFF81音调方块的生成：",
    "#cECF2FF1. 手持高中低音块，站在目标位置上，输入音块的点击次数(0~12)或音名(CDEFGAB)可生成音调方块。",
    "#cE3DFFD2. 可在代码中编辑调性和位置偏移。",
    "#cFFFF81乐器方块的生成：",
    "#cE5D1FA1. 手持鼓、电子、综合、乐器方块，输入音块的点击次数，手持石矛再次选择该快捷栏可在准星位置生成对应的音乐方块。",
    "#cCFF5E72. 切换音色：手持对应乐器方块重新输入数字即可，这会覆盖复制的音组数据。",
    "#cA0E4CB3. 清除保存的数据：在聊天框输入“清除乐器方块数据”来清除，再次选择石矛快捷栏不会生成方块。",
    "#cFFFF81区域音乐方块复制（雷电法杖与极寒域法杖）：",
    "#cFFEECC1. 用雷电法杖锚定区域起点和终点框选欲复制的区域，方法如下一条所示",
    "#cFFDDCC2. 手持雷电法杖#W使用一下#cFFDDCC（按右键）可在#W玩家位置#cFFDDCC锚定一个点，#W撸#cFFDDCC一下方块可以在#W方块位置#cFFDDCC锚定一个点",
    "#cFFCCCC3. 两种方法都可以使用，具体依据个人需求",
    "#cFEBBCC4. 框选好区域后，再使用一次手中的雷电法杖，系统会录入待复制的区域中所有音乐方块的数据",
    "#cFBA1B75. 复制好后，使用极寒域法杖，以自己的位置为起点，粘贴音乐方块",
    "#cFFD1DA6. 手持极寒域法杖，在聊天框输入“撤消”可撤消刚刚粘贴的东西，但使用2和3方式粘贴时被破坏的方块无法恢复",
    "#cFFF0F57. 在锚定点后，切换道具可取消所有锚定的点，再次选择雷电法杖快捷栏可取消区域的终结点",
    "#cFFDBAA8. 手持极寒域法杖，输入数字可改变粘贴方式。 1:无视光束线粘贴(默认) 2.无视除电路外任何方块粘贴 3:无视任何方块粘贴",
    "#c66ccff=========================="
}

local intro = {
    "#c8bf6ab『异端世方』音乐方块生成器★v1.11",
    "#c66ccff==========================",
    "#c61C0BF程序作者：西瓜视频 欧阳闻奕",
    "#cBBDED6迷你号 5丨2丨8丨2丨7丨8丨7丨0丨3",
    "#cFAE3D9告丨别丨手丨撸 awa 高丨效丨创丨作",
    "#cFFB6B9输入“使用说明”获得使用提示",
    "#c66ccff=========================="
} 

local CopyEffectId = 1212 --复制用的特效id

---------------------- 函数定义 ----------------------
--对玩家输出使用说明 参数是玩家的迷你号
local function user(UIN)
    Trigger:wait(0.1)
    for i = 1, #readme
    do
        Chat:sendSystemMsg(readme[i], UIN) --逐条输出
        if(i>=3)
        then
            Trigger:wait((#readme[i]*0.03)) --根据字数设定延迟
        end
    end
end

--复制一个区域 录入一个区域的所有音乐方块数据 参数是玩家的迷你号
local function ctrl_c(UIN)
    --消灭掉上次复制的东西
    M_I_list[UIN].copy.areadata = {}
    --开辟表格 一层套一层 像俄罗斯套娃
    for x = 0, M_I_list[UIN].copy.vector.x, M_I_list[UIN].copy.direction.x 
    do 
        M_I_list[UIN].copy.areadata[x] = {}
        for y = 0, M_I_list[UIN].copy.vector.y, M_I_list[UIN].copy.direction.y 
        do 
            M_I_list[UIN].copy.areadata[x][y] ={}
            for z = 0, M_I_list[UIN].copy.vector.z, M_I_list[UIN].copy.direction.z
            do 
                M_I_list[UIN].copy.areadata[x][y][z] ={}
            end 
        end 
    end 
    
    --录入数据
    --遍历每一个方块
    for x = 0, M_I_list[UIN].copy.vector.x, M_I_list[UIN].copy.direction.x 
    do 
        for y = 0, M_I_list[UIN].copy.vector.y, M_I_list[UIN].copy.direction.y 
        do 
            for z = 0, M_I_list[UIN].copy.vector.z, M_I_list[UIN].copy.direction.z 
            do 
                local result,id = Block:getBlockID( M_I_list[UIN].copy.pos.strpos.x+x, M_I_list[UIN].copy.pos.strpos.y+y, M_I_list[UIN].copy.pos.strpos.z+z)
                if(id >= 690 and id <= 699)--如是音乐方块
                then 
                    local result,data=Block:getBlockData( M_I_list[UIN].copy.pos.strpos.x+x, M_I_list[UIN].copy.pos.strpos.y+y, M_I_list[UIN].copy.pos.strpos.z+z)
                    --录入id 和data 
                    M_I_list[UIN].copy.areadata[x][y][z].id = id 
                    M_I_list[UIN].copy.areadata[x][y][z].data = data
                end 
            end 
        end 
    end 
    Chat:sendSystemMsg(string.format("#cFFE1E1复制区域内所有音乐方块成功，坐标起点(%d,%d,%d)", M_I_list[UIN].copy.pos.strpos.x, M_I_list[UIN].copy.pos.strpos.y, M_I_list[UIN].copy.pos.strpos.z),UIN)
    Chat:sendSystemMsg("#cEEEEEE使用极寒域法杖可粘贴方块。")
    return 0 
end

--粘贴方块 根据M_I_list[UIN].copy.way选择粘贴的方式 参数是玩家的迷你号
local function ctrl_v(UIN)
    --获取玩家位置
    local result,px,py,pz=Actor:getPosition(UIN)
    --将这次粘贴的位置保存到copy中
    M_I_list[UIN].copy.LastPastePos = {x=px,y=py,z=pz}
    --提取数据
    for x = 0, M_I_list[UIN].copy.vector.x, M_I_list[UIN].copy.direction.x 
    do 
        for y = 0, M_I_list[UIN].copy.vector.y, M_I_list[UIN].copy.direction.y 
        do 
            for z = 0, M_I_list[UIN].copy.vector.z, M_I_list[UIN].copy.direction.z 
            do 
                if(M_I_list[UIN].copy.areadata[x][y][z].id)
                then 
                    local result,BeforeId = Block:getBlockID(px+x, py+y, pz+z)
                    if(M_I_list[UIN].copy.way == 1) --1.无视光束线粘贴(默认)
                    then 
                        if(BeforeId == 0 or BeforeId == 351) --空气或光束线
                        then 
                            Block:setBlockAll(px+x, py+y, pz+z, M_I_list[UIN].copy.areadata[x][y][z].id, M_I_list[UIN].copy.areadata[x][y][z].data)
                        end 
                    elseif(M_I_list[UIN].copy.way == 2)-- 2.无视除电路外任何方块粘贴
                    then 
                        if(not((BeforeId>=352 and BeforeId<=374) or (BeforeId==415) or (BeforeId>=690 and BeforeId<=722))) --排除电路元件和音乐方块
                        then 
                            Block:setBlockAll(px+x, py+y, pz+z, M_I_list[UIN].copy.areadata[x][y][z].id, M_I_list[UIN].copy.areadata[x][y][z].data)
                        end 
                    elseif(M_I_list[UIN].copy.way == 3)-- 3.无视任何方块粘贴 
                    then 
                        Block:setBlockAll(px+x, py+y, pz+z, M_I_list[UIN].copy.areadata[x][y][z].id, M_I_list[UIN].copy.areadata[x][y][z].data)
                    end 
                end 
            end 
        end 
    end 
    Chat:sendSystemMsg(string.format("粘贴音乐方块成功 起点(%d,%d,%d)", px, py, pz),UIN)
    return 0 
end 

--撤消（消除刚刚粘贴的东西）
local function ctrl_z(UIN)
    --上次粘贴的位置
    local px, py, pz = M_I_list[UIN].copy.LastPastePos.x, M_I_list[UIN].copy.LastPastePos.y, M_I_list[UIN].copy.LastPastePos.z 
    for x = 0, M_I_list[UIN].copy.vector.x, M_I_list[UIN].copy.direction.x 
    do 
        for y = 0, M_I_list[UIN].copy.vector.y, M_I_list[UIN].copy.direction.y 
        do 
            for z = 0, M_I_list[UIN].copy.vector.z, M_I_list[UIN].copy.direction.z 
            do 
                if(M_I_list[UIN].copy.areadata[x][y][z].id) --对比id和data 进行清除操作
                then 
                    local result,BeforeId = Block:getBlockID(px+x, py+y, pz+z)
                    if(BeforeId == M_I_list[UIN].copy.areadata[x][y][z].id)
                    then 
                        local result,data=Block:getBlockData(px+x, py+y, pz+z)
                        if(data == M_I_list[UIN].copy.areadata[x][y][z].data)
                        then 
                            Block:destroyBlock(px+x, py+y, pz+z, false)
                        end 
                    end 
                end 
            end 
        end 
    end 
    Chat:sendSystemMsg("撤销成功")
    return 0 
end 


---------------------- 事件关联动作定义 ----------------------
--玩家进入游戏时
local function Game_AnyPlayer_EnterGame(event)
    local UIN = event.eventobjid --我不想变量名称太长
    
    --让玩家飞行
    Player:changPlayerMoveType(UIN,1)
    for i = 0 ,#intro --intro
    do
        Chat:sendSystemMsg(intro[i],UIN)
    end
    
    --检测并给玩家添加道具
    for k ,v in pairs(Itemid_List)
    do
        local result=Backpack:hasItemByBackpackBar(UIN,1,v)
        local result2=Backpack:hasItemByBackpackBar(UIN,2,v)
        if(result2==1001 and result==1001)
        then
            Player:gainItems(UIN,v,1,1)
        end
    end
    
    --检测玩家手持道具 创建玩家专属的表格元素
    local result,itemid=Player:getCurToolID(UIN)
    if(id==12002)--若是石矛
    then
        M_I_list[UIN]={['switch']=true}
        return 0
    else
        M_I_list[UIN]={['switch']=false}
    end
    M_I_list[UIN].copy = {
        way = 1 ,
        pos = {
            strpos = {},
            endpos = {},
        },
        vector = {},
        direction = {},
        areadata = {},
        LastPastePos = {}
    } --创建copy索引 
    
    return 0
end

--玩家离开游戏时 将玩家移出点击次数列表
local function Game_AnyPlayer_LeaveGame(event)
    M_I_list[event.eventobjid]=nil
end

--玩家输入字符串时 ...
local function PlayerNewInputContent(event)
    local UIN = event.eventobjid --我不想变量名称太长
    
    ---------------------- 通用功能 ----------------------
    if(event.content=="清除乐器方块数据")--清除对应玩家的数据
    then
        M_I_list[UIN]['block_id']=nil
        M_I_list[UIN]['click_num']=nil
        M_I_list[UIN]['z_bloid']=nil
        M_I_list[UIN]['z_num']=nil
        M_I_list[UIN]['switch']=false
        Trigger:wait(0.1)
        Chat:sendSystemMsg("#R清除乐器方块数据成功",UIN)
        return 0
    end
    
    --飞行控件 若运行了 函数到此结束
    if(event.content=="飞")
    then
        local result = Player:changPlayerMoveType(UIN,1)
        return 0
    end
        
    if(event.content=="落")
    then
        local result = Player:changPlayerMoveType(UIN,0)
        return 0
    end
    
    --对玩家展示使用说明
    if(event.content=="使用说明")
    then
        user(UIN)
        return 0
    end
    ---------------------- 区域方块复制 ----------------------
    --手持极寒域法杖 执行撤销操作/ 输入数字 改变copy.way(粘贴的方式)
    local result,CurToolid=Player:getCurToolID(UIN)
    if(CurToolid == 11668 )
    then 
        --执行撤销操作
        if(event.content == "撤销")
        then
            if(M_I_list[UIN].copy.LastPastePos.x)
            then 
                Chat:sendSystemMsg("开始撤销")
                ctrl_z(UIN)
            end 
            return 0 
        end 
        
        local num = tonumber(event.content)
        if(num>= 1 and num<= 3 )
        then 
            M_I_list[UIN].copy.way = num
            Chat:sendSystemMsg(string.format("#c8bf6ab已将粘贴的方式改为#W%d",num),UIN)
        end 
        return 0 
    end
    
    ---------------------- 乐器方块的录入数据 ----------------------    
    local result,block_id=Player:getCurToolID(UIN)
    if(block_id==693 or block_id==694 or block_id==695) --鼓 电子 综合
    then
        --若玩家手持道具类型是乐器方块 则赋值给对应table中的value
        M_I_list[UIN]['block_id']=block_id
        num=event.content*1--获取玩家在聊天框中输入的内容 若是一个>=0且<=7的数 则进行下一步
        if(num~=nil)
        then
            if(num>=0 and num<=7)
            then
                M_I_list[UIN]['click_num']=num
                --提示录入的数据
                local result,name=Item:getItemName(M_I_list[UIN]['block_id'])
                Trigger:wait(0.1)
                Chat:sendSystemMsg(string.format("#c66ccff乐器方块生成器：#cff7aad录入数据\n#c8bf6ab方块：%s #cB388FF点击次数：%d\n#Y手持石矛对准目标位置再次选择该快捷栏可放置方块",name,M_I_list[UIN]['click_num']),UIN)
                M_I_list[UIN]['z_bloid']=nil
                M_I_list[UIN]['z_num']=nil
                --消灭掉可能存在的音组数据
            end
        end
        return 0
    end
    
    ---------------------- 音调方块的生成 ----------------------
    local result,blockid=Player:getCurToolID(UIN)
    if(blockid==690 or blockid==691 or blockid==692)
    then
        if(type(tonumber(event.content))=="number")--获取玩家在聊天框中输入的内容 若是一个数 则进行下一步
        then
            clicknum=tonumber(event.content)
        else--若不是数 则判断字母
            if(event.content=="C" or event.content=="c")
            then
                clicknum=C
            elseif(event.content=="D" or event.content=="d")
            then
                clicknum=D
            elseif(event.content=="E" or event.content=="e")
            then
                clicknum=E
            elseif(event.content=="F" or event.content=="f")
            then
                clicknum=F
            elseif(event.content=="G" or event.content=="g")
            then
                clicknum=G
            elseif(event.content=="A" or event.content=="a")
            then
                clicknum=A
            elseif(event.content=="B" or event.content=="b")
            then
                clicknum=B
            end
        end
        
        if(clicknum>=0 and clicknum<=11)--若clicknum>=0且<=11 生成方块
        then
            local result,x,y,z=Actor:getPosition(UIN)--获取玩家位置
            local result=Block:setBlockAll(x,y,z,blockid,clicknum) --放置音调方块
            if(result==1001)
            then
                Chat:sendSystemMsg("PutMusicBlock:放置音调方块发育不正常",UIN)
                return 1001--返回发育不正常码
            end
            --位置偏移
            Actor:setPosition(UIN,x+p_x,y+p_y,z+p_z)
        end
        return 0
    end
end 

--玩家选择快捷栏时运行
local function PutMIBlock(event)
    local UIN = event.eventobjid --我不想变量名称太长
    --如是收割者 弹窗提醒 改变switch 结束函数
    if(event.itemid==12009)
    then
        M_I_list[UIN]['switch']=false
        Player:notifyGameInfo2Self(UIN,"#c8bf6ab手持道具收割者点击方块可将其清除")
        return 0
    end
    
    --如是雷电法杖 可取消点 或输出提示 如不是 则进行清除数据的操作
    if(event.itemid == 11582)
    then 
        local pos = M_I_list[UIN].copy.pos --引用这个表
        --分情况
        if(pos.strpos.x and pos.endpos.x == nil)
        then 
            World:stopEffectOnPosition(pos.strpos.x,pos.strpos.y,pos.strpos.z,CopyEffectId)--停止特效
            pos.strpos = {}
            Chat:sendSystemMsg("取消了区域起点",UIN)
            return 0 
        end
        if(pos.strpos.x and pos.endpos.x)
        then 
            World:stopEffectOnPosition(pos.endpos.x,pos.endpos.y,pos.endpos.z,CopyEffectId)--停止特效
            pos.endpos = {}
            Chat:sendSystemMsg("取消了区域终点",UIN)
            return 0 
        end
        Chat:sendSystemMsg("#c8bf6ab这是复制区域时框选区域用的道具，不会用的话，在聊天框输入“使用说明”可以查看使用文档哦", UIN)
        return 0 
    else 
        local pos = M_I_list[UIN].copy.pos --引用这个表
        if(pos.strpos.x or pos.endpos.x)
        then
            --停止特效
            World:stopEffectOnPosition(pos.strpos.x,pos.strpos.y,pos.strpos.z,CopyEffectId)
            World:stopEffectOnPosition(pos.endpos.x,pos.endpos.y,pos.endpos.z,CopyEffectId)
            --清除数据
            pos.strpos = {}
            pos.endpos = {}
            --不结束这个函数！
        end 
    end 
    
    --如是极寒域法杖 输出提示
    if(event.itemid == 11668)
    then 
        if(M_I_list[UIN].copy.direction.x )--有数据
        then 
            Chat:sendSystemMsg(string.format("使用极寒域法杖可以您的位置为起点粘贴区域的音乐方块，您当前的粘贴方式为%d",M_I_list[UIN].copy.way),UIN)
            Chat:sendSystemMsg("粘贴方式枚举 1:无视光束线粘贴(默认) 2.无视除电路外任何方块粘贴 3:无视任何方块粘贴",UIN)
            Chat:sendSystemMsg("#c8bf6ab手持极寒域法杖输入1 2 3 可改变粘贴的策略", UIN)
        else 
            Chat:sendSystemMsg("#c8bf6ab这是粘贴区域内音乐方块用的道具，不会用的话，在聊天框输入“使用说明”可以查看使用文档哦", UIN)
            Chat:sendSystemMsg("#c8bf6ab手持极寒域法杖输入1 2 3 可改变粘贴的策略", UIN)
        end 
        return 0 
    end 
    
    --如是石矛 且开关为开 放置方块...
    if(event.itemid==12002 and M_I_list[UIN]['switch'])
    then
        local result,x,y,z=Player:getAimPos(UIN)--获取玩家准心位置
        --若该位置的方块不是空气方块且不是光束线 则向上偏移一格
        local y1=y--保留y的初值
        local isrun=false 
        local result,id=Block:getBlockID(x,y,z)
        if(id ~= 0 and id ~= 351)
        then
            y=y+1
            if(M_I_list[UIN]['z_bloid'] and M_I_list[UIN]['z_num'])--若有音组数据 再向上偏移一格(考虑到地面上的情况)
            then
                y=y+1
                isrun=true
            end
        end
        
        --若有音组数据 且音调处的方块不是空气 则向上偏移一格
        if(M_I_list[UIN]['z_bloid'] and M_I_list[UIN]['z_num'] and isrun==false)
        then
            local result,id=Block:getBlockID(x,y1-1,z)
            if(id~=0)
            then
                y=y1+1
            end
        end
        
        --康康'click_num'参数是否存在
        if(M_I_list[UIN]['click_num']==nil)
        then
            Trigger:wait(0.1)
            Chat:sendSystemMsg("乐器方块生成器:请您输入点击次数 否则程序无法发育",UIN)
            return 1001--返回发育不正常码
        end
        
        local result=Block:setBlockAll(x,y,z,M_I_list[UIN]['block_id'],M_I_list[UIN]['click_num'])
        --康康放置乐器方块发育正不正常
        if(result==1001)
        then
            Trigger:wait(0.1)
            Chat:sendSystemMsg("PutMusicBlock:放置乐器方块发育不正常",UIN)
            return 1001--返回发育不正常码
        end
        World:playParticalEffect(x,y,z,1005,1)--播放特效
        --放置音调方块（若有） 飘窗文字提示
        local result,name=Item:getItemName(M_I_list[UIN]['block_id'])
        if(M_I_list[UIN]['z_bloid'] and M_I_list[UIN]['z_num'])--若有音组数据 则放置音调方块
        then
            local result=Block:setBlockAll(x,y-1,z,M_I_list[UIN]['z_bloid'],M_I_list[UIN]['z_num'])
            local result,z_name=Item:getItemName(M_I_list[UIN]['z_bloid'])
            Player:notifyGameInfo2Self(UIN,string.format("#c8bf6ab粘贴成功 %s %d %s %d",name,M_I_list[UIN]['click_num'],z_name,M_I_list[UIN]['z_num']))
        else--没有则只提示乐器方块的
            Player:notifyGameInfo2Self(UIN,string.format("#c8bf6ab乐器方块生成：%s %d",name,M_I_list[UIN]['click_num']))
        end
    end
    
    if(event.itemid==12002) --若是石矛 开启特效提示 否则关闭（变量赋值）
    then
        if(M_I_list[UIN]['switch']==false)
        then
            local result,name=Item:getItemName(M_I_list[UIN]['block_id'])
            --飘窗文字提示
            if(M_I_list[UIN]['z_bloid'] and M_I_list[UIN]['z_num'])--若有音组数据 则提示全部的数据 
            then
                local result,z_name=Item:getItemName(M_I_list[UIN]['z_bloid'])
                Player:notifyGameInfo2Self(UIN,string.format("#c8bf6ab当前数据 %s %d %s %d",name,M_I_list[UIN]['click_num'],z_name,M_I_list[UIN]['z_num']))
            else--没有则只提示乐器方块的
                Player:notifyGameInfo2Self(UIN,string.format("#c8bf6ab当前数据：%s %d",name,M_I_list[UIN]['click_num']))
            end
        end
        M_I_list[UIN]['switch']=true
    else
        M_I_list[UIN]['switch']=false
    end

    return 0
end

--每秒运行一次
local function Game_RunTime(event)
    if(event.second) 
    then
        for playerid,tab in pairs(M_I_list)
        do
            if(tab['switch'])
            then
                local result,x,y,z=Player:getAimPos(playerid)--获取玩家准星位置
                World:playParticalEffect(x,y,z,1182,1)--播放特效
            end
        end
    end
end

--玩家点击方块时运行
local function ClickBlock(event)
    local UIN = event.eventobjid --我不想变量名称太长
    
    --收割者清除方块
    local result,itemid=Player:getCurToolID(UIN)
    if(itemid==12009)--若是收割者
    then--破坏掉那个方块 结束函数
        Block:destroyBlock(event.x,event.y,event.z,false)
        return 0
    end
    --提示方块类型 数据
    local result,name=Item:getItemName(event.blockid)
    local result,data=Block:getBlockData(event.x,event.y,event.z)
    Chat:sendSystemMsg("方块名称：#W"..name..'#n ID：#W'..event.blockid,UIN)
    Chat:sendSystemMsg('坐标 #W('..event.x..","..event.y..","..event.z..")   ".."#n方块data：#W"..data,UIN)
    return 0
end

--方块被撸时运行
local function rtrq(event)
    local UIN = event.eventobjid --我不想变量名称太长
    local result,item_id=Player:getCurToolID(UIN)--获得手持道具id
    
    --乐器方块部分的音组复制数据录入
    if(item_id==12002)
    then
        if(event.blockid==693 or event.blockid==694 or event.blockid==695)
        then
            local result,data=Block:getBlockData(event.x,event.y,event.z)
            M_I_list[UIN]['block_id']=event.blockid
            M_I_list[UIN]['click_num']=data
            local result,id=Block:getBlockID(event.x,event.y-1,event.z)--下面的音调方块id
            if(id==690 or id==691 or id==692)
            then
                local result,data=Block:getBlockData(event.x,event.y-1,event.z)
                M_I_list[UIN]['z_bloid']=id
                M_I_list[UIN]['z_num']=data
                local result,name=Item:getItemName(M_I_list[UIN].block_id)
                local result,z_name=Item:getItemName(M_I_list[UIN].z_bloid)
                Chat:sendSystemMsg(string.format("#c66ccff乐器方块生成器：#cff7aad复制音组\n#c8bf6ab乐器方块：%s #cB388FF点击次数：%d\n#c8bf6ab音调方块：%s #cB388FF点击次数：%d\n#Y手持石矛对准目标位置再次选择该快捷栏可粘贴方块",name,M_I_list[UIN]['click_num'],z_name,M_I_list[UIN]['z_num']),UIN)
                return 0
            end
            local result,name=Item:getItemName(M_I_list[UIN]['block_id'])
            Chat:sendSystemMsg(string.format("#c66ccff乐器方块生成器：#cff7aad复制音组\n#c8bf6ab方块：%s #cB388FF点击次数：%d\n#Y手持石矛对准目标位置再次选择该快捷栏可粘贴方块",name,M_I_list[UIN]['click_num']),UIN)
        end
        return 0
    end
    
    --框选区域之锚定坐标点
    if(item_id == 11582)
    then 
        --起点
        if(M_I_list[UIN].copy.pos.strpos.x == nil and M_I_list[UIN].copy.pos.endpos.x == nil)
        then 
            M_I_list[UIN].copy.pos.strpos.x, M_I_list[UIN].copy.pos.strpos.y, M_I_list[UIN].copy.pos.strpos.z = event.x,event.y,event.z
            World:playParticalEffect(M_I_list[UIN].copy.pos.strpos.x, M_I_list[UIN].copy.pos.strpos.y, M_I_list[UIN].copy.pos.strpos.z,CopyEffectId,1) --在锚定的点上播放特效
            Chat:sendSystemMsg(string.format("#c8EC3B0已锚定区域起点(%d,%d,%d)",M_I_list[UIN].copy.pos.strpos.x, M_I_list[UIN].copy.pos.strpos.y, M_I_list[UIN].copy.pos.strpos.z),UIN)
            Chat:sendSystemMsg("#c9ED5C5选择其他快捷栏清除所有锚定的点", UIN)
            return 0
        end
        
        --终点
        if(M_I_list[UIN].copy.pos.strpos.x and M_I_list[UIN].copy.pos.endpos.x == nil)
        then 
            M_I_list[UIN].copy.pos.endpos.x, M_I_list[UIN].copy.pos.endpos.y, M_I_list[UIN].copy.pos.endpos.z = event.x,event.y,event.z
            World:playParticalEffect(M_I_list[UIN].copy.pos.endpos.x, M_I_list[UIN].copy.pos.endpos.y, M_I_list[UIN].copy.pos.endpos.z ,CopyEffectId,1) --在锚定的点上播放特效
            Chat:sendSystemMsg(string.format("#c8EC3B0已锚定区域终点(%d,%d,%d)",M_I_list[UIN].copy.pos.endpos.x, M_I_list[UIN].copy.pos.endpos.y, M_I_list[UIN].copy.pos.endpos.z ),UIN)
            Chat:sendSystemMsg("#c9ED5C5选择其他快捷栏清除所有锚定的点", UIN)
            Chat:sendSystemMsg("#cBCEAD5再次使用雷电法杖可以复制", UIN)
            Chat:sendSystemMsg("#cDEF5E5再次选择雷电法杖快捷栏可取消区域的终结点", UIN)
            return 0
        end
    end
end

--玩家使用道具时执行
local function useitem(event)
    local UIN = event.eventobjid --我不想变量名称太长
    
    --石矛 瞬移
    if(event.itemid == 12002)
    then 
        local result,x,y,z=Player:getAimPos(UIN)--获取玩家准心位置
        Actor:setPosition(UIN,x,y,z) --瞬移
        return 0 
    end 
    
    --雷电法杖 框选区域之锚定坐标点和录入复制数据
    if(event.itemid == 11582)
    then 
        --起点
        if(M_I_list[UIN].copy.pos.strpos.x == nil and M_I_list[UIN].copy.pos.endpos.x == nil)
        then 
            local result,x,y,z=Actor:getPosition(UIN)
            M_I_list[UIN].copy.pos.strpos.x = x
            M_I_list[UIN].copy.pos.strpos.y = y
            M_I_list[UIN].copy.pos.strpos.z = z
            World:playParticalEffect(M_I_list[UIN].copy.pos.strpos.x, M_I_list[UIN].copy.pos.strpos.y, M_I_list[UIN].copy.pos.strpos.z,CopyEffectId,1) --在锚定的点上播放特效
            Chat:sendSystemMsg(string.format("#c8EC3B0已锚定区域起点(%d,%d,%d)",M_I_list[UIN].copy.pos.strpos.x, M_I_list[UIN].copy.pos.strpos.y, M_I_list[UIN].copy.pos.strpos.z),UIN)
            Chat:sendSystemMsg("#c9ED5C5选择其他快捷栏清除所有锚定的点", UIN)
            return 0
        end
        
        --终点
        if(M_I_list[UIN].copy.pos.strpos.x and M_I_list[UIN].copy.pos.endpos.x == nil)
        then 
            local result,x,y,z=Actor:getPosition(UIN)
            M_I_list[UIN].copy.pos.endpos.x = x
            M_I_list[UIN].copy.pos.endpos.y = y
            M_I_list[UIN].copy.pos.endpos.z = z
            World:playParticalEffect(M_I_list[UIN].copy.pos.endpos.x, M_I_list[UIN].copy.pos.endpos.y, M_I_list[UIN].copy.pos.endpos.z ,CopyEffectId,1) --在锚定的点上播放特效
            Chat:sendSystemMsg(string.format("#c8EC3B0已锚定区域终点(%d,%d,%d)",M_I_list[UIN].copy.pos.endpos.x, M_I_list[UIN].copy.pos.endpos.y, M_I_list[UIN].copy.pos.endpos.z),UIN)
            Chat:sendSystemMsg("#c9ED5C5选择其他快捷栏清除所有锚定的点", UIN)
            Chat:sendSystemMsg("#cBCEAD5再次使用雷电法杖可以复制", UIN)
            Chat:sendSystemMsg("#cDEF5E5再次选择雷电法杖快捷栏可取消区域的终结点", UIN)
            return 0
        end
        
        --录入数据（相当于复制到剪贴板）
        if(M_I_list[UIN].copy.pos.strpos.x and M_I_list[UIN].copy.pos.endpos.x)
        then 
            --末位置减去初位置，得到相对于原点的向量
            M_I_list[UIN].copy.vector.x = M_I_list[UIN].copy.pos.endpos.x - M_I_list[UIN].copy.pos.strpos.x
            M_I_list[UIN].copy.vector.y = M_I_list[UIN].copy.pos.endpos.y - M_I_list[UIN].copy.pos.strpos.y
            M_I_list[UIN].copy.vector.z = M_I_list[UIN].copy.pos.endpos.z - M_I_list[UIN].copy.pos.strpos.z
            local direction = M_I_list[UIN].copy.direction
            M_I_list[UIN].copy.direction = {x=1,y=1,z=1} --the direction of the vector 向量的方向
            --考虑负的情况
            if(M_I_list[UIN].copy.vector.x < 0) 
            then
                M_I_list[UIN].copy.direction.x = -1
            end 
            if(M_I_list[UIN].copy.vector.y < 0)
            then
                M_I_list[UIN].copy.direction.y = -1
            end 
            if(M_I_list[UIN].copy.vector.z < 0)
            then
                M_I_list[UIN].copy.direction.z = -1
            end 
            
            Chat:sendSystemMsg(string.format("#cBCCEF8方块复制：开始录入数据，向量(%d,%d,%d)，方向(%d,%d,%d)",M_I_list[UIN].copy.vector.x, M_I_list[UIN].copy.vector.y, M_I_list[UIN].copy.vector.z, M_I_list[UIN].copy.direction.x, M_I_list[UIN].copy.direction.y, M_I_list[UIN].copy.direction.z),UIN)
            
            --执行复制函数
            ctrl_c(UIN)
            
            --停止起点和终点的特效
            World:stopEffectOnPosition(M_I_list[UIN].copy.pos.strpos.x, M_I_list[UIN].copy.pos.strpos.y, M_I_list[UIN].copy.pos.strpos.z,CopyEffectId)
            World:stopEffectOnPosition(M_I_list[UIN].copy.pos.endpos.x, M_I_list[UIN].copy.pos.endpos.y, M_I_list[UIN].copy.pos.endpos.z,CopyEffectId)
            --清除起点和终点的数据
            M_I_list[UIN].copy.pos.strpos = {}
            M_I_list[UIN].copy.pos.endpos = {}
            return 0
        end 
    end 
    
    --极寒域法杖 粘贴 
    if(event.itemid == 11668)
    then 
        if(M_I_list[UIN].copy.direction.x)
        then 
            Chat:sendSystemMsg("#c8bf6ab开始粘贴")
            ctrl_v(UIN)
        end 
        return 0 
    end
end 

---------------------- 事件监听器 ----------------------
--注册玩家输入字符串监听器  
ScriptSupportEvent:registerEvent([=[Player.NewInputContent]=],PlayerNewInputContent)
--注册玩家进入游戏监听器
ScriptSupportEvent:registerEvent([=[Game.AnyPlayer.EnterGame]=],Game_AnyPlayer_EnterGame)
--注册玩家离开游戏监听器
ScriptSupportEvent:registerEvent([=[Game.AnyPlayer.LeaveGame]=],Game_AnyPlayer_LeaveGame)
--注册玩家选择快捷栏监听器
ScriptSupportEvent:registerEvent([=[Player.SelectShortcut]=],PutMIBlock)
--每秒运行一次的事件
ScriptSupportEvent:registerEvent([=[Game.RunTime]=],Game_RunTime)
--注册玩家点击方块监听器
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],ClickBlock)--{eventobjid, blockid, x, y, z}
--注册方块被撸监听器
ScriptSupportEvent:registerEvent([=[Block.Dig.Begin]=],rtrq)--	 {eventobjid, blockid, x, y, z}
--注册玩家使用道具监听器
ScriptSupportEvent:registerEvent([=[Player.UseItem]=],useitem)--eventobjid,itemid,itemnum,itemix

-----------------------------------------------------------------------------------------------------------------------------------------

--[[{
更新日志awa
    v1.0 2023.01.20
    基本框架 使用方法：手持道具（鼓 电子 综合 乐器方块）输入音块的点击次数 站在目标位置上按下潜行键 自动生成对应的音乐方块
    
    后多次更新 修复bug等 作者未详记
    
    v1.5 2023.03.04
    修改使用方法 用石矛做生成工具 
    修改数据存储方法 联机房间中房主和各玩家均可以正常使用
    
    v1.6 2023.03.05
    增加更多提示功能 优化特效
    
    v1.7 2023.03.05
    将音调方块的生成和乐器方块的生成合并为一个项目 音乐方块生成器 便于玩家使用
    
    v1.8 2023.03.06 
    在玩家背包中检测和添加初始道具
    
    v1.9 2023.03.25
    新增音乐组（音调+乐器）复制功能
    新增玩家飞行功能（玩家在聊天框中输入“飞”或“落”进行控制）
    新增音调方块生成后玩家脱身功能 避免被方块卡住
    新增点击方块后显示方块坐标等信息功能
    新增玩家手持道具收割者(12009)点击方块将其清除的功能
    优化提示
    
    v1.10 2023.7.24
    新增使用说明 修改了intro
    将玩家的初始状态改为飞行
    修改生成规则以适应新电路
    
    v1.10.1 2023.7.29
    新增使用石矛瞬移功能
    修改提示
    修复了提示的bug
    
    v1.11 2023.8.4
    新增区域内音乐方块复制功能
--}]]
