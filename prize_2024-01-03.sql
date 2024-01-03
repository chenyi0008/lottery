# ************************************************************
# Sequel Ace SQL dump
# 版本号： 20046
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# 主机: prize (MySQL 5.7.43)
# 数据库: prize
# 生成时间: 2024-01-03 上午3:41:24 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# 转储表 card_game
# ------------------------------------------------------------

DROP TABLE IF EXISTS `card_game`;

CREATE TABLE `card_game` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '活动主题',
  `pic` varchar(255) DEFAULT NULL COMMENT '活动宣传图',
  `info` varchar(1000) DEFAULT NULL COMMENT '活动简介',
  `starttime` datetime NOT NULL COMMENT '开始时间',
  `endtime` datetime NOT NULL COMMENT '结束时间',
  `type` tinyint(2) DEFAULT NULL COMMENT '类型（1=概率类，2=随机类）',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态（0=新建，1=已加载）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

LOCK TABLES `card_game` WRITE;
/*!40000 ALTER TABLE `card_game` DISABLE KEYS */;

INSERT INTO `card_game` (`id`, `title`, `pic`, `info`, `starttime`, `endtime`, `type`, `status`)
VALUES
	(7,'超级女神','http://116.62.213.90:9005/prize/1701763751035.jpeg','女神来抽奖','2019-11-01 09:34:23','2019-11-01 10:24:23',1,1),
	(44,'中秋节红包雨','http://116.62.213.90:9005/prize/1701763740228.jpeg','浓情中秋 感恩大礼','2020-07-02 16:45:25','2020-07-02 16:50:53',1,1),
	(46,'七夕节大抽奖','http://116.62.213.90:9005/prize/1701763719498.jpeg','七夕快乐！','2020-08-31 11:04:00','2020-08-31 11:45:00',1,1),
	(60,'春节年会','http://116.62.213.90:9005/prize/1701763693103.jpeg','又是一年春节了。那么首先,我向在座的各位送上由衷的祝福和感谢。 20xx年对我们侨泰而言是很重要的.一年。这一年里,我们的门店数增加到了20家,公司规模也扩展到了280人。这一串数字让我很欣慰,侨泰成立短短几年就能有今天的成绩','2023-11-02 11:52:17','2023-11-20 10:37:25',1,1),
	(61,'来玩红包雨','http://116.62.213.90:9005/prize/1701763673995.jpeg','同时参与预售及现货销售的同款商品若消费者通过预售方式购买的到手价≥现货方式(直接购买)到手价,将视具体情节采取必要的市场管控措施,包括但不限于下架商','2023-11-17 11:35:23','2023-11-30 11:35:35',1,1),
	(63,'2024年618','http://116.62.213.90:9005/prize/1701760677964.jpeg','2024年才开始，等着吧','2024-06-18 10:43:21','2024-06-30 10:43:34',1,0),
	(65,'春节年会提前嗨','http://116.62.213.90:9005/prize/1701761070133.jpeg','抽奖进行中','2023-12-06 18:25:43','2023-12-25 15:24:44',1,1),
	(66,'压测','http://116.62.213.90:9005/prize/20231229111721A001.jpg','压力测试','2023-12-12 15:16:15','2023-12-23 15:12:39',1,1);

/*!40000 ALTER TABLE `card_game` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 card_game_product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `card_game_product`;

CREATE TABLE `card_game_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gameid` int(11) unsigned DEFAULT NULL COMMENT '活动',
  `productid` int(11) DEFAULT NULL COMMENT '奖品',
  `amount` smallint(6) DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `game_id_constrant` (`gameid`) USING BTREE,
  CONSTRAINT `card_game_product_ibfk_1` FOREIGN KEY (`gameid`) REFERENCES `card_game` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

LOCK TABLES `card_game_product` WRITE;
/*!40000 ALTER TABLE `card_game_product` DISABLE KEYS */;

INSERT INTO `card_game_product` (`id`, `gameid`, `productid`, `amount`)
VALUES
	(128,46,10,30),
	(129,46,11,10),
	(130,46,12,5),
	(159,60,4,50),
	(160,60,5,30),
	(161,60,8,50),
	(162,60,7,80),
	(163,60,13,30),
	(164,60,11,80),
	(165,60,12,60),
	(166,60,10,90),
	(167,61,4,5),
	(168,61,11,5),
	(169,63,5,1),
	(170,63,4,1),
	(171,63,8,1),
	(172,63,10,11),
	(173,63,6,1),
	(174,63,7,11),
	(175,65,4,1000),
	(176,65,5,1000),
	(177,65,8,1000),
	(178,65,11,1000),
	(206,66,5,33),
	(207,66,6,44),
	(208,66,4,112),
	(225,44,4,111),
	(226,44,5,111),
	(227,44,7,111),
	(228,44,8,111),
	(237,7,4,10),
	(238,7,7,20),
	(239,7,8,30),
	(240,7,4,2);

/*!40000 ALTER TABLE `card_game_product` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 card_game_rules
# ------------------------------------------------------------

DROP TABLE IF EXISTS `card_game_rules`;

CREATE TABLE `card_game_rules` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `gameid` int(11) unsigned DEFAULT NULL COMMENT '活动id',
  `userlevel` smallint(6) NOT NULL COMMENT '会员等级',
  `enter_times` smallint(6) NOT NULL DEFAULT '0' COMMENT '可抽奖次数（0为不限）',
  `goal_times` smallint(6) NOT NULL DEFAULT '0' COMMENT '最大中奖次数（0为不限）',
  `random_rate` tinyint(4) NOT NULL DEFAULT '100' COMMENT '如果是概率类，多大中奖率（0-100），默认100',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `gameid` (`gameid`,`userlevel`),
  KEY `card_game_rules_fk` (`gameid`),
  CONSTRAINT `card_game_rules_fk` FOREIGN KEY (`gameid`) REFERENCES `card_game` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='活动策略';

LOCK TABLES `card_game_rules` WRITE;
/*!40000 ALTER TABLE `card_game_rules` DISABLE KEYS */;

INSERT INTO `card_game_rules` (`id`, `gameid`, `userlevel`, `enter_times`, `goal_times`, `random_rate`)
VALUES
	(69,46,1,1,2,100),
	(70,46,2,2,3,5),
	(98,66,1,13,24,35),
	(99,66,2,5,6,7),
	(108,44,0,1,6,7),
	(109,44,2,2,5,8),
	(110,44,1,3,4,9),
	(120,7,1,3,3,3),
	(121,7,2,4,5,6),
	(122,7,0,2,3,3),
	(123,7,3,2,3,4);

/*!40000 ALTER TABLE `card_game_rules` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 card_product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `card_product`;

CREATE TABLE `card_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '奖品名称',
  `pic` varchar(255) DEFAULT NULL COMMENT '图片',
  `info` varchar(1000) DEFAULT NULL COMMENT '简介',
  `price` decimal(10,2) DEFAULT NULL COMMENT '市场价',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

LOCK TABLES `card_product` WRITE;
/*!40000 ALTER TABLE `card_product` DISABLE KEYS */;

INSERT INTO `card_product` (`id`, `name`, `pic`, `info`, `price`)
VALUES
	(4,'美宝莲口红','http://116.62.213.90:9005/prize/1701764278375.jpeg','来自TF的口红，经典的黑金包装，尽显奢华',5000000.00),
	(5,'美食大礼盒','http://116.62.213.90:9005/prize/1701764269414.jpeg','来自好利来的轻奢月饼，是家人食用，馈赠亲友的不二选择',1000.00),
	(6,'5积分','http://116.62.213.90:9005/prize/1701764258626.jpeg','积分可以在积分商城兑换相应商品，例如5个积分可以兑换50元话费',500.00),
	(7,'10积分','http://116.62.213.90:9005/prize/1701764250415.jpeg','积分可以累计，在积分商城里兑换相应价值的商品，例如10个积分可以兑换100元话费',100.00),
	(8,'物美购物卡','http://116.62.213.90:9005/prize/1701764241720.jpeg','物美综合超bai市是国内最早以连锁方式经营du的专业公司之一。',200.00),
	(10,'青铜','http://116.62.213.90:9005/prize/1701764230834.jpeg','看上去和金子一样，但是不是',1.00),
	(11,'一块生铁','http://116.62.213.90:9005/prize/1701764221706.jpeg','挺沉，但没什么用',8.00),
	(12,'金奖章','http://116.62.213.90:9005/prize/1701764213439.jpeg','金光闪闪',77.00),
	(13,'奇怪的猫','http://116.62.213.90:9005/prize/1703556628777.jpeg','西伯利亚猫，长得跟个狗似的',1000.00);

