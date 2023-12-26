package com.itheima.prize.commons.db.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;

/**
 * 
 * @TableName card_user_hit
 */
@TableName(value ="card_user_hit")
public class CardUserHit implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 活动
     */
    private Integer gameid;

    /**
     * 用户
     */
    private Integer userid;

    /**
     * 奖品
     */
    private Integer productid;

    /**
     * 中奖时间
     */
    private Date hittime;

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
     * 活动
     */
    public Integer getGameid() {
        return gameid;
    }

    /**
     * 活动
     */
    public void setGameid(Integer gameid) {
        this.gameid = gameid;
    }

    /**
     * 用户
     */
    public Integer getUserid() {
        return userid;
    }

    /**
     * 用户
     */
    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    /**
     * 奖品
     */
    public Integer getProductid() {
        return productid;
    }

    /**
     * 奖品
     */
    public void setProductid(Integer productid) {
        this.productid = productid;
    }

    /**
     * 中奖时间
     */
    public Date getHittime() {
        return hittime;
    }

    /**
     * 中奖时间
     */
    public void setHittime(Date hittime) {
        this.hittime = hittime;
    }
}