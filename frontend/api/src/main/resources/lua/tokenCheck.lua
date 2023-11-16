
local token = redis.call('lpop',KEYS[1])
local curtime = tonumber(KEYS[2])
if token ~= false then
    if ( tonumber(token)/1000 > tonumber(KEYS[2]) ) then
       redis.call('lpush',KEYS[1],token)
       return 1
    else
       return tonumber(token)
    end
else
    return 0
end