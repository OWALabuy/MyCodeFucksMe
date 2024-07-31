local count = 0

while(count < 5)
do
    print("我跑了一圈")
    --跑一圈 把计数加1
    count = count + 1
    -- ..是连接字符串的符号 在字符串章节会详细说明
    print("我已经完成了" .. count .. "圈")
end

print("我跑完了")
