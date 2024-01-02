package com.ruoyi.lottery.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.lottery.mapper.CardGameRulesMapper;
import com.ruoyi.lottery.domain.CardGameRules;
import com.ruoyi.lottery.service.ICardGameRulesService;
import com.ruoyi.common.core.text.Convert;

/**
 * 活动策略Service业务层处理
 * 
 * @author Shawn
 * @date 2023-12-29
 */
@Service
public class CardGameRulesServiceImpl implements ICardGameRulesService 
{
    @Autowired
    private CardGameRulesMapper cardGameRulesMapper;

    /**
     * 查询活动策略
     * 
     * @param id 活动策略主键
     * @return 活动策略
     */
    @Override
    public CardGameRules selectCardGameRulesById(Long id)
    {
        return cardGameRulesMapper.selectCardGameRulesById(id);
    }

    /**
     * 查询活动策略列表
     * 
     * @param cardGameRules 活动策略
     * @return 活动策略
     */
    @Override
    public List<CardGameRules> selectCardGameRulesList(CardGameRules cardGameRules)
    {
        return cardGameRulesMapper.selectCardGameRulesList(cardGameRules);
    }

    /**
     * 新增活动策略
     * 
     * @param cardGameRules 活动策略
     * @return 结果
     */
    @Override
    public int insertCardGameRules(CardGameRules cardGameRules)
    {
        return cardGameRulesMapper.insertCardGameRules(cardGameRules);
    }

    /**
     * 修改活动策略
     * 
     * @param cardGameRules 活动策略
     * @return 结果
     */
    @Override
    public int updateCardGameRules(CardGameRules cardGameRules)
    {
        return cardGameRulesMapper.updateCardGameRules(cardGameRules);
    }

    /**
     * 批量删除活动策略
     * 
     * @param ids 需要删除的活动策略主键
     * @return 结果
     */
    @Override
    public int deleteCardGameRulesByIds(String ids)
    {
        return cardGameRulesMapper.deleteCardGameRulesByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除活动策略信息
     * 
     * @param id 活动策略主键
     * @return 结果
     */
    @Override
    public int deleteCardGameRulesById(Long id)
    {
        return cardGameRulesMapper.deleteCardGameRulesById(id);
    }
}
