package com.zcurd.online.model;

import com.jfinal.plugin.activerecord.Model;

public class ZcurdHead extends Model<ZcurdHead> {
	private static final long serialVersionUID = 1L;
	public static final ZcurdHead me = new ZcurdHead();
	
	public String getTableName() {
		return getStr("table_name");
	}
	
	public String getIdField() {
		return getStr("id_field");
	}
	
	public String getDbSource() {
		return getStr("db_source");
	}
	
	public String getFormName() {
		return getStr("form_name");
	}
	
	public String getdeleteFlagField() {
		return getStr("delete_flag_field"); 
	}
}
