# ************************************************************
# Sequel Ace SQL dump
# 版本号： 20046
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# 主机: prize (MySQL 5.7.31)
# 数据库: prize
# 生成时间: 2023-11-19 上午3:03:37 +0000
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
	(7,'超级女神','/upload/images/girl.png','女神来抽奖','2019-11-01 09:34:23','2019-11-01 10:24:23',1,1),
	(10,'教师节抽奖','/upload/images/teacher.png','节日快乐！抽惊喜大奖','2019-12-13 15:50:46','2019-12-13 15:55:46',1,1),
	(44,'中秋节红包雨','/upload/images/pic3.png','浓情中秋 感恩大礼','2020-07-02 16:45:25','2020-07-02 16:50:53',1,1),
	(46,'七夕节大抽奖','/upload/images/nian1.jpeg','七夕快乐！','2020-08-31 11:04:00','2020-08-31 11:45:00',1,1),
	(60,'春节年会','/upload/images/nianhui.jpg','又是一年春节了。那么首先,我向在座的各位送上由衷的祝福和感谢。 20xx年对我们侨泰而言是很重要的.一年。这一年里,我们的门店数增加到了20家,公司规模也扩展到了280人。这一串数字让我很欣慰,侨泰成立短短几年就能有今天的成绩','2023-11-02 11:52:17','2023-11-20 10:37:25',1,1),
	(61,'来玩红包雨','/upload/images/hongbao.jpg','同时参与预售及现货销售的同款商品若消费者通过预售方式购买的到手价≥现货方式(直接购买)到手价,将视具体情节采取必要的市场管控措施,包括但不限于下架商','2023-11-17 11:35:23','2023-11-30 11:35:35',1,1),
	(63,'2024年618','/upload/images/618.jpg','2024年才开始，等着吧','2024-06-18 10:43:21','2024-06-30 10:43:34',1,0);

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
	(37,7,4,10),
	(38,7,5,20),
	(39,7,6,50),
	(40,7,7,20),
	(41,7,8,30),
	(52,10,4,600),
	(53,10,5,500),
	(54,10,6,1000),
	(55,10,7,800),
	(56,10,8,900),
	(121,44,4,111),
	(122,44,5,111),
	(123,44,7,111),
	(124,44,8,111),
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
	(170,63,5,1),
	(171,63,8,1),
	(172,63,10,11),
	(173,63,6,1),
	(174,63,7,11);

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
  UNIQUE KEY `gameid` (`gameid`,`userlevel`) USING BTREE,
  CONSTRAINT `card_game_rules_ibfk_1` FOREIGN KEY (`gameid`) REFERENCES `card_game` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='活动策略';

LOCK TABLES `card_game_rules` WRITE;
/*!40000 ALTER TABLE `card_game_rules` DISABLE KEYS */;

