package com.itheima.prize.commons.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.*;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * rabbit配置
 */
@Configuration
public class RabbitConfig {
    private static Logger log = LoggerFactory.getLogger(RabbitConfig.class);
    @Autowired
    private CachingConnectionFactory connectionFactory;


    @Bean
    public Queue getQueueHit() {
        return new Queue(RabbitKeys.QUEUE_HIT);
    }
    @Bean
    public Queue getQueuePlay() {
        return new Queue(RabbitKeys.QUEUE_PLAY);
    }

    /**
     * exchange
     */
    @Bean
    DirectExchange directExchange() {
        return new DirectExchange(RabbitKeys.EXCHANGE_DIRECT);
    }

    // 绑定队列于路由
    @Bean
    Binding bindingExchangeDirect() {
        return BindingBuilder.bind(getQueueHit()).to(directExchange()).with(RabbitKeys.QUEUE_HIT);
    }
    @Bean
    Binding bindingExchangeDirect2() {
        return BindingBuilder.bind(getQueuePlay()).to(directExchange()).with(RabbitKeys.QUEUE_PLAY);
    }


    @Bean
    public RabbitTemplate rabbitTemplate() {
        //若使用confirm-callback或return-callback，必须要配置publisherConfirms或publisherReturns为true
        //每个rabbitTemplate只能有一个confirm-callback和return-callback，如果这里配置了，那么写生产者的时候不能再写confirm-callback和return-callback
        //使用return-callback时必须设置mandatory为true，或者在配置中设置mandatory-expression的值为true
        connectionFactory.setPublisherConfirms(true);
        connectionFactory.setPublisherReturns(true);
        RabbitTemplate rabbitTemplate = new RabbitTemplate(connectionFactory);
        rabbitTemplate.setMandatory(true);
       /**
        * 如果消息没有到exchange,则confirm回调,ack=false
        * 如果消息到达exchange,则confirm回调,ack=true
        * exchange到queue成功,则不回调return
        * exchange到queue失败,则回调return(需设置mandatory=true,否则不回回调,消息就丢了)
        */
        rabbitTemplate.setConfirmCallback(new RabbitTemplate.ConfirmCallback() {
            @Override
            public void confirm(CorrelationData correlationData, boolean ack, String cause) {
                if (ack) {
                    log.info("消息发送成功:correlationData({}),ack({}),cause({})", correlationData, ack, cause);
                } else {
                    log.info("消息发送失败:correlationData({}),ack({}),cause({})", correlationData, ack, cause);
                }
            }
        });
        rabbitTemplate.setReturnCallback(new RabbitTemplate.ReturnCallback() {
            @Override
            public void returnedMessage(Message message, int replyCode, String replyText, String exchange, String routingKey) {
                log.info("消息丢失:exchange({}),route({}),replyCode({}),replyText({}),message:{}", exchange, routingKey, replyCode, replyText, message);
            }
        });
        return rabbitTemplate;
    }
}