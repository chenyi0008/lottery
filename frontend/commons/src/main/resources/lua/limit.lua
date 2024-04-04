-- 从参数中获取键和限流阈值以及时间窗口
local key = KEYS[1]  -- 键名
local limitCount = tonumber(ARGV[1])  -- 限流阈值，即允许的最大请求数
local limitTime = tonumber(ARGV[2])  -- 限流时间窗口，即限流的时间范围（以秒为单位）

-- 获取当前计数
local currentCount = redis.call('get', key)

-- 如果当前计数超过限流阈值，则返回当前计数（即超过限流）
if type(currentCount) == "number" and tonumber(currentCount) > limitCount then
    return tonumber(currentCount)
end

-- 如果当前计数没有超过限流阈值，则对计数器进行递增操作
currentCount = redis.call("incr", key)

-- 如果递增后的计数器的值为1，表示这是第一次请求，则设置键的过期时间为限流时间窗口
if tonumber(currentCount) == 1 then
    redis.call("expire", key, limitTime)
end

-- 返回当前计数，表示当前请求被允许
return tonumber(currentCount)
