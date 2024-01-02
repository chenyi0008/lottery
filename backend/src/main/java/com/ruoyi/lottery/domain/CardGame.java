package com.ruoyi.lottery.domain;

import java.util.List;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 活动管理对象 card_game
 * 
 * @author Shawn
 * @date 2023-12-28
 */
public class CardGame extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** ID */
    @Excel(name = "ID")
    private Integer id;

    /** 活动主题 */
    @Excel(name = "活动主题")
    private String title;

    /** 宣传图 */
    @Excel(name = "宣传图")
    private String pic;

    /** 活动简介 */
    private String info;

    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date starttime;

    /** 结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "结束时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date endtime;

    /** 类型 */
    @Excel(name = "类型")
    private Integer type;

    /** 状态（0=新建，1=已加载） */
    @Excel(name = "状态", readConverterExp = "0==新建，1=已加载")
    private Integer status;

    /** 活动奖品信息 */
    private List<CardGameProduct> cardGameProductList;

    /** 活动策略信息 */
    private List<CardGameRules> cardGameRulesList;

    public void setId(Integer id) 
    {
        this.id = id;
    }

    public Integer getId() 
    {
        return id;
    }
    public void setTitle(String title) 
    {
        this.title = title;
    }

    public String getTitle() 
    {
        return title;
    }
    public void setPic(String pic) 
    {
        this.pic = pic;
    }

    public String getPic() 
    {
        return pic;
    }
    public void setInfo(String info) 
    {
        this.info = info;
    }

    public String getInfo() 
    {
        return info;
    }
    public void setStarttime(Date starttime) 
    {
        this.starttime = starttime;
    }

    public Date getStarttime() 
    {
        return starttime;
    }
    public void setEndtime(Date endtime) 
    {
        this.endtime = endtime;
    }

    public Date getEndtime() 
    {
        return endtime;
    }
    public void setType(Integer type) 
    {
        this.type = type;
    }

    public Integer getType() 
    {
        return type;
    }
    public void setStatus(Integer status) 
    {
        this.status = status;
    }

    public Integer getStatus() 
    {
        return status;
    }

    public List<CardGameProduct> getCardGameProductList()
    {
        return cardGameProductList;
    }

    public void setCardGameProductList(List<CardGameProduct> cardGameProductList)
    {
        this.cardGameProductList = cardGameProductList;
    }
    public List<CardGameRules> getCardGameRulesList()
    {
        return cardGameRulesList;
    }

    public void setCardGameRulesList(List<CardGameRules> cardGameRulesList)
    {
        this.cardGameRulesList = cardGameRulesList;
    }
    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("title", getTitle())
            .append("pic", getPic())
            .append("info", getInfo())
            .append("starttime", getStarttime())
            .append("endtime", getEndtime())
            .append("type", getType())
            .append("status", getStatus())
            .append("cardGameProductList", getCardGameProductList())
                .append("cardGameRulesList", getCardGameRulesList())
                .toString();
    }
}
