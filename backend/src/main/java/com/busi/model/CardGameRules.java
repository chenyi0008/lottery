package com.busi.model;

import java.util.Map;

import com.jfinal.plugin.activerecord.Model;
import com.zcurd.common.DbMetaTool;

public class CardGameRules extends Model<CardGameRules> {
	private static final long serialVersionUID = 1L;
	public static final CardGameRules me = new CardGameRules();
		
	public Map<String, Object> getDictDatagameid() {
		return DbMetaTool.getDictData("select id,title from card_game");
	}	
		
	public Map<String, Object> getDictDatauserlevel() {
		return DbMetaTool.getDictData("select dict_key,dict_value from sys_dict where dict_type='card_user_level' ");
	}	
	
}
