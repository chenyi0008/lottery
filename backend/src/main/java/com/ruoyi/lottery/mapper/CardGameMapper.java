package com.ruoyi.lottery.mapper;

import java.util.List;
import com.ruoyi.lottery.domain.CardGame;
import com.ruoyi.lottery.domain.CardGameProduct;
import com.ruoyi.lottery.domain.CardGameRules;

/**
 * 活动管理Mapper接口
 * 
 * @author Shawn
 * @date 2023-12-28
 */
public interface CardGameMapper 
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
     * 删除活动管理
     * 
     * @param id 活动管理主键
     * @return 结果
     */
    public int deleteCardGameById(Integer id);

    /**
     * 批量删除活动管理
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCardGameByIds(String[] ids);

    /**
     * 批量删除活动奖品
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCardGameProductByGameids(String[] ids);
    
    /**
     * 批量新增活动奖品
     * 
     * @param cardGameProductList 活动奖品列表
     * @return 结果
     */
    public int batchCardGameProduct(List<CardGameProduct> cardGameProductList);
    

    /**
     * 通过活动管理主键删除活动奖品信息
     * 
     * @param id 活动管理ID
     * @return 结果
     */
    public int deleteCardGameProductByGameid(Integer id);
    /**
     * 批量删除活动策略
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCardGameRulesByGameids(String[] ids);

    /**
     * 批量新增活动策略
     *
     * @param cardGameRulesList 活动策略列表
     * @return 结果
     */
    public int batchCardGameRules(List<CardGameRules> cardGameRulesList);


    /**
     * 通过活动管理主键删除活动策略信息
     *
     * @param id 活动管理ID
     * @return 结果
     */
    public int deleteCardGameRulesByGameid(Integer id);

}
