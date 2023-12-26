package com.itheima.prize.commons.db.mapper;

import com.itheima.prize.commons.db.entity.CardProductDto;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface GameLoadMapper {


    /*
    * 根据活动获取绑定的奖品以及数量
    * */
    @Select("select p.*,cgp.amount from card_product p " +
            "join card_game_product cgp on p.id=cgp.productid " +
            "where cgp.gameid=#{gameId,jdbcType=INTEGER}")
    public List<CardProductDto> getByGameId(int gameId);
    /**
     * 用户参与的活动数
     * @param userid
     * @return
     */
    @Select("select count(id) as num from card_user_game c where userid=#{userid} group by userid")
    public Integer getGamesNumByUserId(int userid);

    /**
     * 用户中奖数统计
     * @param userid
     * @return
     */
    @Select("select count(id) as num from card_user_hit where userid=#{userid} group by userid")
    public Integer getPrizesNumByUserId(int userid);
}