/*!40000 ALTER TABLE `card_product` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 card_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `card_user`;

CREATE TABLE `card_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uname` varchar(20) NOT NULL COMMENT '用户名',
  `pic` varchar(255) DEFAULT NULL COMMENT '头像',
  `passwd` varchar(50) NOT NULL COMMENT '密码',
  `realname` varchar(10) DEFAULT NULL COMMENT '姓名',
  `idcard` varchar(18) NOT NULL COMMENT '身份证号',
  `phone` varchar(15) NOT NULL COMMENT '手机号码',
  `level` smallint(6) NOT NULL DEFAULT '0' COMMENT '等级',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uname` (`uname`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员信息表';

LOCK TABLES `card_user` WRITE;
/*!40000 ALTER TABLE `card_user` DISABLE KEYS */;

INSERT INTO `card_user` (`id`, `uname`, `pic`, `passwd`, `realname`, `idcard`, `phone`, `level`, `createtime`, `updatetime`)
VALUES
	(14,'shawn','http://116.62.213.90:9005/prize/1701763890730.jpeg','1','wsw','1','13355556666',3,'2019-10-31 11:24:25','2023-12-29 17:12:48'),
	(20,'bxg','http://116.62.213.90:9005/prize/1701763881362.jpeg','-7fa723a043f8f629d8629dfbd0e5d571','bxg','1','13111111111',4,'2023-11-15 09:29:04','2024-01-03 11:20:07'),
	(21,'wxm','http://116.62.213.90:9005/prize/20231229154329A001.jpg','wxm','王小猫','','13322332233',0,'2023-12-29 15:43:47','2023-12-29 15:44:05'),
	(23,'bxg21','http://116.62.213.90:9005/prize/20240102093310A001.jpg','202cb962ac59075b964b07152d234b70','奶茶','321321','13355556666',4,'2023-12-29 17:37:19','2024-01-03 11:19:31');

/*!40000 ALTER TABLE `card_user` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 card_user_game
# ------------------------------------------------------------

DROP TABLE IF EXISTS `card_user_game`;

CREATE TABLE `card_user_game` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  `gameid` int(11) DEFAULT NULL COMMENT '活动id',
  `createtime` datetime DEFAULT NULL COMMENT '参与时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

LOCK TABLES `card_user_game` WRITE;
/*!40000 ALTER TABLE `card_user_game` DISABLE KEYS */;

INSERT INTO `card_user_game` (`id`, `userid`, `gameid`, `createtime`)
VALUES
	(1,20,65,'2023-12-06 18:25:51'),
	(2,20,66,'2023-12-12 15:24:12'),
	(3,20,66,'2023-12-12 15:16:15');

/*!40000 ALTER TABLE `card_user_game` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 card_user_hit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `card_user_hit`;

CREATE TABLE `card_user_hit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gameid` int(10) unsigned DEFAULT NULL COMMENT '活动',
  `userid` int(10) unsigned DEFAULT NULL COMMENT '用户',
  `productid` int(10) unsigned DEFAULT NULL COMMENT '奖品',
  `hittime` datetime DEFAULT NULL COMMENT '中奖时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `gameid` (`gameid`) USING BTREE,
  KEY `userid` (`userid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

LOCK TABLES `card_user_hit` WRITE;
/*!40000 ALTER TABLE `card_user_hit` DISABLE KEYS */;

INSERT INTO `card_user_hit` (`id`, `gameid`, `userid`, `productid`, `hittime`)
VALUES
	(1,65,20,5,'2023-12-06 18:29:44'),
	(2,65,20,11,'2023-12-12 10:57:59'),
	(3,65,20,5,'2023-12-12 10:58:15');

