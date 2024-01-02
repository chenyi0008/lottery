package com.ruoyi.lottery.mapper;

import java.util.List;
import com.ruoyi.lottery.domain.ViewCardUserHit;

/**
 * 中奖用户详情Mapper接口
 * 
 * @author Shawn
 * @date 2024-01-02
 */
public interface ViewCardUserHitMapper 
{
    /**
     * 查询中奖用户详情
     * 
     * @param id 中奖用户详情主键
     * @return 中奖用户详情
     */
    public ViewCardUserHit selectViewCardUserHitById(Integer id);

    /**
     * 查询中奖用户详情列表
     * 
     * @param viewCardUserHit 中奖用户详情
     * @return 中奖用户详情集合
     */
    public List<ViewCardUserHit> selectViewCardUserHitList(ViewCardUserHit viewCardUserHit);

    /**
     * 新增中奖用户详情
     * 
     * @param viewCardUserHit 中奖用户详情
     * @return 结果
     */
    public int insertViewCardUserHit(ViewCardUserHit viewCardUserHit);

    /**
     * 修改中奖用户详情
     * 
     * @param viewCardUserHit 中奖用户详情
     * @return 结果
     */
    public int updateViewCardUserHit(ViewCardUserHit viewCardUserHit);

    /**
     * 删除中奖用户详情
     * 
     * @param id 中奖用户详情主键
     * @return 结果
     */
    public int deleteViewCardUserHitById(Integer id);

    /**
     * 批量删除中奖用户详情
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteViewCardUserHitByIds(String[] ids);
}
