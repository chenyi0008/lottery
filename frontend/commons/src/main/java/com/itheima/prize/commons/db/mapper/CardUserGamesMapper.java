package com.itheima.prize.commons.db.mapper;

import org.apache.ibatis.annotations.Select;

public interface CardUserGamesMapper {

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
