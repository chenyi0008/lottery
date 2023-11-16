package com.busi.controller;

import com.busi.model.CardGameRules;
import com.busi.model.CardUser;
import com.jfinal.plugin.activerecord.Record;
import com.zcurd.common.DBTool;
import com.zcurd.common.base.BaseController;
import com.zcurd.common.render.csv.CsvRender;
import com.zcurd.common.util.PasswordUtil;
import com.zcurd.common.util.StringUtil;
import sun.security.provider.MD5;

import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 会员信息
 */
public class CardUserController extends BaseController {
	
	public void listPage() {
		setAttr("dictDatalevel", CardUser.me.getDictDatalevel());
		render("list.html");
	}
	
	public void listData() {
		Object[] queryParams = getQueryParams();
		String[] properties = (String[]) queryParams[0];
		String[] symbols = (String[]) queryParams[1];
		Object[] values = (Object[]) queryParams[2];
		
		String orderBy = getOrderBy();
		if(StringUtil.isEmpty(orderBy)) {
			orderBy = "id desc";
		}
		
		List<Record> list = DBTool.findByMultPropertiesDbSource("zcurd_busi", "card_user", properties, symbols, values, orderBy, getPager());
		Map<String, Object> dictDatalevel = CardUser.me.getDictDatalevel();
		for(Record record : list) {
			String fieldName = "level";
			if(record.get(fieldName) != null && dictDatalevel.get(record.get(fieldName).toString()) != null) {
				record.set(fieldName, dictDatalevel.get(record.get(fieldName).toString()));
			}
		}
		
		renderDatagrid(
			list, 
			DBTool.countByMultPropertiesDbSource("zcurd_busi", "card_user", properties, symbols, values)
		);
	}
	
	//增加页面
	public void addPage() {
		setAttr("dictDatalevel", CardUser.me.getDictDatalevel());
		render("add.html");
	}
	
	//增加
	public void add() {
		CardUser user = getModel(CardUser.class, "model");
		user.set("passwd", PasswordUtil.encodePassword(user.get("passwd")));
		try {
			user.save();
		}catch (Exception e){
			if(e.getMessage().contains("Duplicate entry")){
				renderFailed("用户名已存在！");
				return;
			}
		}
		addOpLog("[会员"+user.get("uname")+"] 增加");
		renderSuccess();
	}
	
	//修改页面
	public void updatePage() {
		setAttr("dictDatalevel", CardUser.me.getDictDatalevel());
		setAttr("model", CardUser.me.findById(getPara("id")));
		render("update.html");
	}
	//修改页面
	public void updatePwdPage() {
		setAttr("dictDatalevel", CardUser.me.getDictDatalevel());
		setAttr("model", CardUser.me.findById(getPara("id")));
		render("updatepwd.html");
	}

	//修改
	public void update() {
		CardUser model = CardUser.me.findById(getPara("id"));
		String log = "[会员"+model.get("uname")+"] 修改";
		//用户名禁止修改
//		model.set("uname", getPara("model.uname",model.get("uname")));
		model.set("pic", getPara("model.pic",model.get("pic")));
		model.set("realname", getPara("model.realname",model.get("realname")));
		model.set("idcard", getPara("model.idcard",model.get("idcard")));
		model.set("phone", getPara("model.phone",model.get("phone")));
		model.set("level", getPara("model.level",Integer.valueOf(model.get("level").toString()).toString()));
        if (StringUtil.isNotEmpty(getPara("model.passwd"))){
            model.set("passwd",PasswordUtil.encodePassword(getPara("model.passwd")));
            log = "[会员"+model.get("uname")+"] 修改密码";
        }
		model.update();
		addOpLog(log);
		renderSuccess();
	}
	
	//删除
	public void delete() {
		Integer[] ids = getParaValuesToInt("id[]");
		for (Integer id : ids) {
			new CardUser().set("id", id).delete();
			
		}
		
		addOpLog("[会员信息] 删除");
		renderSuccess();
	}
	
	//详情页面
	public void detailPage() {
		CardUser model = CardUser.me.findById(getParaToInt("id"));
		Map<String, Object> dictDatalevel = CardUser.me.getDictDatalevel();
		if(dictDatalevel.get(model.get("level").toString()) != null) {
			model.set("level", dictDatalevel.get(model.get("level").toString()));
		}
		setAttr("model", model);
		render("detail.html");
	}
	
	//导出csv
	public void exportCsv() {
		Object[] queryParams = getQueryParams();
		String[] properties = (String[]) queryParams[0];
		String[] symbols = (String[]) queryParams[1];
		Object[] values = (Object[]) queryParams[2];
		
		String orderBy = getOrderBy();
		if(StringUtil.isEmpty(orderBy)) {
			orderBy = "id desc";
		}
		
		List<Record> list = DBTool.findByMultPropertiesDbSource("zcurd_busi", "card_user", properties, symbols, values);
		Map<String, Object> dictDatalevel = CardUser.me.getDictDatalevel();
		for(Record record : list) {
			String fieldName = "level";
			if(dictDatalevel.get(record.get(fieldName).toString()) != null) {
				record.set(fieldName, dictDatalevel.get(record.get(fieldName).toString()));
			}
		}
		
		List<String> headers = new ArrayList<String>();
		List<String> clomuns = new ArrayList<String>();
		headers.add("用户名");
		clomuns.add("uname");
		headers.add("头像");
		clomuns.add("pic");
		headers.add("姓名");
		clomuns.add("realname");
		headers.add("身份证号");
		clomuns.add("idcard");
		headers.add("手机号码");
		clomuns.add("phone");
		headers.add("等级");
		clomuns.add("level");
		
		CsvRender csvRender = new CsvRender(headers, list);
		csvRender.clomuns(clomuns);
		csvRender.fileName("会员信息");
		
		addOpLog("[会员信息] 导出cvs");
		render(csvRender);
	}
}
