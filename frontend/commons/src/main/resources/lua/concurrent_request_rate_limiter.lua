-- 从KEYS数组中获取键和ID
local key = KEYS[1]        -- 有序集合键
local id = KEYS[2]         -- ID

-- 解析传入参数，包括容量和时间戳
local capacity = tonumber(ARGV[2])    -- 容量
local timestamp = tonumber(ARGV[3])   -- 时间戳

-- 获取有序集合中的成员数量
local count = redis.call("zcard", key)

-- 初始化允许标志和计数
local allowed = 0

-- 如果成员数量小于容量，则添加新的成员到有序集合中
if count < capacity then
  redis.call("zadd", key, timestamp, id)
  allowed = 1
  count = count + 1
end

-- 返回允许标志和更新后的成员数量
return { allowed, count }
