
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
    `create_id` bigint(11) DEFAULT NULL COMMENT '创建者id',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='基金表';


DROP TABLE IF EXISTS `fund_valuation`;
CREATE TABLE `fund_valuation` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `fund_id` bigint(11) NOT NULL COMMENT '基金Id',
  `fund_date` varchar(16) NOT NULL COMMENT '日期',
  `dwjz` varchar(16) DEFAULT NULL COMMENT '单位净值',
  `equity_return` varchar(16) DEFAULT NULL COMMENT '估值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='基金估值表';


DROP TABLE IF EXISTS `fund_stock`;
CREATE TABLE `fund_stock` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `fund_id` bigint(11) NOT NULL COMMENT '基金Id',
  `stock_code` varchar(8) NOT NULL COMMENT '股票code',
  `stock_name` varchar(8) DEFAULT NULL COMMENT '股票名称',
  `create_id` bigint(11) DEFAULT NULL COMMENT '创建者id',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='基金-持仓股票';



