package com.itheima.prize.commons.db.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;

/**
 * 
 * @TableName card_user_game
 */
@TableName(value ="card_user_game")
public class CardUserGame implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 用户id
     */
    private Integer userid;

    /**
     * 活动id
     */
    private Integer gameid;

    /**
     * 参与时间
     */
    private Date createtime;

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
     * 用户id
     */
    public Integer getUserid() {
        return userid;
    }

    /**
     * 用户id
     */
    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    /**
     * 活动id
     */
    public Integer getGameid() {
        return gameid;
    }

    /**
     * 活动id
     */
    public void setGameid(Integer gameid) {
        this.gameid = gameid;
    }

    /**
     * 参与时间
     */
    public Date getCreatetime() {
        return createtime;
    }

    /**
     * 参与时间
     */
    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }
}