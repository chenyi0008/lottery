package com.ruoyi.lottery.service;

import java.util.List;
import com.ruoyi.lottery.domain.CardProduct;

/**
 * 奖品管理Service接口
 * 
 * @author Shawn
 * @date 2023-12-28
 */
public interface ICardProductService 
{
    /**
     * 查询奖品管理
     * 
     * @param id 奖品管理主键
     * @return 奖品管理
     */
    public CardProduct selectCardProductById(Integer id);

    /**
     * 查询奖品管理列表
     * 
     * @param cardProduct 奖品管理
     * @return 奖品管理集合
     */
    public List<CardProduct> selectCardProductList(CardProduct cardProduct);

    /**
     * 新增奖品管理
     * 
     * @param cardProduct 奖品管理
     * @return 结果
     */
    public int insertCardProduct(CardProduct cardProduct);

    /**
     * 修改奖品管理
     * 
     * @param cardProduct 奖品管理
     * @return 结果
     */
    public int updateCardProduct(CardProduct cardProduct);

    /**
     * 批量删除奖品管理
     * 
     * @param ids 需要删除的奖品管理主键集合
     * @return 结果
     */
    public int deleteCardProductByIds(String ids);

    /**
     * 删除奖品管理信息
     * 
     * @param id 奖品管理主键
     * @return 结果
     */
    public int deleteCardProductById(Integer id);
}
