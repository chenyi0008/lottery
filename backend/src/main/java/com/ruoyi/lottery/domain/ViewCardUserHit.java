package com.ruoyi.lottery.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 中奖用户详情对象 view_card_user_hit
 * 
 * @author Shawn
 * @date 2024-01-02
 */
public class ViewCardUserHit extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /**  */
    private Integer id;

    /** 活动主题 */
    @Excel(name = "活动主题")
    private String title;

    /** 活动类型 */
    @Excel(name = "活动类型")
    private String type;

    /** 登录名 */
    @Excel(name = "登录名")
    private String uname;

    /** 姓名 */
    @Excel(name = "姓名")
    private String realname;

    /** 身份证号 */
    @Excel(name = "身份证号")
    private String idcard;

    /** 手机号码 */
    @Excel(name = "手机号码")
    private String phone;

    /** 用户等级 */
    @Excel(name = "用户等级")
    private String level;

    /** 奖品名称 */
    @Excel(name = "奖品名称")
    private String name;

    /** 市场价 */
    @Excel(name = "市场价")
    private BigDecimal price;

    /** 活动 */
    private Integer gameid;

    /** 用户 */
    private Integer userid;

    /** 奖品 */
    private Integer productid;

    /** 中奖时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "中奖时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date hittime;

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
    public void setType(String type) 
    {
        this.type = type;
    }

    public String getType() 
    {
        return type;
    }
    public void setUname(String uname) 
    {
        this.uname = uname;
    }

    public String getUname() 
    {
        return uname;
    }
    public void setRealname(String realname) 
    {
        this.realname = realname;
    }

    public String getRealname() 
    {
        return realname;
    }
    public void setIdcard(String idcard) 
    {
        this.idcard = idcard;
    }

    public String getIdcard() 
    {
        return idcard;
    }
    public void setPhone(String phone) 
    {
        this.phone = phone;
    }

    public String getPhone() 
    {
        return phone;
    }
    public void setLevel(String level) 
    {
        this.level = level;
    }

    public String getLevel() 
    {
        return level;
    }
    public void setName(String name) 
    {
        this.name = name;
    }

    public String getName() 
    {
        return name;
    }
    public void setPrice(BigDecimal price) 
    {
        this.price = price;
    }

    public BigDecimal getPrice() 
    {
        return price;
    }
    public void setGameid(Integer gameid) 
    {
        this.gameid = gameid;
    }

    public Integer getGameid() 
    {
        return gameid;
    }
    public void setUserid(Integer userid) 
    {
        this.userid = userid;
    }

    public Integer getUserid() 
    {
        return userid;
    }
    public void setProductid(Integer productid) 
    {
        this.productid = productid;
    }

    public Integer getProductid() 
    {
        return productid;
    }
    public void setHittime(Date hittime) 
    {
        this.hittime = hittime;
    }

    public Date getHittime() 
    {
        return hittime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("title", getTitle())
            .append("type", getType())
            .append("uname", getUname())
            .append("realname", getRealname())
            .append("idcard", getIdcard())
            .append("phone", getPhone())
            .append("level", getLevel())
            .append("name", getName())
            .append("price", getPrice())
            .append("gameid", getGameid())
            .append("userid", getUserid())
            .append("productid", getProductid())
            .append("hittime", getHittime())
            .toString();
    }
}
