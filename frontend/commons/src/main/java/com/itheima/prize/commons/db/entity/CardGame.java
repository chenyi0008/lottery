package com.itheima.prize.commons.db.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;

/**
 * 
 * @TableName card_game
 */
@TableName(value ="card_game")
public class CardGame implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 活动主题
     */
    private String title;

    /**
     * 活动宣传图
     */
    private String pic;

    /**
     * 活动简介
     */
    private String info;

    /**
     * 开始时间
     */
    private Date starttime;

    /**
     * 结束时间
     */
    private Date endtime;

    /**
     * 类型（1=概率类，2=随机类）
     */
    private Integer type;

    /**
     * 状态（0=新建，1=已加载）
     */
    private Integer status;

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
     * 活动宣传图
     */
    public String getPic() {
        return pic;
    }

    /**
     * 活动宣传图
     */
    public void setPic(String pic) {
        this.pic = pic;
    }

    /**
     * 活动简介
     */
    public String getInfo() {
        return info;
    }

    /**
     * 活动简介
     */
    public void setInfo(String info) {
        this.info = info;
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
     * 类型（1=概率类，2=随机类）
     */
    public Integer getType() {
        return type;
    }

    /**
     * 类型（1=概率类，2=随机类）
     */
    public void setType(Integer type) {
        this.type = type;
    }

    /**
     * 状态（0=新建，1=已加载）
     */
    public Integer getStatus() {
        return status;
    }

    /**
     * 状态（0=新建，1=已加载）
     */
    public void setStatus(Integer status) {
        this.status = status;
    }
}