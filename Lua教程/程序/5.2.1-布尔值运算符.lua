local a, b = true, false

local c = a and b --c为false
local d = a or b --d为true

local e = not a --e为false
local f = not b --f为true

print(c, d, e, f)
