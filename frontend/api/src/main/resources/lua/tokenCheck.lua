-- 从 Redis 中获取列表 `KEYS[1]` 的第一个元素，并将其保存在变量 `token` 中
local token = redis.call('lpop', KEYS[1])

-- 将 `KEYS[2]` 转换为数字类型，保存在变量 `curtime` 中
local curtime = tonumber(KEYS[2])

-- 如果获取到的 `token` 不为 false，则执行以下逻辑
if token ~= false then
    -- 如果 `token` 除以 1000 得到的结果大于 `KEYS[2]` 转换后的数字，则执行以下逻辑
    if (tonumber(token) / 1000 > tonumber(KEYS[2])) then
        -- 将 `token` 放回列表 `KEYS[1]` 的开头
        redis.call('lpush', KEYS[1], token)
        -- 返回 1，表示操作成功
        return 1
    else
        -- 返回 `token` 转换后的数字
        return tonumber(token)
    end
else
    -- 如果未获取到 `token`，则返回 0，表示没有可用的令牌
    return 0
end