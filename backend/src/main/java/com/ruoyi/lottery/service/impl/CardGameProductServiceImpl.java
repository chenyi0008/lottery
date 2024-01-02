package com.ruoyi.lottery.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.lottery.mapper.CardGameProductMapper;
import com.ruoyi.lottery.domain.CardGameProduct;
import com.ruoyi.lottery.service.ICardGameProductService;
import com.ruoyi.common.core.text.Convert;

/**
 * 活动奖品Service业务层处理
 * 
 * @author Shawn
 * @date 2023-12-27
 */
@Service
public class CardGameProductServiceImpl implements ICardGameProductService 
{
    @Autowired
    private CardGameProductMapper cardGameProductMapper;

    /**
     * 查询活动奖品
     * 
     * @param id 活动奖品主键
     * @return 活动奖品
     */
    @Override
    public CardGameProduct selectCardGameProductById(Integer id)
    {
        return cardGameProductMapper.selectCardGameProductById(id);
    }

    /**
     * 查询活动奖品列表
     * 
     * @param cardGameProduct 活动奖品
     * @return 活动奖品
     */
    @Override
    public List<CardGameProduct> selectCardGameProductList(CardGameProduct cardGameProduct)
    {
        return cardGameProductMapper.selectCardGameProductList(cardGameProduct);
    }

    /**
     * 新增活动奖品
     * 
     * @param cardGameProduct 活动奖品
     * @return 结果
     */
    @Override
    public int insertCardGameProduct(CardGameProduct cardGameProduct)
    {
        return cardGameProductMapper.insertCardGameProduct(cardGameProduct);
    }

    /**
     * 修改活动奖品
     * 
     * @param cardGameProduct 活动奖品
     * @return 结果
     */
    @Override
    public int updateCardGameProduct(CardGameProduct cardGameProduct)
    {
        return cardGameProductMapper.updateCardGameProduct(cardGameProduct);
    }

    /**
     * 批量删除活动奖品
     * 
     * @param ids 需要删除的活动奖品主键
     * @return 结果
     */
    @Override
    public int deleteCardGameProductByIds(String ids)
    {
        return cardGameProductMapper.deleteCardGameProductByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除活动奖品信息
     * 
     * @param id 活动奖品主键
     * @return 结果
     */
    @Override
    public int deleteCardGameProductById(Integer id)
    {
        return cardGameProductMapper.deleteCardGameProductById(id);
    }
}
