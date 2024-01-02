package com.ruoyi.lottery.service;

import java.util.List;
import com.ruoyi.lottery.domain.CardUser;

/**
 * 会员信息Service接口
 * 
 * @author Shawn
 * @date 2023-12-29
 */
public interface ICardUserService 
{
    /**
     * 查询会员信息
     * 
     * @param id 会员信息主键
     * @return 会员信息
     */
    public CardUser selectCardUserById(Long id);

    /**
     * 查询会员信息列表
     * 
     * @param cardUser 会员信息
     * @return 会员信息集合
     */
    public List<CardUser> selectCardUserList(CardUser cardUser);

    /**
     * 新增会员信息
     * 
     * @param cardUser 会员信息
     * @return 结果
     */
    public int insertCardUser(CardUser cardUser);

    /**
     * 修改会员信息
     * 
     * @param cardUser 会员信息
     * @return 结果
     */
    public int updateCardUser(CardUser cardUser);

    /**
     * 批量删除会员信息
     * 
     * @param ids 需要删除的会员信息主键集合
     * @return 结果
     */
    public int deleteCardUserByIds(String ids);

    /**
     * 删除会员信息信息
     * 
     * @param id 会员信息主键
     * @return 结果
     */
    public int deleteCardUserById(Long id);
}
