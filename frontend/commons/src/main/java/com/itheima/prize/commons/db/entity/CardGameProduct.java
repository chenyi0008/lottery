package com.itheima.prize.commons.db.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;

/**
 * 
 * @TableName card_game_product
 */
@TableName(value ="card_game_product")
public class CardGameProduct implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 活动
     */
    private Integer gameid;

    /**
     * 奖品
     */
    private Integer productid;

    /**
     * 数量
     */
    private Integer amount;

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
     * 数量
     */
    public Integer getAmount() {
        return amount;
    }

    /**
     * 数量
     */
    public void setAmount(Integer amount) {
        this.amount = amount;
    }
}