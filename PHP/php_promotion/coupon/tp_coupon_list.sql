/*
 Navicat Premium Data Transfer

 Source Server         : 本地链接
 Source Server Type    : MySQL
 Source Server Version : 50726 (5.7.26)
 Source Host           : localhost:3306
 Source Schema         : tpshop6.0

 Target Server Type    : MySQL
 Target Server Version : 50726 (5.7.26)
 File Encoding         : 65001

 Date: 30/03/2023 11:27:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tp_coupon_list
-- ----------------------------
DROP TABLE IF EXISTS `tp_coupon_list`;
CREATE TABLE `tp_coupon_list`  (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '表id',
  `cid` int(8) NOT NULL DEFAULT 0 COMMENT '优惠券 对应coupon表id',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '发放类型 1 按订单发放 2 注册 3 邀请 4 按用户发放',
  `uid` int(8) NOT NULL DEFAULT 0 COMMENT '用户id',
  `order_id` int(8) NOT NULL DEFAULT 0 COMMENT '订单id',
  `get_order_id` int(11) NULL DEFAULT 0 COMMENT '优惠券来自订单ID',
  `use_time` int(11) NOT NULL DEFAULT 0 COMMENT '使用时间',
  `code` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '优惠券兑换码',
  `send_time` int(11) NOT NULL DEFAULT 0 COMMENT '发放时间',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '0未使用1已使用2已过期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `code`(`code`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 324 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tp_coupon_list
-- ----------------------------
INSERT INTO `tp_coupon_list` VALUES (1, 1, 2, 4, 0, 0, 0, '', 1523330394, 0);
INSERT INTO `tp_coupon_list` VALUES (3, 1, 2, 2, 82, 0, 1523956158, '', 1523949672, 1);
INSERT INTO `tp_coupon_list` VALUES (4, 8, 2, 3, 83, 0, 1523956270, '', 1523955386, 1);
INSERT INTO `tp_coupon_list` VALUES (5, 4, 2, 3, 85, 0, 1523958311, '', 1523955394, 1);
INSERT INTO `tp_coupon_list` VALUES (6, 1, 2, 3, 81, 0, 1523955774, '', 1523955398, 1);
INSERT INTO `tp_coupon_list` VALUES (7, 1, 2, 1, 0, 0, 0, '', 1523959281, 0);
INSERT INTO `tp_coupon_list` VALUES (8, 5, 1, 11, 0, 0, 0, '', 1523959470, 0);
INSERT INTO `tp_coupon_list` VALUES (9, 5, 1, 10, 0, 0, 0, '', 1523959470, 0);
INSERT INTO `tp_coupon_list` VALUES (10, 5, 1, 9, 0, 0, 0, '', 1523959470, 0);
INSERT INTO `tp_coupon_list` VALUES (11, 5, 1, 8, 0, 0, 0, '', 1523959470, 0);
INSERT INTO `tp_coupon_list` VALUES (12, 5, 1, 7, 0, 0, 0, '', 1523959470, 0);
INSERT INTO `tp_coupon_list` VALUES (13, 5, 1, 6, 0, 0, 0, '', 1523959470, 0);
INSERT INTO `tp_coupon_list` VALUES (14, 5, 1, 5, 0, 0, 0, '', 1523959470, 0);
INSERT INTO `tp_coupon_list` VALUES (15, 5, 1, 4, 0, 0, 0, '', 1523959470, 0);
INSERT INTO `tp_coupon_list` VALUES (16, 5, 1, 3, 324, 0, 1524455996, '', 1523959470, 1);
INSERT INTO `tp_coupon_list` VALUES (17, 5, 1, 2, 0, 0, 0, '', 1523959470, 0);
INSERT INTO `tp_coupon_list` VALUES (18, 7, 2, 1, 0, 0, 0, '', 1523960149, 0);
INSERT INTO `tp_coupon_list` VALUES (19, 7, 2, 2, 470, 0, 1524732058, '', 1523964037, 1);
INSERT INTO `tp_coupon_list` VALUES (20, 8, 2, 2, 0, 0, 0, '', 1523964044, 0);
INSERT INTO `tp_coupon_list` VALUES (21, 4, 2, 2, 126, 0, 1524039515, '', 1523979222, 1);
INSERT INTO `tp_coupon_list` VALUES (22, 6, 2, 2, 115, 0, 1524035008, '', 1524014410, 1);
INSERT INTO `tp_coupon_list` VALUES (24, 3, 0, 3, 124, 98, 1524037060, '', 1524021780, 1);
INSERT INTO `tp_coupon_list` VALUES (23, 6, 2, 3, 0, 0, 0, '', 1524017285, 0);
INSERT INTO `tp_coupon_list` VALUES (25, 15, 3, 2, 107, 0, 1524030988, 'JF8qiEpl', 1524030889, 1);
INSERT INTO `tp_coupon_list` VALUES (26, 15, 3, 2, 116, 0, 1524035538, 'gbDnP9tD', 1524030889, 1);
INSERT INTO `tp_coupon_list` VALUES (27, 15, 3, 0, 0, 0, 0, 'Pkdqatev', 1524030889, 0);
INSERT INTO `tp_coupon_list` VALUES (28, 15, 3, 0, 0, 0, 0, 'b65qeCCb', 1524030889, 0);
INSERT INTO `tp_coupon_list` VALUES (29, 15, 3, 0, 0, 0, 0, '4uS9CCjc', 1524030889, 0);
INSERT INTO `tp_coupon_list` VALUES (30, 15, 3, 0, 0, 0, 0, 'lGFbhwKl', 1524030889, 0);
INSERT INTO `tp_coupon_list` VALUES (31, 15, 3, 0, 0, 0, 0, 'NCbpqdnb', 1524030889, 0);
INSERT INTO `tp_coupon_list` VALUES (32, 15, 3, 0, 0, 0, 0, '4L2iaj2S', 1524030889, 0);
INSERT INTO `tp_coupon_list` VALUES (33, 15, 3, 0, 0, 0, 0, 'ewL8yvHA', 1524030889, 0);
INSERT INTO `tp_coupon_list` VALUES (34, 15, 3, 0, 0, 0, 0, 'F6DHsFtb', 1524030889, 0);
INSERT INTO `tp_coupon_list` VALUES (35, 16, 3, 3, 451, 0, 1524722541, 'GtAgpcn2', 1524033204, 1);
INSERT INTO `tp_coupon_list` VALUES (36, 16, 3, 0, 0, 0, 0, 'fNC9M3ey', 1524033204, 0);
INSERT INTO `tp_coupon_list` VALUES (37, 16, 3, 0, 0, 0, 0, 'v2K53lsK', 1524033204, 0);
INSERT INTO `tp_coupon_list` VALUES (38, 16, 3, 0, 0, 0, 0, 'Co136K9n', 1524033204, 0);
INSERT INTO `tp_coupon_list` VALUES (39, 16, 3, 0, 0, 0, 0, '6qbFmxKi', 1524033204, 0);
INSERT INTO `tp_coupon_list` VALUES (40, 16, 3, 0, 0, 0, 0, 'i7aNbd53', 1524033204, 0);
INSERT INTO `tp_coupon_list` VALUES (41, 16, 3, 0, 0, 0, 0, '4ldBzAut', 1524033204, 0);
INSERT INTO `tp_coupon_list` VALUES (42, 16, 3, 0, 0, 0, 0, 'Pk2dMcy1', 1524033204, 0);
INSERT INTO `tp_coupon_list` VALUES (43, 16, 3, 0, 0, 0, 0, 'AMAt4SP2', 1524033204, 0);
INSERT INTO `tp_coupon_list` VALUES (44, 16, 3, 0, 0, 0, 0, 'pDMQJQPq', 1524033204, 0);
INSERT INTO `tp_coupon_list` VALUES (45, 16, 3, 0, 0, 0, 0, '1Dc2Fwvu', 1524033402, 0);
INSERT INTO `tp_coupon_list` VALUES (46, 16, 3, 0, 0, 0, 0, 'j1JL1SCq', 1524033402, 0);
INSERT INTO `tp_coupon_list` VALUES (47, 16, 3, 0, 0, 0, 0, 'awzDPqKl', 1524033402, 0);
INSERT INTO `tp_coupon_list` VALUES (48, 16, 3, 0, 0, 0, 0, '2zhBh2MA', 1524033402, 0);
INSERT INTO `tp_coupon_list` VALUES (49, 16, 3, 0, 0, 0, 0, 'GF5mzn3z', 1524033402, 0);
INSERT INTO `tp_coupon_list` VALUES (50, 16, 3, 0, 0, 0, 0, 'Eeh9oEN8', 1524033402, 0);
INSERT INTO `tp_coupon_list` VALUES (51, 16, 3, 0, 0, 0, 0, 'xtaawH4g', 1524033402, 0);
INSERT INTO `tp_coupon_list` VALUES (52, 16, 3, 0, 0, 0, 0, 'Jug23vAy', 1524033402, 0);
INSERT INTO `tp_coupon_list` VALUES (53, 16, 3, 0, 0, 0, 0, 'FqM7mS95', 1524033402, 0);
INSERT INTO `tp_coupon_list` VALUES (54, 16, 3, 0, 0, 0, 0, 'wjtkKw4a', 1524033402, 0);
INSERT INTO `tp_coupon_list` VALUES (55, 16, 3, 0, 0, 0, 0, 'Lb46ycKh', 1524033575, 0);
INSERT INTO `tp_coupon_list` VALUES (56, 7, 2, 3, 0, 0, 0, '', 1524037105, 0);
INSERT INTO `tp_coupon_list` VALUES (57, 14, 0, 2, 135, 131, 1524043209, '', 1524041611, 1);
INSERT INTO `tp_coupon_list` VALUES (58, 20, 3, 0, 0, 0, 0, '13owQNG4', 1524110292, 0);
INSERT INTO `tp_coupon_list` VALUES (59, 20, 3, 0, 0, 0, 0, 'LmQjMgxE', 1524110292, 0);
INSERT INTO `tp_coupon_list` VALUES (60, 20, 3, 0, 0, 0, 0, 'nF5Ltn25', 1524110292, 0);
INSERT INTO `tp_coupon_list` VALUES (61, 20, 3, 0, 0, 0, 0, 'G147ukk8', 1524110292, 0);
INSERT INTO `tp_coupon_list` VALUES (62, 20, 3, 0, 0, 0, 0, 'EJhgygou', 1524110292, 0);
INSERT INTO `tp_coupon_list` VALUES (63, 20, 3, 0, 0, 0, 0, 'EuHd4yLL', 1524110292, 0);
INSERT INTO `tp_coupon_list` VALUES (64, 20, 3, 0, 0, 0, 0, '1NewrTfl', 1524110292, 0);
INSERT INTO `tp_coupon_list` VALUES (65, 20, 3, 0, 0, 0, 0, 'CSxqBC1H', 1524110292, 0);
INSERT INTO `tp_coupon_list` VALUES (66, 20, 3, 0, 0, 0, 0, 'pcwKsJrh', 1524110292, 0);
INSERT INTO `tp_coupon_list` VALUES (67, 21, 1, 5, 0, 0, 0, '', 1524117317, 0);
INSERT INTO `tp_coupon_list` VALUES (68, 21, 1, 3, 0, 0, 0, '', 1524117317, 0);
INSERT INTO `tp_coupon_list` VALUES (69, 21, 1, 1, 0, 0, 0, '', 1524117317, 0);
INSERT INTO `tp_coupon_list` VALUES (70, 18, 2, 2, 0, 0, 0, '', 1524208370, 0);
INSERT INTO `tp_coupon_list` VALUES (71, 6, 2, 9, 0, 0, 0, '', 1524212971, 0);
INSERT INTO `tp_coupon_list` VALUES (72, 18, 2, 9, 0, 0, 0, '', 1524212974, 0);
INSERT INTO `tp_coupon_list` VALUES (139, 34, 2, 722, 0, 0, 0, '', 1539163438, 0);
INSERT INTO `tp_coupon_list` VALUES (74, 1, 2, 10, 341, 0, 1524471718, '', 1524470195, 1);
INSERT INTO `tp_coupon_list` VALUES (75, 19, 2, 2, 0, 0, 0, '', 1524647424, 0);
INSERT INTO `tp_coupon_list` VALUES (76, 9, 2, 2, 0, 0, 0, '', 1524647441, 0);
INSERT INTO `tp_coupon_list` VALUES (77, 20, 2, 2, 0, 0, 0, '', 1524650343, 0);
INSERT INTO `tp_coupon_list` VALUES (138, 34, 2, 775, 0, 0, 0, '', 1539143884, 0);
INSERT INTO `tp_coupon_list` VALUES (79, 23, 2, 2, 429, 0, 1524650374, '', 1524650352, 1);
INSERT INTO `tp_coupon_list` VALUES (80, 26, 1, 18, 0, 0, 0, '', 1524706427, 0);
INSERT INTO `tp_coupon_list` VALUES (81, 26, 1, 17, 0, 0, 0, '', 1524706427, 0);
INSERT INTO `tp_coupon_list` VALUES (82, 26, 1, 15, 0, 0, 0, '', 1524706427, 0);
INSERT INTO `tp_coupon_list` VALUES (83, 26, 1, 12, 0, 0, 0, '', 1524706427, 0);
INSERT INTO `tp_coupon_list` VALUES (84, 26, 1, 9, 0, 0, 0, '', 1524706427, 0);
INSERT INTO `tp_coupon_list` VALUES (85, 26, 1, 8, 0, 0, 0, '', 1524706427, 0);
INSERT INTO `tp_coupon_list` VALUES (91, 29, 1, 26, 0, 0, 0, '', 1524809217, 0);
INSERT INTO `tp_coupon_list` VALUES (87, 28, 2, 2, 453, 0, 1524726570, '', 1524726404, 1);
INSERT INTO `tp_coupon_list` VALUES (88, 25, 0, 2, 508, 453, 1524798257, '', 1524726651, 1);
INSERT INTO `tp_coupon_list` VALUES (89, 18, 2, 22, 0, 0, 0, '', 1524727826, 0);
INSERT INTO `tp_coupon_list` VALUES (90, 1, 2, 17, 501, 0, 1524795449, '', 1524793023, 1);
INSERT INTO `tp_coupon_list` VALUES (92, 29, 1, 25, 0, 0, 0, '', 1524809217, 0);
INSERT INTO `tp_coupon_list` VALUES (93, 29, 1, 24, 0, 0, 0, '', 1524809217, 0);
INSERT INTO `tp_coupon_list` VALUES (94, 29, 1, 23, 0, 0, 0, '', 1524809217, 0);
INSERT INTO `tp_coupon_list` VALUES (95, 29, 1, 22, 0, 0, 0, '', 1524809217, 0);
INSERT INTO `tp_coupon_list` VALUES (96, 29, 1, 21, 0, 0, 0, '', 1524809217, 0);
INSERT INTO `tp_coupon_list` VALUES (97, 29, 1, 20, 0, 0, 0, '', 1524809217, 0);
INSERT INTO `tp_coupon_list` VALUES (98, 29, 1, 19, 0, 0, 0, '', 1524809217, 0);
INSERT INTO `tp_coupon_list` VALUES (99, 29, 1, 18, 0, 0, 0, '', 1524809217, 0);
INSERT INTO `tp_coupon_list` VALUES (100, 29, 1, 17, 0, 0, 0, '', 1524809217, 0);
INSERT INTO `tp_coupon_list` VALUES (109, 31, 1, 16, 0, 0, 0, '', 1524809947, 0);
INSERT INTO `tp_coupon_list` VALUES (108, 25, 0, 17, 540, 538, 1524810889, '', 1524809868, 1);
INSERT INTO `tp_coupon_list` VALUES (107, 31, 1, 1, 0, 0, 0, '', 1524809858, 0);
INSERT INTO `tp_coupon_list` VALUES (106, 31, 1, 2, 0, 0, 0, '', 1524809814, 0);
INSERT INTO `tp_coupon_list` VALUES (110, 1, 2, 23, 0, 0, 0, '', 1524812701, 0);
INSERT INTO `tp_coupon_list` VALUES (111, 32, 2, 25, 0, 0, 0, '', 1524816382, 0);
INSERT INTO `tp_coupon_list` VALUES (112, 28, 2, 25, 0, 0, 0, '', 1524823260, 0);
INSERT INTO `tp_coupon_list` VALUES (113, 23, 2, 25, 0, 0, 0, '', 1524823263, 0);
INSERT INTO `tp_coupon_list` VALUES (114, 20, 2, 25, 0, 0, 0, '', 1524823266, 0);
INSERT INTO `tp_coupon_list` VALUES (115, 25, 0, 23, 0, 543, 0, '', 1527648249, 0);
INSERT INTO `tp_coupon_list` VALUES (116, 33, 1, 7, 587, 0, 1535610687, '', 1535607498, 1);
INSERT INTO `tp_coupon_list` VALUES (145, 34, 2, 951, 0, 0, 0, '', 1540633266, 0);
INSERT INTO `tp_coupon_list` VALUES (118, 34, 2, 210, 0, 0, 0, '', 1535990518, 0);
INSERT INTO `tp_coupon_list` VALUES (143, 34, 2, 864, 0, 0, 0, '', 1540212849, 0);
INSERT INTO `tp_coupon_list` VALUES (120, 34, 2, 222, 0, 0, 0, '', 1536118938, 0);
INSERT INTO `tp_coupon_list` VALUES (142, 34, 2, 845, 0, 0, 0, '', 1539931255, 0);
INSERT INTO `tp_coupon_list` VALUES (141, 34, 2, 778, 0, 0, 0, '', 1539334677, 0);
INSERT INTO `tp_coupon_list` VALUES (140, 34, 2, 785, 0, 0, 0, '', 1539254348, 0);
INSERT INTO `tp_coupon_list` VALUES (124, 34, 2, 353, 0, 0, 0, '', 1536408822, 0);
INSERT INTO `tp_coupon_list` VALUES (125, 34, 2, 401, 0, 0, 0, '', 1536571081, 0);
INSERT INTO `tp_coupon_list` VALUES (126, 34, 2, 213, 799, 0, 1536582012, '', 1536581573, 1);
INSERT INTO `tp_coupon_list` VALUES (127, 34, 2, 6, 0, 0, 0, '', 1536651006, 0);
INSERT INTO `tp_coupon_list` VALUES (128, 34, 2, 407, 0, 0, 0, '', 1536762672, 0);
INSERT INTO `tp_coupon_list` VALUES (129, 34, 2, 479, 0, 0, 0, '', 1536882159, 0);
INSERT INTO `tp_coupon_list` VALUES (130, 34, 2, 484, 0, 0, 0, '', 1536891991, 0);
INSERT INTO `tp_coupon_list` VALUES (131, 34, 2, 256, 0, 0, 0, '', 1536894114, 0);
INSERT INTO `tp_coupon_list` VALUES (132, 34, 2, 461, 0, 0, 0, '', 1536910992, 0);
INSERT INTO `tp_coupon_list` VALUES (133, 34, 2, 624, 0, 0, 0, '', 1537791910, 0);
INSERT INTO `tp_coupon_list` VALUES (134, 34, 2, 650, 0, 0, 0, '', 1537874190, 0);
INSERT INTO `tp_coupon_list` VALUES (135, 34, 2, 544, 0, 0, 0, '', 1538488548, 0);
INSERT INTO `tp_coupon_list` VALUES (136, 34, 2, 716, 0, 0, 0, '', 1538793446, 0);
INSERT INTO `tp_coupon_list` VALUES (137, 34, 2, 741, 0, 0, 0, '', 1538991365, 0);
INSERT INTO `tp_coupon_list` VALUES (144, 34, 2, 642, 0, 0, 0, '', 1540266410, 0);
INSERT INTO `tp_coupon_list` VALUES (146, 34, 2, 994, 0, 0, 0, '', 1540797852, 0);
INSERT INTO `tp_coupon_list` VALUES (147, 34, 2, 1027, 0, 0, 0, '', 1540881238, 0);
INSERT INTO `tp_coupon_list` VALUES (182, 41, 2, 2001, 0, 0, 0, '', 1544412990, 0);
INSERT INTO `tp_coupon_list` VALUES (181, 41, 2, 1118, 0, 0, 0, '', 1544357481, 0);
INSERT INTO `tp_coupon_list` VALUES (180, 41, 2, 1990, 0, 0, 0, '', 1544336161, 0);
INSERT INTO `tp_coupon_list` VALUES (179, 41, 2, 1986, 0, 0, 0, '', 1544268637, 0);
INSERT INTO `tp_coupon_list` VALUES (178, 41, 2, 1974, 0, 0, 0, '', 1544241272, 0);
INSERT INTO `tp_coupon_list` VALUES (177, 41, 2, 1903, 0, 0, 0, '', 1543971911, 0);
INSERT INTO `tp_coupon_list` VALUES (176, 41, 2, 1857, 0, 0, 0, '', 1543903028, 0);
INSERT INTO `tp_coupon_list` VALUES (175, 41, 2, 1864, 0, 0, 0, '', 1543861447, 0);
INSERT INTO `tp_coupon_list` VALUES (174, 41, 2, 1745, 0, 0, 0, '', 1543389713, 0);
INSERT INTO `tp_coupon_list` VALUES (173, 41, 2, 1570, 0, 0, 0, '', 1543040787, 0);
INSERT INTO `tp_coupon_list` VALUES (172, 41, 2, 1632, 0, 0, 0, '', 1542963180, 0);
INSERT INTO `tp_coupon_list` VALUES (171, 41, 2, 1610, 0, 0, 0, '', 1542898837, 0);
INSERT INTO `tp_coupon_list` VALUES (183, 41, 2, 2035, 0, 0, 0, '', 1544500885, 0);
INSERT INTO `tp_coupon_list` VALUES (184, 41, 2, 90, 0, 0, 0, '', 1544520529, 0);
INSERT INTO `tp_coupon_list` VALUES (185, 41, 2, 2041, 0, 0, 0, '', 1544521971, 0);
INSERT INTO `tp_coupon_list` VALUES (186, 41, 2, 2042, 0, 0, 0, '', 1544526906, 0);
INSERT INTO `tp_coupon_list` VALUES (188, 39, 1, 112, 0, 0, 0, '', 1544583088, 0);
INSERT INTO `tp_coupon_list` VALUES (189, 39, 1, 2053, 0, 0, 0, '', 1544584003, 0);
INSERT INTO `tp_coupon_list` VALUES (190, 41, 2, 2067, 0, 0, 0, '', 1544606493, 0);
INSERT INTO `tp_coupon_list` VALUES (191, 41, 2, 2052, 0, 0, 0, '', 1544606828, 0);
INSERT INTO `tp_coupon_list` VALUES (192, 41, 2, 2125, 0, 0, 0, '', 1544775712, 0);
INSERT INTO `tp_coupon_list` VALUES (193, 41, 2, 2179, 0, 0, 0, '', 1545094061, 0);
INSERT INTO `tp_coupon_list` VALUES (194, 41, 2, 2330, 0, 0, 0, '', 1545270069, 0);
INSERT INTO `tp_coupon_list` VALUES (195, 41, 2, 2391, 0, 0, 0, '', 1545392816, 0);
INSERT INTO `tp_coupon_list` VALUES (196, 41, 2, 2396, 0, 0, 0, '', 1545398573, 0);
INSERT INTO `tp_coupon_list` VALUES (197, 42, 2, 90, 1383, 0, 1553763508, '', 1553504475, 1);
INSERT INTO `tp_coupon_list` VALUES (198, 42, 2, 4229, 0, 0, 0, '', 1553526887, 0);
INSERT INTO `tp_coupon_list` VALUES (199, 42, 2, 4237, 0, 0, 0, '', 1553576381, 0);
INSERT INTO `tp_coupon_list` VALUES (200, 42, 2, 4273, 0, 0, 0, '', 1555057716, 0);
INSERT INTO `tp_coupon_list` VALUES (201, 42, 2, 4279, 0, 0, 0, '', 1555065115, 0);
INSERT INTO `tp_coupon_list` VALUES (202, 42, 2, 4296, 0, 0, 0, '', 1555163144, 0);
INSERT INTO `tp_coupon_list` VALUES (203, 42, 2, 3844, 0, 0, 0, '', 1555290784, 0);
INSERT INTO `tp_coupon_list` VALUES (204, 42, 2, 4358, 0, 0, 0, '', 1555425571, 0);
INSERT INTO `tp_coupon_list` VALUES (205, 42, 2, 4373, 0, 0, 0, '', 1555483196, 0);
INSERT INTO `tp_coupon_list` VALUES (206, 42, 2, 4391, 0, 0, 0, '', 1555554824, 0);
INSERT INTO `tp_coupon_list` VALUES (207, 42, 2, 2125, 0, 0, 0, '', 1555555612, 0);
INSERT INTO `tp_coupon_list` VALUES (208, 42, 2, 4399, 0, 0, 0, '', 1555571560, 0);
INSERT INTO `tp_coupon_list` VALUES (209, 42, 2, 4415, 0, 0, 0, '', 1555659319, 0);
INSERT INTO `tp_coupon_list` VALUES (210, 42, 2, 4456, 0, 0, 0, '', 1555918830, 0);
INSERT INTO `tp_coupon_list` VALUES (211, 42, 2, 1212, 0, 0, 0, '', 1555919263, 0);
INSERT INTO `tp_coupon_list` VALUES (212, 42, 2, 4378, 0, 0, 0, '', 1556004325, 0);
INSERT INTO `tp_coupon_list` VALUES (213, 42, 2, 4486, 0, 0, 0, '', 1556070390, 0);
INSERT INTO `tp_coupon_list` VALUES (214, 44, 3, 0, 0, 0, 0, '6iQp2Sqq', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (215, 44, 3, 0, 0, 0, 0, 'y9vHH6Kn', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (216, 44, 3, 0, 0, 0, 0, 'yw3Q4kJC', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (217, 44, 3, 0, 0, 0, 0, 'BKCHNHgy', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (218, 44, 3, 0, 0, 0, 0, 'iTltLvNy', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (219, 44, 3, 0, 0, 0, 0, 'Jp3xE15n', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (220, 44, 3, 0, 0, 0, 0, 'AyE3FxBk', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (221, 44, 3, 0, 0, 0, 0, 'CpAFrp2J', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (222, 44, 3, 0, 0, 0, 0, 'Lno7muFA', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (223, 44, 3, 0, 0, 0, 0, 'lkoq4jl8', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (224, 44, 3, 0, 0, 0, 0, 'SAlSKjdn', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (225, 44, 3, 0, 0, 0, 0, 'el5jkTaF', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (226, 44, 3, 0, 0, 0, 0, '5AeSwkEk', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (227, 44, 3, 0, 0, 0, 0, 'j5iPln7A', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (228, 44, 3, 0, 0, 0, 0, 'mkweNSyy', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (229, 44, 3, 0, 0, 0, 0, 'gS5ij4Q7', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (230, 44, 3, 0, 0, 0, 0, 'k18kDeQq', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (231, 44, 3, 0, 0, 0, 0, 'x8pTHghc', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (232, 44, 3, 0, 0, 0, 0, 'ECEETwAH', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (233, 44, 3, 0, 0, 0, 0, 'BM14D89v', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (234, 44, 3, 0, 0, 0, 0, 'M4ubvgLJ', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (235, 44, 3, 0, 0, 0, 0, '1hDgEKzQ', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (236, 44, 3, 0, 0, 0, 0, 'zN2Au9LD', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (237, 44, 3, 0, 0, 0, 0, 'c2gm9qkJ', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (238, 44, 3, 0, 0, 0, 0, 'FC8Geesd', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (239, 44, 3, 0, 0, 0, 0, 'fA7Q7Ap5', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (240, 44, 3, 0, 0, 0, 0, 'Dortokgg', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (241, 44, 3, 0, 0, 0, 0, 'uxuED6Dx', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (242, 44, 3, 0, 0, 0, 0, '35A4jElx', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (243, 44, 3, 0, 0, 0, 0, '2uNxacFN', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (244, 44, 3, 0, 0, 0, 0, 'maeeNBHk', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (245, 44, 3, 0, 0, 0, 0, 'g9wTNJ4C', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (246, 44, 3, 0, 0, 0, 0, 'By5oG9vJ', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (247, 44, 3, 0, 0, 0, 0, 'HylqxBbA', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (248, 44, 3, 0, 0, 0, 0, '79hSwnHN', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (249, 44, 3, 0, 0, 0, 0, 'QmixucMP', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (250, 44, 3, 0, 0, 0, 0, 'r4rMEzLJ', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (251, 44, 3, 0, 0, 0, 0, '4F5gs35C', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (252, 44, 3, 0, 0, 0, 0, 'aEJpwwmH', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (253, 44, 3, 0, 0, 0, 0, 'KnLv1Af4', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (254, 44, 3, 0, 0, 0, 0, 'el8Nw9zv', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (255, 44, 3, 0, 0, 0, 0, '8bAel4lk', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (256, 44, 3, 0, 0, 0, 0, 'Ev8Qk3j5', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (257, 44, 3, 0, 0, 0, 0, 'jumoEh41', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (258, 44, 3, 0, 0, 0, 0, 'wMoqNm35', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (259, 44, 3, 0, 0, 0, 0, 'hkSb6fD2', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (260, 44, 3, 0, 0, 0, 0, 'EuEcHm4E', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (261, 44, 3, 0, 0, 0, 0, 'zmlcq6CB', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (262, 44, 3, 0, 0, 0, 0, '67EdpMGk', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (263, 44, 3, 0, 0, 0, 0, 'E4Sl1Tl6', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (264, 44, 3, 0, 0, 0, 0, 'HQfy92yK', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (265, 44, 3, 0, 0, 0, 0, 'NMkq7DhS', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (266, 44, 3, 0, 0, 0, 0, 'dPlbdNfq', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (267, 44, 3, 0, 0, 0, 0, 'qgGCHjh3', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (268, 44, 3, 0, 0, 0, 0, 'c8sT97Eo', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (269, 44, 3, 0, 0, 0, 0, '492kGCyL', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (270, 44, 3, 0, 0, 0, 0, 'jny1Arts', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (271, 44, 3, 0, 0, 0, 0, 'smCswb4h', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (272, 44, 3, 0, 0, 0, 0, '3SpDNxHz', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (273, 44, 3, 0, 0, 0, 0, '7BfsGh5i', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (274, 44, 3, 0, 0, 0, 0, 'F2CJssix', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (275, 44, 3, 0, 0, 0, 0, 'DSbDQdPn', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (276, 44, 3, 0, 0, 0, 0, '1qaDLfJw', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (277, 44, 3, 0, 0, 0, 0, 'Mc65MwEl', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (278, 44, 3, 0, 0, 0, 0, 'yoKh1ySN', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (279, 44, 3, 0, 0, 0, 0, 'PNLGEPFN', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (280, 44, 3, 0, 0, 0, 0, 'FESpExsq', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (281, 44, 3, 0, 0, 0, 0, '6FCHalk6', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (282, 44, 3, 0, 0, 0, 0, '4wiBEbrw', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (283, 44, 3, 0, 0, 0, 0, 'Fjoyknah', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (284, 44, 3, 0, 0, 0, 0, 'J3dMsPep', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (285, 44, 3, 0, 0, 0, 0, 'nzoLehht', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (286, 44, 3, 0, 0, 0, 0, '4FCCEoxM', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (287, 44, 3, 0, 0, 0, 0, 'NELHuJke', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (288, 44, 3, 0, 0, 0, 0, 'Ayvrff1H', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (289, 44, 3, 0, 0, 0, 0, 'mnF41HzK', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (290, 44, 3, 0, 0, 0, 0, 'tqyypix1', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (291, 44, 3, 0, 0, 0, 0, 'GJcgoLck', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (292, 44, 3, 0, 0, 0, 0, 'zLCkiuoE', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (293, 44, 3, 0, 0, 0, 0, 'r1kCLT48', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (294, 44, 3, 0, 0, 0, 0, 'ftNfBwrg', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (295, 44, 3, 0, 0, 0, 0, 'LxBCx8di', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (296, 44, 3, 0, 0, 0, 0, '2cu3dlNw', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (297, 44, 3, 0, 0, 0, 0, '5r2xsMQx', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (298, 44, 3, 0, 0, 0, 0, '23rSBHQT', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (299, 44, 3, 0, 0, 0, 0, 'pkC711yH', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (300, 44, 3, 0, 0, 0, 0, 'Tm7zQciB', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (301, 44, 3, 0, 0, 0, 0, 'njD7abdo', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (302, 44, 3, 0, 0, 0, 0, 'mltw6dcq', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (303, 44, 3, 0, 0, 0, 0, 'GAH91wcs', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (304, 44, 3, 0, 0, 0, 0, 'xpzJFckk', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (305, 44, 3, 0, 0, 0, 0, 'Ceu9mqAP', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (306, 44, 3, 0, 0, 0, 0, 'QaisT1g7', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (307, 44, 3, 0, 0, 0, 0, 'TlzTlJsd', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (308, 44, 3, 0, 0, 0, 0, 'LAqBrni2', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (309, 44, 3, 0, 0, 0, 0, '2dK7a1uf', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (310, 44, 3, 0, 0, 0, 0, '4lfCHTGi', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (311, 44, 3, 0, 0, 0, 0, '5x7gjlAE', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (312, 44, 3, 0, 0, 0, 0, 'zy8Tfu74', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (313, 44, 3, 0, 0, 0, 0, 'jtETNPMJ', 1562573180, 0);
INSERT INTO `tp_coupon_list` VALUES (314, 44, 3, 0, 0, 0, 0, 'KE41JcNm', 1562573521, 0);
INSERT INTO `tp_coupon_list` VALUES (315, 44, 3, 0, 0, 0, 0, 'k8M6Lfju', 1562573521, 0);
INSERT INTO `tp_coupon_list` VALUES (316, 44, 3, 0, 0, 0, 0, '5gSuG499', 1562573521, 0);
INSERT INTO `tp_coupon_list` VALUES (317, 44, 3, 0, 0, 0, 0, 'psjPmytn', 1562573521, 0);
INSERT INTO `tp_coupon_list` VALUES (318, 44, 3, 0, 0, 0, 0, 'rbF2G3JF', 1562573521, 0);
INSERT INTO `tp_coupon_list` VALUES (319, 44, 3, 0, 0, 0, 0, 'pm62e1xp', 1562573521, 0);
INSERT INTO `tp_coupon_list` VALUES (320, 44, 3, 0, 0, 0, 0, 'puhlfrva', 1562573521, 0);
INSERT INTO `tp_coupon_list` VALUES (321, 44, 3, 0, 0, 0, 0, 'jc46HJLJ', 1562573521, 0);
INSERT INTO `tp_coupon_list` VALUES (322, 44, 3, 0, 0, 0, 0, 'tTQ7dm6i', 1562573521, 0);
INSERT INTO `tp_coupon_list` VALUES (323, 44, 3, 0, 0, 0, 0, 'fzey339J', 1562573521, 0);

SET FOREIGN_KEY_CHECKS = 1;
