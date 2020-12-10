
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


INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000001', '华夏成长混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000003', '中海可转债债券A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000005', '嘉实增强信用定期债券');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000031', '华夏复兴混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000209', '信诚新兴产业混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000263', '工银信息产业混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000336', '农银研究精选混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000522', '华润元大信息传媒科技混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000603', '易方达创新驱动灵活配置混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000619', '东方红产业升级混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000772', '景顺长城中国回报灵活配置混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000960', '招商医药健康产业股票');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000961', '天弘沪深300ETF联接A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000962', '天弘中证500ETF联接A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000974', '安信消费医药股票');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('000991', '工银战略转型股票');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001030', '天弘云端生活优选');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001052', '华夏中证500ETF联接A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001071', '华安媒体互联网混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001156', '申万菱信新能源汽车混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001302', '前海开源金银珠宝混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001371', '富国沪港深价值混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001384', '东方新思路混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001475', '易方达国防军工混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001480', '财通成长优选混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001500', '泓德远见回报混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001508', '富国新动力灵活配置混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001510', '富国新动力灵活配置混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001548', '天弘上证50指数A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001553', '天弘中证证券保险C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001556', '天弘中证500指数增强A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001557', '天弘中证500指数增强C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001594', '天弘中证银行指数A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001595', '天弘中证银行指数C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001605', '国富沪港深成长精选股票');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001606', '农银工业4.0混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001616', '嘉实环保低碳股票');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001631', '天弘中证食品饮料指数A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001643', '汇丰晋信智造先锋股票A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001644', '汇丰晋信智造先锋股票C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001679', '前海开源中国稀缺资产混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001704', '国投瑞银进宝灵活配置混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001714', '工银文体产业股票A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001716', '工银新趋势灵活配置混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001790', '国泰智能汽车股票');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001832', '易方达瑞恒灵活配置混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001838', '国投瑞银国家安全混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001856', '易方达环保主题混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001858', '建信鑫利灵活配置混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001938', '中欧时代先锋股票A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001951', '金鹰改革红利混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('001997', '工银新趋势灵活配置混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('002005', '工银新得利混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('002083', '新华鑫动力灵活配置混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('002084', '新华鑫动力灵活配置混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('002190', '农银新能源主题');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('002300', '长盛医疗行业量化配置股票');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('002345', '华夏高端制造混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('002408', '中信建投医改混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('002681', '金鹰元和灵活配置混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('002682', '金鹰元和灵活配置混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('002900', '南方中证500信息技术联接A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('002983', '长信国防军工量化混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('003096', '中欧医疗健康混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('003634', '嘉实农业产业股票');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('003834', '华夏能源革新股票');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('003853', '金鹰信息产业股票A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('003884', '汇安沪深300指数增强A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('003938', '南方荣尊混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('003984', '嘉实新能源新材料股票A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('004224', '南方军工改革灵活配置混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('004237', '中欧新蓝筹混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('004241', '中欧时代先锋股票C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('004683', '建信高端医疗股票');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('004698', '博时军工主题股票');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('004854', '广发中证全指汽车指数A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('004856', '广发中证全指建筑材料指数A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('004857', '广发中证全指建筑材料指数C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('004868', '交银股息优化混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('004997', '广发高端制造股票A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005004', '交银品质升级混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005035', '银华信息科技量化股票发起式A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005037', '银华新能源新材料A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005063', '广发中证全指家用电器指数A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005094', '万家臻选混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005223', '广发中证基建工程指数A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005342', '长安裕泰混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005352', '鹏扬景泰成长混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005353', '鹏扬景泰成长混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005609', '富国军工主题混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005668', '融通新能源汽车主题精选混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005774', '华夏产业升级混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005855', '中科沃土沃瑞混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005856', '中科沃土沃瑞混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005888', '华夏新兴消费混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005889', '华夏新兴消费混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005928', '创金合信新能源汽车股票C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005939', '工银新能源汽车混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('005940', '工银新能源汽车混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('006080', '海富通电子传媒股票C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('006081', '海富通电子传媒股票A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('006241', '中融医疗健康混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('006252', '永赢消费主题A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('006355', '华宝香港大盘C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('006502', '财通集成电路产业股票A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('006585', '南方宝元债券C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('006615', '工银战略新兴产业混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('006616', '工银战略新兴产业混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('006736', '国投瑞银先进制造混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('007163', '浦银安盛环保新能源A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('007202', '天弘优质成长企业');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('007301', '国联安中证半导体ETF联接C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('007305', '国联安新科技混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('007346', '易方达科技创新混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('007553', '中信建投医改混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('007570', '方正富邦红利精选混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('007803', '兴全合泰混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('007844', '华宝标普油气上游股票人民币C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('007872', '金信稳健策略灵活配置混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('007874', '华宝科技ETF联接C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('007959', '方正富邦天恒混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('007960', '方正富邦天恒混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('008086', '华夏中证5G通信主题ETF联接A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('008087', '华夏中证5G通信主题ETF联接C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('008246', '圆信永丰致优混合C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('008382', '融通产业趋势股票');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('008640', '方正富邦科技创新A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('008641', '方正富邦科技创新C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('008888', '华夏国证半导体芯片ETF联接C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('009049', '易方达高端制造混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('009860', '易方达中证银行指数(LOF)C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('070021', '嘉实主题新动力混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('070023', '嘉实深证基本面120联接A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('100018', '富国天利增长债券');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('100060', '富国高新技术产业混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('110003', '易方达上证50指数A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('110011', '易方达中小盘混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('110017', '易方达增强回报债券A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('110022', '易方达消费行业股票');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('150252', '招商中证煤炭等权指数分级B');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('150312', '信诚中证智能家居指数分级B');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('159801', '广发国证半导体芯片ETF');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('160119', '南方中证500ETF联接A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('160221', '国泰国证有色金属行业指数分级');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('160225', '国泰国证新能源汽车指数');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('160605', '鹏华中国50混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('160629', '鹏华传媒分级');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('161005', '富国天惠成长混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('161025', '富国中证移动互联网指数分级');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('161028', '富国中证新能源汽车指数分级');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('161032', '富国中证煤炭指数分级');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('161631', '融通人工智能指数(LOF)A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('161723', '招商中证银行指数分级');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('161725', '招商中证白酒指数分级');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('161726', '招商国证生物医药指数分级');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('162202', '泰达宏利周期混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('162412', '华宝中证医疗指数分级');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('163402', '兴全趋势投资混合(LOF)');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('163406', '兴全合润分级混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('163415', '兴全商业模式优选混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('164205', '天弘文化新兴产业');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('164402', '前海开源中航军工');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('164403', '前海开源沪港深农业混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('165516', '信诚周期轮动混合(LOF)');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('165519', '信诚中证800医药指数分级');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('165520', '信诚中证800有色指数分级');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('166002', '中欧新蓝筹混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('167301', '方正富邦保险主题指数分级');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('169101', '东方红睿丰混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('180031', '银华中小盘混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('202023', '南方优选成长混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('206009', '鹏华新兴产业混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('210008', '金鹰策略配置混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('213001', '宝盈鸿利收益灵活配置混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('240022', '华宝资源优选混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('257040', '国联安红利混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('260101', '景顺长城优选混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('260108', '景顺长城新兴成长混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('270002', '广发稳健增长混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('290011', '泰信中小盘精选混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('320022', '诺安研究精选股票');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('377240', '上投摩根新兴动力混合A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('400015', '东方新能源汽车混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('481010', '工银中小盘混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('501005', '汇添富中证精准医疗指数A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('501016', '国泰中证申万证券行业指数');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('501048', '汇添富中证全指证券公司指数C');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('501057', '汇添富中证新能源汽车A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('501311', '嘉实港股通新经济指数A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('502056', '广发中证医疗指数(LOF)A');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('519095', '新华行业周期轮换混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('519196', '万家新兴蓝筹灵活配置混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('519674', '银河创新成长混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('519736', '交银新成长混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('519918', '华夏兴和混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('530001', '建信恒久价值混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('530011', '建信内生动力混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('570001', '诺德价值优势混合');
INSERT INTO `fund_hold` (`fund_code`, `fund_name`) VALUES ('010160', '广发高端制造股票C');





