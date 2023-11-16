package com.itheima.prize.msg;

import com.itheima.prize.commons.config.RabbitKeys;
import com.itheima.prize.commons.db.entity.CardUserGame;
import com.itheima.prize.commons.db.mapper.CardUserGameMapper;
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
    private CardUserGameMapper cardUserGameMapper;

    @RabbitHandler
    public void processMessage3(CardUserGame message) {
        logger.info("user play : game={},user={},time={} " , message.getGameid(),message.getUserid(),message.getCreatetime());
        cardUserGameMapper.insert(message);
    }

}
