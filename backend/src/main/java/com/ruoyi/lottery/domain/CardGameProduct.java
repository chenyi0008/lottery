package com.ruoyi.lottery.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 活动奖品对象 card_game_product
 * 
 * @author Shawn
 * @date 2023-12-27
 */
public class CardGameProduct extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /**  */
    private Integer id;

    /** 活动 */
    @Excel(name = "活动")
    private Integer gameid;

    /** 奖品 */
    @Excel(name = "奖品")
    private Integer productid;

    /** 数量 */
    @Excel(name = "数量")
    private Integer amount;

    public void setId(Integer id) 
    {
        this.id = id;
    }

    public Integer getId() 
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
    public void setProductid(Integer productid) 
    {
        this.productid = productid;
    }

    public Integer getProductid() 
    {
        return productid;
    }
    public void setAmount(Integer amount) 
    {
        this.amount = amount;
    }

    public Integer getAmount() 
    {
        return amount;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("gameid", getGameid())
            .append("productid", getProductid())
            .append("amount", getAmount())
            .toString();
    }
}
