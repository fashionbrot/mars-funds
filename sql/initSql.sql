
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户名',
  `real_name` varchar(20) NOT NULL COMMENT '真实姓名',
  `password` varchar(32) NOT NULL COMMENT '加密密码',
  `salt` varchar(32) NOT NULL COMMENT '密码加盐参数',
  `status` tinyint(2) NOT NULL COMMENT '用户状态',
  `super_admin` tinyint(1) DEFAULT '0' COMMENT '是否是超级管理员 1超级 0普通',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_id` bigint(11) NOT NULL COMMENT '创建者id',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_id` bigint(11) DEFAULT NULL COMMENT '最近更新者id',
  `update_date` datetime DEFAULT NULL COMMENT '最近更新时间',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '删除标志位 1删除 0未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='用户信息表';
ALTER TABLE user_info ADD INDEX index_del_flag (del_flag);


DROP TABLE IF EXISTS `role_info`;
CREATE TABLE `role_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `role_code` varchar(30) NOT NULL COMMENT '角色标识',
  `role_name` varchar(30) NOT NULL COMMENT '角色描述',
  `status` int(2) NOT NULL COMMENT '权限状态',
  `create_id` bigint(11) NOT NULL COMMENT '创建者id',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_id` bigint(11) DEFAULT NULL COMMENT '最近更新者id',
  `update_date` datetime DEFAULT NULL COMMENT '最近更新时间',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '删除标志位 1删除 0未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';
ALTER TABLE role_info ADD INDEX index_del_flag (del_flag);


DROP TABLE IF EXISTS `user_role_relation`;
CREATE TABLE `user_role_relation` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `create_id` bigint(11) NOT NULL COMMENT '创建者id',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_id` bigint(11) DEFAULT NULL COMMENT '最近更新者id',
  `update_date` datetime DEFAULT NULL COMMENT '最近更新时间',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '删除标志位 1删除 0未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-角色关系表';
ALTER TABLE user_role_relation ADD INDEX index_del_flag (del_flag);


DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `menu_name` varchar(16) NOT NULL COMMENT '菜单名称',
  `menu_level` int(3) unsigned NOT NULL COMMENT '菜单级别',
  `menu_url` varchar(255) DEFAULT NULL COMMENT '菜单url',
  `parent_menu_id` bigint(11) unsigned DEFAULT '0' COMMENT '父菜单id',
  `priority` int(5) unsigned NOT NULL COMMENT '显示优先级',
  `code` varchar(64) DEFAULT NULL COMMENT '权限code',
  `create_id` bigint(11) DEFAULT NULL COMMENT '创建者id',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_id` bigint(11) DEFAULT NULL COMMENT '最近更新者id',
  `update_date` datetime DEFAULT NULL COMMENT '最近更新时间',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '删除标志位 1删除 0未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='菜单表';
ALTER TABLE menu ADD INDEX index_del_flag (del_flag);


