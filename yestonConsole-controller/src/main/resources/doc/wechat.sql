/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : wechat

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2016-01-02 12:05:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for wx_account
-- ----------------------------
DROP TABLE IF EXISTS `wx_account`;
CREATE TABLE `wx_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountaccesstoken` varchar(255) DEFAULT NULL,
  `accountappid` varchar(255) DEFAULT NULL,
  `accountappsecret` varchar(255) DEFAULT NULL,
  `accountdesc` varchar(255) DEFAULT NULL,
  `accountemail` varchar(255) DEFAULT NULL,
  `accountid` varchar(255) DEFAULT NULL,
  `accountname` varchar(255) DEFAULT NULL,
  `accountnumber` varchar(255) DEFAULT NULL,
  `accounttoken` varchar(255) DEFAULT NULL,
  `accounttype` int(11) DEFAULT NULL,
  `addtoekntime` datetime DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wx_account
-- ----------------------------
INSERT INTO `wx_account` VALUES ('1', null, '', '', '', '2223@qq.com', '11', '11', '11', '11', '10', null, null);
INSERT INTO `wx_account` VALUES ('2', null, '', '', '', '2222@qq.com', '22', '222', '11', '122', '20', '2014-07-16 19:49:41', null);
INSERT INTO `wx_account` VALUES ('3', null, '22', '22', '222', '333@qq.com', '222', '33', '444', '444', '10', '2014-07-16 19:52:19', null);
INSERT INTO `wx_account` VALUES ('4', null, '11', '22', '222', '555@qq.com', '333', '44', '444', '555', '10', '2014-07-16 19:52:59', null);
INSERT INTO `wx_account` VALUES ('5', null, '', '', '', '222@qq.com', '555', '555', '555', '555', '10', '2014-07-16 22:42:16', null);
INSERT INTO `wx_account` VALUES ('6', null, '', '', '', '222@qq.com', '666', '666', '666', '666', '20', '2014-07-17 01:05:20', null);
