package com.zcurd.online.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Duang;
import com.jfinal.plugin.activerecord.Record;
import com.zcurd.common.DBTool;
import com.zcurd.common.DbMetaTool;
import com.zcurd.common.ZcurdTool;
import com.zcurd.common.base.BaseController;
import com.zcurd.common.handler.CurdHandle;
import com.zcurd.common.render.csv.CsvRender;
import com.zcurd.common.util.FreemarkUtil;
import com.zcurd.common.util.StringUtil;
import com.zcurd.online.model.ZcurdField;
import com.zcurd.online.model.ZcurdHead;
import com.zcurd.online.model.ZcurdHeadJs;
import com.zcurd.online.service.ZcurdService;
import com.zcurd.online.vo.QueryParamVO;
import com.zcurd.online.vo.ZcurdMeta;

/**
 * 在线表单
 * @author 钟世云 2016.2.5
 */
public class ZcurdController extends BaseController {
	
	//列表页面
	public void listPage() {
		int headId = getHeadId();
		ZcurdService zcurdService = Duang.duang(ZcurdService.class);
		ZcurdMeta metaData = zcurdService.getMetaData(headId);
		flushDictData(metaData);
		
		// 默认排序
		setAttr("sort", getPara("sort"));
		setAttr("order", getPara("order"));
		
		setAttr("headId", headId);
		setAttrs(metaData.toMap());
		setAttr("queryPara", ZcurdTool.getQueryPara(getParaMap()));
		handleVar(metaData, null);
		render("listPage.html");
	}
	
	//列表数据
	public void listData() {
		int headId = getHeadId();
		ZcurdService zcurdService = Duang.duang(ZcurdService.class);
		ZcurdMeta metaData = DbMetaTool.getMetaData(headId);
		ZcurdHead head = metaData.getHead();
		
		QueryParamVO vo = getQueryParamsVO();
		vo.setDbSource(head.getDbSource());
		vo.setTable(head.getTableName());
		vo.setPager(getPager());
		vo.setOrderBy(getOrderBy(head.getIdField() + " desc"));
		vo.setWhereSql(getAuthDataRule());
		
		// 判断逻辑删除标识
		if(StringUtil.isNotEmpty(head.getdeleteFlagField())) {
			vo.add(head.getdeleteFlagField(), 0);
		}
		
		renderDatagrid(
			ZcurdTool.replaceDict(metaData, DBTool.findList(vo)), 
			DBTool.countBy(vo), 
			zcurdService.getFooter(metaData, vo)
		);
	}
	
	//增加页面
	public void addPage() {
		int headId = getHeadId();
		ZcurdService zcurdService = Duang.duang(ZcurdService.class);
		ZcurdMeta metaData = zcurdService.getMetaData(headId);
		flushDictData(metaData);
		
		//变量
		Map<String, Object> varData = new HashMap<>();
		varData.put("user", getSessionUser());
		varData.put("metaData", metaData);
		varData.put("request", getRequest());
		varData.put("session", getRequest().getSession());
		for (ZcurdField field : metaData.getAddFieldList()) {
			String defaultValue = field.getStr("default_value");
			if(StringUtil.isNotEmpty(defaultValue)) {
				//默认值变量处理
				field.set("default_value", FreemarkUtil.parse(defaultValue, varData));
			}
		}
		
		setAttr("headId", headId);
		setAttrs(metaData.toMap());
		setAttr("queryPara", ZcurdTool.getQueryPara(getParaMap()));
		handleVar(metaData, null);
	}
	
