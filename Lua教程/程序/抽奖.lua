math.randomseed(os.time())
local ranNum = math.random(100)
print(ranNum)

if(ranNum <= 10) then
    print("10%概率抽到")
elseif(ranNum <= 40) then
    print("30%")
elseif(ranNum <= 80) then
    print("40%")
else
    print("20%")
end

