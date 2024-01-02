package com.ruoyi.lottery.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 奖品管理对象 card_product
 * 
 * @author Shawn
 * @date 2023-12-28
 */
public class CardProduct extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /**  */
    private Integer id;

    /** 奖品名称 */
    @Excel(name = "奖品名称")
    private String name;

    /** 图片 */
    @Excel(name = "图片")
    private String pic;

    /** 简介 */
    @Excel(name = "简介")
    private String info;

    /** 市场价 */
    @Excel(name = "市场价")
    private BigDecimal price;

    private Float beginPrice,endPrice;

    public Float getBeginPrice() {
        return beginPrice;
    }

    public void setBeginPrice(Float beginPrice) {
        this.beginPrice = beginPrice;
    }

    public Float getEndPrice() {
        return endPrice;
    }

    public void setEndPrice(Float endPrice) {
        this.endPrice = endPrice;
    }

    public void setId(Integer id)
    {
        this.id = id;
    }

    public Integer getId() 
    {
        return id;
    }
    public void setName(String name) 
    {
        this.name = name;
    }

    public String getName() 
    {
        return name;
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
    public void setPrice(BigDecimal price) 
    {
        this.price = price;
    }

    public BigDecimal getPrice() 
    {
        return price;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("name", getName())
            .append("pic", getPic())
            .append("info", getInfo())
            .append("price", getPrice())
            .toString();
    }
}
