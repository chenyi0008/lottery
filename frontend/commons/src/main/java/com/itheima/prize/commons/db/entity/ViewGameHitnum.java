package com.itheima.prize.commons.db.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;

/**
 * 
 * @TableName view_game_hitnum
 */
@TableName(value ="view_game_hitnum")
public class ViewGameHitnum implements Serializable {
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