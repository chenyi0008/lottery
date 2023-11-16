package com.zcurd.online.model;

import java.util.Map;

import com.jfinal.plugin.activerecord.Model;
import com.zcurd.common.DbMetaTool;

public class SysMenuBtn extends Model<SysMenuBtn> {
	private static final long serialVersionUID = 1L;
	public static final SysMenuBtn me = new SysMenuBtn();
		
	public Map<String, Object> getDictDatamenu_id() {
		return DbMetaTool.getDictData("select id, menu_name from sys_menu");
	}	
	
}
