package com.itheima.prize.msg;

import com.alibaba.fastjson.JSON;
import com.itheima.prize.commons.config.RabbitKeys;
import com.itheima.prize.commons.db.entity.CardUserHit;
import com.itheima.prize.commons.db.mapper.CardUserHitMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@RabbitListener(queues = RabbitKeys.QUEUE_HIT)
public class PrizeHitReceiver {
    private final static Logger logger = LoggerFactory.getLogger(PrizeHitReceiver.class);

    @Autowired
    private CardUserHitMapper hitMapper;

    @RabbitHandler
    public void processMessage2(String message) {
        logger.info("user hit : message={}", message);
        hitMapper.insert(JSON.parseObject(message, CardUserHit.class));
    }
}