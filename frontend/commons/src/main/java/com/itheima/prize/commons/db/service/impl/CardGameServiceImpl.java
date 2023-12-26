package com.itheima.prize.commons.db.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itheima.prize.commons.db.entity.CardGame;
import com.itheima.prize.commons.db.service.CardGameService;
import com.itheima.prize.commons.db.mapper.CardGameMapper;
import org.springframework.stereotype.Service;

/**
* @author shawn
* @description 针对表【card_game】的数据库操作Service实现
* @createDate 2023-12-26 11:58:48
*/
@Service
public class CardGameServiceImpl extends ServiceImpl<CardGameMapper, CardGame>
    implements CardGameService{

}




