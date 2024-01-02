package com.ruoyi.lottery.mapper;

import java.util.List;
import com.ruoyi.lottery.domain.CardGameProduct;

/**
 * 活动奖品Mapper接口
 * 
 * @author Shawn
 * @date 2023-12-27
 */
public interface CardGameProductMapper 
{
    /**
     * 查询活动奖品
     * 
     * @param id 活动奖品主键
     * @return 活动奖品
     */
    public CardGameProduct selectCardGameProductById(Integer id);

    /**
     * 查询活动奖品列表
     * 
     * @param cardGameProduct 活动奖品
     * @return 活动奖品集合
     */
    public List<CardGameProduct> selectCardGameProductList(CardGameProduct cardGameProduct);

    /**
     * 新增活动奖品
     * 
     * @param cardGameProduct 活动奖品
     * @return 结果
     */
    public int insertCardGameProduct(CardGameProduct cardGameProduct);

    /**
     * 修改活动奖品
     * 
     * @param cardGameProduct 活动奖品
     * @return 结果
     */
    public int updateCardGameProduct(CardGameProduct cardGameProduct);

    /**
     * 删除活动奖品
     * 
     * @param id 活动奖品主键
     * @return 结果
     */
    public int deleteCardGameProductById(Integer id);

    /**
     * 批量删除活动奖品
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCardGameProductByIds(String[] ids);
}
