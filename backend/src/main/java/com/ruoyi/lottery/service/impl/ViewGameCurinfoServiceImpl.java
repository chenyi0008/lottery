package com.ruoyi.lottery.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.lottery.mapper.ViewGameCurinfoMapper;
import com.ruoyi.lottery.domain.ViewGameCurinfo;
import com.ruoyi.lottery.service.IViewGameCurinfoService;
import com.ruoyi.common.core.text.Convert;

/**
 * 活动中奖统计Service业务层处理
 * 
 * @author Shawn
 * @date 2024-01-02
 */
@Service
public class ViewGameCurinfoServiceImpl implements IViewGameCurinfoService 
{
    @Autowired
    private ViewGameCurinfoMapper viewGameCurinfoMapper;

    /**
     * 查询活动中奖统计
     * 
     * @param id 活动中奖统计主键
     * @return 活动中奖统计
     */
    @Override
    public ViewGameCurinfo selectViewGameCurinfoById(Integer id)
    {
        return viewGameCurinfoMapper.selectViewGameCurinfoById(id);
    }

    /**
     * 查询活动中奖统计列表
     * 
     * @param viewGameCurinfo 活动中奖统计
     * @return 活动中奖统计
     */
    @Override
    public List<ViewGameCurinfo> selectViewGameCurinfoList(ViewGameCurinfo viewGameCurinfo)
    {
        return viewGameCurinfoMapper.selectViewGameCurinfoList(viewGameCurinfo);
    }

    /**
     * 新增活动中奖统计
     * 
     * @param viewGameCurinfo 活动中奖统计
     * @return 结果
     */
    @Override
    public int insertViewGameCurinfo(ViewGameCurinfo viewGameCurinfo)
    {
        return viewGameCurinfoMapper.insertViewGameCurinfo(viewGameCurinfo);
    }

    /**
     * 修改活动中奖统计
     * 
     * @param viewGameCurinfo 活动中奖统计
     * @return 结果
     */
    @Override
    public int updateViewGameCurinfo(ViewGameCurinfo viewGameCurinfo)
    {
        return viewGameCurinfoMapper.updateViewGameCurinfo(viewGameCurinfo);
    }

    /**
     * 批量删除活动中奖统计
     * 
     * @param ids 需要删除的活动中奖统计主键
     * @return 结果
     */
    @Override
    public int deleteViewGameCurinfoByIds(String ids)
    {
        return viewGameCurinfoMapper.deleteViewGameCurinfoByIds(Convert.toStrArray(ids));
    }

    /**
     * 删除活动中奖统计信息
     * 
     * @param id 活动中奖统计主键
     * @return 结果
     */
    @Override
    public int deleteViewGameCurinfoById(Integer id)
    {
        return viewGameCurinfoMapper.deleteViewGameCurinfoById(id);
    }
}
