package com.itheima.prize.commons.db.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;

/**
 * 
 * @TableName view_game_curinfo
 */
@TableName(value ="view_game_curinfo")
public class ViewGameCurinfo implements Serializable {
    /**
     * 
     */
    private Integer id;

    /**
     * 活动主题
     */
    private String title;

    /**
     * 开始时间
     */
    private Date starttime;

    /**
     * 结束时间
     */
    private Date endtime;

    /**
     * 值
     */
    private String type;

    /**
     * 
     */
    private Long total;

    /**
     * 
     */
    private Long hit;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    public Integer getId() {
        return id;
    }

    /**
     * 
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 活动主题
     */
    public String getTitle() {
        return title;
    }

    /**
     * 活动主题
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * 开始时间
     */
    public Date getStarttime() {
        return starttime;
    }

    /**
     * 开始时间
     */
    public void setStarttime(Date starttime) {
        this.starttime = starttime;
    }

    /**
     * 结束时间
     */
    public Date getEndtime() {
        return endtime;
    }

    /**
     * 结束时间
     */
    public void setEndtime(Date endtime) {
        this.endtime = endtime;
    }

    /**
     * 值
     */
    public String getType() {
        return type;
    }

    /**
     * 值
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * 
     */
    public Long getTotal() {
        return total;
    }

    /**
     * 
     */
    public void setTotal(Long total) {
        this.total = total;
    }

    /**
     * 
     */
    public Long getHit() {
        return hit;
    }

    /**
     * 
     */
    public void setHit(Long hit) {
        this.hit = hit;
    }
}