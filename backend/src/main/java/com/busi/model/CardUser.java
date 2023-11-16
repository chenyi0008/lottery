package com.busi.model;

import java.util.Map;

import com.jfinal.plugin.activerecord.Model;
import com.zcurd.common.DbMetaTool;

public class CardUser extends Model<CardUser> {
	private static final long serialVersionUID = 1L;
	public static final CardUser me = new CardUser();
		
	public Map<String, Object> getDictDatalevel() {
		return DbMetaTool.getDictData("select dict_key,dict_value from sys_dict where dict_type='card_user_level' ");
	}	
	
}
