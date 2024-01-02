package com.ruoyi.lottery.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.lottery.mapper.CardProductMapper;
import com.ruoyi.lottery.domain.CardProduct;
import com.ruoyi.lottery.service.ICardProductService;
import com.ruoyi.common.core.text.Convert;

/**
 * 奖品管理Service业务层处理
 * 
 * @author Shawn
 * @date 2023-12-28
 */
@Service
public class CardProductServiceImpl implements ICardProductService 
{
    @Autowired
    private CardProductMapper cardProductMapper;

    /**
     * 查询奖品管理
     * 
     * @param id 奖品管理主键
     * @return 奖品管理
     */
    @Override
    public CardProduct selectCardProductById(Integer id)
    {
        return cardProductMapper.selectCardProductById(id);
    }

    /**
     * 查询奖品管理列表
     * 
     * @param cardProduct 奖品管理
     * @return 奖品管理
     */
    @Override
    public List<CardProduct> selectCardProductList(CardProduct cardProduct)
    {
        return cardProductMapper.selectCardProductList(cardProduct);
    }

    /**
     * 新增奖品管理
     * 
     * @param cardProduct 奖品管理
     * @return 结果
     */
    @Override
    public int insertCardProduct(CardProduct cardProduct)
    {
        return cardProductMapper.insertCardProduct(cardProduct);
    }

    /**
     * 修改奖品管理
     * 
     * @param cardProduct 奖品管理
     * @return 结果
     */
    @Override
    public int updateCardProduct(CardProduct cardProduct)
    {
        return cardProductMapper.updateCardProduct(cardProduct);
    }

    /**
     * 批量删除奖品管理
     * 
     * @param ids 需要删除的奖品管理主键
     * @return 结果
     */
    @Override
    public int deleteCardProductByIds(String ids)
    {
        return cardProductMapper.deleteCardProductByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除奖品管理信息
     * 
     * @param id 奖品管理主键
     * @return 结果
     */
    @Override
    public int deleteCardProductById(Integer id)
    {
        return cardProductMapper.deleteCardProductById(id);
    }
}
