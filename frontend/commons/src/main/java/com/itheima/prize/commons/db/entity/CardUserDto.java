package com.itheima.prize.commons.db.entity;

import org.springframework.beans.BeanUtils;

public class CardUserDto extends CardUser {
    public CardUserDto(CardUser user){
        BeanUtils.copyProperties(user,this);
    }
    public CardUserDto(){
        super();
    }

    //参与的活动数，中奖数
    private Integer games,products;

    public Integer getGames() {
        return games;
    }

    public void setGames(Integer games) {
        this.games = games;
    }

    public Integer getProducts() {
        return products;
    }

    public void setProducts(Integer products) {
        this.products = products;
    }
}
