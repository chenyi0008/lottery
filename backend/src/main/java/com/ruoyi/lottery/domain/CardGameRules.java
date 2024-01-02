package com.ruoyi.lottery.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 活动策略对象 card_game_rules
 * 
 * @author Shawn
 * @date 2023-12-28
 */
public class CardGameRules extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /**  */
    private Long id;

    /** 活动id */
    @Excel(name = "活动id")
    private Integer gameid;

    /** 会员等级 */
    @Excel(name = "会员等级")
    private Integer userlevel;

    /** 可抽奖次数（0为不限） */
    @Excel(name = "可抽奖次数", readConverterExp = "0=为不限")
    private Integer enterTimes;

    /** 最大中奖次数（0为不限） */
    @Excel(name = "最大中奖次数", readConverterExp = "0=为不限")
    private Integer goalTimes;

    /** 如果是概率类，多大中奖率（0-100），默认100 */
    @Excel(name = "如果是概率类，多大中奖率", readConverterExp = "0=-100")
    private Integer randomRate;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setGameid(Integer gameid) 
    {
        this.gameid = gameid;
    }

    public Integer getGameid() 
    {
        return gameid;
    }
    public void setUserlevel(Integer userlevel) 
    {
        this.userlevel = userlevel;
    }

    public Integer getUserlevel() 
    {
        return userlevel;
    }
    public void setEnterTimes(Integer enterTimes) 
    {
        this.enterTimes = enterTimes;
    }

    public Integer getEnterTimes() 
    {
        return enterTimes;
    }
    public void setGoalTimes(Integer goalTimes) 
    {
        this.goalTimes = goalTimes;
    }

    public Integer getGoalTimes() 
    {
        return goalTimes;
    }
    public void setRandomRate(Integer randomRate) 
    {
        this.randomRate = randomRate;
    }

    public Integer getRandomRate() 
    {
        return randomRate;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("gameid", getGameid())
            .append("userlevel", getUserlevel())
            .append("enterTimes", getEnterTimes())
            .append("goalTimes", getGoalTimes())
            .append("randomRate", getRandomRate())
            .toString();
    }
}
