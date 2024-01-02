package com.ruoyi.lottery.mapper;

import java.util.List;
import com.ruoyi.lottery.domain.CardGameRules;

/**
 * 活动策略Mapper接口
 * 
 * @author Shawn
 * @date 2023-12-29
 */
public interface CardGameRulesMapper 
{
    /**
     * 查询活动策略
     * 
     * @param id 活动策略主键
     * @return 活动策略
     */
    public CardGameRules selectCardGameRulesById(Long id);

    /**
     * 查询活动策略列表
     * 
     * @param cardGameRules 活动策略
     * @return 活动策略集合
     */
    public List<CardGameRules> selectCardGameRulesList(CardGameRules cardGameRules);

    /**
     * 新增活动策略
     * 
     * @param cardGameRules 活动策略
     * @return 结果
     */
    public int insertCardGameRules(CardGameRules cardGameRules);

    /**
     * 修改活动策略
     * 
     * @param cardGameRules 活动策略
     * @return 结果
     */
    public int updateCardGameRules(CardGameRules cardGameRules);

    /**
     * 删除活动策略
     * 
     * @param id 活动策略主键
     * @return 结果
     */
    public int deleteCardGameRulesById(Long id);

    /**
     * 批量删除活动策略
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCardGameRulesByIds(String[] ids);
}
