package com.busi.controller;

import com.busi.model.CardGameRules;
import com.jfinal.plugin.activerecord.Record;
import com.zcurd.common.DBTool;
import com.zcurd.common.base.BaseController;
import com.zcurd.common.render.csv.CsvRender;
import com.zcurd.common.util.StringUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 活动策略
 */
public class CardGameRulesController extends BaseController {
	
	public void listPage() {
		setAttr("dictDatagameid", CardGameRules.me.getDictDatagameid());
		setAttr("dictDatauserlevel", CardGameRules.me.getDictDatauserlevel());
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
		
		List<Record> list = DBTool.findByMultPropertiesDbSource("zcurd_busi", "card_game_rules", properties, symbols, values, orderBy, getPager());
		Map<String, Object> dictDatagameid = CardGameRules.me.getDictDatagameid();
		for(Record record : list) {
			String fieldName = "gameid";
			if(record.get(fieldName) != null && dictDatagameid.get(record.get(fieldName).toString()) != null) {
				record.set(fieldName, dictDatagameid.get(record.get(fieldName).toString()));
			}
		}
		Map<String, Object> dictDatauserlevel = CardGameRules.me.getDictDatauserlevel();
		for(Record record : list) {
			String fieldName = "userlevel";
			if(record.get(fieldName) != null && dictDatauserlevel.get(record.get(fieldName).toString()) != null) {
				record.set(fieldName, dictDatauserlevel.get(record.get(fieldName).toString()));
			}
		}
		
		renderDatagrid(
			list, 
			DBTool.countByMultPropertiesDbSource("zcurd_busi", "card_game_rules", properties, symbols, values)
		);
	}
	
	//增加页面
	public void addPage() {
		setAttr("dictDatagameid", CardGameRules.me.getDictDatagameid());
		setAttr("dictDatauserlevel", CardGameRules.me.getDictDatauserlevel());
		render("add.html");
	}
	
	//增加
	public void add() {
		try {
			getModel(CardGameRules.class, "model").save();
		}catch (Exception e){
			if(e.getMessage().contains("Duplicate entry")){
				renderFailed("该等级配置已存在，请勿重复添加！");
				return;
			}
		}

		addOpLog("[活动策略] 增加");
		renderSuccess();
	}
	
	//修改页面
	public void updatePage() {
		setAttr("dictDatagameid", CardGameRules.me.getDictDatagameid());
		setAttr("dictDatauserlevel", CardGameRules.me.getDictDatauserlevel());
		setAttr("model", CardGameRules.me.findById(getPara("id")));
		render("update.html");
	}
	
	//修改
	public void update() {
		CardGameRules model = CardGameRules.me.findById(getPara("id"));
		model.set("userlevel", getPara("model.userlevel"));
		model.set("enter_times", getPara("model.enter_times"));
		model.set("goal_times", getPara("model.goal_times"));
		model.set("random_rate", getPara("model.random_rate"));
		model.update();
		addOpLog("[活动策略] 修改");
		renderSuccess();
	}
	
	//删除
	public void delete() {
		Integer[] ids = getParaValuesToInt("id[]");
		for (Integer id : ids) {
			new CardGameRules().set("id", id).delete();
			
		}
		
		addOpLog("[活动策略] 删除");
		renderSuccess();
	}
	
	//详情页面
	public void detailPage() {
		CardGameRules model = CardGameRules.me.findById(getParaToInt("id"));
		Map<String, Object> dictDatagameid = CardGameRules.me.getDictDatagameid();
		if(dictDatagameid.get(model.get("gameid").toString()) != null) {
			model.set("gameid", dictDatagameid.get(model.get("gameid").toString()));
		}
		Map<String, Object> dictDatauserlevel = CardGameRules.me.getDictDatauserlevel();
		if(dictDatauserlevel.get(model.get("userlevel").toString()) != null) {
			model.set("userlevel", dictDatauserlevel.get(model.get("userlevel").toString()));
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
		
		List<Record> list = DBTool.findByMultPropertiesDbSource("zcurd_busi", "card_game_rules", properties, symbols, values);
		Map<String, Object> dictDatagameid = CardGameRules.me.getDictDatagameid();
		for(Record record : list) {
			String fieldName = "gameid";
			if(dictDatagameid.get(record.get(fieldName).toString()) != null) {
				record.set(fieldName, dictDatagameid.get(record.get(fieldName).toString()));
			}
		}
		Map<String, Object> dictDatauserlevel = CardGameRules.me.getDictDatauserlevel();
		for(Record record : list) {
			String fieldName = "userlevel";
			if(dictDatauserlevel.get(record.get(fieldName).toString()) != null) {
				record.set(fieldName, dictDatauserlevel.get(record.get(fieldName).toString()));
			}
		}
		
		List<String> headers = new ArrayList<String>();
		List<String> clomuns = new ArrayList<String>();
		headers.add("会员等级");
		clomuns.add("userlevel");
		headers.add("可抽奖次数（0为不限）");
		clomuns.add("enter_times");
		headers.add("最大中奖次数（0为不限）");
		clomuns.add("goal_times");
		headers.add("中奖概率（0-100，概率类有效）");
		clomuns.add("random_rate");
		
		CsvRender csvRender = new CsvRender(headers, list);
		csvRender.clomuns(clomuns);
		csvRender.fileName("活动策略");
		
		addOpLog("[活动策略] 导出cvs");
		render(csvRender);
	}
}
