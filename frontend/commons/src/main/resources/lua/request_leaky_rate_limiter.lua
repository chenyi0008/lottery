-- 基于漏桶算法的限流器。主要作用如下：
--
-- 定义了漏桶键和上次更新键，用于存储漏桶中的令牌数量和上次更新时间。
-- 解析传入的参数，包括漏桶的容量、漏水速率、当前时间戳和请求的令牌数量。
-- 计算漏桶的存活时间，即漏桶的容量除以漏水速率再加1。
-- 获取漏桶中当前的令牌数量和上次漏水的时间。
-- 根据当前时间与上次漏水时间的时间间隔以及漏水速率，计算已经漏出的令牌数量。
-- 清空漏桶，即将已经漏出的令牌数量从漏桶中移除，并更新上次更新时间为当前时间。
-- 根据请求的令牌数量判断是否允许通过，如果新的令牌数量不超过漏桶容量，则允许通过，否则不允许通过。
-- 更新漏桶中的令牌数量和上次更新时间。
-- 返回是否允许通过的标志和新的令牌数量。



-- 从KEYS数组中获取漏桶键和上次更新键
local leaky_bucket_key = KEYS[1]    -- 漏桶键
local last_bucket_key = KEYS[2]     -- 上次更新键

-- 解析传入参数，包括容量、漏水速率、当前时间和请求数量
local capacity = tonumber(ARGV[2])  -- 漏桶容量
local rate = tonumber(ARGV[1])      -- 漏水速率
local requested = tonumber(ARGV[4]) -- 请求的令牌数量
local now = tonumber(ARGV[3])       -- 当前时间戳

-- 计算漏桶的存活时间
local key_lifetime = math.ceil((capacity / rate) + 1)

-- 获取漏桶中当前的令牌数量，默认为0
local key_bucket_count = tonumber(redis.call("GET", leaky_bucket_key)) or 0

-- 获取上次漏水的时间，默认为当前时间
local last_time = tonumber(redis.call("GET", last_bucket_key)) or now

-- 计算距离上次漏水的时间间隔
local millis_since_last_leak = now - last_time

-- 计算已经漏出的令牌数量
local leaks = millis_since_last_leak * rate

-- 清空漏桶
if leaks > 0 then
    if leaks >= key_bucket_count then
        key_bucket_count = 0
    else
        key_bucket_count = key_bucket_count - leaks
    end
    last_time = now
end

-- 默认不允许通过
local is_allow = 0

-- 计算新的令牌数量
local new_bucket_count = key_bucket_count + requested

-- 允许通过
if new_bucket_count <= capacity then
    is_allow = 1
else
    -- 不允许通过，返回当前令牌数量
    return {is_allow, new_bucket_count}
end

-- 更新漏桶中的令牌数量
redis.call("SETEX", leaky_bucket_key, key_lifetime, new_bucket_count)

-- 更新上次更新时间
redis.call("SETEX", last_bucket_key, key_lifetime, now)

-- 返回允许标志和新的令牌数量
return {is_allow, new_bucket_count}
