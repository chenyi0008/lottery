package com.ruoyi.lottery.service;

import java.util.List;
import com.ruoyi.lottery.domain.CardGame;

/**
 * 活动管理Service接口
 * 
 * @author Shawn
 * @date 2023-12-28
 */
public interface ICardGameService 
{
    /**
     * 查询活动管理
     * 
     * @param id 活动管理主键
     * @return 活动管理
     */
    public CardGame selectCardGameById(Integer id);

    /**
     * 查询活动管理列表
     * 
     * @param cardGame 活动管理
     * @return 活动管理集合
     */
    public List<CardGame> selectCardGameList(CardGame cardGame);

    /**
     * 新增活动管理
     * 
     * @param cardGame 活动管理
     * @return 结果
     */
    public int insertCardGame(CardGame cardGame);

    /**
     * 修改活动管理
     * 
     * @param cardGame 活动管理
     * @return 结果
     */
    public int updateCardGame(CardGame cardGame);

    /**
     * 批量删除活动管理
     * 
     * @param ids 需要删除的活动管理主键集合
     * @return 结果
     */
    public int deleteCardGameByIds(String ids);

    /**
     * 删除活动管理信息
     * 
     * @param id 活动管理主键
     * @return 结果
     */
    public int deleteCardGameById(Integer id);
}
