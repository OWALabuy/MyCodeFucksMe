local count = 0

for i = 1, 3
do
    local str = ""
    for j = 1, 4
    do
        str = str .. count .. " "
        count = count + 1
    end
    print(str)
end
