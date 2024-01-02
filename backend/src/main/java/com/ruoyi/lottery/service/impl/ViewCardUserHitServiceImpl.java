package com.ruoyi.lottery.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.lottery.mapper.ViewCardUserHitMapper;
import com.ruoyi.lottery.domain.ViewCardUserHit;
import com.ruoyi.lottery.service.IViewCardUserHitService;
import com.ruoyi.common.core.text.Convert;

/**
 * 中奖用户详情Service业务层处理
 * 
 * @author Shawn
 * @date 2024-01-02
 */
@Service
public class ViewCardUserHitServiceImpl implements IViewCardUserHitService 
{
    @Autowired
    private ViewCardUserHitMapper viewCardUserHitMapper;

    /**
     * 查询中奖用户详情
     * 
     * @param id 中奖用户详情主键
     * @return 中奖用户详情
     */
    @Override
    public ViewCardUserHit selectViewCardUserHitById(Integer id)
    {
        return viewCardUserHitMapper.selectViewCardUserHitById(id);
    }

    /**
     * 查询中奖用户详情列表
     * 
     * @param viewCardUserHit 中奖用户详情
     * @return 中奖用户详情
     */
    @Override
    public List<ViewCardUserHit> selectViewCardUserHitList(ViewCardUserHit viewCardUserHit)
    {
        return viewCardUserHitMapper.selectViewCardUserHitList(viewCardUserHit);
    }

    /**
     * 新增中奖用户详情
     * 
     * @param viewCardUserHit 中奖用户详情
     * @return 结果
     */
    @Override
    public int insertViewCardUserHit(ViewCardUserHit viewCardUserHit)
    {
        return viewCardUserHitMapper.insertViewCardUserHit(viewCardUserHit);
    }

    /**
     * 修改中奖用户详情
     * 
     * @param viewCardUserHit 中奖用户详情
     * @return 结果
     */
    @Override
    public int updateViewCardUserHit(ViewCardUserHit viewCardUserHit)
    {
        return viewCardUserHitMapper.updateViewCardUserHit(viewCardUserHit);
    }

    /**
     * 批量删除中奖用户详情
     * 
     * @param ids 需要删除的中奖用户详情主键
     * @return 结果
     */
    @Override
    public int deleteViewCardUserHitByIds(String ids)
    {
        return viewCardUserHitMapper.deleteViewCardUserHitByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除中奖用户详情信息
     * 
     * @param id 中奖用户详情主键
     * @return 结果
     */
    @Override
    public int deleteViewCardUserHitById(Integer id)
    {
        return viewCardUserHitMapper.deleteViewCardUserHitById(id);
    }
}
