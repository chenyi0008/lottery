package com.itheima.prize.commons.db.service;

import com.itheima.prize.commons.db.entity.CardProductDto;

import java.util.List;

public interface GameLoadService {

    /*
     * 根据活动获取绑定的奖品以及数量
     * */
    public List<CardProductDto> getByGameId(int gameId);
    /**
     * 用户参与的活动数
     * @param userid
     * @return
     */
    public Integer getGamesNumByUserId(int userid);

    /**
     * 用户中奖数统计
     * @param userid
     * @return
     */
    public Integer getPrizesNumByUserId(int userid);
}
