package com.busi.controller;

import com.busi.model.CardGameProduct;
import com.jfinal.plugin.activerecord.Record;
import com.zcurd.common.DBTool;
import com.zcurd.common.base.BaseController;
import com.zcurd.common.render.csv.CsvRender;
import com.zcurd.common.util.StringUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 配置奖品
 */
public class CardGameProductController extends BaseController {
	
	public void listPage() {
		setAttr("dictDatagameid", CardGameProduct.me.getDictDatagameid());
		setAttr("dictDataproductid", CardGameProduct.me.getDictDataproductid());
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
		
		List<Record> list = DBTool.findByMultPropertiesDbSource("zcurd_busi", "card_game_product", properties, symbols, values, orderBy, getPager());
		Map<String, Object> dictDatagameid = CardGameProduct.me.getDictDatagameid();
		for(Record record : list) {
			String fieldName = "gameid";
			if(record.get(fieldName) != null && dictDatagameid.get(record.get(fieldName).toString()) != null) {
				record.set(fieldName, dictDatagameid.get(record.get(fieldName).toString()));
			}
		}
		Map<String, Object> dictDataproductid = CardGameProduct.me.getDictDataproductid();
		for(Record record : list) {
			String fieldName = "productid";
			if(record.get(fieldName) != null && dictDataproductid.get(record.get(fieldName).toString()) != null) {
				record.set(fieldName, dictDataproductid.get(record.get(fieldName).toString()));
			}
		}
		
		renderDatagrid(
			list, 
			DBTool.countByMultPropertiesDbSource("zcurd_busi", "card_game_product", properties, symbols, values)
		);
	}
	
	//增加页面
	public void addPage() {
		setAttr("dictDatagameid", CardGameProduct.me.getDictDatagameid());
		setAttr("dictDataproductid", CardGameProduct.me.getDictDataproductid());
		render("add.html");
	}
	
	//增加
	public void add() {
		getModel(CardGameProduct.class, "model").save();
		
		addOpLog("[配置奖品] 增加");
		renderSuccess();
	}
	
	//修改页面
	public void updatePage() {
		setAttr("dictDatagameid", CardGameProduct.me.getDictDatagameid());
		setAttr("dictDataproductid", CardGameProduct.me.getDictDataproductid());
		setAttr("model", CardGameProduct.me.findById(getPara("id")));
		render("update.html");
	}
	
	//修改
	public void update() {
		CardGameProduct model = CardGameProduct.me.findById(getPara("id"));
		model.set("gameid", getPara("model.gameid"));
		model.set("productid", getPara("model.productid"));
		model.set("amount", getPara("model.amount"));
		model.update();
		addOpLog("[配置奖品] 修改");
		renderSuccess();
	}
	
	//删除
	public void delete() {
		Integer[] ids = getParaValuesToInt("id[]");
		for (Integer id : ids) {
			new CardGameProduct().set("id", id).delete();
			
		}
		
		addOpLog("[配置奖品] 删除");
		renderSuccess();
	}
	
	//详情页面
	public void detailPage() {
		CardGameProduct model = CardGameProduct.me.findById(getParaToInt("id"));
		Map<String, Object> dictDatagameid = CardGameProduct.me.getDictDatagameid();
		if(dictDatagameid.get(model.get("gameid").toString()) != null) {
			model.set("gameid", dictDatagameid.get(model.get("gameid").toString()));
		}
		Map<String, Object> dictDataproductid = CardGameProduct.me.getDictDataproductid();
		if(dictDataproductid.get(model.get("productid").toString()) != null) {
			model.set("productid", dictDataproductid.get(model.get("productid").toString()));
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
		
		List<Record> list = DBTool.findByMultPropertiesDbSource("zcurd_busi", "card_game_product", properties, symbols, values);
		Map<String, Object> dictDatagameid = CardGameProduct.me.getDictDatagameid();
		for(Record record : list) {
			String fieldName = "gameid";
			if(dictDatagameid.get(record.get(fieldName).toString()) != null) {
				record.set(fieldName, dictDatagameid.get(record.get(fieldName).toString()));
			}
		}
		Map<String, Object> dictDataproductid = CardGameProduct.me.getDictDataproductid();
		for(Record record : list) {
			String fieldName = "productid";
			if(dictDataproductid.get(record.get(fieldName).toString()) != null) {
				record.set(fieldName, dictDataproductid.get(record.get(fieldName).toString()));
			}
		}
		
		List<String> headers = new ArrayList<String>();
		List<String> clomuns = new ArrayList<String>();
		headers.add("活动");
		clomuns.add("gameid");
		headers.add("奖品");
		clomuns.add("productid");
		headers.add("数量");
		clomuns.add("amount");
		
		CsvRender csvRender = new CsvRender(headers, list);
		csvRender.clomuns(clomuns);
		csvRender.fileName("配置奖品");
		
		addOpLog("[配置奖品] 导出cvs");
		render(csvRender);
	}
}
