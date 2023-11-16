package com.busi.controller;

import com.busi.model.CardGame;
import com.busi.model.CardGameProduct;
import com.busi.model.CardGameRules;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.zcurd.common.DBTool;
import com.zcurd.common.base.BaseController;
import com.zcurd.common.render.csv.CsvRender;
import com.zcurd.common.util.StringUtil;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * 历史活动
 */
public class CardGameController extends BaseController {
	
	public void listPage() {
		setAttr("dictDatatype", CardGame.me.getDictDatatype());
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
		
		List<Record> list = DBTool.findByMultPropertiesDbSource("zcurd_busi", "card_game", properties, symbols, values, orderBy, getPager());
		Map<String, Object> dictDatatype = CardGame.me.getDictDatatype();
		for(Record record : list) {
			String fieldName = "type";
			if(record.get(fieldName) != null && dictDatatype.get(record.get(fieldName).toString()) != null) {
				record.set(fieldName, dictDatatype.get(record.get(fieldName).toString()));
			}
		}
		
		renderDatagrid(
			list, 
			DBTool.countByMultPropertiesDbSource("zcurd_busi", "card_game", properties, symbols, values)
		);
	}
	
	//增加页面
	public void addPage() {
		setAttr("dictDatatype", CardGame.me.getDictDatatype());
		render("add.html");
	}
	
	//增加
	public void add() {
		getModel(CardGame.class, "model").save();
		
		addOpLog("[历史活动] 增加");
		renderSuccess();
	}
	
	//修改页面
	public void updatePage() {
		setAttr("dictDatatype", CardGame.me.getDictDatatype());
		setAttr("model", CardGame.me.findById(getPara("id")));
		render("update.html");
	}
	
	//修改
	public void update() {
		CardGame model = CardGame.me.findById(getPara("id"));
		model.set("title", getPara("model.title"));
		model.set("info", getPara("model.info"));
		model.set("starttime", getPara("model.starttime"));
		model.set("endtime", getPara("model.endtime"));
		model.set("type", getPara("model.type"));
		model.update();
		addOpLog("[历史活动] 修改");
		renderSuccess();
	}
	
	//删除
	public void delete() {
		Integer[] ids = getParaValuesToInt("id[]");
		for (Integer id : ids) {
			new CardGame().set("id", id).delete();
			
		}
		
		addOpLog("[历史活动] 删除");
		renderSuccess();
	}
	
	//详情页面
	public void detailPage() {
		CardGame model = CardGame.me.findById(getParaToInt("id"));
		Map<String, Object> dictDatatype = CardGame.me.getDictDatatype();
		if(dictDatatype.get(model.get("type").toString()) != null) {
			model.set("type", dictDatatype.get(model.get("type").toString()));
		}
		//中奖策略
		List<Record> rules = Db.find(
		        "select s.dict_value level_name,r.* from card_game_rules r,sys_dict s where s.dict_type='card_user_level' and r.userlevel=s.dict_key and r.gameid=?",
                getParaToInt("id")
        );
		setAttr("rules",rules);
		//奖品配置
        List<Record> products = Db.find(
				"select p.name,c.amount from card_game_product c,card_product p where c.productid=p.id and c.gameid=?",
				getParaToInt("id")
		);
        setAttr("products",products);

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
		
		List<Record> list = DBTool.findByMultPropertiesDbSource("zcurd_busi", "card_game", properties, symbols, values);
		Map<String, Object> dictDatatype = CardGame.me.getDictDatatype();
		for(Record record : list) {
			String fieldName = "type";
			if(dictDatatype.get(record.get(fieldName).toString()) != null) {
				record.set(fieldName, dictDatatype.get(record.get(fieldName).toString()));
			}
		}
		
		List<String> headers = new ArrayList<String>();
		List<String> clomuns = new ArrayList<String>();
		headers.add("活动主题");
		clomuns.add("title");
		headers.add("活动简介");
		clomuns.add("info");
		headers.add("开始时间");
		clomuns.add("starttime");
		headers.add("结束时间");
		clomuns.add("endtime");
		headers.add("类型");
		clomuns.add("type");
		
		CsvRender csvRender = new CsvRender(headers, list);
		csvRender.clomuns(clomuns);
		csvRender.fileName("历史活动");
		
		addOpLog("[历史活动] 导出cvs");
		render(csvRender);
	}
}