/*!40000 ALTER TABLE `card_user_hit` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 gen_table
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gen_table`;

CREATE TABLE `gen_table` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作 sub主子表操作）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表';

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;

INSERT INTO `gen_table` (`table_id`, `table_name`, `table_comment`, `sub_table_name`, `sub_table_fk_name`, `class_name`, `tpl_category`, `package_name`, `module_name`, `business_name`, `function_name`, `function_author`, `gen_type`, `gen_path`, `options`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(4,'card_product','奖品管理','',NULL,'CardProduct','crud','com.ruoyi.lottery','lottery','product','奖品管理','Shawn','0','/','{\"parentMenuId\":\"2000\",\"treeName\":\"\",\"treeParentCode\":\"\",\"parentMenuName\":\"抽奖系统\",\"treeCode\":\"\"}','admin','2023-12-27 14:58:38','','2023-12-28 14:30:51',''),
	(5,'card_game','活动管理','card_game_product','gameid','CardGame','sub','com.ruoyi.lottery','lottery','game','活动管理','Shawn','1','/','{\"parentMenuId\":\"2000\",\"treeName\":\"\",\"treeParentCode\":\"\",\"parentMenuName\":\"抽奖系统\",\"treeCode\":\"\"}','admin','2023-12-27 15:56:14','','2023-12-28 15:00:53',''),
	(6,'card_game_product','活动奖品','',NULL,'CardGameProduct','crud','com.ruoyi.lottery','lottery','product','活动奖品','Shawn','0','/','{\"parentMenuId\":\"2000\",\"treeName\":\"\",\"treeParentCode\":\"\",\"parentMenuName\":\"抽奖系统\",\"treeCode\":\"\"}','admin','2023-12-27 16:21:01','','2023-12-27 16:31:05',''),
	(7,'card_game_rules','活动策略','',NULL,'CardGameRules','crud','com.ruoyi.lottery','lottery','rules','活动策略','Shawn','0','/','{\"parentMenuId\":\"2000\",\"treeName\":\"\",\"treeParentCode\":\"\",\"parentMenuName\":\"抽奖系统\",\"treeCode\":\"\"}','admin','2023-12-27 16:40:28','','2023-12-27 16:44:24',''),
	(9,'card_user','会员管理','',NULL,'CardUser','crud','com.ruoyi.lottery','lottery','user','会员信息','Shawn','0','/','{\"parentMenuId\":\"2000\",\"treeName\":\"\",\"treeParentCode\":\"\",\"parentMenuName\":\"抽奖系统\",\"treeCode\":\"\"}','admin','2023-12-29 15:22:33','','2023-12-29 15:36:09',''),
	(10,'view_game_curinfo','活动中奖统计','',NULL,'ViewGameCurinfo','crud','com.ruoyi.lottery','lottery','curinfo','活动中奖统计','Shawn','0','/','{\"parentMenuId\":\"2025\",\"treeName\":\"\",\"treeParentCode\":\"\",\"parentMenuName\":\"活动统计\",\"treeCode\":\"\"}','admin','2024-01-02 11:09:06','','2024-01-02 11:13:47',''),
	(11,'view_card_user_hit','中奖用户详情','',NULL,'ViewCardUserHit','crud','com.ruoyi.lottery','lottery','hit','中奖用户详情','Shawn','0','/','{\"parentMenuId\":\"2025\",\"treeName\":\"\",\"treeParentCode\":\"\",\"parentMenuName\":\"活动统计\",\"treeCode\":\"\"}','admin','2024-01-02 11:15:54','','2024-01-02 11:20:10','');

/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 gen_table_column
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gen_table_column`;

CREATE TABLE `gen_table_column` (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint(20) DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表字段';

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;

INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES
	(18,4,'id','','int(10) unsigned','Integer','id','1','1',NULL,NULL,NULL,NULL,NULL,'EQ','input','',1,'admin','2023-12-27 14:58:39',NULL,'2023-12-28 14:30:51'),
	(19,4,'name','奖品名称','varchar(255)','String','name','0','0',NULL,'1','1','1','1','LIKE','input','',2,'admin','2023-12-27 14:58:39',NULL,'2023-12-28 14:30:51'),
	(20,4,'pic','图片','varchar(255)','String','pic','0','0',NULL,'1','1','1',NULL,'EQ','upload','',3,'admin','2023-12-27 14:58:39',NULL,'2023-12-28 14:30:51'),
	(21,4,'info','简介','varchar(1000)','String','info','0','0',NULL,'1','1','1',NULL,'EQ','textarea','',4,'admin','2023-12-27 14:58:39',NULL,'2023-12-28 14:30:51'),
	(22,4,'price','市场价','decimal(10,2)','BigDecimal','price','0','0',NULL,'1','1','1','1','BETWEEN','input','',5,'admin','2023-12-27 14:58:39',NULL,'2023-12-28 14:30:51'),
	(23,5,'id','ID','int(10) unsigned','Integer','id','1','1',NULL,NULL,NULL,'1',NULL,'EQ','input','',1,'admin','2023-12-27 15:56:14',NULL,'2023-12-28 15:00:53'),
	(24,5,'title','活动主题','varchar(255)','String','title','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2023-12-27 15:56:14',NULL,'2023-12-28 15:00:53'),
	(25,5,'pic','宣传图','varchar(255)','String','pic','0','0',NULL,'1','1','1',NULL,'EQ','upload','',3,'admin','2023-12-27 15:56:14',NULL,'2023-12-28 15:00:53'),
	(26,5,'info','活动简介','varchar(1000)','String','info','0','0',NULL,'1','1',NULL,NULL,'EQ','textarea','',4,'admin','2023-12-27 15:56:14',NULL,'2023-12-28 15:00:54'),
	(27,5,'starttime','开始时间','datetime','Date','starttime','0','0','1','1','1','1','1','BETWEEN','datetime','',5,'admin','2023-12-27 15:56:14',NULL,'2023-12-28 15:00:54'),
	(28,5,'endtime','结束时间','datetime','Date','endtime','0','0','1','1','1','1',NULL,'EQ','datetime','',6,'admin','2023-12-27 15:56:14',NULL,'2023-12-28 15:00:54'),
	(29,5,'type','类型','tinyint(2)','Integer','type','0','0',NULL,'1','1','1','1','EQ','select','card_game_type',7,'admin','2023-12-27 15:56:14',NULL,'2023-12-28 15:00:54'),
	(30,5,'status','状态（0=新建，1=已加载）','tinyint(1)','Integer','status','0','0','1',NULL,NULL,'1','1','EQ','radio','card_game_status',8,'admin','2023-12-27 15:56:15',NULL,'2023-12-28 15:00:54'),
	(31,6,'id','','int(10) unsigned','Integer','id','1','1',NULL,'1',NULL,NULL,NULL,'EQ','input','',1,'admin','2023-12-27 16:21:01',NULL,'2023-12-27 16:31:05'),
	(32,6,'gameid','活动','int(11) unsigned','Integer','gameid','0','0',NULL,'1','1','1','1','EQ','input','',2,'admin','2023-12-27 16:21:01',NULL,'2023-12-27 16:31:05'),
	(33,6,'productid','奖品','int(11)','Integer','productid','0','0',NULL,'1','1','1','1','EQ','select','',3,'admin','2023-12-27 16:21:01',NULL,'2023-12-27 16:31:06'),
	(34,6,'amount','数量','smallint(6)','Integer','amount','0','0',NULL,'1','1','1','1','EQ','input','',4,'admin','2023-12-27 16:21:01',NULL,'2023-12-27 16:31:06'),
	(35,7,'id','','int(11) unsigned','Long','id','1','1',NULL,'1',NULL,NULL,NULL,'EQ','input','',1,'admin','2023-12-27 16:40:28',NULL,'2023-12-27 16:44:24'),
	(36,7,'gameid','活动id','int(11) unsigned','Integer','gameid','0','0',NULL,'1','1','1','1','EQ','input','',2,'admin','2023-12-27 16:40:28',NULL,'2023-12-27 16:44:24'),
	(37,7,'userlevel','会员等级','smallint(6)','Integer','userlevel','0','0','1','1','1','1','1','EQ','select','card_user_level',3,'admin','2023-12-27 16:40:28',NULL,'2023-12-27 16:44:24'),
	(38,7,'enter_times','可抽奖次数（0为不限）','smallint(6)','Integer','enterTimes','0','0','1','1','1','1','1','EQ','input','',4,'admin','2023-12-27 16:40:29',NULL,'2023-12-27 16:44:24'),
	(39,7,'goal_times','最大中奖次数（0为不限）','smallint(6)','Integer','goalTimes','0','0','1','1','1','1','1','EQ','input','',5,'admin','2023-12-27 16:40:29',NULL,'2023-12-27 16:44:24'),
	(40,7,'random_rate','如果是概率类，多大中奖率（0-100），默认100','tinyint(4)','Integer','randomRate','0','0','1','1','1','1','1','EQ','input','',6,'admin','2023-12-27 16:40:29',NULL,'2023-12-27 16:44:24'),
	(45,9,'id','','int(11) unsigned','Long','id','1','1',NULL,'1',NULL,NULL,NULL,'EQ','input','',1,'admin','2023-12-29 15:22:33',NULL,'2023-12-29 15:36:09'),
	(46,9,'uname','用户名','varchar(20)','String','uname','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2023-12-29 15:22:33',NULL,'2023-12-29 15:36:09'),
	(47,9,'pic','头像','varchar(255)','String','pic','0','0',NULL,'1','1','1',NULL,'EQ','upload','',3,'admin','2023-12-29 15:22:33',NULL,'2023-12-29 15:36:09'),
	(48,9,'passwd','密码','varchar(50)','String','passwd','0','0','1','1',NULL,NULL,NULL,'EQ','input','',4,'admin','2023-12-29 15:22:33',NULL,'2023-12-29 15:36:09'),
	(49,9,'realname','姓名','varchar(10)','String','realname','0','0',NULL,'1','1','1','1','LIKE','input','',5,'admin','2023-12-29 15:22:33',NULL,'2023-12-29 15:36:09'),
	(50,9,'idcard','身份证号','varchar(18)','String','idcard','0','0',NULL,'1','1',NULL,'1','LIKE','input','',6,'admin','2023-12-29 15:22:33',NULL,'2023-12-29 15:36:09'),
	(51,9,'phone','手机号码','varchar(15)','String','phone','0','0',NULL,'1','1','1','1','LIKE','input','',7,'admin','2023-12-29 15:22:33',NULL,'2023-12-29 15:36:09'),
	(52,9,'level','等级','smallint(6)','Integer','level','0','0','1','1','1','1','1','EQ','select','card_user_level',8,'admin','2023-12-29 15:22:33',NULL,'2023-12-29 15:36:09'),
	(53,9,'createtime','创建时间','datetime','Date','createtime','0','0',NULL,'1',NULL,'1',NULL,'EQ','datetime','',9,'admin','2023-12-29 15:22:33',NULL,'2023-12-29 15:36:09'),
	(54,9,'updatetime','更新时间','datetime','Date','updatetime','0','0',NULL,'1',NULL,NULL,NULL,'EQ','datetime','',10,'admin','2023-12-29 15:22:33',NULL,'2023-12-29 15:36:09'),
	(55,10,'id','','int(10) unsigned','Integer','id','0','0',NULL,NULL,NULL,NULL,NULL,'EQ','input','',1,'admin','2024-01-02 11:09:06',NULL,'2024-01-02 11:13:47'),
	(56,10,'title','活动主题','varchar(255)','String','title','0','0',NULL,NULL,NULL,'1','1','LIKE','input','',2,'admin','2024-01-02 11:09:07',NULL,'2024-01-02 11:13:47'),
	(57,10,'starttime','开始时间','datetime','Date','starttime','0','0',NULL,NULL,NULL,'1',NULL,'BETWEEN','datetime','',3,'admin','2024-01-02 11:09:07',NULL,'2024-01-02 11:13:47'),
	(58,10,'endtime','结束时间','datetime','Date','endtime','0','0',NULL,NULL,NULL,'1',NULL,'BETWEEN','datetime','',4,'admin','2024-01-02 11:09:07',NULL,'2024-01-02 11:13:47'),
	(59,10,'type','活动类型','varchar(100)','String','type','0','0',NULL,NULL,NULL,'1','1','EQ','select','card_game_type',5,'admin','2024-01-02 11:09:07',NULL,'2024-01-02 11:13:47'),
	(60,10,'total','奖品数','decimal(27,0)','Long','total','0','0',NULL,NULL,NULL,'1',NULL,'BETWEEN','input','',6,'admin','2024-01-02 11:09:07',NULL,'2024-01-02 11:13:47'),
	(61,10,'hit','中奖数','bigint(21)','Long','hit','0','0',NULL,NULL,NULL,'1',NULL,'BETWEEN','input','',7,'admin','2024-01-02 11:09:07',NULL,'2024-01-02 11:13:47'),
	(62,11,'id','','int(10) unsigned','Integer','id','0','0',NULL,NULL,NULL,NULL,NULL,'EQ','input','',1,'admin','2024-01-02 11:15:54',NULL,'2024-01-02 11:20:10'),
	(63,11,'title','活动主题','varchar(255)','String','title','0','0',NULL,NULL,NULL,'1','1','LIKE','input','',2,'admin','2024-01-02 11:15:54',NULL,'2024-01-02 11:20:10'),
	(64,11,'type','活动类型','varchar(100)','String','type','0','0',NULL,NULL,NULL,'1','1','EQ','select','card_game_type',3,'admin','2024-01-02 11:15:54',NULL,'2024-01-02 11:20:10'),
	(65,11,'uname','登录名','varchar(20)','String','uname','0','0',NULL,NULL,NULL,'1','1','LIKE','input','',4,'admin','2024-01-02 11:15:54',NULL,'2024-01-02 11:20:10'),
	(66,11,'realname','姓名','varchar(10)','String','realname','0','0',NULL,NULL,NULL,'1','1','LIKE','input','',5,'admin','2024-01-02 11:15:54',NULL,'2024-01-02 11:20:10'),
	(67,11,'idcard','身份证号','varchar(18)','String','idcard','0','0',NULL,NULL,NULL,'1',NULL,'EQ','input','',6,'admin','2024-01-02 11:15:54',NULL,'2024-01-02 11:20:10'),
	(68,11,'phone','手机号码','varchar(15)','String','phone','0','0',NULL,NULL,NULL,'1','1','EQ','input','',7,'admin','2024-01-02 11:15:54',NULL,'2024-01-02 11:20:10'),
	(69,11,'level','用户等级','varchar(100)','String','level','0','0',NULL,NULL,NULL,'1','1','EQ','select','card_user_level',8,'admin','2024-01-02 11:15:54',NULL,'2024-01-02 11:20:10'),
	(70,11,'name','奖品名称','varchar(255)','String','name','0','0',NULL,NULL,NULL,'1','1','LIKE','input','',9,'admin','2024-01-02 11:15:54',NULL,'2024-01-02 11:20:10'),
	(71,11,'price','市场价','decimal(10,2)','BigDecimal','price','0','0',NULL,NULL,NULL,'1',NULL,'EQ','input','',10,'admin','2024-01-02 11:15:54',NULL,'2024-01-02 11:20:10'),
	(72,11,'gameid','活动','int(10) unsigned','Integer','gameid','0','0',NULL,NULL,NULL,NULL,NULL,'EQ','input','',11,'admin','2024-01-02 11:15:54',NULL,'2024-01-02 11:20:10'),
	(73,11,'userid','用户','int(10) unsigned','Integer','userid','0','0',NULL,NULL,NULL,NULL,NULL,'EQ','input','',12,'admin','2024-01-02 11:15:54',NULL,'2024-01-02 11:20:10'),
	(74,11,'productid','奖品','int(10) unsigned','Integer','productid','0','0',NULL,NULL,NULL,NULL,NULL,'EQ','input','',13,'admin','2024-01-02 11:15:55',NULL,'2024-01-02 11:20:10'),
	(75,11,'hittime','中奖时间','datetime','Date','hittime','0','0',NULL,NULL,NULL,'1',NULL,'EQ','datetime','',14,'admin','2024-01-02 11:15:55',NULL,'2024-01-02 11:20:11');

/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_config`;

CREATE TABLE `sys_config` (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='参数配置表';

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;

INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2023-12-27 12:02:51','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),
	(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2023-12-27 12:02:51','',NULL,'初始化密码 123456'),
	(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2023-12-27 12:02:51','',NULL,'深黑主题theme-dark，浅色主题theme-light，深蓝主题theme-blue'),
	(4,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2023-12-27 12:02:51','',NULL,'是否开启注册用户功能（true开启，false关闭）'),
	(5,'用户管理-密码字符范围','sys.account.chrtype','0','Y','admin','2023-12-27 12:02:51','',NULL,'默认任意字符范围，0任意（密码可以输入任意字符），1数字（密码只能为0-9数字），2英文字母（密码只能为a-z和A-Z字母），3字母和数字（密码必须包含字母，数字）,4字母数字和特殊字符（目前支持的特殊字符包括：~!@#$%^&*()-=_+）'),
	(6,'用户管理-初始密码修改策略','sys.account.initPasswordModify','0','Y','admin','2023-12-27 12:02:51','',NULL,'0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框'),
	(7,'用户管理-账号密码更新周期','sys.account.passwordValidateDays','0','Y','admin','2023-12-27 12:02:51','',NULL,'密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框'),
	(8,'主框架页-菜单导航显示风格','sys.index.menuStyle','default','Y','admin','2023-12-27 12:02:51','',NULL,'菜单导航显示风格（default为左侧导航菜单，topnav为顶部导航菜单）'),
	(9,'主框架页-是否开启页脚','sys.index.footer','true','Y','admin','2023-12-27 12:02:51','',NULL,'是否开启底部页脚显示（true显示，false隐藏）'),
	(10,'主框架页-是否开启页签','sys.index.tagsView','true','Y','admin','2023-12-27 12:02:51','',NULL,'是否开启菜单多页签显示（true显示，false隐藏）'),
	(11,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2023-12-27 12:02:51','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_dept
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_dept`;

CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;

INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES
	(100,0,'0','传智教育',0,'超级管理员','15888888888','ry@qq.com','0','0','admin','2023-12-27 12:02:41','',NULL),
	(101,100,'0,100','北京总部',1,'超级管理员','15888888888','ry@qq.com','0','0','admin','2023-12-27 12:02:41','',NULL),
	(102,100,'0,100','昌平分公司',2,'超级管理员','15888888888','ry@qq.com','0','0','admin','2023-12-27 12:02:41','',NULL),
	(103,101,'0,100,101','研发部门',1,'超级管理员','15888888888','ry@qq.com','0','0','admin','2023-12-27 12:02:41','',NULL),
	(104,101,'0,100,101','市场部门',2,'超级管理员','15888888888','ry@qq.com','0','0','admin','2023-12-27 12:02:41','',NULL),
	(105,101,'0,100,101','测试部门',3,'超级管理员','15888888888','ry@qq.com','0','0','admin','2023-12-27 12:02:41','',NULL),
	(106,101,'0,100,101','财务部门',4,'超级管理员','15888888888','ry@qq.com','0','0','admin','2023-12-27 12:02:41','',NULL),
	(107,101,'0,100,101','运维部门',5,'超级管理员','15888888888','ry@qq.com','0','0','admin','2023-12-27 12:02:41','',NULL),
	(108,102,'0,100,102','市场部门',1,'超级管理员','15888888888','ry@qq.com','0','0','admin','2023-12-27 12:02:41','',NULL),
	(109,102,'0,100,102','财务部门',2,'超级管理员','15888888888','ry@qq.com','0','0','admin','2023-12-27 12:02:41','',NULL);

/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_dict_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_dict_data`;

CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`),
  UNIQUE KEY `dict_type` (`dict_type`,`dict_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='字典数据表';

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;

INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,1,'男','0','sys_user_sex','','','Y','0','admin','2023-12-27 12:02:50','',NULL,'性别男'),
	(2,2,'女','1','sys_user_sex','','','N','0','admin','2023-12-27 12:02:50','',NULL,'性别女'),
	(3,3,'未知','2','sys_user_sex','','','N','0','admin','2023-12-27 12:02:50','',NULL,'性别未知'),
	(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2023-12-27 12:02:50','',NULL,'显示菜单'),
	(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2023-12-27 12:02:50','',NULL,'隐藏菜单'),
	(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2023-12-27 12:02:50','',NULL,'正常状态'),
	(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2023-12-27 12:02:50','',NULL,'停用状态'),
	(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2023-12-27 12:02:50','',NULL,'正常状态'),
	(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2023-12-27 12:02:50','',NULL,'停用状态'),
	(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2023-12-27 12:02:50','',NULL,'默认分组'),
	(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2023-12-27 12:02:50','',NULL,'系统分组'),
	(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2023-12-27 12:02:50','',NULL,'系统默认是'),
	(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2023-12-27 12:02:50','',NULL,'系统默认否'),
	(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2023-12-27 12:02:50','',NULL,'通知'),
	(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2023-12-27 12:02:50','',NULL,'公告'),
	(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2023-12-27 12:02:50','',NULL,'正常状态'),
	(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2023-12-27 12:02:50','',NULL,'关闭状态'),
	(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2023-12-27 12:02:50','',NULL,'其他操作'),
	(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2023-12-27 12:02:50','',NULL,'新增操作'),
	(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2023-12-27 12:02:51','',NULL,'修改操作'),
	(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2023-12-27 12:02:51','',NULL,'删除操作'),
	(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2023-12-27 12:02:51','',NULL,'授权操作'),
	(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2023-12-27 12:02:51','',NULL,'导出操作'),
	(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2023-12-27 12:02:51','',NULL,'导入操作'),
	(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2023-12-27 12:02:51','',NULL,'强退操作'),
	(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2023-12-27 12:02:51','',NULL,'生成操作'),
	(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2023-12-27 12:02:51','',NULL,'清空操作'),
	(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2023-12-27 12:02:51','',NULL,'正常状态'),
	(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2023-12-27 12:02:51','',NULL,'停用状态'),
	(100,1,'随机出现','1','card_game_type',NULL,NULL,'Y','0','admin','2023-12-27 16:23:44','',NULL,NULL),
	(101,2,'瞬间秒杀','2','card_game_type',NULL,NULL,'N','0','admin','2023-12-27 16:24:03','',NULL,NULL),
	(102,3,'幸运转盘','3','card_game_type',NULL,NULL,'N','0','admin','2023-12-27 16:24:30','',NULL,NULL),
	(103,0,'普通会员','0','card_user_level',NULL,NULL,'Y','0','admin','2023-12-27 16:41:59','',NULL,NULL),
	(104,1,'一级会员','1','card_user_level',NULL,NULL,'N','0','admin','2023-12-27 16:42:12','',NULL,NULL),
	(105,2,'二级会员','2','card_user_level',NULL,NULL,'N','0','admin','2023-12-27 16:42:28','',NULL,NULL),
	(106,3,'三级会员','3','card_user_level','','','N','0','admin','2023-12-27 16:42:38','admin','2023-12-27 16:42:43',''),
	(107,0,'新建','0','card_game_status',NULL,NULL,'Y','0','admin','2023-12-28 13:42:45','',NULL,NULL),
	(108,1,'已加载','1','card_game_status',NULL,NULL,'Y','0','admin','2023-12-28 13:42:55','',NULL,NULL),
	(122,4,'金牌会员','4','card_user_level',NULL,NULL,'N','0','','2024-01-03 11:19:08','',NULL,NULL);

/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_dict_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_dict_type`;

CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='字典类型表';

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;

INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'用户性别','sys_user_sex','0','admin','2023-12-27 12:02:49','',NULL,'用户性别列表'),
	(2,'菜单状态','sys_show_hide','0','admin','2023-12-27 12:02:49','',NULL,'菜单状态列表'),
	(3,'系统开关','sys_normal_disable','0','admin','2023-12-27 12:02:49','',NULL,'系统开关列表'),
	(4,'任务状态','sys_job_status','0','admin','2023-12-27 12:02:49','',NULL,'任务状态列表'),
	(5,'任务分组','sys_job_group','0','admin','2023-12-27 12:02:49','',NULL,'任务分组列表'),
	(6,'系统是否','sys_yes_no','0','admin','2023-12-27 12:02:49','',NULL,'系统是否列表'),
	(7,'通知类型','sys_notice_type','0','admin','2023-12-27 12:02:50','',NULL,'通知类型列表'),
	(8,'通知状态','sys_notice_status','0','admin','2023-12-27 12:02:50','',NULL,'通知状态列表'),
	(9,'操作类型','sys_oper_type','0','admin','2023-12-27 12:02:50','',NULL,'操作类型列表'),
	(10,'系统状态','sys_common_status','0','admin','2023-12-27 12:02:50','',NULL,'登录状态列表'),
	(100,'活动类型','card_game_type','0','admin','2023-12-27 16:23:07','',NULL,NULL),
	(101,'会员等级','card_user_level','0','admin','2023-12-27 16:41:31','',NULL,NULL),
	(102,'活动状态','card_game_status','0','admin','2023-12-28 13:41:53','',NULL,NULL);

/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_job
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_job`;

CREATE TABLE `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度表';

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;

INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2023-12-27 12:02:52','',NULL,''),
	(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2023-12-27 12:02:52','',NULL,''),
	(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2023-12-27 12:02:52','',NULL,'');

/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_job_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_job_log`;

CREATE TABLE `sys_job_log` (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度日志表';



# 转储表 sys_logininfor
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_logininfor`;

CREATE TABLE `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `login_name` varchar(50) DEFAULT '' COMMENT '登录账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统访问记录';



# 转储表 sys_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `url` varchar(200) DEFAULT '#' COMMENT '请求地址',
  `target` varchar(20) DEFAULT '' COMMENT '打开方式（menuItem页签 menuBlank新窗口）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `is_refresh` char(1) DEFAULT '1' COMMENT '是否刷新（0刷新 1不刷新）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜单权限表';

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;

INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `url`, `target`, `menu_type`, `visible`, `is_refresh`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'系统管理',0,2,'#','menuItem','M','0','1','','fa fa-gear','admin','2023-12-27 12:02:42','admin','2023-12-29 18:36:31','系统管理目录'),
	(2,'系统监控',0,2,'#','','M','0','1','','fa fa-video-camera','admin','2023-12-27 12:02:42','',NULL,'系统监控目录'),
	(3,'系统工具',0,3,'#','','M','0','1','','fa fa-bars','admin','2023-12-27 12:02:42','',NULL,'系统工具目录'),
	(100,'用户管理',1,1,'/system/user','','C','0','1','system:user:view','fa fa-user-o','admin','2023-12-27 12:02:42','',NULL,'用户管理菜单'),
	(101,'角色管理',1,2,'/system/role','','C','0','1','system:role:view','fa fa-user-secret','admin','2023-12-27 12:02:42','',NULL,'角色管理菜单'),
	(102,'菜单管理',1,3,'/system/menu','','C','0','1','system:menu:view','fa fa-th-list','admin','2023-12-27 12:02:42','',NULL,'菜单管理菜单'),
	(103,'部门管理',1,4,'/system/dept','','C','0','1','system:dept:view','fa fa-outdent','admin','2023-12-27 12:02:42','',NULL,'部门管理菜单'),
	(104,'岗位管理',1,5,'/system/post','','C','0','1','system:post:view','fa fa-address-card-o','admin','2023-12-27 12:02:42','',NULL,'岗位管理菜单'),
	(105,'字典管理',1,6,'/system/dict','','C','0','1','system:dict:view','fa fa-bookmark-o','admin','2023-12-27 12:02:42','',NULL,'字典管理菜单'),
	(106,'参数设置',1,7,'/system/config','','C','0','1','system:config:view','fa fa-sun-o','admin','2023-12-27 12:02:42','',NULL,'参数设置菜单'),
	(107,'通知公告',1,8,'/system/notice','','C','0','1','system:notice:view','fa fa-bullhorn','admin','2023-12-27 12:02:42','',NULL,'通知公告菜单'),
	(108,'日志管理',1,9,'#','','M','0','1','','fa fa-pencil-square-o','admin','2023-12-27 12:02:42','',NULL,'日志管理菜单'),
	(109,'在线用户',2,1,'/monitor/online','','C','0','1','monitor:online:view','fa fa-user-circle','admin','2023-12-27 12:02:43','',NULL,'在线用户菜单'),
	(110,'定时任务',2,2,'/monitor/job','','C','0','1','monitor:job:view','fa fa-tasks','admin','2023-12-27 12:02:43','',NULL,'定时任务菜单'),
	(111,'数据监控',2,3,'/monitor/data','','C','0','1','monitor:data:view','fa fa-bug','admin','2023-12-27 12:02:43','',NULL,'数据监控菜单'),
	(112,'服务监控',2,4,'/monitor/server','','C','0','1','monitor:server:view','fa fa-server','admin','2023-12-27 12:02:43','',NULL,'服务监控菜单'),
	(113,'缓存监控',2,5,'/monitor/cache','','C','0','1','monitor:cache:view','fa fa-cube','admin','2023-12-27 12:02:43','',NULL,'缓存监控菜单'),
	(114,'表单构建',3,1,'/tool/build','','C','0','1','tool:build:view','fa fa-wpforms','admin','2023-12-27 12:02:43','',NULL,'表单构建菜单'),
	(115,'代码生成',3,2,'/tool/gen','','C','0','1','tool:gen:view','fa fa-code','admin','2023-12-27 12:02:43','',NULL,'代码生成菜单'),
	(116,'系统接口',3,3,'/tool/swagger','','C','0','1','tool:swagger:view','fa fa-gg','admin','2023-12-27 12:02:43','',NULL,'系统接口菜单'),
	(500,'操作日志',108,1,'/monitor/operlog','','C','0','1','monitor:operlog:view','fa fa-address-book','admin','2023-12-27 12:02:43','',NULL,'操作日志菜单'),
	(501,'登录日志',108,2,'/monitor/logininfor','','C','0','1','monitor:logininfor:view','fa fa-file-image-o','admin','2023-12-27 12:02:43','',NULL,'登录日志菜单'),
	(1000,'用户查询',100,1,'#','','F','0','1','system:user:list','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1001,'用户新增',100,2,'#','','F','0','1','system:user:add','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1002,'用户修改',100,3,'#','','F','0','1','system:user:edit','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1003,'用户删除',100,4,'#','','F','0','1','system:user:remove','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1004,'用户导出',100,5,'#','','F','0','1','system:user:export','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1005,'用户导入',100,6,'#','','F','0','1','system:user:import','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1006,'重置密码',100,7,'#','','F','0','1','system:user:resetPwd','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1007,'角色查询',101,1,'#','','F','0','1','system:role:list','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1008,'角色新增',101,2,'#','','F','0','1','system:role:add','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1009,'角色修改',101,3,'#','','F','0','1','system:role:edit','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1010,'角色删除',101,4,'#','','F','0','1','system:role:remove','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1011,'角色导出',101,5,'#','','F','0','1','system:role:export','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1012,'菜单查询',102,1,'#','','F','0','1','system:menu:list','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1013,'菜单新增',102,2,'#','','F','0','1','system:menu:add','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1014,'菜单修改',102,3,'#','','F','0','1','system:menu:edit','#','admin','2023-12-27 12:02:43','',NULL,''),
	(1015,'菜单删除',102,4,'#','','F','0','1','system:menu:remove','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1016,'部门查询',103,1,'#','','F','0','1','system:dept:list','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1017,'部门新增',103,2,'#','','F','0','1','system:dept:add','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1018,'部门修改',103,3,'#','','F','0','1','system:dept:edit','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1019,'部门删除',103,4,'#','','F','0','1','system:dept:remove','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1020,'岗位查询',104,1,'#','','F','0','1','system:post:list','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1021,'岗位新增',104,2,'#','','F','0','1','system:post:add','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1022,'岗位修改',104,3,'#','','F','0','1','system:post:edit','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1023,'岗位删除',104,4,'#','','F','0','1','system:post:remove','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1024,'岗位导出',104,5,'#','','F','0','1','system:post:export','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1025,'字典查询',105,1,'#','','F','0','1','system:dict:list','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1026,'字典新增',105,2,'#','','F','0','1','system:dict:add','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1027,'字典修改',105,3,'#','','F','0','1','system:dict:edit','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1028,'字典删除',105,4,'#','','F','0','1','system:dict:remove','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1029,'字典导出',105,5,'#','','F','0','1','system:dict:export','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1030,'参数查询',106,1,'#','','F','0','1','system:config:list','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1031,'参数新增',106,2,'#','','F','0','1','system:config:add','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1032,'参数修改',106,3,'#','','F','0','1','system:config:edit','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1033,'参数删除',106,4,'#','','F','0','1','system:config:remove','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1034,'参数导出',106,5,'#','','F','0','1','system:config:export','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1035,'公告查询',107,1,'#','','F','0','1','system:notice:list','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1036,'公告新增',107,2,'#','','F','0','1','system:notice:add','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1037,'公告修改',107,3,'#','','F','0','1','system:notice:edit','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1038,'公告删除',107,4,'#','','F','0','1','system:notice:remove','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1039,'操作查询',500,1,'#','','F','0','1','monitor:operlog:list','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1040,'操作删除',500,2,'#','','F','0','1','monitor:operlog:remove','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1041,'详细信息',500,3,'#','','F','0','1','monitor:operlog:detail','#','admin','2023-12-27 12:02:44','',NULL,''),
	(1042,'日志导出',500,4,'#','','F','0','1','monitor:operlog:export','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1043,'登录查询',501,1,'#','','F','0','1','monitor:logininfor:list','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1044,'登录删除',501,2,'#','','F','0','1','monitor:logininfor:remove','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1045,'日志导出',501,3,'#','','F','0','1','monitor:logininfor:export','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1046,'账户解锁',501,4,'#','','F','0','1','monitor:logininfor:unlock','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1047,'在线查询',109,1,'#','','F','0','1','monitor:online:list','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1048,'批量强退',109,2,'#','','F','0','1','monitor:online:batchForceLogout','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1049,'单条强退',109,3,'#','','F','0','1','monitor:online:forceLogout','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1050,'任务查询',110,1,'#','','F','0','1','monitor:job:list','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1051,'任务新增',110,2,'#','','F','0','1','monitor:job:add','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1052,'任务修改',110,3,'#','','F','0','1','monitor:job:edit','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1053,'任务删除',110,4,'#','','F','0','1','monitor:job:remove','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1054,'状态修改',110,5,'#','','F','0','1','monitor:job:changeStatus','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1055,'任务详细',110,6,'#','','F','0','1','monitor:job:detail','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1056,'任务导出',110,7,'#','','F','0','1','monitor:job:export','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1057,'生成查询',115,1,'#','','F','0','1','tool:gen:list','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1058,'生成修改',115,2,'#','','F','0','1','tool:gen:edit','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1059,'生成删除',115,3,'#','','F','0','1','tool:gen:remove','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1060,'预览代码',115,4,'#','','F','0','1','tool:gen:preview','#','admin','2023-12-27 12:02:45','',NULL,''),
	(1061,'生成代码',115,5,'#','','F','0','1','tool:gen:code','#','admin','2023-12-27 12:02:45','',NULL,''),
	(2000,'活动管理',0,0,'#','menuItem','M','0','1','','fa fa-cubes','admin','2023-12-27 15:14:27','admin','2023-12-29 18:14:21',''),
	(2001,'奖品管理',2000,20,'/lottery/product','menuItem','C','0','1','lottery:product:view','#','admin','2023-12-27 15:23:39','admin','2024-01-03 11:03:30','奖品管理菜单'),
	(2002,'奖品管理查询',2001,1,'#','','F','0','1','lottery:product:list','#','admin','2023-12-27 15:23:39','',NULL,''),
	(2003,'奖品管理新增',2001,2,'#','','F','0','1','lottery:product:add','#','admin','2023-12-27 15:23:39','',NULL,''),
	(2004,'奖品管理修改',2001,3,'#','','F','0','1','lottery:product:edit','#','admin','2023-12-27 15:23:39','',NULL,''),
	(2005,'奖品管理删除',2001,4,'#','','F','0','1','lottery:product:remove','#','admin','2023-12-27 15:23:39','',NULL,''),
	(2006,'奖品管理导出',2001,5,'#','','F','0','1','lottery:product:export','#','admin','2023-12-27 15:23:39','',NULL,''),
	(2007,'活动配置',2000,30,'/lottery/game','menuItem','C','0','1','lottery:game:view','#','admin','2023-12-27 16:32:29','admin','2024-01-03 11:03:44','活动管理菜单'),
	(2008,'活动管理查询',2007,1,'#','','F','0','1','lottery:game:list','#','admin','2023-12-27 16:32:29','',NULL,''),
	(2009,'活动管理新增',2007,2,'#','','F','0','1','lottery:game:add','#','admin','2023-12-27 16:32:29','',NULL,''),
	(2010,'活动管理修改',2007,3,'#','','F','0','1','lottery:game:edit','#','admin','2023-12-27 16:32:29','',NULL,''),
	(2011,'活动管理删除',2007,4,'#','','F','0','1','lottery:game:remove','#','admin','2023-12-27 16:32:30','',NULL,''),
	(2012,'活动管理导出',2007,5,'#','','F','0','1','lottery:game:export','#','admin','2023-12-27 16:32:30','',NULL,''),
	(2019,'会员管理',2000,10,'/lottery/user','menuItem','C','0','1','lottery:user:view','#','admin','2023-12-29 15:34:09','admin','2024-01-03 11:02:55','会员信息菜单'),
	(2020,'会员信息查询',2019,1,'#','','F','0','1','lottery:user:list','#','admin','2023-12-29 15:34:09','',NULL,''),
	(2021,'会员信息新增',2019,2,'#','','F','0','1','lottery:user:add','#','admin','2023-12-29 15:34:09','',NULL,''),
	(2022,'会员信息修改',2019,3,'#','','F','0','1','lottery:user:edit','#','admin','2023-12-29 15:34:09','',NULL,''),
	(2023,'会员信息删除',2019,4,'#','','F','0','1','lottery:user:remove','#','admin','2023-12-29 15:34:09','',NULL,''),
	(2024,'会员信息导出',2019,5,'#','','F','0','1','lottery:user:export','#','admin','2023-12-29 15:34:09','',NULL,''),
	(2025,'活动统计',0,1,'#','menuItem','M','0','1',NULL,'fa fa-bar-chart','admin','2023-12-29 18:35:17','',NULL,''),
	(2026,'活动中奖统计',2025,1,'/lottery/curinfo','','C','0','1','lottery:curinfo:view','#','admin','2024-01-02 11:12:55','',NULL,'活动中奖统计菜单'),
	(2027,'活动中奖统计查询',2026,1,'#','','F','0','1','lottery:curinfo:list','#','admin','2024-01-02 11:12:55','',NULL,''),
	(2028,'活动中奖统计导出',2026,5,'#','','F','0','1','lottery:curinfo:export','#','admin','2024-01-02 11:12:55','',NULL,''),
	(2029,'中奖用户详情',2025,1,'/lottery/hit','','C','0','1','lottery:hit:view','#','admin','2024-01-02 11:20:47','',NULL,'中奖用户详情菜单'),
	(2030,'中奖用户详情查询',2029,1,'#','','F','0','1','lottery:hit:list','#','admin','2024-01-02 11:20:47','',NULL,''),
	(2031,'中奖用户详情导出',2029,5,'#','','F','0','1','lottery:hit:export','#','admin','2024-01-02 11:20:47','',NULL,''),
	(2032,'会员等级',2000,9,'/lottery/data','menuItem','C','0','1','lottery:data:view','#','admin','2024-01-03 10:19:41','admin','2024-01-03 11:03:16','会员等级管理菜单'),
	(2033,'会员等级管理查询',2032,1,'#','','F','0','1','lottery:data:list','#','admin','2024-01-03 10:19:41','',NULL,''),
	(2034,'会员等级管理新增',2032,2,'#','','F','0','1','lottery:data:add','#','admin','2024-01-03 10:19:41','',NULL,''),
	(2035,'会员等级管理修改',2032,3,'#','','F','0','1','lottery:data:edit','#','admin','2024-01-03 10:19:41','',NULL,''),
	(2036,'会员等级管理删除',2032,4,'#','','F','0','1','lottery:data:remove','#','admin','2024-01-03 10:19:41','',NULL,''),
	(2037,'会员等级管理导出',2032,5,'#','','F','0','1','lottery:data:export','#','admin','2024-01-03 10:19:41','',NULL,'');

/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_notice
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_notice`;

CREATE TABLE `sys_notice` (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` varchar(2000) DEFAULT NULL COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='通知公告表';

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;

INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'温馨提醒：618活动即将开始','2','新版本内容','0','admin','2023-12-27 12:02:52','user','2024-01-02 09:51:27','管理员'),
	(2,'维护通知：今天项目上线','1','维护内容','0','admin','2023-12-27 12:02:52','user','2024-01-02 09:51:47','管理员');

/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_oper_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_oper_log`;

CREATE TABLE `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int(1) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志记录';



# 转储表 sys_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_post`;

CREATE TABLE `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='岗位信息表';

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;

INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'ceo','CEO',1,'0','admin','2023-12-27 12:02:42','',NULL,''),
	(2,'se','项目经理',2,'0','admin','2023-12-27 12:02:42','',NULL,''),
	(3,'hr','人力资源',3,'0','admin','2023-12-27 12:02:42','',NULL,''),
	(4,'user','普通员工',4,'0','admin','2023-12-27 12:02:42','',NULL,'');

/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色信息表';

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;

INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,'超级管理员','admin',1,'1','0','0','admin','2023-12-27 12:02:42','',NULL,'超级管理员'),
	(2,'普通角色','common',2,'5','0','0','admin','2023-12-27 12:02:42','admin','2023-12-28 12:05:22','普通角色'),
	(100,'活动运营','yunying',3,'1','0','0','admin','2024-01-02 09:50:08','admin','2024-01-03 11:04:13','');

/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_role_dept
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role_dept`;

CREATE TABLE `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和部门关联表';



# 转储表 sys_role_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和菜单关联表';

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;

INSERT INTO `sys_role_menu` (`role_id`, `menu_id`)
VALUES
	(2,1),
	(2,2),
	(2,3),
	(2,4),
	(2,100),
	(2,101),
	(2,102),
	(2,103),
	(2,104),
	(2,105),
	(2,106),
	(2,107),
	(2,108),
	(2,109),
	(2,110),
	(2,111),
	(2,112),
	(2,113),
	(2,114),
	(2,115),
	(2,116),
	(2,500),
	(2,501),
	(2,1000),
	(2,1001),
	(2,1002),
	(2,1003),
	(2,1004),
	(2,1005),
	(2,1006),
	(2,1007),
	(2,1008),
	(2,1009),
	(2,1010),
	(2,1011),
	(2,1012),
	(2,1013),
	(2,1014),
	(2,1015),
	(2,1016),
	(2,1017),
	(2,1018),
	(2,1019),
	(2,1020),
	(2,1021),
	(2,1022),
	(2,1023),
	(2,1024),
	(2,1025),
	(2,1026),
	(2,1027),
	(2,1028),
	(2,1029),
	(2,1030),
	(2,1031),
	(2,1032),
	(2,1033),
	(2,1034),
	(2,1035),
	(2,1036),
	(2,1037),
	(2,1038),
	(2,1039),
	(2,1040),
	(2,1041),
	(2,1042),
	(2,1043),
	(2,1044),
	(2,1045),
	(2,1046),
	(2,1047),
	(2,1048),
	(2,1049),
	(2,1050),
	(2,1051),
	(2,1052),
	(2,1053),
	(2,1054),
	(2,1055),
	(2,1056),
	(2,1057),
	(2,1058),
	(2,1059),
	(2,1060),
	(2,1061),
	(100,1),
	(100,2),
	(100,107),
	(100,108),
	(100,111),
	(100,112),
	(100,113),
	(100,500),
	(100,501),
	(100,1035),
	(100,1036),
	(100,1037),
	(100,1038),
	(100,1039),
	(100,1040),
	(100,1041),
	(100,1042),
	(100,1043),
	(100,1044),
	(100,1045),
	(100,1046),
	(100,2000),
	(100,2001),
	(100,2002),
	(100,2003),
	(100,2004),
	(100,2005),
	(100,2006),
	(100,2007),
	(100,2008),
	(100,2009),
	(100,2010),
	(100,2011),
	(100,2012),
	(100,2019),
	(100,2020),
	(100,2021),
	(100,2022),
	(100,2023),
	(100,2024),
	(100,2025),
	(100,2026),
	(100,2027),
	(100,2028),
	(100,2029),
	(100,2030),
	(100,2031),
	(100,2032),
	(100,2033),
	(100,2034),
	(100,2035),
	(100,2036),
	(100,2037);

/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `login_name` varchar(30) NOT NULL COMMENT '登录账号',
  `user_name` varchar(30) DEFAULT '' COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户 01注册用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像路径',
  `password` varchar(50) DEFAULT '' COMMENT '密码',
  `salt` varchar(20) DEFAULT '' COMMENT '盐加密',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;

INSERT INTO `sys_user` (`user_id`, `dept_id`, `login_name`, `user_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `salt`, `status`, `del_flag`, `login_ip`, `login_date`, `pwd_update_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
VALUES
	(1,103,'admin','超级管理员','00','ry@163.com','15888888888','1','/profile/avatar/2023/12/27/blob_20231227121211A002.png','cd5c653aad9c947add80dd5b74dec949','56f88c','0','0','127.0.0.1','2024-01-03 11:02:10','2024-01-02 09:47:00','admin','2023-12-27 12:02:41','','2024-01-03 11:02:10','管理员'),
	(2,105,'ry','测试用户','00','ry@qq.com','15666666666','1','','13df7e5e78d714ca0e27b7640981eb4f','722576','0','0','127.0.0.1','2023-12-27 12:02:42','2023-12-27 12:02:42','admin','2023-12-27 12:02:42','','2023-12-28 12:02:06','测试员'),
	(100,103,'user','user','00','','','0','','e4c40195f1543bbbd722ef47540ca7c4','c548a7','0','0','127.0.0.1','2024-01-03 11:14:44',NULL,'admin','2024-01-02 09:48:04','admin','2024-01-03 11:14:43','');

/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_user_online
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user_online`;

CREATE TABLE `sys_user_online` (
  `sessionId` varchar(50) NOT NULL DEFAULT '' COMMENT '用户会话id',
  `login_name` varchar(50) DEFAULT '' COMMENT '登录账号',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` varchar(10) DEFAULT '' COMMENT '在线状态on_line在线off_line离线',
  `start_timestamp` datetime DEFAULT NULL COMMENT 'session创建时间',
  `last_access_time` datetime DEFAULT NULL COMMENT 'session最后访问时间',
  `expire_time` int(5) DEFAULT '0' COMMENT '超时时间，单位为分钟',
  PRIMARY KEY (`sessionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='在线用户记录';

LOCK TABLES `sys_user_online` WRITE;
/*!40000 ALTER TABLE `sys_user_online` DISABLE KEYS */;

