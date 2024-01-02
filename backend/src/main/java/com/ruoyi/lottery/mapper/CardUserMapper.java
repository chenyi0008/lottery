package com.ruoyi.lottery.mapper;

import java.util.List;
import com.ruoyi.lottery.domain.CardUser;

/**
 * 会员信息Mapper接口
 * 
 * @author Shawn
 * @date 2023-12-29
 */
public interface CardUserMapper 
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
     * 删除会员信息
     * 
     * @param id 会员信息主键
     * @return 结果
     */
    public int deleteCardUserById(Long id);

    /**
     * 批量删除会员信息
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCardUserByIds(String[] ids);
}