DROP TABLE IF EXISTS `menu_role_relation`;
CREATE TABLE `menu_role_relation` (
  `menu_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `create_id` bigint(11) NOT NULL COMMENT '创建者id',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_id` bigint(11) DEFAULT NULL COMMENT '最近更新者id',
  `update_date` datetime DEFAULT NULL COMMENT '最近更新时间',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '删除标志位 1删除 0未删除',
  PRIMARY KEY (`id`),
  KEY `idx_role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单-角色关系表';
ALTER TABLE menu_role_relation ADD INDEX index_del_flag (del_flag);


INSERT INTO `user_info` (`id`, `user_name`, `real_name`, `password`, `salt`, `status`, `super_admin`, `last_login_time`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`) VALUES ('1', 'mars', 'mars', 'f1a65d566b294b8db222cf61b3b28f72', '3bb81260d3941f5818e72dff4b1342f8', '1', '1', NULL, '1', '2020-09-11 23:40:18', NULL, NULL, '0');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('1', '用户管理', '1', '', '0', '100', NULL, '2019-12-08 13:29:27', '1', '2020-09-12 21:19:14', '0', NULL);
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('2', '用户列表', '2', '/user/index', '1', '101', NULL, '2019-12-08 13:29:49', '1', '2020-09-12 21:19:23', '0', NULL);
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('13', '用户列表-修改密码', '3', '', '2', '102', '1', '2020-09-12 21:43:55', NULL, NULL, '0', 'user:reset:pwd');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('14', '用户列表-新增用户', '3', '', '2', '103', '1', '2020-09-12 21:45:05', NULL, NULL, '0', 'user:list:add');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('15', '用户列表-编辑用户', '3', '', '2', '104', '1', '2020-09-12 21:45:41', NULL, NULL, '0', 'user:list:edit');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('16', '用户列表-删除用户', '3', '', '2', '105', '1', '2020-09-12 21:54:11', NULL, NULL, '0', 'user:list:del');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('17', '用户列表-查看详情', '3', '', '2', '106', '1', '2020-09-12 21:55:55', '1', '2020-09-12 22:39:10', '0', '');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('18', '用户列表-查询全部', '3', '', '2', '107', '1', '2020-09-12 21:56:51', NULL, NULL, '0', 'user:list:list');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('3', '菜单管理', '1', '', '0', '200', NULL, '2019-12-08 14:20:46', '1', '2020-09-12 22:34:12', '0', '');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('4', '菜单列表', '2', '/admin/menu/index', '3', '201', NULL, '2019-12-08 14:21:08', '1', '2020-09-12 22:34:21', '0', '');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('19', '菜单列表-新增', '3', '', '4', '202', '1', '2020-09-12 22:34:05', NULL, NULL, '0', 'menu:list:add');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('20', '菜单列表-编辑', '3', '', '4', '203', '1', '2020-09-12 22:35:35', NULL, NULL, '0', 'menu:list:edit');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('21', '菜单列表-删除', '3', '', '4', '204', '1', '2020-09-12 22:36:17', NULL, NULL, '0', 'menu:list:del');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('22', '菜单列表-查看详情', '3', '', '4', '205', '1', '2020-09-12 22:37:23', NULL, NULL, '0', 'menu:list:info');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('23', '菜单列表-列表', '3', '', '4', '206', '1', '2020-09-12 22:37:59', NULL, NULL, '0', 'menu:list:list');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('8', '权限管理', '1', '', '0', '400', NULL, '2019-12-08 15:56:09', '1', '2020-09-12 23:32:16', '0', '');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('9', '权限列表', '2', '/role/index', '8', '401', NULL, '2019-12-08 15:56:37', '1', '2020-09-12 23:32:21', '0', '');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('34', '权限列表-列表', '3', '', '9', '402', '1', '2020-09-12 23:32:52', NULL, NULL, '0', 'role:list:list');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('35', '权限列表-详情', '3', '', '9', '403', '1', '2020-09-12 23:33:24', NULL, NULL, '0', 'role:list:info');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('36', '权限列表-新增', '3', '', '9', '404', '1', '2020-09-12 23:33:56', NULL, NULL, '0', 'role:list:add');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('37', '权限列表-编辑', '3', '', '9', '405', '1', '2020-09-12 23:34:24', NULL, NULL, '0', 'role:list:edit');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('38', '权限列表-删除', '3', '', '9', '406', '1', '2020-09-12 23:35:00', NULL, NULL, '0', 'role:list:del');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('39', '权限列表-菜单权限', '3', '', '9', '407', '1', '2020-09-12 23:39:59', NULL, NULL, '0', 'role:list:update:menu');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`, `code`) VALUES ('40', '权限列表-动态配置权限', '3', '', '9', '408', '1', '2020-09-12 23:43:09', '1', '2020-09-12 23:43:42', '0', 'role:list:update:role');



DROP TABLE IF EXISTS `fund`;
CREATE TABLE `fund` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `fund_code` varchar(8) NOT NULL COMMENT '基金code',
  `fund_name` varchar(32) NOT NULL COMMENT '基金名称',
  `fund_source_rate` varchar(8) DEFAULT NULL COMMENT '原费率',
  `fund_Rate` varchar(8) DEFAULT NULL COMMENT '现费率',
  `fund_minsg` varchar(8) DEFAULT NULL COMMENT '最小申购金额',
  `equity_return` double(11,2) DEFAULT '0.00' COMMENT '估值',
  `create_id` bigint(11) DEFAULT NULL COMMENT '创建者id',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='基金表';


DROP TABLE IF EXISTS `fund_valuation`;
CREATE TABLE `fund_valuation` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `fund_code` varchar(11) NOT NULL COMMENT '基金code',
  `fund_date` datetime DEFAULT NULL COMMENT '日期',
  `dwjz` varchar(16) DEFAULT NULL COMMENT '单位净值',
  `equity_return` varchar(16) DEFAULT '0.00' COMMENT '估值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='基金估值表';


DROP TABLE IF EXISTS `fund_stock`;
CREATE TABLE `fund_stock` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `fund_code` varchar(8) NOT NULL COMMENT '基金code',
  `stock_code` varchar(8) NOT NULL COMMENT '股票code',
  `stock_name` varchar(32) DEFAULT NULL COMMENT '股票名称',
  `create_id` bigint(11) DEFAULT NULL COMMENT '创建者id',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='基金-持仓股票';


DROP TABLE IF EXISTS `fund_hold`;
CREATE TABLE `fund_hold` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `fund_code` varchar(8) NOT NULL COMMENT '基金code',
  `fund_name` varchar(32) DEFAULT NULL COMMENT '基金名称',
  `user_name` varchar(8) DEFAULT NULL COMMENT '用户',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户持仓基金';


INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `code`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`) VALUES ('41', '基金管理', '1', '', '0', '10000', '', '1', '2020-12-07 16:06:46', NULL, NULL, '0');
INSERT INTO `menu` (`id`, `menu_name`, `menu_level`, `menu_url`, `parent_menu_id`, `priority`, `code`, `create_id`, `create_date`, `update_id`, `update_date`, `del_flag`) VALUES ('42', '基金列表', '2', '/fund/index', '41', '10001', '', '1', '2020-12-07 16:07:02', NULL, NULL, '0');




INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('1', '110022', '易方达消费行业股票', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('2', '001156', '申万菱信新能源汽车混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('3', '002084', '新华鑫动力灵活配置混合C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('4', '400015', '东方新能源汽车混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('5', '003834', '华夏能源革新股票', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('6', '161028', '富国中证新能源汽车指数分级', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('7', '002190', '农银新能源主题', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('8', '003853', '金鹰信息产业股票A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('9', '160225', '国泰国证新能源汽车指数', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('10', '501057', '汇添富中证新能源汽车A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('11', '005928', '创金合信新能源汽车股票C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('12', '006081', '海富通电子传媒股票A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('13', '006080', '海富通电子传媒股票C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('14', '007346', '易方达科技创新混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('15', '008086', '华夏中证5G通信主题ETF联接A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('16', '008087', '华夏中证5G通信主题ETF联接C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('17', '007844', '华宝标普油气上游股票人民币C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('18', '519674', '银河创新成长混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('19', '163415', '兴全商业模式优选混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('20', '166002', '中欧新蓝筹混合A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('21', '320022', '诺安研究精选股票', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('22', '001508', '富国新动力灵活配置混合A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('23', '150252', '招商中证煤炭等权指数分级B', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('24', '150312', '信诚中证智能家居指数分级B', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('25', '005889', '华夏新兴消费混合C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('26', '005888', '华夏新兴消费混合A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('27', '000522', '华润元大信息传媒科技混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('28', '257040', '国联安红利混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('29', '000772', '景顺长城中国回报灵活配置混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('30', '006252', '永赢消费主题A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('31', '001832', '易方达瑞恒灵活配置混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('32', '001856', '易方达环保主题混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('33', '004868', '交银股息优化混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('34', '570001', '诺德价值优势混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('35', '481010', '工银中小盘混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('36', '005004', '交银品质升级混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('37', '000263', '工银信息产业混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('38', '000336', '农银研究精选混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('39', '001606', '农银工业4.0混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('40', '005774', '华夏产业升级混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('41', '290011', '泰信中小盘精选混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('42', '005609', '富国军工主题混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('43', '164205', '天弘文化新兴产业', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('44', '110017', '易方达增强回报债券A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('45', '000991', '工银战略转型股票', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('46', '001644', '汇丰晋信智造先锋股票C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('47', '001643', '汇丰晋信智造先锋股票A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('48', '161025', '富国中证移动互联网指数分级', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('49', '161631', '融通人工智能指数(LOF)A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('50', '165519', '信诚中证800医药指数分级', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('51', '001071', '华安媒体互联网混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('52', '160605', '鹏华中国50混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('53', '161032', '富国中证煤炭指数分级', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('54', '070021', '嘉实主题新动力混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('55', '161725', '招商中证白酒指数分级', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('56', '001595', '天弘中证银行指数C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('57', '167301', '方正富邦保险主题指数分级', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('58', '001553', '天弘中证证券保险C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('59', '005223', '广发中证基建工程指数A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('60', '007803', '兴全合泰混合C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('61', '260108', '景顺长城新兴成长混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('62', '100018', '富国天利增长债券', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('63', '003634', '嘉实农业产业股票', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('64', '501048', '汇添富中证全指证券公司指数C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('65', '002900', '南方中证500信息技术联接A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('66', '007305', '国联安新科技混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('67', '007874', '华宝科技ETF联接C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('68', '160629', '鹏华传媒分级', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('69', '377240', '上投摩根新兴动力混合A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('70', '003884', '汇安沪深300指数增强A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('71', '530011', '建信内生动力混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('72', '004683', '建信高端医疗股票', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('73', '004997', '广发高端制造股票A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('74', '000960', '招商医药健康产业股票', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('75', '001679', '前海开源中国稀缺资产混合A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('76', '006241', '中融医疗健康混合C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('77', '501005', '汇添富中证精准医疗指数A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('78', '162412', '华宝中证医疗指数分级', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('79', '502056', '广发中证医疗指数(LOF)A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('80', '161726', '招商国证生物医药指数分级', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('81', '001302', '前海开源金银珠宝混合A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('82', '206009', '鹏华新兴产业混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('83', '110011', '易方达中小盘混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('84', '270002', '广发稳健增长混合A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('85', '161005', '富国天惠成长混合A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('86', '001557', '天弘中证500指数增强C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('87', '000962', '天弘中证500ETF联接A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('88', '001938', '中欧时代先锋股票A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('89', '001480', '财通成长优选混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('90', '006502', '财通集成电路产业股票A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('91', '003938', '南方荣尊混合A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('92', '000001', '华夏成长混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('93', '000003', '中海可转债债券A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('94', '000005', '嘉实增强信用定期债券', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('95', '004241', '中欧时代先锋股票C', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('96', '001631', '天弘中证食品饮料指数A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('97', '001475', '易方达国防军工混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('98', '001500', '泓德远见回报混合', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('99', '213001', '宝盈鸿利收益灵活配置混合A', NULL, '2020-12-08 15:35:02');
INSERT INTO `fund_hold` (`id`, `fund_code`, `fund_name`, `user_name`, `create_date`) VALUES ('100', '005063', '广发中证全指家用电器指数A', NULL, '2020-12-08 15:35:02');

