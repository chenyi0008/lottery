-- 从KEYS数组中获取tokens_key和timestamp_key
local tokens_key = KEYS[1]      -- 令牌桶键
local timestamp_key = KEYS[2]   -- 时间戳键

-- 解析传入参数，包括速率、容量、当前时间和请求的令牌数量
local rate = tonumber(ARGV[1])     -- 速率
local capacity = tonumber(ARGV[2]) -- 容量
local now = tonumber(ARGV[3])      -- 当前时间
local requested = tonumber(ARGV[4])  -- 请求的令牌数量

-- 计算填充时间和TTL（存活时间）
local fill_time = capacity / rate
local ttl = math.floor(fill_time * 2)

-- 获取上次令牌和时间戳的信息
local last_tokens = tonumber(redis.call("get", tokens_key))       -- 上次令牌数量
if last_tokens == nil then
  last_tokens = capacity
end

local last_refreshed = tonumber(redis.call("get", timestamp_key))  -- 上次刷新时间戳
if last_refreshed == nil then
  last_refreshed = 0
end

-- 计算时间差和新的令牌数量
local delta = math.max(0, now - last_refreshed)
local filled_tokens = math.min(capacity, last_tokens + (delta * rate))

-- 检查是否允许请求通过，计算新的令牌数量和允许标志
local allowed = filled_tokens >= requested
local new_tokens = filled_tokens
local allowed_num = 0
if allowed then
  new_tokens = filled_tokens - requested
  allowed_num = 1
end

-- 设置新的令牌数量和时间戳，并返回允许标志和新的令牌数量
redis.call("setex", tokens_key, ttl, new_tokens)
redis.call("setex", timestamp_key, ttl, now)

return { allowed_num, new_tokens }
