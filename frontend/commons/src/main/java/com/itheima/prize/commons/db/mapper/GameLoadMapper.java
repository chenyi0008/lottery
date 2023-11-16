package com.itheima.prize.commons.db.mapper;

import com.itheima.prize.commons.db.entity.CardProductDto;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface GameLoadMapper {

    @Select("select p.*,cgp.amount from card_product p " +
            "join card_game_product cgp on p.id=cgp.productid " +
            "where cgp.gameid=#{gameId,jdbcType=INTEGER}")
    public List<CardProductDto> getByGameId(int gameId);
}
