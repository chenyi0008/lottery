package com.chenyi.prize.msg;

import com.alibaba.fastjson.JSON;
import com.chenyi.prize.commons.config.RabbitKeys;
import com.chenyi.prize.commons.db.entity.CardUserGame;
import com.chenyi.prize.commons.db.service.CardUserGameService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@RabbitListener(queues = RabbitKeys.QUEUE_PLAY)
public class PrizeGameReceiver {

    private final static Logger logger = LoggerFactory.getLogger(PrizeGameReceiver.class);

    @Autowired
    private CardUserGameService cardUserGameService;

    @RabbitHandler
    public void processMessage(String message) {

        logger.info("user play : msg={}" , message);
        //TODO
        CardUserGame cardUserGame = JSON.parseObject(message, CardUserGame.class);
        boolean save = cardUserGameService.save(cardUserGame);
        if(!save){
            logger.warn(RabbitKeys.QUEUE_PLAY, " save failed,", cardUserGame.toString());
        }
    }

}