	//增加
	public void add() {
		int headId = getHeadId();
		ZcurdMeta metaData = DbMetaTool.getMetaData(headId);
		ZcurdHead head = metaData.getHead();
		Map<String, String[]> paraMap = new HashMap<String, String[]>();
		paraMap.putAll(getParaMap());	//原始paramMap不允许修改，因此创建新的paraMap
		
		String handleClass = head.getStr("handle_class");
		if(StringUtil.isNotEmpty(handleClass)) {
			try {
				CurdHandle ch = (CurdHandle) Duang.duang(Class.forName(handleClass));
				ch.add(metaData, getRequest(), paraMap);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		ZcurdService zcurdService = Duang.duang(ZcurdService.class);
		zcurdService.add(getHeadId(), paraMap, getRequest());
		
		addOpLog("[" + head.getFormName() + "] 增加");
		renderSuccess();
	}
	
	//修改页面
	public void updatePage() {
		int headId = getHeadId();
		ZcurdService zcurdService = Duang.duang(ZcurdService.class);
		ZcurdMeta metaData = zcurdService.getMetaData(headId);
		flushDictData(metaData);
		
		setAttr("headId", headId);
		setAttrs(metaData.toMap());
		Record currRecord = zcurdService.get(headId, getParaToInt("id"));
		setAttr("model", currRecord.getColumns());
		handleVar(metaData, currRecord);
		render("updatePage.html");
	}
	
	//修改
	public void update() {
		int headId = getHeadId();
		ZcurdMeta metaData = DbMetaTool.getMetaData(headId);
		ZcurdHead head = metaData.getHead();
		
		Map<String, String[]> paraMap = new HashMap<String, String[]>();
		paraMap.putAll(getParaMap());	//原始paramMap不允许修改，因此创建新的paraMap
		String handleClass = head.getStr("handle_class");
		if(StringUtil.isNotEmpty(handleClass)) {
			try {
				CurdHandle ch = (CurdHandle) Duang.duang(Class.forName(handleClass));
				ch.update(metaData, getRequest(), paraMap);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		ZcurdService zcurdService = Duang.duang(ZcurdService.class);
		zcurdService.update(getHeadId(), getParaToInt("id"), paraMap);
		
		addOpLog("[" + head.getFormName() + "] 修改");
		renderSuccess();
	}
	
	//删除
	public void delete() {
		int headId = getHeadId();
		ZcurdMeta metaData = DbMetaTool.getMetaData(headId);
		ZcurdHead head = metaData.getHead();
		
		Integer[] ids = getParaValuesToInt("id[]");
		ZcurdService zcurdService = Duang.duang(ZcurdService.class);
		zcurdService.delete(getHeadId(), ids);
		
		addOpLog("[" + head.getFormName() + "] 删除");
		renderSuccess();
	}
	
	//详情页面
	public void detailPage() {
		int headId = getHeadId();
		ZcurdMeta metaData = DbMetaTool.getMetaData(headId);
		ZcurdService zcurdService = Duang.duang(ZcurdService.class);
		
		Record row = zcurdService.get(headId, getParaToInt("id"));
		setAttr("headId", headId);
		setAttrs(metaData.toMap());
		setAttr("model", ZcurdTool.replaceDict(metaData, row));
		handleVar(metaData, row);
		render("detailPage.html");
	}
	
	//导出csv
	public void exportCsv() {
		int headId = getHeadId();
		ZcurdMeta metaData = DbMetaTool.getMetaData(headId);
		ZcurdHead head = metaData.getHead();
		List<ZcurdField> fieldList = metaData.getFieldList();
		flushDictData(metaData);
		
		Object[] queryParams = getQueryParams();
		String[] properties = (String[]) queryParams[0];
		String[] symbols = (String[]) queryParams[1];
		Object[] values = (Object[]) queryParams[2];
		
		String orderBy = getOrderBy();
		if(StringUtil.isEmpty(orderBy)) {
			orderBy = head.getIdField() + " desc";
		}
		
		List<Record> list = ZcurdTool.replaceDict(headId, 
				DBTool.findByMultPropertiesDbSource(ZcurdTool.getDbSource(head.getDbSource()), head.getTableName(), properties, symbols, values));
		List<String> headers = new ArrayList<String>();
		List<String> clomuns = new ArrayList<String>();
		for (ZcurdField zcurdField : fieldList) {
			if(zcurdField.getInt("is_show_list") == 1) {
				headers.add(zcurdField.getStr("column_name"));
				clomuns.add(zcurdField.getStr("field_name"));
			}
		}
		CsvRender csvRender = new CsvRender(headers, list);
		csvRender.clomuns(clomuns);
		csvRender.fileName(head.getStr("form_name"));
		
		addOpLog("[" + head.getFormName() + "] 导出cvs");
		render(csvRender);
	}
	
	/**
	 * 获得表单id
	 */
	private int getHeadId() {
		String headId = getAttr("headId");
		return Integer.parseInt(headId);
	}

	/**
	 * 刷新字典数据
	 */
	private void flushDictData(ZcurdMeta metaData) {
		for (ZcurdField zcurdField : metaData.getFieldList()) {
			String dictSql = zcurdField.getStr("dict_sql");
			if(StringUtil.isNotEmpty(dictSql)) {
				Map<String, Object> dictData = DbMetaTool.getDictData(dictSql);
				metaData.getDictMap().put(zcurdField.getStr("field_name"), dictData);
				zcurdField.put("dict", dictData);
			}
		}
	}
	
	/**
	 * 处理变量
	 */
	private void handleVar(ZcurdMeta metaData, Record currRecord) {
		//TODO 变量处理，此处可以加其它数据
		Map<String, Object> varData = new HashMap<>();
		varData.put("currRecord", currRecord);	//当前编辑记录，编辑、详情页面可用
		varData.put("user", getSessionUser());
		varData.put("metaData", metaData);
		varData.put("request", getRequest());
		varData.put("session", getSession());
		
		//sql数据
		List<Object> sqlData = new ArrayList<>();
		for (ZcurdHeadJs zcurdHeadJs : metaData.getJsList()) {
			String sqlContent = FreemarkUtil.parse(zcurdHeadJs.getStr("sql_content"), varData);
			if(StringUtil.isNotEmpty(sqlContent)) {
				zcurdHeadJs.set("sql_content", sqlContent);
				for (String sql : sqlContent.split(";")) {
					sqlData.add(DBTool.findBySQL4DbSource(sql));
				}
			}
		}
		varData.put("sqlData", sqlData);
		
		for (ZcurdHeadJs zcurdHeadJs : metaData.getJsList()) {
			//处理变量后的扩展js内容
			zcurdHeadJs.setJsContentData(FreemarkUtil.parse(zcurdHeadJs.getStr("js_content"), varData));
		}
	}

}
