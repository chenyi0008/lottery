package com.ruoyi.lottery.mapper;

import java.util.List;
import com.ruoyi.lottery.domain.ViewGameCurinfo;

/**
 * 活动中奖统计Mapper接口
 * 
 * @author Shawn
 * @date 2024-01-02
 */
public interface ViewGameCurinfoMapper 
{
    /**
     * 查询活动中奖统计
     * 
     * @param id 活动中奖统计主键
     * @return 活动中奖统计
     */
    public ViewGameCurinfo selectViewGameCurinfoById(Integer id);

    /**
     * 查询活动中奖统计列表
     * 
     * @param viewGameCurinfo 活动中奖统计
     * @return 活动中奖统计集合
     */
    public List<ViewGameCurinfo> selectViewGameCurinfoList(ViewGameCurinfo viewGameCurinfo);

    /**
     * 新增活动中奖统计
     * 
     * @param viewGameCurinfo 活动中奖统计
     * @return 结果
     */
    public int insertViewGameCurinfo(ViewGameCurinfo viewGameCurinfo);

    /**
     * 修改活动中奖统计
     * 
     * @param viewGameCurinfo 活动中奖统计
     * @return 结果
     */
    public int updateViewGameCurinfo(ViewGameCurinfo viewGameCurinfo);

    /**
     * 删除活动中奖统计
     * 
     * @param id 活动中奖统计主键
     * @return 结果
     */
    public int deleteViewGameCurinfoById(Integer id);

    /**
     * 批量删除活动中奖统计
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteViewGameCurinfoByIds(String[] ids);
}
