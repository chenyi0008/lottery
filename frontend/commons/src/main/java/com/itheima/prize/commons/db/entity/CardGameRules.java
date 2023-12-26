package com.itheima.prize.commons.db.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;

/**
 * 活动策略
 * @TableName card_game_rules
 */
@TableName(value ="card_game_rules")
public class CardGameRules implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 活动id
     */
    private Integer gameid;

    /**
     * 会员等级
     */
    private Integer userlevel;

    /**
     * 可抽奖次数（0为不限）
     */
    private Integer enterTimes;

    /**
     * 最大中奖次数（0为不限）
     */
    private Integer goalTimes;

    /**
     * 如果是概率类，多大中奖率（0-100），默认100
     */
    private Integer randomRate;

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
     * 会员等级
     */
    public Integer getUserlevel() {
        return userlevel;
    }

    /**
     * 会员等级
     */
    public void setUserlevel(Integer userlevel) {
        this.userlevel = userlevel;
    }

    /**
     * 可抽奖次数（0为不限）
     */
    public Integer getEnterTimes() {
        return enterTimes;
    }

    /**
     * 可抽奖次数（0为不限）
     */
    public void setEnterTimes(Integer enterTimes) {
        this.enterTimes = enterTimes;
    }

    /**
     * 最大中奖次数（0为不限）
     */
    public Integer getGoalTimes() {
        return goalTimes;
    }

    /**
     * 最大中奖次数（0为不限）
     */
    public void setGoalTimes(Integer goalTimes) {
        this.goalTimes = goalTimes;
    }

    /**
     * 如果是概率类，多大中奖率（0-100），默认100
     */
    public Integer getRandomRate() {
        return randomRate;
    }

    /**
     * 如果是概率类，多大中奖率（0-100），默认100
     */
    public void setRandomRate(Integer randomRate) {
        this.randomRate = randomRate;
    }
}