INSERT INTO `sys_user_online` (`sessionId`, `login_name`, `dept_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `start_timestamp`, `last_access_time`, `expire_time`)
VALUES
	('c6a2677f-be11-48bf-b665-9142e9b5f680','user','研发部门','127.0.0.1','内网IP','Safari','Mac OS X','on_line','2024-01-03 10:32:22','2024-01-03 11:35:36',1800000);

/*!40000 ALTER TABLE `sys_user_online` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_user_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user_post`;

CREATE TABLE `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户与岗位关联表';

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;

INSERT INTO `sys_user_post` (`user_id`, `post_id`)
VALUES
	(1,1),
	(2,2),
	(100,2);

/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_user_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户和角色关联表';

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;

INSERT INTO `sys_user_role` (`user_id`, `role_id`)
VALUES
	(1,1),
	(2,2),
	(100,100);

/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;





# 导出视图 view_game_hitnum
# ------------------------------------------------------------

DROP TABLE IF EXISTS `view_game_hitnum`; DROP VIEW IF EXISTS `view_game_hitnum`;

CREATE VIEW `view_game_hitnum`
AS SELECT
   `card_user_hit`.`gameid` AS `gameid`,count(`card_user_hit`.`id`) AS `num`
FROM `card_user_hit` group by `card_user_hit`.`gameid`;




# 导出视图 view_game_productnum
# ------------------------------------------------------------

DROP TABLE IF EXISTS `view_game_productnum`; DROP VIEW IF EXISTS `view_game_productnum`;

CREATE VIEW `view_game_productnum`
AS SELECT
   `card_game_product`.`gameid` AS `gameid`,sum(`card_game_product`.`amount`) AS `num`
FROM `card_game_product` group by `card_game_product`.`gameid`;

# 导出视图 view_game_curinfo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `view_game_curinfo`; DROP VIEW IF EXISTS `view_game_curinfo`;

CREATE VIEW `view_game_curinfo`
AS SELECT
   `g`.`id` AS `id`,
   `g`.`title` AS `title`,
   `g`.`starttime` AS `starttime`,
   `g`.`endtime` AS `endtime`,
   `sd2`.`dict_label` AS `type`,
   `cgp`.`num` AS `total`,
   `h`.`num` AS `hit`
FROM (((`card_game` `g` left join `view_game_productnum` `cgp` on((`g`.`id` = `cgp`.`gameid`))) left join `view_game_hitnum` `h` on((`g`.`id` = `h`.`gameid`))) join `sys_dict_data` `sd2` on(((`g`.`type` = `sd2`.`dict_value`) and (`sd2`.`dict_type` = 'card_game_type'))));



# 导出视图 view_card_user_hit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `view_card_user_hit`; DROP VIEW IF EXISTS `view_card_user_hit`;

CREATE VIEW `view_card_user_hit`
AS SELECT
   `h`.`id` AS `id`,
   `g`.`title` AS `title`,
   `sd2`.`dict_value` AS `type`,
   `u`.`uname` AS `uname`,
   `u`.`realname` AS `realname`,
   `u`.`idcard` AS `idcard`,
   `u`.`phone` AS `phone`,
   `sd1`.`dict_label` AS `level`,
   `p`.`name` AS `name`,
   `p`.`price` AS `price`,
   `h`.`gameid` AS `gameid`,
   `h`.`userid` AS `userid`,
   `h`.`productid` AS `productid`,
   `h`.`hittime` AS `hittime`
FROM (((((`card_game` `g` join `card_product` `p`) join `card_user` `u`) join `card_user_hit` `h`) join `sys_dict_data` `sd1` on(((`u`.`level` = `sd1`.`dict_value`) and (`sd1`.`dict_type` = 'card_user_level')))) join `sys_dict_data` `sd2` on(((`g`.`type` = `sd2`.`dict_value`) and (`sd2`.`dict_type` = 'card_game_type')))) where ((`h`.`gameid` = `g`.`id`) and (`h`.`userid` = `u`.`id`) and (`h`.`productid` = `p`.`id`)) order by `h`.`hittime` desc;


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
