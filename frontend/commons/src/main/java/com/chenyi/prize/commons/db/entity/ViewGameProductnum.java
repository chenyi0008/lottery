package com.chenyi.prize.commons.db.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;

/**
 * 
 * @TableName view_game_productnum
 */
@TableName(value ="view_game_productnum")
public class ViewGameProductnum implements Serializable {
    /**
     * 活动
     */
    private Integer gameid;

    /**
     * 
     */
    private Long num;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

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
     * 
     */
    public Long getNum() {
        return num;
    }

    /**
     * 
     */
    public void setNum(Long num) {
        this.num = num;
    }
}