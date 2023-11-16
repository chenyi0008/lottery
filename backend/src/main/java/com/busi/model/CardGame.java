package com.busi.model;

import java.util.Map;

import com.jfinal.plugin.activerecord.Model;
import com.zcurd.common.DbMetaTool;

public class CardGame extends Model<CardGame> {
	private static final long serialVersionUID = 1L;
	public static final CardGame me = new CardGame();
		
	public Map<String, Object> getDictDatatype() {
		return DbMetaTool.getDictData("select dict_key,dict_value from sys_dict where dict_type='card_game_type'");
	}	
	
}
