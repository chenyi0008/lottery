package com.ruoyi.lottery.service.impl;

import java.util.List;

import com.ruoyi.lottery.domain.CardGameRules;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import com.ruoyi.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.lottery.domain.CardGameProduct;
import com.ruoyi.lottery.mapper.CardGameMapper;
import com.ruoyi.lottery.domain.CardGame;
import com.ruoyi.lottery.service.ICardGameService;
import com.ruoyi.common.core.text.Convert;

/**
 * 活动管理Service业务层处理
 * 
 * @author Shawn
 * @date 2023-12-28
 */
@Service
public class CardGameServiceImpl implements ICardGameService 
{
    @Autowired
    private CardGameMapper cardGameMapper;

    /**
     * 查询活动管理
     * 
     * @param id 活动管理主键
     * @return 活动管理
     */
    @Override
    public CardGame selectCardGameById(Integer id)
    {
        return cardGameMapper.selectCardGameById(id);
    }

    /**
     * 查询活动管理列表
     * 
     * @param cardGame 活动管理
     * @return 活动管理
     */
    @Override
    public List<CardGame> selectCardGameList(CardGame cardGame)
    {
        return cardGameMapper.selectCardGameList(cardGame);
    }

    /**
     * 新增活动管理
     * 
     * @param cardGame 活动管理
     * @return 结果
     */
    @Transactional
    @Override
    public int insertCardGame(CardGame cardGame)
    {
        int rows = cardGameMapper.insertCardGame(cardGame);
        insertCardGameProduct(cardGame);
        insertCardGameRules(cardGame);
        return rows;
    }

    /**
     * 修改活动管理
     * 
     * @param cardGame 活动管理
     * @return 结果
     */
    @Transactional
    @Override
    public int updateCardGame(CardGame cardGame)
    {
        cardGameMapper.deleteCardGameProductByGameid(cardGame.getId());
        insertCardGameProduct(cardGame);
        cardGameMapper.deleteCardGameRulesByGameid(cardGame.getId());
        insertCardGameRules(cardGame);
        return cardGameMapper.updateCardGame(cardGame);
    }

    /**
     * 批量删除活动管理
     * 
     * @param ids 需要删除的活动管理主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteCardGameByIds(String ids)
    {
        cardGameMapper.deleteCardGameProductByGameids(Convert.toStrArray(ids));
        cardGameMapper.deleteCardGameRulesByGameids(Convert.toStrArray(ids));
        return cardGameMapper.deleteCardGameByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除活动管理信息
     * 
     * @param id 活动管理主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteCardGameById(Integer id)
    {
        cardGameMapper.deleteCardGameProductByGameid(id);
        cardGameMapper.deleteCardGameRulesByGameid(id);
        return cardGameMapper.deleteCardGameById(id);
    }

    /**
     * 新增活动奖品信息
     * 
     * @param cardGame 活动管理对象
     */
    public void insertCardGameProduct(CardGame cardGame)
    {
        List<CardGameProduct> cardGameProductList = cardGame.getCardGameProductList();
        Integer id = cardGame.getId();
        if (StringUtils.isNotNull(cardGameProductList))
        {
            List<CardGameProduct> list = new ArrayList<CardGameProduct>();
            for (CardGameProduct cardGameProduct : cardGameProductList)
            {
                cardGameProduct.setGameid(id);
                list.add(cardGameProduct);
            }
            if (list.size() > 0)
            {
                cardGameMapper.batchCardGameProduct(list);
            }
        }
    }
    /**
     * 新增活动策略信息
     *
     * @param cardGame 活动管理对象
     */
    public void insertCardGameRules(CardGame cardGame)
    {
        List<CardGameRules> cardGameRulesList = cardGame.getCardGameRulesList();
        Integer id = cardGame.getId();
        if (StringUtils.isNotNull(cardGameRulesList))
        {
            List<CardGameRules> list = new ArrayList<CardGameRules>();
            for (CardGameRules cardGameRules : cardGameRulesList)
            {
                cardGameRules.setGameid(id);
                list.add(cardGameRules);
            }
            if (list.size() > 0)
            {
                cardGameMapper.batchCardGameRules(list);
            }
        }
    }
}
