
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `mod_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned DEFAULT '0' COMMENT '角色id',
  `user_id` int(10) unsigned DEFAULT '0' COMMENT '前台用户id',
  `username` varchar(255) DEFAULT '' COMMENT '用户名',
  `password` varchar(255) DEFAULT '' COMMENT '密码',
  `login_time` bigint(15) unsigned DEFAULT '0' COMMENT '登录时间',
  `login_ip` varchar(20) DEFAULT '' COMMENT '登录ip',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态1-启用2-禁用',
  `remark` varchar(255) DEFAULT '' COMMENT '备注信息',
  `create_time` bigint(15) unsigned DEFAULT '0' COMMENT '创建时间',
  `update_time` bigint(15) unsigned DEFAULT '0' COMMENT '更新时间',
  `google_secret` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '谷歌',
  `google_url` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '谷歌url',
  `google_is_bind` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否绑定',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_admin_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `node` varchar(200) NOT NULL DEFAULT '' COMMENT '当前操作节点',
  `geoip` varchar(15) NOT NULL DEFAULT '' COMMENT '操作者IP地址',
  `action` varchar(200) NOT NULL DEFAULT '' COMMENT '操作行为名称',
  `content` varchar(4096) NOT NULL DEFAULT '' COMMENT '操作内容描述',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '操作人用户名',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='系统-日志';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_announcement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_announcement` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT '' COMMENT '标题',
  `title_zh` varchar(255) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `content_zh` text COMMENT '内容(json)',
  `content_en` text NOT NULL,
  `content_pt` text NOT NULL,
  `content_nl` text NOT NULL,
  `content_he` text NOT NULL,
  `content_fr` text NOT NULL,
  `content_es` text NOT NULL,
  `content_de` text NOT NULL,
  `content_ar` text NOT NULL,
  `title_pt` varchar(255) NOT NULL,
  `title_nl` varchar(255) NOT NULL,
  `title_he` varchar(255) NOT NULL,
  `title_fr` varchar(255) NOT NULL,
  `title_es` varchar(255) NOT NULL,
  `title_de` varchar(255) NOT NULL,
  `title_ar` varchar(255) NOT NULL,
  `update_time` bigint(15) unsigned DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='公告';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_app_roll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_app_roll` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '' COMMENT 'App名称',
  `img` varchar(255) DEFAULT '' COMMENT '图片',
  `desc` text COMMENT '介绍',
  `create_time` bigint(15) unsigned DEFAULT '0',
  `update_time` bigint(15) unsigned DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='app滚动';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_bank` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) DEFAULT '0' COMMENT '用户id',
  `name` varchar(200) DEFAULT '' COMMENT '银行名称',
  `card_no` varchar(200) DEFAULT '' COMMENT '卡号',
  `account_name` varchar(100) DEFAULT '' COMMENT '户名',
  `account_open_name` varchar(255) DEFAULT '' COMMENT '开户支行',
  `mobile` varchar(50) DEFAULT '' COMMENT '手机号',
  `wise` varchar(255) DEFAULT NULL COMMENT 'wise',
  `revolut` varchar(255) DEFAULT NULL COMMENT 'revolut',
  `usdt` varchar(255) DEFAULT NULL COMMENT 'USDT地址（TRC20）',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态1-启用2-禁用',
  `create_time` bigint(15) unsigned DEFAULT '0',
  `update_time` bigint(15) unsigned DEFAULT '0',
  `type` int(3) DEFAULT '1' COMMENT '銀行2 usdt 1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='银行';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_bank_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_bank_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增ID',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `before` text NOT NULL COMMENT '修改之前地址',
  `after` text NOT NULL COMMENT '修改之后地址',
  `action_type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '操作类型 0前台修改 1后台修改',
  `action_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作人Id',
  `action_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  `action_ip` varchar(100) NOT NULL DEFAULT '' COMMENT '操作IP',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='钱包/卡号修改记录表';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_configure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_configure` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT '' COMMENT '标题',
  `content` longtext COMMENT '内容(json)',
  `update_time` bigint(15) unsigned DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统配置';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_day_fill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_day_fill` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `day` int(10) unsigned DEFAULT NULL COMMENT '日期',
  `agent_id` int(10) unsigned DEFAULT '0' COMMENT '代理id',
  `people` int(5) unsigned DEFAULT '0' COMMENT '人数',
  `price` decimal(40,2) DEFAULT '0.00' COMMENT '金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='每日首充记录';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_goods` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '产品名称',
  `zh_name` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '产品名称',
  `en_name` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '产品名称',
  `pt_name` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '产品名称',
  `nl_name` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '产品名称',
  `he_name` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '产品名称',
  `fr_name` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '产品名称',
  `es_name` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '产品名称',
  `de_name` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '产品名称',
  `ar_name` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '产品名称',
  `img` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '图片',
  `price` decimal(40,2) unsigned DEFAULT NULL COMMENT '价格',
  `desc` text CHARACTER SET utf8 COMMENT '介绍',
  `room_name` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '房间类型',
  `rating` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '评分',
  `rating_tag` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '评分标签',
  `comments_number` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '评价数量',
  `create_time` bigint(15) unsigned DEFAULT '0',
  `update_time` bigint(15) unsigned DEFAULT '0',
  `see` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_goods2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_goods2` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `prizeName` varchar(255) DEFAULT '' COMMENT '奖品描述',
  `prizeImage` varchar(255) DEFAULT '' COMMENT '图片',
  `type` int(10) unsigned DEFAULT '1' COMMENT '类型；1usdt,2,商品,3,高级用户',
  `price` int(10) unsigned DEFAULT NULL COMMENT '赠送金额，商品id，高级用户天数',
  `prizeWeight` int(10) unsigned DEFAULT NULL COMMENT '权重',
  `prizeStock` int(10) unsigned DEFAULT NULL COMMENT '库存',
  `create_time` bigint(15) unsigned DEFAULT '0',
  `update_time` bigint(15) unsigned DEFAULT '0',
  `desc` text COMMENT '介绍',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='奖品';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_goods3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_goods3` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `prizeName` varchar(255) DEFAULT '' COMMENT '奖品描述',
  `prizeImage` varchar(255) DEFAULT '' COMMENT '图片',
  `type` int(10) unsigned DEFAULT '1' COMMENT '类型；1usdt,2,商品,3,高级用户',
  `price` int(10) unsigned DEFAULT NULL COMMENT '赠送金额，商品id，高级用户天数',
  `uid` int(10) unsigned DEFAULT NULL,
  `prizeWeight` int(10) unsigned DEFAULT NULL COMMENT '权重',
  `prizeStock` int(10) unsigned DEFAULT NULL COMMENT '库存',
  `create_time` bigint(15) unsigned DEFAULT '0',
  `update_time` bigint(15) unsigned DEFAULT '0',
  `desc` text COMMENT '介绍',
  `type2` int(10) unsigned DEFAULT '3' COMMENT '审核状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='奖品';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_goods_bat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_goods_bat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `zh_name` varchar(255) DEFAULT '' COMMENT '产品名称',
  `en_name` varchar(255) DEFAULT '' COMMENT '产品名称',
  `pt_name` varchar(255) DEFAULT '' COMMENT '产品名称',
  `nl_name` varchar(255) DEFAULT '' COMMENT '产品名称',
  `he_name` varchar(255) DEFAULT '' COMMENT '产品名称',
  `fr_name` varchar(255) DEFAULT '' COMMENT '产品名称',
  `es_name` varchar(255) DEFAULT '' COMMENT '产品名称',
  `de_name` varchar(255) DEFAULT '' COMMENT '产品名称',
  `ar_name` varchar(255) DEFAULT '' COMMENT '产品名称',
  `img` varchar(255) DEFAULT '' COMMENT '图片',
  `price` decimal(40,2) unsigned DEFAULT NULL COMMENT '价格',
  `desc` text COMMENT '介绍',
  `room_name` varchar(255) NOT NULL DEFAULT '' COMMENT '房间类型',
  `rating` varchar(255) NOT NULL DEFAULT '' COMMENT '评分',
  `rating_tag` varchar(255) NOT NULL DEFAULT '' COMMENT '评分标签',
  `comments_number` varchar(255) NOT NULL DEFAULT '' COMMENT '评价数量',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `see` varchar(255) DEFAULT NULL COMMENT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='产品';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_graborders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_graborders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '用户id',
  `create_time` bigint(20) DEFAULT NULL COMMENT '时间\r\n',
  `admin_id` int(11) DEFAULT NULL COMMENT '操作角色\r\n',
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户是否开启自动派单',
  `lang` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='自动派单表';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_hotsales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_hotsales` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned DEFAULT '0' COMMENT '用户id',
  `appointment` int(1) DEFAULT '1' COMMENT '爆单开始单号',
  `amount` text COMMENT '金额',
  `number` varchar(255) DEFAULT NULL COMMENT '佣金倍数',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态1-触发2-未触发',
  `update_time` bigint(15) unsigned DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='爆单设置';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_level` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT '',
  `order_num` int(5) unsigned DEFAULT '0' COMMENT '每日订单量',
  `match_min` tinyint(1) unsigned DEFAULT '0' COMMENT '匹配区间比例-最小',
  `match_max` tinyint(1) unsigned DEFAULT '0' COMMENT '匹配区间比例-最大',
  `limit_price` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '做单限制金额',
  `withdraw_min` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '提现最小金额',
  `withdraw_max` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '提现最大金额',
  `withdraw_rate` varchar(10) DEFAULT '' COMMENT '提现手续费率',
  `order_rate` varchar(10) DEFAULT '' COMMENT '订单佣金比例',
  `withdraw_num` int(5) unsigned DEFAULT '0' COMMENT '提现限制-完成单数',
  `create_time` bigint(15) unsigned DEFAULT '0',
  `update_time` bigint(15) unsigned DEFAULT '0',
  `reward_price` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '升级奖励',
  `price` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '价格',
  `img` varchar(255) DEFAULT '' COMMENT '图标',
  `ring` int(1) unsigned DEFAULT '0' COMMENT '轮',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户等级';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned DEFAULT '0' COMMENT '用户id',
  `title_vi` varchar(255) DEFAULT '' COMMENT '标题-越南',
  `content_zh` text COMMENT '内容-繁体',
  `content_vi` text COMMENT '内容-越南',
  `content_en` text COMMENT '内容-英文',
  `create_time` bigint(15) unsigned DEFAULT '0',
  `status` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='前台用户-系统消息';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_order` (
  `id` int(12) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(20) DEFAULT '' COMMENT '订单号',
  `uid` int(10) unsigned DEFAULT '0' COMMENT '用户id',
  `goods_id` int(10) unsigned DEFAULT '0' COMMENT '商品id',
  `num` int(8) unsigned DEFAULT '0' COMMENT '商品数量',
  `price` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '交易金额',
  `commission` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '佣金',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态1-未付款2-交易完成',
  `com_status` tinyint(1) DEFAULT '1' COMMENT '返佣状态1-未返佣2-已返佣',
  `create_time` bigint(15) unsigned DEFAULT '0',
  `end_time` bigint(15) unsigned DEFAULT '0' COMMENT '结束时间',
  `rate` int(11) DEFAULT '1' COMMENT '评分',
  `comm` varchar(255) DEFAULT NULL COMMENT '下级佣金配置',
  `is_fuli` int(1) DEFAULT '0' COMMENT '1 福利',
  `beishu` varchar(50) DEFAULT '1' COMMENT '倍数',
  `lang` varchar(10) DEFAULT NULL,
  `guest_review` text COMMENT '住客评价快照(与提交弹窗一致)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_uid_status` (`uid`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_recharge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_recharge` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned DEFAULT '0' COMMENT '用户id',
  `admin_id` int(10) unsigned DEFAULT '0' COMMENT '操作id',
  `price` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '金额',
  `price_pre` decimal(40,2) DEFAULT '0.00' COMMENT '操作前金额',
  `create_time` bigint(15) unsigned DEFAULT '0',
  `handle_time` bigint(15) unsigned DEFAULT '0' COMMENT '处理时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '1-上分2-下分',
  `beizhu` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='充值-上下分记录';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_recharge2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_recharge2` (
  `id` int(11) NOT NULL,
  `money` decimal(20,2) NOT NULL DEFAULT '0.00',
  `create_time` bigint(15) NOT NULL,
  `uid` int(11) NOT NULL,
  `fee` decimal(20,2) DEFAULT '0.00' COMMENT '手续费'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT '' COMMENT '角色名称',
  `rules` longtext COMMENT '权限数据',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '启用状态1-启用',
  `create_time` bigint(15) unsigned DEFAULT '0' COMMENT '创建时间',
  `update_time` bigint(15) unsigned DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色-权限控制';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_schedule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned DEFAULT '0' COMMENT '用户id',
  `type` tinyint(1) DEFAULT '2' COMMENT '1-卡单2-连单',
  `start_num` int(1) DEFAULT '1' COMMENT '连单开始单号',
  `rule` text COMMENT '规则',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态1-启用2-禁用',
  `update_time` bigint(15) unsigned DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='排单设置';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_sign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_sign` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned DEFAULT NULL COMMENT '用户id',
  `create_time` bigint(15) unsigned DEFAULT '0',
  `update_time` bigint(15) unsigned DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='签到';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_stat` (
  `id` int(12) unsigned NOT NULL AUTO_INCREMENT,
  `day` char(8) DEFAULT '' COMMENT '统计日期',
  `user_num` int(5) unsigned DEFAULT '0' COMMENT '新增用户数',
  `vip_num` int(5) DEFAULT NULL COMMENT '新增会员数',
  `active_num` int(5) unsigned DEFAULT '0' COMMENT '活跃用户数',
  `extra` text COMMENT '额外统计数据json',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='每日统计数据';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '邮箱',
  `password` varchar(100) NOT NULL DEFAULT '' COMMENT '密码',
  `mobile` varchar(20) DEFAULT '' COMMENT '手机号码',
  `nickname` varchar(20) DEFAULT '' COMMENT '昵称',
  `head_img` varchar(255) DEFAULT '' COMMENT '头像',
  `deal_pass` varchar(100) DEFAULT '' COMMENT '取款密码',
  `level_id` int(5) unsigned DEFAULT '1' COMMENT '等级id',
  `pid` int(10) unsigned DEFAULT '1' COMMENT '上级id',
  `credit_score` int(5) DEFAULT '100' COMMENT '信用分',
  `invite_code` char(6) DEFAULT '' COMMENT '邀请码',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态1-正常2-禁用',
  `balance` decimal(40,2) DEFAULT '0.00' COMMENT '余额',
  `freeze_balance` decimal(40,2) DEFAULT '0.00' COMMENT '冻结金额',
  `trade_status` tinyint(1) DEFAULT '1' COMMENT '交易状态1-正常2-禁止',
  `order_total` int(8) unsigned DEFAULT '0' COMMENT '总交易订单数',
  `user_order` int(8) DEFAULT '0' COMMENT '用户被派单数量',
  `commission` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '总佣金',
  `recharge` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '累计充值',
  `withdraw` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '累计提现',
  `is_agent` tinyint(1) DEFAULT '0' COMMENT '1-代理0-非代理',
  `is_test` tinyint(1) DEFAULT '0' COMMENT '1-测试账号0-普通账号',
  `login_time` bigint(15) unsigned DEFAULT '0' COMMENT '登录时间',
  `login_ip` varchar(50) DEFAULT NULL COMMENT '登录ip',
  `create_time` bigint(15) unsigned DEFAULT '0',
  `create_ip` varchar(20) DEFAULT NULL COMMENT '创建ip',
  `update_time` bigint(15) unsigned DEFAULT '0',
  `sub_num` int(5) unsigned DEFAULT '0' COMMENT '下级数量',
  `family` varchar(200) DEFAULT '' COMMENT '上级族谱',
  `deal_date` char(8) DEFAULT '' COMMENT '交易日期-当天',
  `today_profit` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '今日订单收益',
  `bind_card` tinyint(1) DEFAULT '0' COMMENT '绑定银行卡状态',
  `agent_id` int(10) unsigned DEFAULT '0' COMMENT '代理id',
  `jiang` varchar(255) DEFAULT '' COMMENT '奖项设置',
  `jiangk` int(10) DEFAULT '0' COMMENT '抽奖次数',
  `auto_add_credit_time` int(11) NOT NULL DEFAULT '0' COMMENT '自动增加信用分日期',
  `withdrawal_status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '是否可提现 默认1可以 0不可以',
  `gd` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_users_order_repeat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_users_order_repeat` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '关联用户id',
  `day` varchar(50) NOT NULL DEFAULT '' COMMENT '当天 日期 字符',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid_and_day` (`uid`,`day`) USING BTREE,
  KEY `uid_and_add_time` (`uid`,`add_time`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_wallet_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_wallet_log` (
  `id` int(12) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned DEFAULT '0' COMMENT '用户id',
  `order_id` int(12) unsigned DEFAULT '0' COMMENT '订单id',
  `type` tinyint(1) unsigned DEFAULT '1' COMMENT '类型1-后台充值2-提现3-交易4-交易佣金',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态1-收入2-支出',
  `price` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '金额',
  `price_pre` decimal(40,2) DEFAULT '0.00' COMMENT '交易前金额',
  `create_time` bigint(15) unsigned DEFAULT '0',
  `explain` varchar(255) DEFAULT '' COMMENT '说明',
  `extra_id` int(12) unsigned DEFAULT '0' COMMENT '额外id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户资金记录';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mod_withdraw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_withdraw` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned DEFAULT '0' COMMENT '用户id',
  `bank_id` int(10) unsigned DEFAULT '0' COMMENT '银行卡id',
  `content` text NOT NULL COMMENT '提款信息',
  `price` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '提现金额',
  `fee` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '手续费',
  `status` tinyint(1) DEFAULT '1' COMMENT '1-待处理2-通过3-驳回',
  `remark` varchar(255) DEFAULT '' COMMENT '驳回原因',
  `create_time` bigint(15) unsigned DEFAULT '0',
  `handle_time` bigint(15) unsigned DEFAULT '0' COMMENT '处理时间',
  `price_pre` decimal(40,2) unsigned DEFAULT '0.00' COMMENT '交易前金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='提现';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

