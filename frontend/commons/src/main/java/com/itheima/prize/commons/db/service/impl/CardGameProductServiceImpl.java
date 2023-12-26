package com.itheima.prize.commons.db.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itheima.prize.commons.db.entity.CardGameProduct;
import com.itheima.prize.commons.db.service.CardGameProductService;
import com.itheima.prize.commons.db.mapper.CardGameProductMapper;
import org.springframework.stereotype.Service;

/**
* @author shawn
* @description 针对表【card_game_product】的数据库操作Service实现
* @createDate 2023-12-26 11:58:48
*/
@Service
public class CardGameProductServiceImpl extends ServiceImpl<CardGameProductMapper, CardGameProduct>
    implements CardGameProductService{

}




