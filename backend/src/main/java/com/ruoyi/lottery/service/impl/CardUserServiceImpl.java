package com.ruoyi.lottery.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.lottery.mapper.CardUserMapper;
import com.ruoyi.lottery.domain.CardUser;
import com.ruoyi.lottery.service.ICardUserService;
import com.ruoyi.common.core.text.Convert;

/**
 * 会员信息Service业务层处理
 * 
 * @author Shawn
 * @date 2023-12-29
 */
@Service
public class CardUserServiceImpl implements ICardUserService 
{
    @Autowired
    private CardUserMapper cardUserMapper;

    /**
     * 查询会员信息
     * 
     * @param id 会员信息主键
     * @return 会员信息
     */
    @Override
    public CardUser selectCardUserById(Long id)
    {
        return cardUserMapper.selectCardUserById(id);
    }

    /**
     * 查询会员信息列表
     * 
     * @param cardUser 会员信息
     * @return 会员信息
     */
    @Override
    public List<CardUser> selectCardUserList(CardUser cardUser)
    {
        return cardUserMapper.selectCardUserList(cardUser);
    }

    /**
     * 新增会员信息
     * 
     * @param cardUser 会员信息
     * @return 结果
     */
    @Override
    public int insertCardUser(CardUser cardUser)
    {
        return cardUserMapper.insertCardUser(cardUser);
    }

    /**
     * 修改会员信息
     * 
     * @param cardUser 会员信息
     * @return 结果
     */
    @Override
    public int updateCardUser(CardUser cardUser)
    {
        return cardUserMapper.updateCardUser(cardUser);
    }

    /**
     * 批量删除会员信息
     * 
     * @param ids 需要删除的会员信息主键
     * @return 结果
     */
    @Override
    public int deleteCardUserByIds(String ids)
    {
        return cardUserMapper.deleteCardUserByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除会员信息信息
     * 
     * @param id 会员信息主键
     * @return 结果
     */
    @Override
    public int deleteCardUserById(Long id)
    {
        return cardUserMapper.deleteCardUserById(id);
    }
}
