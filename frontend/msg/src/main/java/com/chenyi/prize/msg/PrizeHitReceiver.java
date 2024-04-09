package com.chenyi.prize.msg;

import com.alibaba.fastjson.JSON;
import com.chenyi.prize.commons.config.RabbitKeys;
import com.chenyi.prize.commons.db.entity.CardUserHit;
import com.chenyi.prize.commons.db.service.CardUserHitService;
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
    private CardUserHitService hitService;

    @RabbitHandler
    public void processMessage(String message) {
        logger.info("user hit : message={}", message);
        CardUserHit cardUserHit = JSON.parseObject(message, CardUserHit.class);
        boolean save = hitService.save(cardUserHit);
        if(!save)logger.warn("RabbitKeys.QUEUE_HIT", " save failed,", cardUserHit.toString());
    }
}