INSERT INTO `card_game_rules` (`id`, `gameid`, `userlevel`, `enter_times`, `goal_times`, `random_rate`)
VALUES
	(69,46,1,1,2,100),
	(70,46,2,2,3,5);

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
	(4,'美宝莲口红','/upload/images/kouhong.png','来自TF的口红，经典的黑金包装，尽显奢华',5000000.00),
	(5,'美食大礼盒','/upload/images/food.png','来自好利来的轻奢月饼，是家人食用，馈赠亲友的不二选择',1000.00),
	(6,'5积分','/upload/images/555555.png','积分可以在积分商城兑换相应商品，例如5个积分可以兑换50元话费',500.00),
	(7,'10积分','/upload/images/101010.png','积分可以累计，在积分商城里兑换相应价值的商品，例如10个积分可以兑换100元话费',100.00),
	(8,'物美购物卡','/upload/images/card.png','物美综合超bai市是国内最早以连锁方式经营du的专业公司之一。自创建北京首家综合超市以来，秉承“发展民族零售产业，提升大众生活品质”的经营理念，以振兴民族零售产业为己任，在连锁超市领域辛勤耕耘，目前在北京市区、周边区县及河北省、天津市拥有40余家店铺，为广大顾客提供实惠商品和优质服务的大型连锁企业。',200.00),
	(10,'青铜','/upload/images/money.png','看上去和金子一样，但是不是',1.00),
	(11,'一块生铁','/upload/images/sild.png','挺沉，但没什么用',8.00),
	(12,'金奖章','/upload/images/gggg.png','金光闪闪',77.00),
	(13,'奇怪的猫','/upload/images/21.jpg','this is a cat ',1000.00);

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
  `updatetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uname` (`uname`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员信息表';

LOCK TABLES `card_user` WRITE;
/*!40000 ALTER TABLE `card_user` DISABLE KEYS */;

INSERT INTO `card_user` (`id`, `uname`, `pic`, `passwd`, `realname`, `idcard`, `phone`, `level`, `createtime`, `updatetime`)
VALUES
	(14,'shawn','/upload/images/21.jpg','202cb962ac59075b964b07152d234b70','wsw','1','13355556666',3,'2019-10-31 11:24:25','2020-08-25 00:37:55'),
	(20,'bxg','/upload/images/11wqw.jpg','-7fa723a043f8f629d8629dfbd0e5d571','bxg','1','13111111111',4,'2023-11-15 09:29:04','2023-11-19 10:38:06');

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
	(70,7,46,'2020-08-31 10:37:11'),
	(71,7,46,'2020-08-31 11:06:12'),
	(80,12,60,'2023-11-02 11:40:55'),
	(81,19,60,'2023-11-07 10:25:21'),
	(82,20,60,'2023-11-15 20:13:25'),
	(84,20,61,'2023-11-19 10:41:51');

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
	(834,46,7,10,'2020-08-31 10:37:11'),
	(835,46,7,10,'2020-08-31 10:40:12'),
	(836,46,7,10,'2020-08-31 10:40:14'),
	(837,46,7,10,'2020-08-31 10:40:17'),
	(838,46,7,10,'2020-08-31 10:40:18'),
	(876,60,12,4,'2023-11-02 15:59:06'),
	(877,60,12,8,'2023-11-02 15:59:08'),
	(883,60,12,10,'2023-11-03 11:25:56'),
	(1143,60,12,8,'2023-11-16 13:54:04'),
	(1144,60,20,11,'2023-11-16 13:55:07'),
	(1158,60,20,5,'2023-11-16 13:55:28'),
	(1185,60,20,7,'2023-11-16 13:56:02'),
	(1186,60,20,12,'2023-11-16 13:56:02'),
	(1187,60,20,11,'2023-11-16 13:56:03'),
	(1188,60,12,11,'2023-11-16 14:17:37'),
	(1189,60,12,11,'2023-11-16 14:17:38'),
	(1190,60,12,10,'2023-11-16 14:17:40'),
	(1191,60,12,13,'2023-11-16 14:17:40'),
	(1192,60,12,7,'2023-11-16 14:17:41'),
	(1197,60,20,8,'2023-11-16 14:45:09'),
	(1198,60,20,12,'2023-11-16 14:45:09');

/*!40000 ALTER TABLE `card_user_hit` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 common_file
# ------------------------------------------------------------

DROP TABLE IF EXISTS `common_file`;

CREATE TABLE `common_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL COMMENT '分类（1：图片，2：文件）',
  `path` varchar(200) NOT NULL DEFAULT '' COMMENT '图片地址',
  `sys_user_id` int(11) NOT NULL COMMENT '系统用户',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='文件管理';

LOCK TABLES `common_file` WRITE;
/*!40000 ALTER TABLE `common_file` DISABLE KEYS */;

INSERT INTO `common_file` (`id`, `type`, `path`, `sys_user_id`, `create_time`)
VALUES
	(258,1,'WechatIMG988.jpeg',3,'2023-11-02 10:31:42'),
	(259,1,'dog.jpeg',3,'2023-11-02 10:37:11'),
	(262,1,'WechatIMG6241.jpeg',1,'2023-11-02 11:36:58'),
	(265,1,'21.jpg',3,'2023-11-17 18:21:39'),
	(266,1,'gggg.png',3,'2023-11-17 18:22:14'),
	(267,1,'sild.png',3,'2023-11-17 18:22:27'),
	(268,1,'money.png',3,'2023-11-17 18:22:39'),
	(269,1,'card.png',3,'2023-11-17 18:22:54'),
	(270,1,'101010.png',3,'2023-11-17 18:23:23'),
	(271,1,'555555.png',3,'2023-11-17 18:23:32'),
	(272,1,'food.png',3,'2023-11-17 18:24:00'),
	(273,1,'kouhong.png',3,'2023-11-17 18:24:14'),
	(274,1,'111.jpg',1,'2023-11-17 18:28:22'),
	(275,1,'girl.png',1,'2023-11-17 18:28:53'),
	(276,1,'teacher.png',1,'2023-11-17 18:29:06'),
	(277,1,'pic3.png',1,'2023-11-17 18:29:18'),
	(278,1,'milk.jpg',1,'2023-11-17 18:30:11'),
	(279,1,'nian.jpeg',1,'2023-11-17 18:31:08'),
	(280,1,'hongbao.jpg',1,'2023-11-17 18:32:27'),
	(282,1,'11wqw.jpg',1,'2023-11-19 10:38:02'),
	(284,1,'618.jpg',1,'2023-11-19 10:43:07'),
	(285,1,'nianhui.jpg',1,'2023-11-19 10:45:24'),
	(286,1,'nian1.jpeg',1,'2023-11-19 10:47:49');

/*!40000 ALTER TABLE `common_file` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 images
# ------------------------------------------------------------

DROP TABLE IF EXISTS `images`;

CREATE TABLE `images` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT '图片名称',
  `url` varchar(200) NOT NULL DEFAULT '' COMMENT '图片地址',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='图片管理';

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;

INSERT INTO `images` (`id`, `name`, `url`, `create_time`)
VALUES
	(6,'1','/upload/images/a.jpeg','2019-08-20 19:12:44'),
	(7,'123','/upload/images/QQ图片20190212181320.png','2019-08-23 05:30:25'),
	(8,'432','/upload/images/QQ图片20190723093437.gif','2019-08-23 05:47:49'),
	(10,'jy','/upload/images/加油.jpg','2019-10-09 23:57:31');

/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_dict
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_dict`;

CREATE TABLE `sys_dict` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `dict_type` varchar(50) NOT NULL DEFAULT '' COMMENT '类型',
  `dict_key` varchar(50) NOT NULL DEFAULT '' COMMENT '键',
  `dict_value` varchar(100) NOT NULL DEFAULT '' COMMENT '值',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='数据字典';

LOCK TABLES `sys_dict` WRITE;
/*!40000 ALTER TABLE `sys_dict` DISABLE KEYS */;

INSERT INTO `sys_dict` (`id`, `dict_type`, `dict_key`, `dict_value`, `create_time`)
VALUES
	(1,'datarule_symbol','=','=','2016-03-02 14:42:05'),
	(2,'datarule_symbol','>','>','2016-03-02 14:42:21'),
	(3,'datarule_symbol','<','<','2016-03-02 14:42:28'),
	(6,'db_source','prize','基本库','2019-09-03 02:58:04'),
	(7,'db_source','prize','业务库','2019-09-03 02:58:10'),
	(8,'task_type','1','url','2017-03-13 15:29:43'),
	(9,'task_type','2','sql','2017-03-13 15:29:51'),
	(10,'task_statu','1','等待运行','2017-03-13 15:31:55'),
	(11,'task_statu','2','已停止','2017-03-13 15:32:12'),
	(12,'task_type','3','ITask','2017-03-19 06:47:57'),
	(13,'task_statu','3','运行中','2017-03-29 15:26:26'),
	(14,'card_user_level','0','普通会员','2019-08-23 21:07:19'),
	(15,'card_user_level','1','一级会员','2019-08-23 21:07:20'),
	(16,'card_user_level','2','二级会员','2019-08-23 21:07:22'),
	(17,'card_user_level','3','三级会员','2019-08-23 21:07:23'),
	(18,'card_user_level','4','四级会员','2019-08-24 19:29:25'),
	(19,'card_game_type','1','随机出现','2019-08-24 19:32:09'),
	(20,'card_game_type','2','瞬间秒杀','2019-08-24 19:32:54'),
	(21,'card_game_type','3','幸运转盘','2020-09-07 15:36:41');

/*!40000 ALTER TABLE `sys_dict` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_login_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_login_log`;

CREATE TABLE `sys_login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `session_id` varchar(50) DEFAULT NULL COMMENT 'session id',
  `ip` varchar(100) DEFAULT NULL COMMENT '登陆ip',
  `is_success` int(11) DEFAULT NULL COMMENT '是否成功（0：失败，1：成功）',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='登陆日志';



# 转储表 sys_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `menu_name` varchar(100) DEFAULT NULL COMMENT '菜单名称',
  `menu_url` varchar(100) DEFAULT NULL COMMENT '菜单地址',
  `parent_id` int(11) DEFAULT NULL COMMENT '所属菜单',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  `order_num` int(11) DEFAULT NULL COMMENT '顺序',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='菜单';

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;

INSERT INTO `sys_menu` (`id`, `menu_name`, `menu_url`, `parent_id`, `icon`, `order_num`, `create_time`)
VALUES
	(1,'系统管理','z',0,'glyphicon-cog',90,'2016-01-07 11:37:31'),
	(2,'在线表单','/zcurdHead/listPage',1,'glyphicon-cloud',1,'2016-01-08 13:41:21'),
	(3,'菜单管理','/menu/list',1,'glyphicon-menu-hamburger',5,'2016-01-07 11:37:38'),
	(4,'字典管理','/zcurd/7/listPage',1,'glyphicon-book',6,'2016-03-01 03:44:07'),
	(5,'用户管理',NULL,0,'glyphicon-user',5,'2016-01-07 11:37:31'),
	(6,'角色管理','/zcurd/8/listPage',5,'glyphicon-user',1,'2016-01-07 19:32:08'),
	(7,'系统用户','/zcurd/12/listPage',5,'glyphicon-king',2,'2016-02-16 19:59:22'),
	(9,'内容管理','aa',0,'glyphicon-search',99,'2016-09-13 14:10:51'),
	(13,'操作日志','/oplog/listPage',1,'glyphicon-time',7,'2016-10-17 02:08:02'),
	(14,'图片管理','/zcurd/18/listPage',9,'glyphicon-picture',3,'2016-12-21 17:12:05'),
	(15,'定时任务','/task/listPage',1,'glyphicon-tasks',2,'2017-03-16 15:55:04'),
	(16,'baidu','http://www.baidu.com',9,'glyphicon-euro',1,'2019-08-23 13:40:35'),
	(17,'奖券管理','/a',0,'glyphicon-gift',2,'2019-08-23 18:22:04'),
	(18,'奖品管理','/zcurd/32/listPage',17,'glyphicon-calendar',1,'2019-08-23 18:22:40'),
	(21,'会员管理','/aa',0,'glyphicon-user',1,'2019-08-23 18:25:18'),
	(22,'会员管理','/carduser/listPage',21,'glyphicon-user',1,'2019-08-23 18:25:38'),
	(23,'等级管理','/zcurd/33/listPage',21,'glyphicon-road',2,'2019-08-23 18:26:04'),
	(24,'活动管理','/s',0,'glyphicon-headphones',3,'2019-08-23 18:26:36'),
	(25,'创建活动','/zcurd/34/listPage',24,'glyphicon-flag',1,'2019-08-23 18:27:48'),
	(26,'模板管理','/ssf',24,'glyphicon-list-alt',2,'2019-08-23 18:28:05'),
	(27,'信息管理','z',0,'glyphicon-th',6,'2019-08-23 18:31:24'),
	(28,'中奖统计','/zcurd/39/listPage',27,'glyphicon-film',1,'2019-08-23 18:33:07'),
	(29,'中奖列表','/zcurd/38/listPage',27,'glyphicon-inbox',2,'2019-08-23 18:33:34'),
	(30,'历史活动','/gamehistory/listPage',24,'glyphicon-film',3,'2019-09-11 20:57:07');

/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_menu_btn
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_menu_btn`;

CREATE TABLE `sys_menu_btn` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `menu_id` int(11) DEFAULT NULL COMMENT '所属菜单',
  `btn_name` varchar(100) DEFAULT NULL COMMENT '按钮名称',
  `class_name` varchar(100) DEFAULT NULL COMMENT '页面class名称',
  `method_name` varchar(500) DEFAULT NULL COMMENT '后台method名称',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='菜单按钮';

LOCK TABLES `sys_menu_btn` WRITE;
/*!40000 ALTER TABLE `sys_menu_btn` DISABLE KEYS */;

INSERT INTO `sys_menu_btn` (`id`, `menu_id`, `btn_name`, `class_name`, `method_name`, `create_time`)
VALUES
	(3,12,'增加','addBtn','add,addPage','2016-10-17 05:55:52'),
	(4,12,'修改','updateBtn','update,updatePage','2016-10-17 05:55:52'),
	(5,12,'删除','delBtn','delete','2016-10-17 05:55:52'),
	(6,12,'导出','exportBtn','exportCsv','2016-10-17 05:55:52'),
	(7,10,'增加','addBtn','add,addPage','2016-10-17 06:11:44'),
	(8,10,'修改','updateBtn','update,updatePage','2016-10-17 06:11:44'),
	(9,10,'删除','delBtn','delete','2016-10-17 06:11:44'),
	(10,10,'导出','exportBtn','exportCsv','2016-10-17 06:11:44'),
	(11,11,'增加','addBtn','add,addPage','2016-10-17 06:14:28'),
	(12,11,'修改','updateBtn','update,updatePage','2016-10-17 06:14:28'),
	(13,11,'删除','delBtn','delete','2016-10-17 06:14:28'),
	(14,11,'导出','exportBtn','exportCsv','2016-10-17 06:14:28'),
	(15,14,'增加','addBtn','add,addPage','2016-12-22 14:52:59'),
	(16,14,'修改','updateBtn','update,updatePage','2016-12-22 14:52:59'),
	(17,14,'删除','delBtn','delete','2016-12-22 14:52:59'),
	(18,14,'导出','exportBtn','exportCsv','2016-12-22 14:52:59'),
	(19,6,'增加','addBtn','add,addPage,/zcurd/5/\\w+,/zcurd/6/\\w+','2016-12-22 14:55:21'),
	(20,6,'修改','updateBtn,operate','/role/editAuthPage,/role/getAllMenu,/zcurd/6/\\w+,/zcurd/5/\\w+,/role/editAuth','2016-12-22 14:55:21'),
	(21,6,'删除','delBtn','delete','2016-12-22 14:55:21'),
	(22,6,'导出','exportBtn','exportCsv','2016-12-22 14:55:21'),
	(23,7,'增加','addBtn','add,addPage','2016-12-22 14:56:44'),
	(24,7,'修改','updateBtn','update,updatePage','2016-12-22 14:56:44'),
	(25,7,'删除','delBtn','delete','2016-12-22 14:56:44'),
	(26,7,'导出','exportBtn','exportCsv','2016-12-22 14:56:44'),
	(31,3,'增加','addBtn','add,addPage','2016-12-22 15:01:15'),
	(32,3,'修改','updateBtn','update,updatePage','2016-12-22 15:01:15'),
	(33,3,'删除','delBtn','delete','2016-12-22 15:01:15'),
	(34,3,'导出','exportBtn','exportCsv','2016-12-22 15:01:15'),
	(35,4,'增加','addBtn','add,addPage','2016-12-22 15:01:28'),
	(36,4,'修改','updateBtn','update,updatePage','2016-12-22 15:01:28'),
	(37,4,'删除','delBtn','delete','2016-12-22 15:01:28'),
	(38,4,'导出','exportBtn','exportCsv','2016-12-22 15:01:28'),
	(39,7,'重置密码','exBtn4','/user/resetPassword','2017-01-28 07:07:20'),
	(44,15,'增加','addBtn','add,addPage','2017-11-23 15:28:19'),
	(45,15,'修改','updateBtn','update,updatePage','2017-11-23 15:28:19'),
	(46,15,'删除','delBtn','delete','2017-11-23 15:28:19'),
	(47,15,'导出','exportBtn','exportCsv','2017-11-23 15:28:19'),
	(48,2,'删除','delBtn','/zcurdHead/delete','2018-03-28 16:19:14'),
	(49,2,'修改','updateBtn','/zcurdHead/updatePage,/zcurdHead/update,/zcurdHead/listField','2018-03-28 16:19:14'),
	(51,2,'生成表单','genFormBtn','/zcurdHead/genFormPage,/zcurdHead/genFormData,/zcurdHead/genForm','2018-03-28 16:19:14'),
	(52,2,'扩展按钮','extendBtnBtn','/zcurd/1/\\w+','2018-03-28 16:40:12'),
	(53,2,'扩展JS','extendJsBtn','/zcurd/2/\\w+','2018-03-29 15:46:52'),
	(54,2,'生成代码','genCodeBtn','/zcurdHead/genCode','2018-03-29 15:47:58'),
	(55,3,'列表','_no_','/menu/listAll','2018-03-29 15:49:45'),
	(59,13,'导出','exportBtn','exportCsv','2018-03-29 16:06:08'),
	(60,22,'增加','addBtn','add,addPage','2019-08-24 06:20:06'),
	(61,22,'修改','updateBtn','update,updatePage','2019-08-24 06:20:06'),
	(62,22,'删除','delBtn','delete','2019-08-24 06:20:06'),
	(63,22,'导出','exportBtn','exportCsv','2019-08-24 06:20:06'),
	(64,16,'增加','addBtn','add,addPage','2019-08-24 06:21:36'),
	(65,16,'修改','updateBtn','update,updatePage','2019-08-24 06:21:36'),
	(66,16,'删除','delBtn','delete','2019-08-24 06:21:36'),
	(67,16,'导出','exportBtn','exportCsv','2019-08-24 06:21:36'),
	(68,23,'增加','addBtn','add,addPage','2019-08-24 19:21:32'),
	(69,23,'修改','updateBtn','update,updatePage','2019-08-24 19:21:32'),
	(70,23,'删除','delBtn','delete','2019-08-24 19:21:32'),
	(71,23,'导出','exportBtn','exportCsv','2019-08-24 19:21:32'),
	(72,18,'增加','addBtn','add,addPage','2019-08-24 20:36:50'),
	(73,18,'修改','updateBtn','update,updatePage','2019-08-24 20:36:50'),
	(74,18,'删除','delBtn','delete','2019-08-24 20:36:50'),
	(75,18,'导出','exportBtn','exportCsv','2019-08-24 20:36:50'),
	(76,25,'增加','addBtn','add,addPage','2019-08-24 20:36:55'),
	(77,25,'修改','updateBtn','update,updatePage','2019-08-24 20:36:55'),
	(78,25,'删除','delBtn','delete','2019-08-24 20:36:55'),
	(79,25,'导出','exportBtn','exportCsv','2019-08-24 20:36:55'),
	(80,25,'奖品配置','aa','/gameproduct/listPage,/gameproduct/addPage,/gameproduct/updatePage,/gameproduct/add,/gameproduct/update,/gameproduct/delete','2019-09-03 02:04:25'),
	(81,25,'策略配置','aa','/gamerules/listPage,/gamerules/addPage,/gamerules/updatePage,/gamerules/add,/gamerules/update,/gamerules/delete','2019-09-03 04:58:11'),
	(82,22,'修改密码','detailBtn','updatePwdPage,update','2019-09-03 14:31:59'),
	(83,28,'增加','addBtn','add,addPage','2019-09-11 12:37:18'),
	(84,28,'修改','updateBtn','update,updatePage','2019-09-11 12:37:18'),
	(85,28,'删除','delBtn','delete','2019-09-11 12:37:18'),
	(86,28,'导出','exportBtn','exportCsv','2019-09-11 12:37:18'),
	(87,29,'增加','addBtn','add,addPage','2019-09-11 12:38:10'),
	(88,29,'修改','updateBtn','update,updatePage','2019-09-11 12:38:10'),
	(89,29,'删除','delBtn','delete','2019-09-11 12:38:10'),
	(90,29,'导出','exportBtn','exportCsv','2019-09-11 12:38:10'),
	(96,30,'增加','addBtn','add,addPage','2019-09-11 21:29:54'),
	(97,30,'修改','updateBtn','update,updatePage','2019-09-11 21:29:54'),
	(98,30,'删除','delBtn','delete','2019-09-11 21:29:54'),
	(99,30,'导出','exportBtn','exportCsv','2019-09-11 21:29:54');

/*!40000 ALTER TABLE `sys_menu_btn` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_menu_datarule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_menu_datarule`;

CREATE TABLE `sys_menu_datarule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `menu_id` int(11) DEFAULT NULL COMMENT '菜单',
  `field_name` varchar(50) DEFAULT NULL COMMENT '字段名称',
  `symbol` varchar(50) DEFAULT NULL COMMENT '符号',
  `value` varchar(100) DEFAULT NULL COMMENT 'sql条件值',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

LOCK TABLES `sys_menu_datarule` WRITE;
/*!40000 ALTER TABLE `sys_menu_datarule` DISABLE KEYS */;

INSERT INTO `sys_menu_datarule` (`id`, `menu_id`, `field_name`, `symbol`, `value`, `create_time`)
VALUES
	(3,12,'status','=','1','2016-09-27 16:16:00'),
	(4,6,'id','>','2','2016-12-22 14:56:25'),
	(5,7,'id','>','10','2016-12-22 14:57:56'),
	(6,2,'id','>','18','2016-12-22 15:01:01'),
	(8,15,'id','>','10','2017-11-23 15:28:35'),
	(9,11,'closing_price','>=','1000','2018-03-29 16:17:58'),
	(10,11,'closing_price','<','2000','2018-03-29 16:18:20'),
	(11,11,'closing_price','>=2000 and closing_price<3000 and 1=','1','2018-03-29 16:19:20'),
	(12,23,'dict_type','=','card_user_level','2019-08-24 19:22:17'),
	(13,25,'status','=','0','2019-09-10 11:55:10'),
	(14,30,'status','>','0','2019-09-11 20:57:46');

/*!40000 ALTER TABLE `sys_menu_datarule` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_oplog
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_oplog`;

CREATE TABLE `sys_oplog` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) DEFAULT NULL COMMENT '用户',
  `op_content` varchar(1000) DEFAULT NULL COMMENT '操作内容',
  `ip` varchar(100) DEFAULT NULL COMMENT 'ip',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统操作日志';



# 转储表 sys_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_name` varchar(11) DEFAULT NULL COMMENT '角色名称',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色管理';

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;

INSERT INTO `sys_role` (`id`, `role_name`, `create_time`)
VALUES
	(6,'运营人员','2019-08-24 06:19:50'),
	(7,'活动创建人员','2019-11-15 16:24:14');

/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_role_btn
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role_btn`;

CREATE TABLE `sys_role_btn` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int(11) DEFAULT NULL COMMENT '角色id',
  `btn_id` int(11) DEFAULT NULL COMMENT '按钮id',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

LOCK TABLES `sys_role_btn` WRITE;
/*!40000 ALTER TABLE `sys_role_btn` DISABLE KEYS */;

INSERT INTO `sys_role_btn` (`id`, `role_id`, `btn_id`, `create_time`)
VALUES
	(1129,5,55,'2018-03-31 16:32:29'),
	(1130,5,20,'2018-03-31 16:32:29'),
	(1131,4,12,'2018-04-01 15:59:33'),
	(1229,1,54,'2019-08-24 06:15:08'),
	(1230,1,53,'2019-08-24 06:15:08'),
	(1231,1,52,'2019-08-24 06:15:08'),
	(1232,1,51,'2019-08-24 06:15:08'),
	(1233,1,49,'2019-08-24 06:15:08'),
	(1234,1,48,'2019-08-24 06:15:08'),
	(1235,1,55,'2019-08-24 06:15:08'),
	(1236,1,34,'2019-08-24 06:15:08'),
	(1237,1,33,'2019-08-24 06:15:08'),
	(1238,1,32,'2019-08-24 06:15:08'),
	(1239,1,31,'2019-08-24 06:15:08'),
	(1240,1,38,'2019-08-24 06:15:08'),
	(1241,1,36,'2019-08-24 06:15:08'),
	(1242,1,35,'2019-08-24 06:15:08'),
	(1243,1,22,'2019-08-24 06:15:08'),
	(1244,1,20,'2019-08-24 06:15:08'),
	(1245,1,19,'2019-08-24 06:15:08'),
	(1246,1,10,'2019-08-24 06:15:08'),
	(1247,1,9,'2019-08-24 06:15:08'),
	(1248,1,8,'2019-08-24 06:15:08'),
	(1249,1,7,'2019-08-24 06:15:08'),
	(1250,1,14,'2019-08-24 06:15:08'),
	(1251,1,13,'2019-08-24 06:15:08'),
	(1252,1,12,'2019-08-24 06:15:08'),
	(1253,1,11,'2019-08-24 06:15:08'),
	(1254,1,6,'2019-08-24 06:15:08'),
	(1255,1,5,'2019-08-24 06:15:08'),
	(1256,1,4,'2019-08-24 06:15:08'),
	(1257,1,3,'2019-08-24 06:15:08'),
	(1258,1,59,'2019-08-24 06:15:08'),
	(1259,1,18,'2019-08-24 06:15:08'),
	(1260,1,16,'2019-08-24 06:15:08'),
	(1261,2,34,'2019-08-24 06:15:15'),
	(1262,2,32,'2019-08-24 06:15:15'),
	(1263,2,31,'2019-08-24 06:15:15'),
	(1264,2,36,'2019-08-24 06:15:15'),
	(1265,2,35,'2019-08-24 06:15:15'),
	(1266,2,22,'2019-08-24 06:15:15'),
	(1267,2,21,'2019-08-24 06:15:15'),
	(1268,2,24,'2019-08-24 06:15:15'),
	(1269,2,23,'2019-08-24 06:15:15'),
	(1270,2,10,'2019-08-24 06:15:15'),
	(1271,2,9,'2019-08-24 06:15:15'),
	(1272,2,8,'2019-08-24 06:15:15'),
	(1273,2,7,'2019-08-24 06:15:15'),
	(1274,2,14,'2019-08-24 06:15:15'),
	(1275,2,13,'2019-08-24 06:15:15'),
	(1276,2,12,'2019-08-24 06:15:15'),
	(1277,2,11,'2019-08-24 06:15:15'),
	(1278,2,6,'2019-08-24 06:15:15'),
	(1279,2,5,'2019-08-24 06:15:15'),
	(1280,2,4,'2019-08-24 06:15:15'),
	(1281,2,3,'2019-08-24 06:15:15'),
	(1282,2,18,'2019-08-24 06:15:15'),
	(1283,2,17,'2019-08-24 06:15:15'),
	(1284,2,16,'2019-08-24 06:15:15'),
	(1285,2,15,'2019-08-24 06:15:15'),
	(1994,6,59,'2019-09-11 21:31:14'),
	(1995,6,18,'2019-09-11 21:31:14'),
	(1996,6,17,'2019-09-11 21:31:14'),
	(1997,6,16,'2019-09-11 21:31:14'),
	(1998,6,15,'2019-09-11 21:31:14'),
	(1999,6,67,'2019-09-11 21:31:14'),
	(2000,6,66,'2019-09-11 21:31:14'),
	(2001,6,65,'2019-09-11 21:31:14'),
	(2002,6,64,'2019-09-11 21:31:14'),
	(2003,6,75,'2019-09-11 21:31:14'),
	(2004,6,74,'2019-09-11 21:31:14'),
	(2005,6,73,'2019-09-11 21:31:14'),
	(2006,6,72,'2019-09-11 21:31:14'),
	(2007,6,82,'2019-09-11 21:31:14'),
	(2008,6,63,'2019-09-11 21:31:14'),
	(2009,6,62,'2019-09-11 21:31:14'),
	(2010,6,61,'2019-09-11 21:31:14'),
	(2011,6,60,'2019-09-11 21:31:14'),
	(2012,6,70,'2019-09-11 21:31:14'),
	(2013,6,69,'2019-09-11 21:31:14'),
	(2014,6,68,'2019-09-11 21:31:14'),
	(2015,6,81,'2019-09-11 21:31:14'),
	(2016,6,80,'2019-09-11 21:31:14'),
	(2017,6,79,'2019-09-11 21:31:14'),
	(2018,6,78,'2019-09-11 21:31:14'),
	(2019,6,77,'2019-09-11 21:31:14'),
	(2020,6,76,'2019-09-11 21:31:14'),
	(2021,6,86,'2019-09-11 21:31:14'),
	(2022,6,90,'2019-09-11 21:31:14'),
	(2023,6,99,'2019-09-11 21:31:14');

/*!40000 ALTER TABLE `sys_role_btn` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_role_datarule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role_datarule`;

CREATE TABLE `sys_role_datarule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int(11) NOT NULL COMMENT '角色',
  `datarule_id` int(11) NOT NULL COMMENT '数据规则',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色数据规则';

LOCK TABLES `sys_role_datarule` WRITE;
/*!40000 ALTER TABLE `sys_role_datarule` DISABLE KEYS */;

INSERT INTO `sys_role_datarule` (`id`, `role_id`, `datarule_id`, `create_time`)
VALUES
	(179,4,10,'2018-04-01 15:59:33'),
	(180,4,9,'2018-04-01 15:59:33'),
	(181,4,3,'2018-04-01 15:59:33'),
	(226,6,12,'2019-09-11 21:31:14'),
	(227,6,13,'2019-09-11 21:31:14'),
	(228,6,14,'2019-09-11 21:31:14');

/*!40000 ALTER TABLE `sys_role_datarule` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_role_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int(11) DEFAULT NULL COMMENT '角色',
  `menu_id` int(11) DEFAULT NULL COMMENT '菜单',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色菜单';

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;

INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`)
VALUES
	(794,5,6,'2018-03-31 16:32:29'),
	(795,5,2,'2018-03-31 16:32:29'),
	(796,5,15,'2018-03-31 16:32:29'),
	(797,5,3,'2018-03-31 16:32:29'),
	(798,5,4,'2018-03-31 16:32:29'),
	(799,5,13,'2018-03-31 16:32:29'),
	(800,4,12,'2018-04-01 15:59:33'),
	(801,4,10,'2018-04-01 15:59:33'),
	(802,4,11,'2018-04-01 15:59:33'),
	(803,4,14,'2018-04-01 15:59:33'),
	(828,1,6,'2019-08-24 06:15:08'),
	(829,1,7,'2019-08-24 06:15:08'),
	(830,1,2,'2019-08-24 06:15:08'),
	(831,1,15,'2019-08-24 06:15:08'),
	(832,1,3,'2019-08-24 06:15:08'),
	(833,1,4,'2019-08-24 06:15:08'),
	(834,1,13,'2019-08-24 06:15:08'),
	(835,2,16,'2019-08-24 06:15:15'),
	(836,2,14,'2019-08-24 06:15:15'),
	(1026,6,22,'2019-09-11 21:31:14'),
	(1027,6,23,'2019-09-11 21:31:14'),
	(1028,6,18,'2019-09-11 21:31:14'),
	(1029,6,25,'2019-09-11 21:31:14'),
	(1030,6,30,'2019-09-11 21:31:14'),
	(1031,6,28,'2019-09-11 21:31:14'),
	(1032,6,29,'2019-09-11 21:31:14'),
	(1033,6,13,'2019-09-11 21:31:14'),
	(1034,7,25,'2019-11-15 16:24:47');

/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `roles` varchar(100) DEFAULT NULL COMMENT '角色',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户管理';

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;

INSERT INTO `sys_user` (`id`, `user_name`, `password`, `roles`, `create_time`)
VALUES
	(1,'admin','-1ef523c6b645a65441a91fa80df077c2',NULL,'2016-01-09 07:33:05'),
	(2,'zcurd','-1ef523c6b645a65441a91fa80df077c2','6','2016-10-30 08:59:44'),
	(3,'user','-1ef523c6b645a65441a91fa80df077c2','6','2019-09-03 04:57:07'),
	(4,'test2','-52fdcb7d6dfa46fcce69457e708578d5','7','2019-11-15 16:25:40'),
	(5,'james','-1ef523c6b645a65441a91fa80df077c2','6','2020-07-02 12:22:13');

/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 task_base
# ------------------------------------------------------------

DROP TABLE IF EXISTS `task_base`;

CREATE TABLE `task_base` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `target_type` int(11) DEFAULT NULL COMMENT '任务类型',
  `target_value` text COMMENT '任务值',
  `cron` varchar(50) DEFAULT NULL COMMENT 'cron表达式',
  `last_run_result` varchar(50) DEFAULT NULL COMMENT '上次执行结果',
  `last_run_time` datetime DEFAULT NULL COMMENT '上次执行时间',
  `last_run_time_cost` int(11) DEFAULT NULL COMMENT '上次执行耗时',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `create_user_id` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='定时任务';

LOCK TABLES `task_base` WRITE;
/*!40000 ALTER TABLE `task_base` DISABLE KEYS */;

INSERT INTO `task_base` (`id`, `name`, `target_type`, `target_value`, `cron`, `last_run_result`, `last_run_time`, `last_run_time_cost`, `status`, `create_user_id`, `create_time`)
VALUES
	(1,'重置账号数据',2,'delete from sys_menu;\nINSERT INTO `sys_menu` (`id`, `menu_name`, `menu_url`, `parent_id`, `icon`, `order_num`, `create_time`)\nVALUES\n	(1,\'系统管理\',NULL,0,\'glyphicon-cog\',6,\'2016-01-06 19:37:31\'),\n	(2,\'在线表单\',\'/zcurdHead/list\',1,\'glyphicon-cloud\',1,\'2016-01-07 21:41:21\'),\n	(3,\'菜单管理\',\'/menu/list\',1,\'glyphicon-menu-hamburger\',5,\'2016-01-06 19:37:38\'),\n	(4,\'字典管理\',\'/zcurd/7/listPage\',1,\'glyphicon-book\',6,\'2016-02-29 11:44:07\'),\n	(5,\'用户管理\',NULL,0,\'glyphicon-user\',5,\'2016-01-06 19:37:31\'),\n	(6,\'角色管理\',\'/zcurd/8/listPage\',5,\'glyphicon-user\',1,\'2016-01-07 03:32:08\'),\n	(7,\'系统用户\',\'/zcurd/12/listPage\',5,\'glyphicon-king\',2,\'2016-02-16 03:59:22\'),\n	(9,\'内容管理\',NULL,0,\'glyphicon-search\',2,\'2016-09-12 22:10:51\'),\n	(10,\'客户管理\',\'/zcurd/15/listPage\',9,\'glyphicon-th-list\',1,\'2016-09-12 22:11:26\'),\n	(11,\'大盘数据\',\'/zcurd/16/listPage\',9,\'glyphicon-flag\',2,\'2016-09-12 22:12:33\'),\n	(12,\'小说采集\',\'/zcurd/17/listPage\',9,\'glyphicon-cd\',0,\'2016-09-18 18:55:28\'),\n	(13,\'操作日志\',\'/oplog/listPage\',1,\'glyphicon-time\',7,\'2016-10-16 10:08:02\'),\n	(14,\'图片管理\',\'/zcurd/18/listPage\',9,\'glyphicon-picture\',3,\'2016-12-21 01:12:05\'),\n	(15,\'定时任务\',\'/task/listPage\',1,\'glyphicon-tasks\',2,\'2017-03-15 23:55:04\');\n\ndelete from sys_menu_btn;\nINSERT INTO `sys_menu_btn` (`id`, `menu_id`, `btn_name`, `class_name`, `method_name`, `create_time`)\nVALUES\n	(3,12,\'增加\',\'addBtn\',\'add,addPage\',\'2016-10-16 13:55:52\'),\n	(4,12,\'修改\',\'updateBtn\',\'update,updatePage\',\'2016-10-16 13:55:52\'),\n	(5,12,\'删除\',\'delBtn\',\'delete\',\'2016-10-16 13:55:52\'),\n	(6,12,\'导出\',\'exportBtn\',\'exportCsv\',\'2016-10-16 13:55:52\'),\n	(7,10,\'增加\',\'addBtn\',\'add,addPage\',\'2016-10-16 14:11:44\'),\n	(8,10,\'修改\',\'updateBtn\',\'update,updatePage\',\'2016-10-16 14:11:44\'),\n	(9,10,\'删除\',\'delBtn\',\'delete\',\'2016-10-16 14:11:44\'),\n	(10,10,\'导出\',\'exportBtn\',\'exportCsv\',\'2016-10-16 14:11:44\'),\n	(11,11,\'增加\',\'addBtn\',\'add,addPage\',\'2016-10-16 14:14:28\'),\n	(12,11,\'修改\',\'updateBtn\',\'update,updatePage\',\'2016-10-16 14:14:28\'),\n	(13,11,\'删除\',\'delBtn\',\'delete\',\'2016-10-16 14:14:28\'),\n	(14,11,\'导出\',\'exportBtn\',\'exportCsv\',\'2016-10-16 14:14:28\'),\n	(15,14,\'增加\',\'addBtn\',\'add,addPage\',\'2016-12-21 22:52:59\'),\n	(16,14,\'修改\',\'updateBtn\',\'update,updatePage\',\'2016-12-21 22:52:59\'),\n	(17,14,\'删除\',\'delBtn\',\'delete\',\'2016-12-21 22:52:59\'),\n	(18,14,\'导出\',\'exportBtn\',\'exportCsv\',\'2016-12-21 22:52:59\'),\n	(19,6,\'增加\',\'addBtn\',\'add,addPage\',\'2016-12-21 22:55:21\'),\n	(20,6,\'修改\',\'updateBtn\',\'update,updatePage\',\'2016-12-21 22:55:21\'),\n	(21,6,\'删除\',\'delBtn\',\'delete\',\'2016-12-21 22:55:21\'),\n	(22,6,\'导出\',\'exportBtn\',\'exportCsv\',\'2016-12-21 22:55:21\'),\n	(23,7,\'增加\',\'addBtn\',\'add,addPage\',\'2016-12-21 22:56:44\'),\n	(24,7,\'修改\',\'updateBtn\',\'update,updatePage\',\'2016-12-21 22:56:44\'),\n	(25,7,\'删除\',\'delBtn\',\'delete\',\'2016-12-21 22:56:44\'),\n	(26,7,\'导出\',\'exportBtn\',\'exportCsv\',\'2016-12-21 22:56:44\'),\n	(29,2,\'删除\',\'delBtn\',\'delete\',\'2016-12-21 22:58:28\'),\n	(31,3,\'增加\',\'addBtn\',\'add,addPage\',\'2016-12-21 23:01:15\'),\n	(32,3,\'修改\',\'updateBtn\',\'update,updatePage\',\'2016-12-21 23:01:15\'),\n	(33,3,\'删除\',\'delBtn\',\'delete\',\'2016-12-21 23:01:15\'),\n	(34,3,\'导出\',\'exportBtn\',\'exportCsv\',\'2016-12-21 23:01:15\'),\n	(35,4,\'增加\',\'addBtn\',\'add,addPage\',\'2016-12-21 23:01:28\'),\n	(36,4,\'修改\',\'updateBtn\',\'update,updatePage\',\'2016-12-21 23:01:28\'),\n	(37,4,\'删除\',\'delBtn\',\'delete\',\'2016-12-21 23:01:28\'),\n	(38,4,\'导出\',\'exportBtn\',\'exportCsv\',\'2016-12-21 23:01:28\'),\n	(39,7,\'重置密码\',\'exBtn4\',\'/user/resetPassword\',\'2017-01-27 15:07:20\'),\n	(44,15,\'增加\',\'addBtn\',\'add,addPage\',\'2017-11-22 23:28:19\'),\n	(45,15,\'修改\',\'updateBtn\',\'update,updatePage\',\'2017-11-22 23:28:19\'),\n	(46,15,\'删除\',\'delBtn\',\'delete\',\'2017-11-22 23:28:19\'),\n	(47,15,\'导出\',\'exportBtn\',\'exportCsv\',\'2017-11-22 23:28:19\');\n\ndelete from sys_role;\nINSERT INTO `sys_role` (`id`, `role_name`, `create_time`)\nVALUES\n	(1,\'系统管理员\',\'2016-02-04 21:05:45\'),\n	(2,\'内容运营\',\'2016-02-04 21:06:12\'),\n	(4,\'readonly\',\'2016-10-16 14:22:10\');\n\ndelete from sys_role_btn;\nINSERT INTO `sys_role_btn` (`id`, `role_id`, `btn_id`, `create_time`)\nVALUES\n	(450,2,34,\'2016-12-21 23:05:22\'),\n	(451,2,32,\'2016-12-21 23:05:22\'),\n	(452,2,31,\'2016-12-21 23:05:22\'),\n	(453,2,36,\'2016-12-21 23:05:22\'),\n	(454,2,35,\'2016-12-21 23:05:22\'),\n	(455,2,22,\'2016-12-21 23:05:22\'),\n	(456,2,21,\'2016-12-21 23:05:22\'),\n	(457,2,24,\'2016-12-21 23:05:22\'),\n	(458,2,23,\'2016-12-21 23:05:22\'),\n	(459,2,10,\'2016-12-21 23:05:22\'),\n	(460,2,9,\'2016-12-21 23:05:22\'),\n	(461,2,8,\'2016-12-21 23:05:22\'),\n	(462,2,7,\'2016-12-21 23:05:22\'),\n	(463,2,14,\'2016-12-21 23:05:22\'),\n	(464,2,13,\'2016-12-21 23:05:22\'),\n	(465,2,12,\'2016-12-21 23:05:22\'),\n	(466,2,11,\'2016-12-21 23:05:22\'),\n	(467,2,6,\'2016-12-21 23:05:22\'),\n	(468,2,5,\'2016-12-21 23:05:22\'),\n	(469,2,4,\'2016-12-21 23:05:22\'),\n	(470,2,3,\'2016-12-21 23:05:22\'),\n	(471,2,18,\'2016-12-21 23:05:22\'),\n	(472,2,17,\'2016-12-21 23:05:22\'),\n	(473,2,16,\'2016-12-21 23:05:22\'),\n	(474,2,15,\'2016-12-21 23:05:22\'),\n	(521,1,32,\'2017-11-22 23:28:40\'),\n	(522,1,31,\'2017-11-22 23:28:40\'),\n	(523,1,38,\'2017-11-22 23:28:40\'),\n	(524,1,36,\'2017-11-22 23:28:40\'),\n	(525,1,35,\'2017-11-22 23:28:40\'),\n	(526,1,22,\'2017-11-22 23:28:40\'),\n	(527,1,20,\'2017-11-22 23:28:40\'),\n	(528,1,19,\'2017-11-22 23:28:40\'),\n	(529,1,10,\'2017-11-22 23:28:40\'),\n	(530,1,9,\'2017-11-22 23:28:40\'),\n	(531,1,8,\'2017-11-22 23:28:40\'),\n	(532,1,7,\'2017-11-22 23:28:40\'),\n	(533,1,14,\'2017-11-22 23:28:40\'),\n	(534,1,13,\'2017-11-22 23:28:40\'),\n	(535,1,12,\'2017-11-22 23:28:40\'),\n	(536,1,11,\'2017-11-22 23:28:40\'),\n	(537,1,6,\'2017-11-22 23:28:40\'),\n	(538,1,5,\'2017-11-22 23:28:40\'),\n	(539,1,4,\'2017-11-22 23:28:40\'),\n	(540,1,3,\'2017-11-22 23:28:40\');\n\ndelete from sys_role_datarule;\nINSERT INTO `sys_role_datarule` (`id`, `role_id`, `datarule_id`, `create_time`)\nVALUES\n	(18,3,3,\'2016-10-16 15:01:17\'),\n	(23,4,3,\'2016-12-21 22:53:05\'),\n	(44,2,6,\'2016-12-21 23:05:22\'),\n	(45,2,4,\'2016-12-21 23:05:22\'),\n	(46,2,5,\'2016-12-21 23:05:22\'),\n	(56,1,6,\'2017-11-22 23:28:40\'),\n	(57,1,4,\'2017-11-22 23:28:40\'),\n	(58,1,5,\'2017-11-22 23:28:40\'),\n	(59,1,3,\'2017-11-22 23:28:40\'),\n	(60,1,8,\'2017-11-22 23:28:40\');\n\ndelete from sys_role_menu;\nINSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`)\nVALUES\n	(472,4,12,\'2016-12-21 22:53:05\'),\n	(473,4,10,\'2016-12-21 22:53:05\'),\n	(474,4,11,\'2016-12-21 22:53:05\'),\n	(475,4,14,\'2016-12-21 22:53:05\'),\n	(578,2,12,\'2016-12-21 23:05:22\'),\n	(579,2,10,\'2016-12-21 23:05:22\'),\n	(580,2,11,\'2016-12-21 23:05:22\'),\n	(581,2,14,\'2016-12-21 23:05:22\'),\n	(596,1,6,\'2017-11-22 23:28:40\'),\n	(597,1,7,\'2017-11-22 23:28:40\'),\n	(598,1,2,\'2017-11-22 23:28:40\'),\n	(599,1,15,\'2017-11-22 23:28:40\'),\n	(600,1,3,\'2017-11-22 23:28:40\'),\n	(601,1,4,\'2017-11-22 23:28:40\'),\n	(602,1,13,\'2017-11-22 23:28:40\');\n\ndelete from sys_user;\nINSERT INTO `sys_user` (`id`, `user_name`, `password`, `roles`, `create_time`)\nVALUES\n	(1,\'admin\',\'25d55ad283aa400af464c76d713c07ad\',NULL,\'2016-01-08 15:33:05\'),\n	(2,\'zcurd\',\'-1ef523c6b645a65441a91fa80df077c2\',\'2,1\',\'2016-10-29 16:59:44\'),\n	(3,\'readonly\',\'-1ef523c6b645a65441a91fa80df077c2\',\'4\',\'2016-10-16 14:22:46\'),\n	(11,\'zhong\',\'-1ef523c6b645a65441a91fa80df077c2\',\'2,1\',\'2016-02-21 01:19:47\');','* * 2 * *','成功','2017-11-22 23:46:17',9,2,NULL,'2017-11-22 16:07:23'),
	(11,'测试-请示URL',1,'https://www.baidu.com','* * */1 * *','成功','2017-11-22 23:23:00',3,2,1,'2017-03-05 08:08:06'),
	(12,'测试-查询',2,'select 2','* * */1 * *','成功','2018-03-21 22:45:00',10,2,NULL,'2017-03-05 09:32:02'),
	(13,'测试-存储过程（体验地址不支持）',2,'call zcurd_base.pro_test()','* * */1 * *','成功','2017-04-09 09:31:24',2,2,NULL,'2017-03-05 16:30:20'),
	(14,'测试-ITask',3,'com.zcurd.common.task.DemoTask','* * */1 * *','成功','2017-03-26 22:50:00',3,2,NULL,'2017-03-19 06:43:55');

/*!40000 ALTER TABLE `task_base` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 task_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `task_log`;

CREATE TABLE `task_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `task_id` int(11) DEFAULT NULL COMMENT '所属任务',
  `result` varchar(50) DEFAULT NULL COMMENT '执行结果',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `cost_time` int(11) DEFAULT NULL COMMENT '耗时',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='定时任务-日志';

LOCK TABLES `task_log` WRITE;
/*!40000 ALTER TABLE `task_log` DISABLE KEYS */;

INSERT INTO `task_log` (`id`, `task_id`, `result`, `start_time`, `end_time`, `cost_time`, `remark`)
VALUES
	(1,12,'成功','2017-11-22 23:48:00','2017-11-22 23:48:00',3,NULL),
	(2,12,'成功','2017-11-22 23:49:00','2017-11-22 23:49:00',3,NULL),
	(3,12,'成功','2018-03-21 22:23:00','2018-03-21 22:23:00',5,NULL),
	(4,12,'成功','2018-03-21 22:24:00','2018-03-21 22:24:00',5,NULL),
	(5,12,'成功','2018-03-21 22:25:00','2018-03-21 22:25:00',6,NULL),
	(6,12,'成功','2018-03-21 22:26:00','2018-03-21 22:26:00',5,NULL),
	(7,12,'成功','2018-03-21 22:27:00','2018-03-21 22:27:00',7,NULL),
	(8,12,'成功','2018-03-21 22:28:00','2018-03-21 22:28:00',6,NULL),
	(9,12,'成功','2018-03-21 22:29:00','2018-03-21 22:29:00',5,NULL),
	(10,12,'成功','2018-03-21 22:30:00','2018-03-21 22:30:00',5,NULL),
	(11,12,'成功','2018-03-21 22:31:00','2018-03-21 22:31:00',6,NULL),
	(12,12,'成功','2018-03-21 22:32:00','2018-03-21 22:32:00',5,NULL),
	(13,12,'成功','2018-03-21 22:33:00','2018-03-21 22:33:00',6,NULL),
	(14,12,'成功','2018-03-21 22:34:00','2018-03-21 22:34:00',6,NULL),
	(15,12,'成功','2018-03-21 22:35:00','2018-03-21 22:35:00',4,NULL),
	(16,12,'成功','2018-03-21 22:36:00','2018-03-21 22:36:00',5,NULL),
	(17,12,'成功','2018-03-21 22:37:00','2018-03-21 22:37:00',5,NULL),
	(18,12,'成功','2018-03-21 22:38:00','2018-03-21 22:38:00',5,NULL),
	(19,12,'成功','2018-03-21 22:39:00','2018-03-21 22:39:00',5,NULL),
	(20,12,'成功','2018-03-21 22:40:00','2018-03-21 22:40:00',5,NULL),
	(21,12,'成功','2018-03-21 22:41:00','2018-03-21 22:41:00',5,NULL),
	(22,12,'成功','2018-03-21 22:42:00','2018-03-21 22:42:00',6,NULL),
	(23,12,'成功','2018-03-21 22:43:00','2018-03-21 22:43:00',2,NULL),
	(24,12,'成功','2018-03-21 22:45:00','2018-03-21 22:45:00',10,NULL);

/*!40000 ALTER TABLE `task_log` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 tb_proc_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_proc_log`;

CREATE TABLE `tb_proc_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `proc_name` varchar(50) DEFAULT NULL COMMENT '过程名称',
  `statu` varchar(20) DEFAULT NULL COMMENT '状态',
  `start_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `cost_time` int(11) DEFAULT NULL COMMENT '耗时',
  `error_code` varchar(50) DEFAULT NULL COMMENT 'error_code',
  `error_msg` varchar(200) DEFAULT NULL COMMENT 'error_msg',
  `step` int(11) DEFAULT NULL COMMENT 'step',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='存储过程运行日志';











# 转储表 zcurd_field
# ------------------------------------------------------------

DROP TABLE IF EXISTS `zcurd_field`;

CREATE TABLE `zcurd_field` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `head_id` int(11) DEFAULT NULL COMMENT '所属表',
  `field_name` varchar(100) DEFAULT NULL COMMENT '字段名称',
  `column_name` varchar(100) DEFAULT NULL COMMENT '列表列名',
  `column_length` int(11) DEFAULT '120' COMMENT '列宽',
  `data_type` varchar(50) DEFAULT NULL COMMENT '数据类型',
  `input_type` varchar(50) DEFAULT 'easyui-textbox' COMMENT '控件类型',
  `is_show_list` int(11) DEFAULT '1' COMMENT '是否列表显示',
  `is_allow_detail` int(11) DEFAULT '1' COMMENT '是否详情显示',
  `is_allow_add` int(11) DEFAULT '1' COMMENT '是否允许增加',
  `is_allow_update` int(11) DEFAULT '1' COMMENT '是否允许编辑',
  `is_search` int(11) DEFAULT '0' COMMENT '是否搜索',
  `is_allow_null` int(11) DEFAULT '1' COMMENT '是否允许为空',
  `dict_sql` varchar(1000) DEFAULT NULL COMMENT '字典sql',
  `order_num` int(11) DEFAULT '0' COMMENT '顺序',
  `search_type` int(11) DEFAULT '1' COMMENT '搜索类型(1:值,2:范围)',
  `is_sum` int(11) DEFAULT '0' COMMENT '是否汇总',
  `default_value` varchar(100) DEFAULT NULL COMMENT '默认值',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='在线表单字段';

LOCK TABLES `zcurd_field` WRITE;
/*!40000 ALTER TABLE `zcurd_field` DISABLE KEYS */;

INSERT INTO `zcurd_field` (`id`, `head_id`, `field_name`, `column_name`, `column_length`, `data_type`, `input_type`, `is_show_list`, `is_allow_detail`, `is_allow_add`, `is_allow_update`, `is_search`, `is_allow_null`, `dict_sql`, `order_num`, `search_type`, `is_sum`, `default_value`, `create_time`)
VALUES
	(2,1,'func_content','方法内容',120,'text','textarea',0,1,1,1,0,0,'',6,1,0,NULL,'2016-01-12 13:58:48'),
	(1,1,'create_time','创建时间',130,'timestamp','easyui-textbox',1,1,0,0,0,1,'',7,1,0,NULL,'2016-01-12 13:58:48'),
	(4,1,'location','按钮位置',80,'int','easyui-combobox',1,1,1,1,0,0,'select 1, \'顶部\' union all select 2, \'行内\'',4,1,0,NULL,'2016-01-12 13:58:48'),
	(5,1,'action','行为',80,'int','easyui-combobox',1,1,1,1,0,0,'select 0, \'自定义\' union all select 1, \'打开子页面\'',5,1,0,NULL,'2016-01-12 13:58:48'),
	(190,15,'archremark','资料归档备注',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,119,1,0,NULL,'2016-09-19 09:31:32'),
	(189,15,'archtime','资料归档时间',120,'date','easyui-textbox',1,1,1,1,0,1,NULL,118,1,0,NULL,'2016-09-19 09:31:32'),
	(188,15,'archstatus','资料归档情况',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,117,1,0,NULL,'2016-09-19 09:31:32'),
	(187,15,'approvalopinion','审批意见',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,116,1,0,NULL,'2016-09-19 09:31:32'),
	(186,15,'gjrelation','共借人关系',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,115,1,0,NULL,'2016-09-19 09:31:32'),
	(7,2,'js_content','扩展js',120,'text','textarea',0,1,1,1,0,0,'',4,1,0,NULL,'2016-01-13 07:35:01'),
	(6,2,'create_time','创建时间',130,'timestamp','easyui-textbox',1,1,0,0,0,1,'',5,1,0,NULL,'2016-01-13 07:35:01'),
	(8,2,'page','页面',120,'varchar','easyui-combobox',1,1,1,1,0,0,'select \'list\' as \'key\', \'list\' as \'value\' union all select \'add\', \'add\' union all select \'update\', \'update\' union all select \'detail\', \'detail\'',2,1,0,NULL,'2016-01-13 07:35:01'),
	(182,15,'refundtime','退款时间',120,'date','easyui-textbox',1,1,1,1,0,1,NULL,111,1,0,NULL,'2016-09-19 09:31:32'),
	(183,15,'loanMoney','loanMoney',120,'double','easyui-textbox',1,1,1,1,0,1,NULL,112,1,0,NULL,'2016-09-19 09:31:32'),
	(184,15,'creditLevel','信用卡等级',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,113,1,0,NULL,'2016-09-19 09:31:32'),
	(185,15,'buyhouseaddress','客户新买房新地址',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,114,1,0,NULL,'2016-09-19 09:31:32'),
	(26,5,'menu_id','所属菜单',100,'int','easyui-combobox',1,1,1,1,1,0,'select id, menu_name from sys_menu',1,1,0,NULL,'2016-02-15 08:35:56'),
	(28,5,'class_name','页面class名称',100,'varchar','easyui-textbox',1,1,1,1,0,0,'',3,1,0,NULL,'2016-02-15 08:35:56'),
	(27,5,'btn_name','按钮名称',100,'varchar','easyui-textbox',1,1,1,1,0,0,'',2,1,0,NULL,'2016-02-15 08:35:56'),
	(34,6,'value','字段件值',80,'varchar','easyui-textbox',1,1,1,1,0,0,'',5,1,0,NULL,'2016-02-26 15:55:58'),
	(36,6,'symbol','符号',80,'varchar','easyui-combobox',1,1,1,1,0,0,'select dict_key, dict_value from sys_dict where dict_type=\'datarule_symbol\'',4,1,0,NULL,'2016-02-28 19:20:56'),
	(33,6,'field_name','字段名称',100,'varchar','easyui-textbox',1,1,1,1,0,0,'',3,1,0,NULL,'2016-02-26 15:55:58'),
	(32,6,'menu_id','菜单',100,'int','easyui-combobox',1,1,1,1,1,0,'select id, menu_name from sys_menu',2,1,0,NULL,'2016-02-26 15:55:58'),
	(194,15,'overduecount','逾期次数',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,123,1,0,NULL,'2016-09-19 09:31:32'),
	(193,15,'repaystatus','还款情况',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,122,1,0,NULL,'2016-09-19 09:31:32'),
	(192,15,'mortgageremark','按揭备注',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,121,1,0,NULL,'2016-09-19 09:31:32'),
	(191,15,'mortgagestatus','按揭情况',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,120,1,0,NULL,'2016-09-19 09:31:32'),
	(181,15,'refundamount','退款金额',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,110,1,0,NULL,'2016-09-19 09:31:32'),
	(43,8,'role_name','角色名称',120,'varchar','easyui-textbox',1,1,1,1,0,0,'',1,1,0,NULL,'2016-02-12 17:58:39'),
	(42,8,'id','id',120,'int','easyui-numberspinner',1,1,1,1,0,0,'',0,1,0,NULL,'2016-02-12 17:58:39'),
	(44,8,'create_time','创建时间',120,'timestamp','easyui-datebox',1,1,0,0,0,1,'',2,1,0,NULL,'2016-02-12 17:58:39'),
	(30,5,'create_time','创建时间',120,'timestamp','easyui-datebox',0,0,0,0,0,0,'',5,1,0,NULL,'2016-02-15 08:35:56'),
	(37,7,'id','id',120,'int','easyui-numberspinner',1,1,1,1,0,0,'',0,1,0,NULL,'2016-03-01 20:39:14'),
	(41,7,'create_time','创建时间',120,'timestamp','easyui-datebox',1,1,0,0,1,0,'',4,2,0,NULL,'2016-03-01 20:39:14'),
	(40,7,'dict_value','值',120,'varchar','easyui-textbox',1,1,1,1,1,0,'',2,1,0,NULL,'2016-03-01 20:39:14'),
	(39,7,'dict_key','键',120,'varchar','easyui-textbox',1,1,1,1,1,0,'',3,1,0,NULL,'2016-03-01 20:39:14'),
	(38,7,'dict_type','类型',120,'varchar','easyui-combobox',1,1,1,1,1,0,'select distinct dict_type as \'key\', dict_type as \'value\' from sys_dict',1,1,0,NULL,'2016-03-01 20:39:14'),
	(61,12,'roles','角色',120,'varchar','easyui-combobox',1,1,1,1,0,1,'select id, role_name from sys_role',4,1,0,NULL,'2016-02-23 20:31:08'),
	(60,12,'create_time','创建时间',120,'timestamp','easyui-textbox',1,1,0,0,1,1,'',5,2,0,NULL,'2016-01-08 13:31:45'),
	(59,12,'password','密码',120,'varchar','easyui-textbox',0,0,1,0,0,1,'',3,1,0,NULL,'2016-01-08 13:31:45'),
	(57,12,'id','id',120,'int','easyui-textbox',1,1,1,1,0,1,'',1,1,0,NULL,'2016-01-08 13:31:45'),
	(58,12,'user_name','用户名',120,'varchar','easyui-textbox',1,1,1,1,1,1,'',2,1,0,NULL,'2016-01-08 13:31:45'),
	(180,15,'consultantphone','顾问号码',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,109,1,0,NULL,'2016-09-19 09:31:32'),
	(179,15,'houseConsultant','职业顾问',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,108,1,0,NULL,'2016-09-19 09:31:32'),
	(178,15,'loanbankaccount','还款银行卡号',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,107,1,0,NULL,'2016-09-19 09:31:32'),
	(177,15,'accountbranch','开户支行',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,106,1,0,NULL,'2016-09-19 09:31:32'),
	(31,6,'id','id',120,'int','easyui-numberspinner',1,1,1,1,0,0,'',1,1,0,NULL,'2016-02-26 15:55:58'),
	(176,15,'applyloandate','申请放款时间',120,'date','easyui-textbox',1,1,1,1,0,1,NULL,105,1,0,NULL,'2016-09-19 09:31:32'),
	(175,15,'urgentlevel','紧急程度',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,104,1,0,NULL,'2016-09-19 09:31:32'),
	(174,15,'othertime','othertime',120,'date','easyui-textbox',1,1,1,1,0,1,NULL,103,1,0,NULL,'2016-09-19 09:31:32'),
	(173,15,'otheramount','加他付款方式',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,102,1,0,NULL,'2016-09-19 09:31:32'),
	(172,15,'transfertime','转账时间',120,'date','easyui-textbox',1,1,1,1,0,1,NULL,101,1,0,NULL,'2016-09-19 09:31:32'),
	(171,15,'transferamount','转账金额',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,100,1,0,NULL,'2016-09-19 09:31:32'),
	(170,15,'cashtime','现金付款时间',120,'date','easyui-textbox',1,1,1,1,0,1,NULL,99,1,0,NULL,'2016-09-19 09:31:32'),
	(169,15,'cashamount','现金金额',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,98,1,0,NULL,'2016-09-19 09:31:32'),
	(168,15,'postime','pos刷卡时间',120,'date','easyui-textbox',1,1,1,1,0,1,NULL,97,1,0,NULL,'2016-09-19 09:31:32'),
	(167,15,'posamount','放款金额',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,96,1,0,NULL,'2016-09-19 09:31:32'),
	(166,15,'recviway','还款方式1 pos机器 2现金  3转账  4其他',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,95,1,0,NULL,'2016-09-19 09:31:32'),
	(165,15,'loantime','放款时间',120,'date','easyui-textbox',1,1,1,1,0,1,NULL,94,1,0,NULL,'2016-09-19 09:31:32'),
	(164,15,'loanstatus','放款状态',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,93,1,0,NULL,'2016-09-19 09:31:32'),
	(163,15,'signtime','签约时间',120,'date','easyui-textbox',1,1,1,1,0,1,NULL,92,1,0,NULL,'2016-09-19 09:31:32'),
	(162,15,'signstatus','签约状态',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,91,1,0,NULL,'2016-09-19 09:31:32'),
	(161,15,'repay','repay',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,90,1,0,NULL,'2016-09-19 09:31:32'),
	(160,15,'period','period',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,89,1,0,NULL,'2016-09-19 09:31:32'),
	(159,15,'personPath','personPath',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,88,1,0,NULL,'2016-09-19 09:31:32'),
	(158,15,'fkid','fkid',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,87,1,0,NULL,'2016-09-19 09:31:32'),
	(157,15,'examindate','报审时间',120,'date','easyui-textbox',1,1,1,1,0,1,NULL,86,1,0,NULL,'2016-09-19 09:31:32'),
	(156,15,'fundname','fundname',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,85,1,0,NULL,'2016-09-19 09:31:32'),
	(155,15,'fund','fund',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,84,1,0,NULL,'2016-09-19 09:31:32'),
	(154,15,'loantimelimit','loantimelimit',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,83,1,0,NULL,'2016-09-19 09:31:32'),
	(153,15,'zcompanyaddress','zcompanyaddress',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,82,1,0,NULL,'2016-09-19 09:31:32'),
	(152,15,'gunitaddress','gunitaddress',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,81,1,0,NULL,'2016-09-19 09:31:32'),
	(151,15,'xsname','xsname',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,80,1,0,NULL,'2016-09-19 09:31:32'),
	(150,15,'xsid','xsid',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,79,1,0,NULL,'2016-09-19 09:31:32'),
	(149,15,'relations','relations',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,78,1,0,NULL,'2016-09-19 09:31:32'),
	(148,15,'creditLoanMoney','creditLoanMoney',120,'double','easyui-textbox',1,1,1,1,0,1,NULL,77,1,0,NULL,'2016-09-19 09:31:32'),
	(147,15,'zenterpborrow','zenterpborrow',120,'double','easyui-textbox',1,1,1,1,0,1,NULL,76,1,0,NULL,'2016-09-19 09:31:32'),
	(146,15,'creditNumber','creditNumber',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,75,1,0,NULL,'2016-09-19 09:31:32'),
	(145,15,'aname','aname',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,74,1,0,NULL,'2016-09-19 09:31:32'),
	(144,15,'ctime','ctime',120,'datetime','easyui-textbox',1,1,1,1,0,1,NULL,73,1,0,NULL,'2016-09-19 09:31:32'),
	(143,15,'adid','adid',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,72,1,0,NULL,'2016-09-19 09:31:32'),
	(142,15,'contposition','紧急联系人工作职位',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,71,1,0,NULL,'2016-09-19 09:31:32'),
	(141,15,'contworkdep','紧急联系人工作部门',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,70,1,0,NULL,'2016-09-19 09:31:32'),
	(140,15,'contunitaddress','紧急联系人单位地址',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,69,1,0,NULL,'2016-09-19 09:31:32'),
	(139,15,'contunitphone','紧急联系人单位电话',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,68,1,0,NULL,'2016-09-19 09:31:32'),
	(138,15,'contunitname','紧急联系人单位名称',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,67,1,0,NULL,'2016-09-19 09:31:32'),
	(137,15,'contaddress','紧急联系人地址',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,66,1,0,NULL,'2016-09-19 09:31:32'),
	(136,15,'contphone','紧急联系人住宅电话',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,65,1,0,NULL,'2016-09-19 09:31:32'),
	(135,15,'contmobile','紧急联系人电话',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,64,1,0,NULL,'2016-09-19 09:31:32'),
	(134,15,'contloan','经济联系人是否知晓贷款',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,63,1,0,NULL,'2016-09-19 09:31:32'),
	(133,15,'contrelation','紧急联系人关系',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,62,1,0,NULL,'2016-09-19 09:31:32'),
	(132,15,'contsex','紧急联系人性别',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,61,1,0,NULL,'2016-09-19 09:31:32'),
	(131,15,'contage','紧急联系人年龄',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,60,1,0,NULL,'2016-09-19 09:31:32'),
	(130,15,'contname','紧急联系人姓名',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,59,1,0,NULL,'2016-09-19 09:31:32'),
	(129,15,'otherloan','其他贷款',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,58,1,0,NULL,'2016-09-19 09:31:32'),
	(128,15,'creditconsume','信用卡已消费',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,57,1,0,NULL,'2016-09-19 09:31:32'),
	(127,15,'creditlimit','信用卡最高额度',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,56,1,0,NULL,'2016-09-19 09:31:32'),
	(126,15,'bankaccount','用户银行账户',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,55,1,0,NULL,'2016-09-19 09:31:32'),
	(125,15,'age','年龄',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,54,1,0,NULL,'2016-09-19 09:31:32'),
	(124,15,'zsharesratio','占股比例-自雇',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,53,1,0,NULL,'2016-09-19 09:31:32'),
	(123,15,'zmanageplace','经营场所-自雇',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,52,1,0,NULL,'2016-09-19 09:31:32'),
	(122,15,'zenterploan','企业借款-自雇',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,51,1,0,NULL,'2016-09-19 09:31:32'),
	(121,15,'zenterpfund','企业资产-自雇',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,50,1,0,NULL,'2016-09-19 09:31:32'),
	(120,15,'zyearbus','年营业额-自雇',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,49,1,0,NULL,'2016-09-19 09:31:32'),
	(119,15,'zmonincome','月收入—自雇',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,48,1,0,NULL,'2016-09-19 09:31:32'),
	(118,15,'zindustrytype','行业类型-自雇',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,47,1,0,NULL,'2016-09-19 09:31:32'),
	(117,15,'zcompanyname','企业名-自雇',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,46,1,0,NULL,'2016-09-19 09:31:32'),
	(116,15,'gsalaryway','工作发放形式-工薪',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,45,1,0,NULL,'2016-09-19 09:31:32'),
	(115,15,'gworklife','工作年限-工薪',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,44,1,0,NULL,'2016-09-19 09:31:32'),
	(114,15,'gmonincome','月收入-工薪',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,43,1,0,NULL,'2016-09-19 09:31:32'),
	(113,15,'gjoblevel','工作级别-工薪',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,42,1,0,NULL,'2016-09-19 09:31:32'),
	(112,15,'gunitnature','单位性质-工薪',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,41,1,0,NULL,'2016-09-19 09:31:32'),
	(111,15,'gunitname','单位名称-工薪',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,40,1,0,NULL,'2016-09-19 09:31:32'),
	(110,15,'job','职业',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,39,1,0,NULL,'2016-09-19 09:31:32'),
	(109,15,'familyaddress','家庭地址',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,38,1,0,NULL,'2016-09-19 09:31:32'),
	(108,15,'marriagestatus','婚姻状态',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,37,1,0,NULL,'2016-09-19 09:31:32'),
	(107,15,'homestatus','置业状况',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,36,1,0,NULL,'2016-09-19 09:31:32'),
	(106,15,'applyamount','申请金额',120,'double','easyui-textbox',1,1,1,1,0,1,NULL,35,1,0,NULL,'2016-09-19 09:31:32'),
	(105,15,'loanproduct','贷款产品',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,34,1,0,NULL,'2016-09-19 09:31:32'),
	(104,15,'fristpayratio','首付比例',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,33,1,0,NULL,'2016-09-19 09:31:32'),
	(103,15,'buyhouseamount','购房金额',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,32,1,0,NULL,'2016-09-19 09:31:32'),
	(102,15,'familycount','家庭人口数量',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,31,1,0,NULL,'2016-09-19 09:31:32'),
	(101,15,'salaryway','工资发放形式',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,30,1,0,NULL,'2016-09-19 09:31:32'),
	(100,15,'domloction','户籍所在地',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,29,1,0,NULL,'2016-09-19 09:31:32'),
	(99,15,'health','健康状况',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,28,1,0,NULL,'2016-09-19 09:31:32'),
	(98,15,'higdegree','最高学位',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,27,1,0,NULL,'2016-09-19 09:31:32'),
	(97,15,'pidunit','发证机关',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,26,1,0,NULL,'2016-09-19 09:31:32'),
	(96,15,'pidvaildity','证件有效期',120,'date','easyui-textbox',1,1,1,1,0,1,NULL,25,1,0,NULL,'2016-09-19 09:31:32'),
	(95,15,'pidtype','证件类型',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,24,1,0,NULL,'2016-09-19 09:31:32'),
	(94,15,'nation','民族',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,23,1,0,NULL,'2016-09-19 09:31:32'),
	(93,15,'natiomality','国籍',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,22,1,0,NULL,'2016-09-19 09:31:32'),
	(10221,33,'create_time','创建时间',120,'timestamp','easyui-datebox',1,1,0,0,0,0,'',50,1,0,'','2019-08-24 19:26:02'),
	(10220,33,'dict_value','等级名称',120,'varchar','easyui-textbox',1,1,1,1,1,0,'',40,1,0,'','2019-08-24 19:26:02'),
	(10217,33,'id','id',120,'int unsigned','easyui-textbox',0,0,0,0,0,0,'',1,1,0,'','2019-08-24 19:26:02'),
	(10219,33,'dict_key','等级代号',120,'varchar','easyui-textbox',1,1,1,1,0,0,'',30,1,0,'','2019-08-24 19:26:02'),
	(10218,33,'dict_type','类型',120,'varchar','easyui-textbox',0,0,0,0,0,0,'',20,1,0,'card_user_level','2019-08-24 19:26:02'),
	(92,15,'birthday','出生年月',120,'date','easyui-textbox',1,1,1,1,0,1,NULL,21,1,0,NULL,'2016-09-19 09:31:32'),
	(91,15,'sex','客户性别',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,20,1,0,NULL,'2016-09-19 09:31:32'),
	(90,15,'etime','贷款结束时间',120,'date','easyui-textbox',1,1,1,1,0,1,NULL,19,1,0,NULL,'2016-09-19 09:31:32'),
	(89,15,'stime','贷款开始时间',120,'date','easyui-textbox',1,1,1,1,0,1,NULL,18,1,0,NULL,'2016-09-19 09:31:32'),
	(88,15,'price','贷款金额',120,'int','easyui-textbox',1,1,1,1,0,0,NULL,17,1,0,NULL,'2016-09-19 09:31:32'),
	(87,15,'ordercode','订单id',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,16,1,0,NULL,'2016-09-19 09:31:32'),
	(86,15,'tempcontent','修改数据',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,15,1,0,NULL,'2016-09-19 09:31:32'),
	(85,15,'score','按模型计算得分',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,14,1,0,NULL,'2016-09-19 09:31:32'),
	(84,15,'mid','使用模型',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,13,1,0,NULL,'2016-09-19 09:31:32'),
	(83,15,'status','状态',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,12,1,0,NULL,'2016-09-19 09:31:32'),
	(82,15,'type','客户类型',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,11,1,0,NULL,'2016-09-19 09:31:32'),
	(81,15,'pname','项目名',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,10,1,0,NULL,'2016-09-19 09:31:32'),
	(80,15,'pid','项目id',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,9,1,0,NULL,'2016-09-19 09:31:32'),
	(79,15,'cityname','城市名',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,8,1,0,NULL,'2016-09-19 09:31:32'),
	(78,15,'cityid','城市id',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,7,1,0,NULL,'2016-09-19 09:31:32'),
	(77,15,'mobile','客户手机号码',120,'varchar','easyui-textbox',1,1,1,1,1,1,'',6,1,0,NULL,'2016-09-19 09:31:32'),
	(76,15,'idcard','客户身份证',120,'varchar','easyui-textbox',1,1,1,1,1,1,'',5,1,0,NULL,'2016-09-19 09:31:32'),
	(75,15,'name','客户姓名',120,'varchar','easyui-textbox',1,1,1,1,1,1,'',4,1,0,NULL,'2016-09-19 09:31:32'),
	(74,15,'parentid','主借人id',120,'int','easyui-textbox',1,1,1,1,1,1,'',3,1,0,NULL,'2016-09-19 09:31:32'),
	(73,15,'source','客户来源',120,'int','easyui-textbox',1,1,1,1,1,1,'',2,1,0,NULL,'2016-09-19 09:31:32'),
	(72,15,'cid','主键客户信息表',120,'int','easyui-textbox',1,1,1,1,0,0,'',1,1,0,NULL,'2016-09-19 09:31:32'),
	(10215,32,'info','简介',120,'varchar','textarea',1,1,1,1,0,1,'',40,1,0,'','2019-08-24 19:13:08'),
	(10216,32,'price','市场价',120,'decimal','easyui-numberspinner',1,1,1,1,1,1,'',50,2,0,'','2019-08-24 19:13:08'),
	(10213,32,'name','奖品名称',120,'varchar','easyui-textbox',1,1,1,1,1,1,'',20,1,0,'','2019-08-24 19:13:08'),
	(10210,31,'createtime','注册时间',120,'datetime','easyui-datebox',1,1,0,0,1,0,'',80,2,0,'','2019-08-23 18:49:31'),
	(10214,32,'pic','图片',120,'varchar','easyui-filebox_img',1,1,1,1,0,1,'',30,1,0,'','2019-08-24 19:13:08'),
	(10228,34,'type','类型',120,'tinyint','easyui-combobox',1,1,1,1,1,1,'select dict_key,dict_value from sys_dict where dict_type=\'card_game_type\'',70,1,0,'','2019-08-24 19:31:13'),
	(10209,31,'level','等级',120,'smallint','easyui-combobox',1,1,1,1,1,0,'select dict_key,dict_value from sys_dict where dict_type=\'card_user_level\' ',70,1,0,'','2019-08-23 18:49:31'),
	(10000,1,'head_id','所属表单',100,'int','easyui-combobox',1,1,1,1,1,0,'select id, form_name from zcurd_head',1,1,0,NULL,'2016-09-27 16:06:53'),
	(3,1,'btn_name','按钮名称',80,'varchar','easyui-textbox',1,1,1,1,0,0,'',2,1,0,NULL,'2016-01-12 13:58:48'),
	(35,6,'create_time','创建时间',120,'timestamp','easyui-datebox',0,0,0,0,0,0,'',6,1,0,NULL,'2016-02-26 15:55:58'),
	(25,5,'id','id',120,'int','easyui-numberspinner',1,1,1,1,0,0,'',0,1,0,NULL,'2016-02-15 08:35:56'),
	(29,5,'method_name','后台method名称',120,'varchar','easyui-textbox',1,1,1,1,0,1,'',4,1,0,NULL,'2016-02-15 08:35:56'),
	(195,15,'overfueremark','逾期记录',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,124,1,0,NULL,'2016-09-19 09:31:32'),
	(196,15,'cheLoanMoney','cheLoanMoney',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,125,1,0,NULL,'2016-09-19 09:31:32'),
	(197,15,'houseLoanMoney','houseLoanMoney',120,'int','easyui-textbox',1,1,1,1,0,1,NULL,126,1,0,NULL,'2016-09-19 09:31:32'),
	(10001,2,'sql_content','扩展sql',120,'varchar','textarea',1,1,1,1,0,1,'',3,1,0,NULL,'2016-11-20 08:08:05'),
	(9,2,'head_id','所属表单',120,'int','easyui-combobox',1,1,1,1,1,0,'select id, form_name from zcurd_head',1,1,0,NULL,'2016-01-13 07:35:01'),
	(10004,18,'url','图片地址',120,'varchar','easyui-filebox_img',1,1,1,1,0,0,'',3,1,0,NULL,'2016-12-20 16:17:53'),
	(10005,18,'create_time','创建时间',120,'timestamp','easyui-datebox',1,1,0,0,0,0,'',4,1,0,NULL,'2016-12-20 16:17:53'),
	(10003,18,'name','图片名称',120,'varchar','easyui-textbox',1,1,1,1,1,0,'',2,1,0,NULL,'2016-12-20 16:17:53'),
	(10002,18,'id','id',120,'int unsigned','easyui-textbox',1,1,1,1,0,0,'',1,1,0,NULL,'2016-12-20 16:17:53'),
	(10212,32,'id','id',120,'int unsigned','easyui-textbox',1,0,0,0,0,0,'',1,1,0,'','2019-08-24 19:13:08'),
	(10208,31,'phone','手机号码',120,'varchar','easyui-textbox',1,1,1,1,1,0,'',60,1,0,'','2019-08-23 18:49:31'),
	(10038,1,'btn_icon','按钮图标',80,'varchar','easyui-textbox',1,1,1,1,0,0,'',3,1,0,NULL,'2017-01-28 07:38:07'),
	(10044,23,'create_user_id','创建人',120,'int','easyui-numberspinner',0,1,0,0,0,1,'',10,1,0,'${user.id}','2017-03-05 08:10:22'),
	(10047,23,'status','状态',80,'int','easyui-combobox',1,1,1,1,1,1,'select dict_key, dict_value from sys_dict where dict_type=\'task_statu\'',9,1,0,'2','2017-03-05 08:10:22'),
	(10046,23,'last_run_time_cost','上次执行耗时',90,'int','easyui-numberspinner',1,1,0,0,0,1,'',8,1,0,'','2017-03-05 08:10:22'),
	(10045,23,'last_run_time','上次执行时间',120,'datetime','easyui-datebox',1,1,0,0,0,1,'',7,1,0,'','2017-03-05 08:10:22'),
	(10049,23,'last_run_result','上次执行结果',90,NULL,'easyui-textbox',1,1,0,0,0,1,'',5,1,0,'','2017-03-13 15:52:52'),
	(10043,23,'cron','cron表达式',100,'varchar','easyui-textbox',1,1,1,1,0,0,'',4,1,0,'','2017-03-05 08:10:22'),
	(10040,23,'name','名称',120,'varchar','easyui-textbox',1,1,1,1,1,0,'',1,1,0,'','2017-03-05 08:10:22'),
	(10041,23,'target_type','任务类型',70,'int','easyui-combobox',1,1,1,1,1,0,'select dict_key, dict_value from sys_dict where dict_type=\'task_type\'',2,1,0,'','2017-03-05 08:10:22'),
	(10042,23,'target_value','任务值',140,'varchar','easyui-textbox',1,1,1,1,0,0,'',3,1,0,'','2017-03-05 08:10:22'),
	(10039,23,'id','id',120,'int','easyui-numberspinner',1,1,1,1,0,0,'',0,1,0,'','2017-03-05 08:10:22'),
	(10048,23,'create_time','创建时间',120,'timestamp','easyui-datebox',1,1,0,0,0,1,'',10,1,0,'','2017-03-05 08:10:22'),
	(10050,24,'id','id',120,'int','easyui-numberspinner',1,1,0,0,0,0,'',1,1,0,'','2017-03-15 16:07:20'),
	(10051,24,'task_id','所属任务',120,'int','easyui-combobox',1,1,0,0,1,1,'select id, name from task_base',2,1,0,'','2017-03-15 16:07:20'),
	(10052,24,'result','执行结果',80,'varchar','easyui-textbox',1,1,0,0,0,1,'',3,1,0,'','2017-03-15 16:07:20'),
	(10053,24,'start_time','开始时间',130,'datetime','easyui-datebox',1,1,0,0,0,1,'',4,1,0,'','2017-03-15 16:07:20'),
	(10054,24,'end_time','结束时间',130,'datetime','easyui-datebox',0,1,0,0,0,1,'',5,1,0,'','2017-03-15 16:07:20'),
	(10055,24,'cost_time','耗时(毫秒)',80,'int','easyui-numberspinner',1,1,0,0,0,1,'',6,1,0,'','2017-03-15 16:07:20'),
	(10056,24,'remark','备注',120,'varchar','easyui-textbox',1,1,0,0,0,1,'',7,1,0,'','2017-03-15 16:07:20'),
	(10227,34,'endtime','结束时间',120,'datetime','easyui-datetimebox',1,1,1,1,0,1,'',60,1,0,'','2019-08-24 19:31:13'),
	(10226,34,'starttime','开始时间',120,'datetime','easyui-datetimebox',1,1,1,1,1,1,'',50,2,0,'','2019-08-24 19:31:13'),
	(10224,34,'info','活动简介',120,'varchar','textarea',0,1,1,1,0,1,'',30,1,0,'','2019-08-24 19:31:13'),
	(10223,34,'title','活动主题',120,'varchar','easyui-textbox',1,1,1,1,1,1,'',20,1,0,'','2019-08-24 19:31:13'),
	(10222,34,'id','id',120,'int unsigned','easyui-textbox',1,0,0,0,0,0,'',1,1,0,'','2019-08-24 19:31:13'),
	(10237,36,'goal_times','最大中奖次数（0为不限）',120,'smallint','easyui-numberspinner',1,1,1,1,0,0,'',50,1,0,'0','2019-09-03 02:31:09'),
	(10236,36,'enter_times','可抽奖次数（0为不限）',120,'smallint','easyui-numberspinner',1,1,1,1,0,0,'',40,1,0,'0','2019-09-03 02:31:09'),
	(10234,36,'gameid','活动',120,'int unsigned','easyui-combobox',1,1,0,0,0,0,'select id,title from card_game',20,1,0,'','2019-09-03 02:31:09'),
	(10235,36,'userlevel','会员等级',120,'smallint','easyui-combobox',1,1,1,1,0,0,'select dict_key,dict_value from sys_dict where dict_type=\'card_user_level\' ',30,1,0,'','2019-09-03 02:31:09'),
	(10232,35,'amount','数量',120,'smallint','easyui-numberspinner',1,1,1,1,0,0,'',40,1,0,'','2019-08-25 05:02:57'),
	(10231,35,'productid','奖品',120,'int','easyui-combobox',1,1,1,1,0,0,'select id,name from card_product',30,1,0,'','2019-08-25 05:02:57'),
	(10230,35,'gameid','活动',120,'int','easyui-combobox',1,1,1,1,0,0,'select id,title from card_game',20,1,0,'','2019-08-25 05:02:57'),
	(10229,35,'id','id',120,'int unsigned','easyui-textbox',0,0,0,0,0,0,'',1,1,0,'','2019-08-25 05:02:57'),
	(10207,31,'idcard','身份证号',120,'varchar','easyui-textbox',1,1,1,1,1,0,'',50,1,0,'','2019-08-23 18:49:31'),
	(10206,31,'realname','姓名',120,'varchar','easyui-textbox',1,1,1,1,1,1,'',40,1,0,'','2019-08-23 18:49:31'),
	(10205,31,'passwd','密码',120,'varchar','easyui-textbox',0,0,1,0,0,0,'',30,1,0,'','2019-08-23 18:49:31'),
	(10233,36,'id','id',120,'int','easyui-numberspinner',1,1,0,0,0,0,'',1,1,0,'','2019-09-03 02:31:09'),
	(10204,31,'uname','用户名',120,'varchar','easyui-textbox',1,1,1,1,1,0,'',20,1,0,'','2019-08-23 18:49:31'),
	(10203,31,'id','id',120,'int unsigned','easyui-textbox',1,0,0,0,0,0,'',1,1,0,'','2019-08-23 18:49:31'),
	(10272,39,'hit','已抽中',120,'bigint','easyui-numberspinner',1,1,1,1,0,1,'',80,1,1,'','2019-09-11 12:33:17'),
	(10265,38,'hittime','中奖时间',120,'datetime','easyui-datebox',1,1,1,1,1,1,'',150,2,0,'','2019-09-11 06:55:11'),
	(10264,38,'productid','奖品id',120,'int unsigned','easyui-textbox',0,1,1,1,0,1,'',140,1,0,'','2019-09-11 06:55:11'),
	(10263,38,'userid','用户id',120,'int unsigned','easyui-textbox',0,1,1,1,0,1,'',130,1,0,'','2019-09-11 06:55:11'),
	(10262,38,'gameid','活动id',120,'int unsigned','easyui-textbox',0,1,1,1,0,1,'',120,1,0,'','2019-09-11 06:55:11'),
	(10260,38,'name','奖品名称',120,'varchar','easyui-textbox',1,1,1,1,1,1,'',100,1,0,'','2019-09-11 06:55:11'),
	(10261,38,'price','市场价',120,'decimal','easyui-textbox',1,1,1,1,0,1,'',110,1,0,'','2019-09-11 06:55:11'),
	(10259,38,'level','会员等级',120,'varchar','easyui-textbox',1,1,1,1,0,0,'',90,1,0,'','2019-09-11 06:55:11'),
	(10258,38,'phone','手机号码',120,'varchar','easyui-textbox',1,1,1,1,1,0,'',80,1,0,'','2019-09-11 06:55:11'),
	(10257,38,'idcard','身份证号',120,'varchar','easyui-textbox',1,1,1,1,0,0,'',70,1,0,'','2019-09-11 06:55:11'),
	(10256,38,'realname','姓名',120,'varchar','easyui-textbox',1,1,1,1,0,1,'',60,1,0,'','2019-09-11 06:55:11'),
	(10253,38,'title','活动主题',120,'varchar','easyui-textbox',1,1,1,1,1,0,'',30,1,0,'','2019-09-11 06:55:11'),
	(10255,38,'uname','用户名',120,'varchar','easyui-textbox',1,1,1,1,1,0,'',50,1,0,'','2019-09-11 06:55:11'),
	(10254,38,'type','活动类型',120,'varchar','easyui-textbox',1,1,1,1,0,0,'',40,1,0,'','2019-09-11 06:55:11'),
	(10252,38,'id','id',120,'int unsigned','easyui-textbox',1,1,1,1,0,0,'',20,1,0,'','2019-09-11 06:55:11'),
	(10271,39,'total','总奖品数',120,'decimal','easyui-textbox',1,1,1,1,0,1,'',70,1,1,'','2019-09-11 12:33:17'),
	(10269,39,'endtime','结束时间',150,'datetime','easyui-datebox',1,1,1,1,0,0,'',50,1,0,'','2019-09-11 12:33:17'),
	(10270,39,'type','活动类型',120,'varchar','easyui-textbox',1,1,1,1,0,0,'',60,1,0,'','2019-09-11 12:33:17'),
	(10268,39,'starttime','开始时间',150,'datetime','easyui-datebox',1,1,1,1,1,0,'',40,2,0,'','2019-09-11 12:33:17'),
	(10266,39,'id','id',120,'int unsigned','easyui-textbox',0,0,0,0,0,0,'',20,1,0,'','2019-09-11 12:33:17'),
	(10267,39,'title','活动主题',120,'varchar','easyui-textbox',1,1,1,1,1,0,'',30,1,0,'','2019-09-11 12:33:17'),
	(10278,40,'type','类型',120,'tinyint','easyui-numberspinner',1,1,1,1,0,1,'select dict_key,dict_value from sys_dict where dict_type=\'card_game_type\'',60,1,0,'','2019-09-11 21:28:53'),
	(10277,40,'endtime','结束时间',120,'datetime','easyui-datebox',1,1,1,1,1,0,'',50,2,0,'','2019-09-11 21:28:53'),
	(10276,40,'starttime','开始时间',120,'datetime','easyui-datebox',1,1,1,1,1,0,'',40,2,0,'','2019-09-11 21:28:53'),
	(10273,40,'id','id',120,'int unsigned','easyui-textbox',1,1,1,1,0,0,'',1,1,0,'','2019-09-11 21:28:53'),
	(10274,40,'title','活动主题',120,'varchar','easyui-textbox',1,1,1,1,1,0,'',20,1,0,'','2019-09-11 21:28:53'),
	(10275,40,'info','活动简介',120,'varchar','easyui-textbox',1,1,1,1,0,1,'',30,1,0,'','2019-09-11 21:28:53'),
	(10280,34,'pic','宣传图',120,NULL,'easyui-filebox_img',0,1,1,1,0,0,'',25,1,0,'','2019-10-15 18:36:29'),
	(10211,31,'updatetime','更新时间',120,'datetime','easyui-datebox',1,1,0,0,0,0,'',90,1,0,'','2019-08-23 18:49:31'),
	(10281,31,'pic','头像',120,NULL,'easyui-filebox_img',1,1,1,1,0,0,'',35,1,0,'','2019-10-19 00:46:26'),
	(10282,41,'id','id',120,'int unsigned','easyui-textbox',1,1,1,1,0,0,NULL,1,1,0,NULL,'2019-11-15 16:20:34'),
	(10283,41,'title','活动主题',120,'varchar','easyui-textbox',1,1,1,1,0,0,NULL,20,1,0,NULL,'2019-11-15 16:20:34'),
	(10284,41,'pic','活动宣传图',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,30,1,0,NULL,'2019-11-15 16:20:34'),
	(10285,41,'info','活动简介',120,'varchar','easyui-textbox',1,1,1,1,0,1,NULL,40,1,0,NULL,'2019-11-15 16:20:34'),
	(10286,41,'starttime','开始时间',120,'datetime','easyui-datebox',1,1,1,1,0,0,NULL,50,1,0,NULL,'2019-11-15 16:20:34'),
	(10287,41,'endtime','结束时间',120,'datetime','easyui-datebox',1,1,1,1,0,0,NULL,60,1,0,NULL,'2019-11-15 16:20:34'),
	(10288,41,'type','类型（1=概率类，2=随机类）',120,'tinyint','easyui-numberspinner',1,1,1,1,0,1,NULL,70,1,0,NULL,'2019-11-15 16:20:34'),
	(10289,41,'status','状态（0=新建，1=已加载）',120,'bit','easyui-textbox',1,1,1,1,0,0,NULL,80,1,0,NULL,'2019-11-15 16:20:34'),
	(10290,36,'random_rate','中奖概率（0-100，概率类有效）',120,NULL,'easyui-numberspinner',1,1,1,1,0,0,'',60,2,0,'100','2020-09-07 14:06:49');

/*!40000 ALTER TABLE `zcurd_field` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 zcurd_head
# ------------------------------------------------------------

DROP TABLE IF EXISTS `zcurd_head`;

CREATE TABLE `zcurd_head` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) DEFAULT NULL COMMENT '数据库表名',
  `form_name` varchar(100) DEFAULT NULL COMMENT '表单名称',
  `id_field` varchar(50) DEFAULT 'id' COMMENT '主键字段',
  `is_auto` int(11) DEFAULT '1' COMMENT '是否自增',
  `form_type` int(11) DEFAULT '1' COMMENT '表单类型（1:单表,2:主从）',
  `dialog_size` varchar(50) NOT NULL DEFAULT '600x400' COMMENT '弹窗大小',
  `db_source` varchar(50) DEFAULT NULL COMMENT '数据源',
  `handle_class` varchar(100) DEFAULT NULL COMMENT '处理类',
  `delete_flag_field` varchar(50) DEFAULT NULL COMMENT '删除标志字段',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='在线表单';

LOCK TABLES `zcurd_head` WRITE;
/*!40000 ALTER TABLE `zcurd_head` DISABLE KEYS */;

INSERT INTO `zcurd_head` (`id`, `table_name`, `form_name`, `id_field`, `is_auto`, `form_type`, `dialog_size`, `db_source`, `handle_class`, `delete_flag_field`, `create_time`)
VALUES
	(1,'zcurd_head_btn','表单扩展按钮','id',1,1,'600x400','zcurd_base','com.zcurd.common.handler.FlushFormCurdHandle',NULL,'2016-01-12 13:58:48'),
	(2,'zcurd_head_js','表单扩展js','id',1,1,'600x400','zcurd_base','com.zcurd.common.handler.FlushFormCurdHandle',NULL,'2016-01-13 07:35:01'),
	(5,'sys_menu_btn','菜单按钮（权限编辑）','id',1,1,'400x300','zcurd_base',NULL,NULL,'2016-02-15 08:35:56'),
	(6,'sys_menu_datarule','菜单数据（权限编辑）','id',1,1,'400x300','zcurd_base',NULL,NULL,'2016-02-26 15:55:58'),
	(7,'sys_dict','数据字典','id',1,1,'400x300','zcurd_base',NULL,NULL,'2016-03-01 20:39:14'),
	(8,'sys_role','角色管理','id',1,1,'400x300','zcurd_base',NULL,NULL,'2016-02-12 17:58:39'),
	(18,'images','图片管理','id',1,1,'600x400','zcurd_busi',NULL,NULL,'2016-12-20 16:17:53'),
	(12,'sys_user','用户管理','id',1,1,'400x300','zcurd_base','com.zcurd.common.handler.PasswordCurdHandle',NULL,'2016-01-08 13:31:45'),
	(15,'customer','客户管理','cid',1,1,'800x600','zcurd_busi',NULL,NULL,'2016-09-19 09:31:32'),
	(33,'sys_dict','会员等级管理','id',1,1,'600x400','zcurd_base',NULL,NULL,'2019-08-24 19:26:02'),
	(34,'card_game','活动配置','id',1,1,'600x400','zcurd_busi',NULL,NULL,'2019-08-24 19:31:13'),
	(35,'card_game_product','配置奖品','id',1,1,'400x200','zcurd_busi',NULL,NULL,'2019-08-25 05:02:57'),
	(32,'card_product','奖品管理','id',1,1,'600x400','zcurd_busi',NULL,NULL,'2019-08-24 19:13:08'),
	(23,'task_base','定时任务','id',1,1,'600x400','zcurd_base',NULL,NULL,'2017-03-05 08:10:22'),
	(24,'task_log','定时任务-日志','id',1,1,'600x400','zcurd_base',NULL,NULL,'2017-03-15 16:07:20'),
	(31,'card_user','会员信息','id',1,1,'600x450','zcurd_busi',NULL,NULL,'2019-08-23 18:49:31'),
	(36,'card_game_rules','活动策略','id',1,1,'600x400','zcurd_busi',NULL,NULL,'2019-09-03 02:31:09'),
	(38,'view_card_user_hit','中奖列表','id',1,1,'600x400','zcurd_busi',NULL,NULL,'2019-09-11 06:55:11'),
	(39,'view_game_curinfo','中奖统计','id',1,1,'600x400','zcurd_busi',NULL,NULL,'2019-09-11 12:33:17'),
	(40,'card_game','历史活动','id',1,1,'600x600','zcurd_busi',NULL,NULL,'2019-09-11 21:28:53'),
	(41,'card_game','','id',1,1,'600x400','zcurd_busi',NULL,NULL,'2019-11-15 16:20:34');

/*!40000 ALTER TABLE `zcurd_head` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 zcurd_head_btn
# ------------------------------------------------------------

DROP TABLE IF EXISTS `zcurd_head_btn`;

CREATE TABLE `zcurd_head_btn` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `head_id` int(11) DEFAULT NULL COMMENT '所属表单',
  `btn_name` varchar(50) DEFAULT NULL COMMENT '按钮名称',
  `btn_icon` varchar(50) DEFAULT NULL COMMENT '按钮图标',
  `location` int(11) DEFAULT '1' COMMENT '按钮位置（1：顶部，2：行内）',
  `action` int(11) DEFAULT '1' COMMENT '行为（0：无，1：打开子页面）',
  `func_content` text COMMENT '方法内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='表单按钮';

LOCK TABLES `zcurd_head_btn` WRITE;
/*!40000 ALTER TABLE `zcurd_head_btn` DISABLE KEYS */;

INSERT INTO `zcurd_head_btn` (`id`, `head_id`, `btn_name`, `btn_icon`, `location`, `action`, `func_content`, `create_time`)
VALUES
	(1,8,'权限设置',NULL,2,1,'function(index) {\r\n var row = datagrid.datagrid(\"getRows\")[index];\r\n  //var url = basePath + \"/zcurd/135/listPage?riskgradeid=\" + row.id;\r\n var url = basePath + \"/role/editAuthPage?roleId=\" + row.id;\r\n _openSubPage(url);\r\n}','2016-02-13 13:23:10'),
	(2,134,'管理',NULL,2,1,'function(index) {\n var row = datagrid.datagrid(\"getRows\")[index];\n  var url = basePath + \"/zcurd/135/listPage?riskgradeid=\" + row.id;\n _openSubPage(url);\n}','2016-01-13 05:28:50'),
	(3,133,'测试',NULL,2,0,'function(){}','2016-01-14 01:30:35'),
	(4,12,'重置密码','glyphicon-repeat',1,0,'function() {\n    var rowsSel = datagrid.datagrid(\"getSelections\");\n	if(rowsSel.length != 1) {\n		showWarnMsg(\"请选择需要重置密码的一条数据！\");\n		return;\n	}\n	confirmMsg(\"确认重置密码？\", function() {\n		var id = rowsSel[0].id;\n		$.post(basePath + \"/user/resetPassword\", {id: id}, function() {\n			showMsg(\"密码重置成功！\");\n		});\n	});\n}','2017-01-28 05:44:37'),
	(5,23,'停止','xx',2,0,'function() {\n\n}','2017-03-13 15:12:56'),
	(6,22,'aaabbbcc','aaa',1,0,'function() {}','2017-04-12 16:46:35'),
	(7,30,'测试按钮',NULL,1,0,'alert(1);','2019-08-23 03:49:40'),
	(8,18,'测试按钮','1',1,0,'function btnClick8(a){\n	var ids = [];\n	$.each(datagrid.datagrid(\"getSelections\"), function(i, item) {\n		ids.push(item.id);\n	});\n	if(ids.length < 1) {\n		showWarnMsg(\"请选择需要删除的数据！\");\n		return;\n	}\n	confirmMsg(\"确认删除？\", function() {\n		showWarnMsg(\"删什么删？只是个测试按钮\"+ids);\n	});\n\n}','2019-08-23 03:52:00'),
	(9,34,'奖品配置','glyphicon-export',2,1,'function(index){\nvar row = datagrid.datagrid(\"getRows\")[index];\n \n var url = basePath + \"/gameproduct/listPage?gameid=\" + \n  row.id;\n _openSubPage(url);\n\n}','2019-08-25 06:13:50'),
	(10,34,'策略配置','glyphicon-pencil',2,1,'function(index){\nvar row = datagrid.datagrid(\"getRows\")[index];\n \n var url = basePath + \"/gamerules/listPage?gameid=\" + \n  row.id;\n _openSubPage(url);\n\n}','2019-09-03 02:54:32');

/*!40000 ALTER TABLE `zcurd_head_btn` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 zcurd_head_js
# ------------------------------------------------------------

DROP TABLE IF EXISTS `zcurd_head_js`;

CREATE TABLE `zcurd_head_js` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `head_id` int(11) DEFAULT NULL COMMENT '所属表单',
  `page` varchar(50) DEFAULT NULL COMMENT '页面',
  `sql_content` varchar(2000) DEFAULT NULL COMMENT '扩展sql',
  `js_content` text COMMENT '扩展js',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='表单扩展js';

LOCK TABLES `zcurd_head_js` WRITE;
/*!40000 ALTER TABLE `zcurd_head_js` DISABLE KEYS */;

INSERT INTO `zcurd_head_js` (`id`, `head_id`, `page`, `sql_content`, `js_content`, `create_time`)
VALUES
	(1,134,'list',NULL,'var operateWidth = 80;\r\nvar subPageWidth = \"50%\";\r\nvar subPageTitle = \"等级详情\";\r\ndgOptions.singleSelect=true;','2016-01-13 08:25:45'),
	(2,5,'list',NULL,'$(\"#searchBtnWrap\").hide();\n$(\".wrap_search\").hide();\ndgOptions.pageSize=1000;\ndgOptions.pagination=false;\n\nwindow.parent.getDgSelections = function() {\n    return datagrid.datagrid(\"getSelections\");\n}\n\ndgOptions.onLoadSuccess = selectAuthRow;\nfunction selectAuthRow() {\n  	var btnIds = window.parent.getCurrMenuBtns();\n 	var rows = datagrid.datagrid(\"getData\").rows;\n 	if(btnIds && rows.length > 0) {\n   		$.each(rows, function(i, item) {\n      		$.each(btnIds, function(j, btnId) {\n	       		if(item.id == btnId) {\n	          		datagrid.datagrid(\"selectRow\", i);\n	        	}\n     		});\n   		});\n 	}\n\n 	//如果无数据，则显示一键生成\n	if(rows.length == 0) {\n		genAuthBtnBatch();\n	}\n}\n\n//显示一键生成\nfunction genAuthBtnBatch() {\n	$(\"<button id=\'genAuthBtnBatchBtn\' style=\'position: fixed; top: 120px; left: 50%; margin-left: -30px; padding: 2px;\'>一键生成<button>\")\n	.linkbutton().click(function() {\n		$.post(\"../../role/genAuthBtnBatch\", {menuId: $(\"#menu_id\").val()}, function() {\n			$(\"#genAuthBtnBatchBtn\").remove();\n			showMsg(\"生成成功！\");\n			datagrid.datagrid(\"reload\");\n		});\n	}).appendTo(\"body\");\n}','2016-02-16 03:13:14'),
	(3,8,'list',NULL,'var operateWidth = 80;\nvar subPageWidth = \"55%\";\nvar subPageTitle = \"权限设置\";\ndgOptions.singleSelect=true;\n\nif(noAuthBtn.indexOf(\"operate\") != -1) {\n    $.each(dgOptions.columns[0], function(i, item) {\n        if(item. field == \'operate\') {\n            item. hidden = true;\n        }\n    });\n}','2016-02-17 08:32:31'),
	(4,131,'update',NULL,'$(function() {\n  changeComboboxToMult(\"roles\");\n});','2016-02-24 15:09:57'),
	(5,12,'add',NULL,'$(function() {\n changeComboboxToMult(\"roles\");\n});','2016-02-24 15:10:03'),
	(6,152,'list',NULL,'$(\"#searchBtnWrap\").hide();\n$(\".wrap_search\").hide();\ndgOptions.pageSize=1000;\ndgOptions.pagination=false;\n\nwindow.parent.getDgSelections2 = function() {\n    return datagrid.datagrid(\"getSelections\");\n}\n\ndgOptions.onLoadSuccess = selectAuthRow;\nfunction selectAuthRow() {\n var dataruleIds = window.parent.getCurrMenuDatarules();\n var rows = datagrid.datagrid(\"getData\").rows;\n if(dataruleIds && rows.length > 0) {\n    $.each(rows, function(i, item) {\n      $.each(dataruleIds, function(j, dataruleId) {\n       if(item.id == dataruleId) {\n         datagrid.datagrid(\"selectRow\", i);\n        }\n     });\n   });\n }\n}','2016-02-16 03:13:14'),
	(7,6,'list',NULL,'$(\"#searchBtnWrap\").hide();\n$(\".wrap_search\").hide();\ndgOptions.pageSize=1000;\ndgOptions.pagination=false;\n\nwindow.parent.getDgSelections2 = function() {\n    return datagrid.datagrid(\"getSelections\");\n}\n\ndgOptions.onLoadSuccess = selectAuthRow;\nfunction selectAuthRow() {\n	var dataruleIds = window.parent.getCurrMenuDatarules();\n	var rows = datagrid.datagrid(\"getData\").rows;\n	if(dataruleIds && rows.length > 0) {\n		$.each(rows, function(i, item) {\n			$.each(dataruleIds, function(j, dataruleId) {\n				if(item.id == dataruleId) {\n					datagrid.datagrid(\"selectRow\", i);\n				}\n			});\n		});\n	}\n}','2016-09-27 16:17:56'),
	(8,12,'update,detail',NULL,'$(function() {\n changeComboboxToMult(\"roles\");\n});','2016-09-27 16:40:00'),
	(13,6,'update,add',NULL,'$(\"#value_label\").html(\"<a class=\'symbol_var\' title=\'支持变量\'>$</a>\" + $(\"#value_label\").html())','2017-02-26 16:39:55'),
	(9,2,'update,add',NULL,'$(function() {\n changeComboboxToMult(\"page\");\n});','2016-11-20 11:52:45'),
	(14,24,'list',NULL,'$(\"#searchBtnWrap\").hide();\n$(\".wrap_search\").hide();\n\n$(\"#tb\").remove();','2017-03-16 15:59:42'),
	(15,18,'list',NULL,'function btnClick8(a){\n\nalert(1);\n\n}','2019-08-23 03:53:07');

/*!40000 ALTER TABLE `zcurd_head_js` ENABLE KEYS */;
UNLOCK TABLES;


# 导出视图 view_game_productnum
# ------------------------------------------------------------

DROP TABLE IF EXISTS `view_game_productnum`; DROP VIEW IF EXISTS `view_game_productnum`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `view_game_productnum`
AS SELECT
   `card_game_product`.`gameid` AS `gameid`,sum(`card_game_product`.`amount`) AS `num`
FROM `card_game_product` group by `card_game_product`.`gameid`;

# 导出视图 view_game_hitnum
# ------------------------------------------------------------

DROP TABLE IF EXISTS `view_game_hitnum`; DROP VIEW IF EXISTS `view_game_hitnum`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `view_game_hitnum`
AS SELECT
   `card_user_hit`.`gameid` AS `gameid`,count(`card_user_hit`.`id`) AS `num`
FROM `card_user_hit` group by `card_user_hit`.`gameid`;


# 导出视图 view_game_curinfo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `view_game_curinfo`; DROP VIEW IF EXISTS `view_game_curinfo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `view_game_curinfo`
AS SELECT
   `g`.`id` AS `id`,
   `g`.`title` AS `title`,
   `g`.`starttime` AS `starttime`,
   `g`.`endtime` AS `endtime`,
   `sd2`.`dict_value` AS `type`,
   `cgp`.`num` AS `total`,
   `h`.`num` AS `hit`
FROM (((`card_game` `g` left join `view_game_productnum` `cgp` on((`g`.`id` = `cgp`.`gameid`))) left join `view_game_hitnum` `h` on((`g`.`id` = `h`.`gameid`))) join `sys_dict` `sd2` on(((`g`.`type` = `sd2`.`dict_key`) and (`sd2`.`dict_type` = 'card_game_type'))));



# 导出视图 view_card_user_hit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `view_card_user_hit`; DROP VIEW IF EXISTS `view_card_user_hit`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `view_card_user_hit`
AS SELECT
   `h`.`id` AS `id`,
   `g`.`title` AS `title`,
   `sd2`.`dict_value` AS `type`,
   `u`.`uname` AS `uname`,
   `u`.`realname` AS `realname`,
   `u`.`idcard` AS `idcard`,
   `u`.`phone` AS `phone`,
   `sd1`.`dict_value` AS `level`,
   `p`.`name` AS `name`,
   `p`.`price` AS `price`,
   `h`.`gameid` AS `gameid`,
   `h`.`userid` AS `userid`,
   `h`.`productid` AS `productid`,
   `h`.`hittime` AS `hittime`
FROM (((((`card_game` `g` join `card_product` `p`) join `card_user` `u`) join `card_user_hit` `h`) join `sys_dict` `sd1` on(((`u`.`level` = `sd1`.`dict_key`) and (`sd1`.`dict_type` = 'card_user_level')))) join `sys_dict` `sd2` on(((`g`.`type` = `sd2`.`dict_key`) and (`sd2`.`dict_type` = 'card_game_type')))) where ((`h`.`gameid` = `g`.`id`) and (`h`.`userid` = `u`.`id`) and (`h`.`productid` = `p`.`id`)) order by `h`.`hittime` desc;


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
