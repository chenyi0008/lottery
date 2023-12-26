package com.itheima.prize.commons.db.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 
 * @TableName view_card_user_hit
 */
@TableName(value ="view_card_user_hit")
public class ViewCardUserHit implements Serializable {
    /**
     * 
     */
    private Integer id;

    /**
     * 活动主题
     */
    private String title;

    /**
     * 值
     */
    private String type;

    /**
     * 用户名
     */
    private String uname;

    /**
     * 姓名
     */
    private String realname;

    /**
     * 身份证号
     */
    private String idcard;

    /**
     * 手机号码
     */
    private String phone;

    /**
     * 值
     */
    private String level;

    /**
     * 奖品名称
     */
    private String name;

    /**
     * 市场价
     */
    private BigDecimal price;

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
     * 活动主题
     */
    public String getTitle() {
        return title;
    }

    /**
     * 活动主题
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * 值
     */
    public String getType() {
        return type;
    }

    /**
     * 值
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * 用户名
     */
    public String getUname() {
        return uname;
    }

    /**
     * 用户名
     */
    public void setUname(String uname) {
        this.uname = uname;
    }

    /**
     * 姓名
     */
    public String getRealname() {
        return realname;
    }

    /**
     * 姓名
     */
    public void setRealname(String realname) {
        this.realname = realname;
    }

    /**
     * 身份证号
     */
    public String getIdcard() {
        return idcard;
    }

    /**
     * 身份证号
     */
    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    /**
     * 手机号码
     */
    public String getPhone() {
        return phone;
    }

    /**
     * 手机号码
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * 值
     */
    public String getLevel() {
        return level;
    }

    /**
     * 值
     */
    public void setLevel(String level) {
        this.level = level;
    }

    /**
     * 奖品名称
     */
    public String getName() {
        return name;
    }

    /**
     * 奖品名称
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * 市场价
     */
    public BigDecimal getPrice() {
        return price;
    }

    /**
     * 市场价
     */
    public void setPrice(BigDecimal price) {
        this.price = price;
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