package com.zcurd.common;

import com.busi.controller.CardGameController;
import com.busi.controller.CardGameProductController;
import com.busi.controller.CardGameRulesController;
import com.busi.controller.CardUserController;
import com.busi.model.CardGame;
import com.busi.model.CardGameProduct;
import com.busi.model.CardGameRules;
import com.busi.model.CardUser;
import com.jfinal.aop.Duang;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.render.FreeMarkerRender;
import com.jfinal.render.ViewType;
import com.jfinal.template.Engine;
import com.zcurd.account.common.AccountConfig;
import com.zcurd.account.model.SysLoginLog;
import com.zcurd.account.model._MappingKit;
import com.zcurd.common.handler.ZcurdHandler;
import com.zcurd.common.interceptor.ErrorInterceptor;
import com.zcurd.online.controller.CommonController;
import com.zcurd.online.controller.SysOplogController;
import com.zcurd.online.controller.TaskBaseController;
import com.zcurd.online.controller.ZcurdController;
import com.zcurd.online.controller.ZcurdHeadController;
import com.zcurd.online.model.CommonFile;
import com.zcurd.online.model.SysMenuBtn;
import com.zcurd.online.model.SysOplog;
import com.zcurd.online.model.TaskBase;
import com.zcurd.online.model.TaskLog;
import com.zcurd.online.model.ZcurdField;
import com.zcurd.online.model.ZcurdHead;
import com.zcurd.online.model.ZcurdHeadBtn;
import com.zcurd.online.model.ZcurdHeadJs;
import com.zcurd.online.service.TaskService;

import freemarker.template.TemplateModelException;

/**
 * API引导式配置
 */
public class ZcurdConfig extends JFinalConfig {
	private AccountConfig accountConfig = new AccountConfig();
	private static Constants jfinalConstants;
	
	/**
	 * 配置常量
	 */
	public void configConstant(Constants me) {
		accountConfig.configConstant(me);
		// 加载少量必要配置，随后可用PropKit.get(...)获取值
		PropKit.use("db.properties");
		me.setDevMode(PropKit.getBoolean("devMode", false));
		me.setViewType(ViewType.FREE_MARKER);
		jfinalConstants = me;
	}
	
	/**
	 * 配置路由
	 */
	public void configRoute(Routes me) {
		accountConfig.configRoute(me);
		me.add("/zcurd", ZcurdController.class, "/zcurd/zcurd");
		me.add("/zcurdHead", ZcurdHeadController.class, "/zcurd");
		me.add("/common", CommonController.class, "/zcurd");
		me.add("/oplog", SysOplogController.class, "/zcurd/sysOplog");
		me.add("/task", TaskBaseController.class, "/zcurd/taskBase");
		me.add("/gameproduct", CardGameProductController.class,"/busi/cardGameProduct");
		me.add("/gamerules", CardGameRulesController.class,"/busi/cardGameRules");
		me.add("/carduser", CardUserController.class,"/busi/cardUser");
		me.add("/gamehistory", CardGameController.class,"/busi/cardGame");

	}
	
	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		accountConfig.configPlugin(me);

		DruidPlugin druidPlugin = new DruidPlugin(PropKit.get("base_jdbcUrl"), PropKit.get("base_user"), PropKit.get("base_password").trim());
		druidPlugin.set(2,1,5);
		me.add(druidPlugin);
		
		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin("zcurd_base", druidPlugin);
		arp.setShowSql(true);
		me.add(arp);
		arp.addMapping("zcurd_head", ZcurdHead.class);
		arp.addMapping("zcurd_field", ZcurdField.class);
		arp.addMapping("zcurd_head_btn", ZcurdHeadBtn.class);
		arp.addMapping("zcurd_head_js", ZcurdHeadJs.class);
		arp.addMapping("sys_menu_btn", SysMenuBtn.class);
		arp.addMapping("sys_oplog", SysOplog.class);
		arp.addMapping("common_file", CommonFile.class);
		arp.addMapping("task_base", TaskBase.class);
		arp.addMapping("task_log", "id", TaskLog.class);
		arp.addMapping("sys_login_log", "id", SysLoginLog.class);
		_MappingKit.mapping(arp);
		
		//业务数据库
		DruidPlugin druidPluginAir = new DruidPlugin(PropKit.get("busi_jdbcUrl"), PropKit.get("busi_user"), PropKit.get("busi_password").trim());
		me.add(druidPluginAir);
		ActiveRecordPlugin arpAir = new ActiveRecordPlugin("zcurd_busi", druidPluginAir);
		arpAir.setShowSql(true);

		arpAir.addMapping("card_game_product", CardGameProduct.class);
		arpAir.addMapping("card_game_rules", CardGameRules.class);
		arpAir.addMapping("card_user", CardUser.class);
		arpAir.addMapping("card_game", CardGame.class);

		me.add(arpAir);
	}
	
	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		accountConfig.configInterceptor(me);
		me.add(new ErrorInterceptor());
	}
	
	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {
		accountConfig.configHandler(me);
		me.add(new ZcurdHandler());
		
	}
	
	@Override
	public void afterJFinalStart() {
		accountConfig.afterJFinalStart();
		try {
			FreeMarkerRender.getConfiguration().setSharedVariable("basePath", JFinal.me().getContextPath());
		} catch (TemplateModelException e) {
			e.printStackTrace();
		}
		
		//定时任务
		TaskService taskService = Duang.duang(TaskService.class);
		taskService.startAll();
	}
	
	/**
	 * 建议使用 JFinal 手册推荐的方式启动项目
	 * 运行此 main 方法可以启动项目，此main方法可以放置在任意的Class类定义中，不一定要放于此
	 */
	public static void main(String[] args) {
		JFinal.start("src/main/webapp", 8080, "/", 5);
	}

	@Override
	public void configEngine(Engine me) {
		accountConfig.configEngine(me);
	}
	
	public static boolean getDevModel() {
		return jfinalConstants.getDevMode();
	}
}
