package com.itheima.prize.commons.db.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;

/**
 * 会员信息表
 * @TableName card_user
 */
@TableName(value ="card_user")
public class CardUser implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 用户名
     */
    private String uname;

    /**
     * 头像
     */
    private String pic;

    /**
     * 密码
     */
    private String passwd;

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
     * 等级
     */
    private Integer level;

    /**
     * 注册时间
     */
    private Date createtime;

    /**
     * 更新时间
     */
    private Date updatetime;

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
     * 头像
     */
    public String getPic() {
        return pic;
    }

    /**
     * 头像
     */
    public void setPic(String pic) {
        this.pic = pic;
    }

    /**
     * 密码
     */
    public String getPasswd() {
        return passwd;
    }

    /**
     * 密码
     */
    public void setPasswd(String passwd) {
        this.passwd = passwd;
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
     * 等级
     */
    public Integer getLevel() {
        return level;
    }

    /**
     * 等级
     */
    public void setLevel(Integer level) {
        this.level = level;
    }

    /**
     * 注册时间
     */
    public Date getCreatetime() {
        return createtime;
    }

    /**
     * 注册时间
     */
    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    /**
     * 更新时间
     */
    public Date getUpdatetime() {
        return updatetime;
    }

    /**
     * 更新时间
     */
    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }
}