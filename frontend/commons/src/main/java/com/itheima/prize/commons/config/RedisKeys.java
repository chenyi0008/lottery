package com.itheima.prize.commons.config;

public class RedisKeys {
    //活动信息
    public final static String INFO="game_info_";
    //令牌前缀
    public final static String TOKEN="game_token_";
    //令牌桶key
    public final static String TOKENS="game_tokens_";
    //最大中奖数
    public final static String MAXGOAL="game_maxgoal_";
    //最大抽奖数
    public final static String MAXENTER="game_maxenter_";
    //中奖概率
    public final static String RANDOMRATE="game_randomrate_";

    //用户中奖数
    public final static String USERHIT="user_hit_";
    //用户参与次数
    public final static String USERENTER="user_enter_";

    //用户登录错误次数
    public final static String USERLOGINTIMES="user_login_times_";
    //用户是否参与过该活动
    public static final String USERGAME = "user_game_";
}
