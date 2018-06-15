-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 10.20.1.88    Database: int_ext_manager
-- ------------------------------------------------------
-- Server version	5.5.30-log

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

--
-- Table structure for table `act_evt_log`
--

DROP TABLE IF EXISTS `act_evt_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_evt_log` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_evt_log`
--

LOCK TABLES `act_evt_log` WRITE;
/*!40000 ALTER TABLE `act_evt_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_evt_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ge_bytearray`
--

DROP TABLE IF EXISTS `act_ge_bytearray`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ge_bytearray`
--

LOCK TABLES `act_ge_bytearray` WRITE;
/*!40000 ALTER TABLE `act_ge_bytearray` DISABLE KEYS */;
INSERT INTO `act_ge_bytearray` VALUES ('250002',1,'YtCarLoan.bpmn','250001','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:activiti=\"http://activiti.org/bpmn\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" typeLanguage=\"http://www.w3.org/2001/XMLSchema\" expressionLanguage=\"http://www.w3.org/1999/XPath\" targetNamespace=\"http://www.activiti.org/test\">\n  <process id=\"YtCarLoan\" name=\"YtCarLoanProcess\" isExecutable=\"true\">\n    <startEvent id=\"startevent1\" name=\"Start\"></startEvent>\n    <userTask id=\"usertask1\" name=\"申请人确认申请\" activiti:assignee=\"${inputUser}\"></userTask>\n    <sequenceFlow id=\"flow1\" sourceRef=\"startevent1\" targetRef=\"usertask1\"></sequenceFlow>\n    <userTask id=\"usertask2\" name=\"初审\" activiti:candidateUsers=\"${branchCheckUser}\"></userTask>\n    <endEvent id=\"endevent1\" name=\"End\"></endEvent>\n    <userTask id=\"usertask3\" name=\"复审\" activiti:candidateUsers=\"${branchCheckUser}\"></userTask>\n    <userTask id=\"usertask4\" name=\"终审\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.mrbt.yeston.listener.HeadquarterCheckListener\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <userTask id=\"usertask5\" name=\"垫付账户放款\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.mrbt.yeston.listener.HeadquarterFinanceListener\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <userTask id=\"usertask7\" name=\"验收垫付款\" activiti:candidateUsers=\"${cooperateFinanceUser}\"></userTask>\n    <sequenceFlow id=\"flow20\" sourceRef=\"usertask5\" targetRef=\"usertask7\"></sequenceFlow>\n    <userTask id=\"usertask8\" name=\"是否发布产品\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.mrbt.yeston.listener.HeadquarterProductListener\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <userTask id=\"usertask9\" name=\"保证金申请\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.mrbt.yeston.listener.HeadquarterFinanceListener\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <userTask id=\"usertask11\" name=\"募集完成\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.mrbt.yeston.listener.HeadquarterProductListener\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <userTask id=\"usertask12\" name=\"借款账户放款\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.mrbt.yeston.listener.HeadquarterFinanceListener\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow28\" sourceRef=\"usertask11\" targetRef=\"usertask12\"></sequenceFlow>\n    <userTask id=\"usertask13\" name=\"供应商收款\" activiti:candidateUsers=\"${cooperateFinanceUser}\"></userTask>\n    <sequenceFlow id=\"flow29\" sourceRef=\"usertask12\" targetRef=\"usertask13\"></sequenceFlow>\n    <userTask id=\"usertask14\" name=\"归还垫付款\" activiti:candidateUsers=\"${cooperateFinanceUser}\"></userTask>\n    <sequenceFlow id=\"flow30\" sourceRef=\"usertask13\" targetRef=\"usertask14\"></sequenceFlow>\n    <userTask id=\"usertask15\" name=\"总部回收垫付款\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.mrbt.yeston.listener.HeadquarterFinanceListener\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow31\" sourceRef=\"usertask14\" targetRef=\"usertask15\"></sequenceFlow>\n    <userTask id=\"usertask16\" name=\"缴纳保证金\" activiti:candidateUsers=\"${cooperateFinanceUser}\"></userTask>\n    <userTask id=\"usertask17\" name=\"保证金收款\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.mrbt.yeston.listener.HeadquarterFinanceListener\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow34\" sourceRef=\"usertask16\" targetRef=\"usertask17\"></sequenceFlow>\n    <userTask id=\"usertask18\" name=\"是否催款\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.mrbt.yeston.listener.AdminListener\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow35\" sourceRef=\"usertask17\" targetRef=\"usertask18\"></sequenceFlow>\n    <userTask id=\"usertask19\" name=\"供应商还款\" activiti:candidateUsers=\"${cooperateFinanceUser}\"></userTask>\n    <userTask id=\"usertask20\" name=\"总部确认收款\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.mrbt.yeston.listener.HeadquarterFinanceListener\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow37\" sourceRef=\"usertask19\" targetRef=\"usertask20\"></sequenceFlow>\n    <userTask id=\"usertask21\" name=\"退还保证金\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.mrbt.yeston.listener.HeadquarterFinanceListener\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow38\" sourceRef=\"usertask20\" targetRef=\"usertask21\"></sequenceFlow>\n    <userTask id=\"usertask22\" name=\"供应商回收保证金\" activiti:candidateUsers=\"${cooperateFinanceUser}\"></userTask>\n    <sequenceFlow id=\"flow39\" sourceRef=\"usertask21\" targetRef=\"usertask22\"></sequenceFlow>\n    <sequenceFlow id=\"flow40\" sourceRef=\"usertask22\" targetRef=\"endevent1\"></sequenceFlow>\n    <sequenceFlow id=\"flow44\" name=\"通过\" sourceRef=\"usertask2\" targetRef=\"usertask3\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'通过\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow45\" name=\"通过\" sourceRef=\"usertask3\" targetRef=\"usertask4\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'通过\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow46\" name=\"通过\" sourceRef=\"usertask4\" targetRef=\"usertask5\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'通过\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow56\" name=\"发布\" sourceRef=\"usertask8\" targetRef=\"usertask11\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'发布\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow57\" sourceRef=\"usertask9\" targetRef=\"usertask16\"></sequenceFlow>\n    <sequenceFlow id=\"flow61\" sourceRef=\"usertask15\" targetRef=\"usertask9\"></sequenceFlow>\n    <sequenceFlow id=\"flow62\" name=\"拒绝\" sourceRef=\"usertask2\" targetRef=\"endevent1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'拒绝\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow63\" name=\"拒绝\" sourceRef=\"usertask3\" targetRef=\"endevent1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'拒绝\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow64\" name=\"拒绝\" sourceRef=\"usertask4\" targetRef=\"endevent1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'拒绝\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow65\" name=\"驳回\" sourceRef=\"usertask2\" targetRef=\"usertask1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'驳回\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow66\" name=\"驳回\" sourceRef=\"usertask3\" targetRef=\"usertask1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'驳回\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow67\" name=\"驳回\" sourceRef=\"usertask4\" targetRef=\"usertask1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'驳回\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow69\" sourceRef=\"usertask7\" targetRef=\"usertask8\"></sequenceFlow>\n    <sequenceFlow id=\"flow70\" name=\"不发布\" sourceRef=\"usertask8\" targetRef=\"usertask9\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'不发布\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow71\" sourceRef=\"usertask1\" targetRef=\"usertask2\"></sequenceFlow>\n    <userTask id=\"usertask23\" name=\"总部催款\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.mrbt.yeston.listener.HeadquarterFinanceListener\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow72\" sourceRef=\"usertask18\" targetRef=\"usertask23\"></sequenceFlow>\n    <sequenceFlow id=\"flow73\" sourceRef=\"usertask23\" targetRef=\"usertask19\"></sequenceFlow>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_YtCarLoan\">\n    <bpmndi:BPMNPlane bpmnElement=\"YtCarLoan\" id=\"BPMNPlane_YtCarLoan\">\n      <bpmndi:BPMNShape bpmnElement=\"startevent1\" id=\"BPMNShape_startevent1\">\n        <omgdc:Bounds height=\"35.0\" width=\"35.0\" x=\"80.0\" y=\"207.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask1\" id=\"BPMNShape_usertask1\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"159.0\" y=\"197.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask2\" id=\"BPMNShape_usertask2\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"360.0\" y=\"197.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"endevent1\" id=\"BPMNShape_endevent1\">\n        <omgdc:Bounds height=\"35.0\" width=\"35.0\" x=\"80.0\" y=\"630.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask3\" id=\"BPMNShape_usertask3\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"573.0\" y=\"197.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask4\" id=\"BPMNShape_usertask4\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"781.0\" y=\"197.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask5\" id=\"BPMNShape_usertask5\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"1010.0\" y=\"197.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask7\" id=\"BPMNShape_usertask7\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"1199.0\" y=\"197.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask8\" id=\"BPMNShape_usertask8\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"1199.0\" y=\"426.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask9\" id=\"BPMNShape_usertask9\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"1199.0\" y=\"530.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask11\" id=\"BPMNShape_usertask11\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"990.0\" y=\"426.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask12\" id=\"BPMNShape_usertask12\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"787.0\" y=\"426.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask13\" id=\"BPMNShape_usertask13\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"573.0\" y=\"426.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask14\" id=\"BPMNShape_usertask14\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"360.0\" y=\"426.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask15\" id=\"BPMNShape_usertask15\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"159.0\" y=\"424.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask16\" id=\"BPMNShape_usertask16\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"1199.0\" y=\"620.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask17\" id=\"BPMNShape_usertask17\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"1050.0\" y=\"620.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask18\" id=\"BPMNShape_usertask18\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"900.0\" y=\"620.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask19\" id=\"BPMNShape_usertask19\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"600.0\" y=\"620.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask20\" id=\"BPMNShape_usertask20\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"450.0\" y=\"620.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask21\" id=\"BPMNShape_usertask21\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"300.0\" y=\"620.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask22\" id=\"BPMNShape_usertask22\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"159.0\" y=\"620.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask23\" id=\"BPMNShape_usertask23\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"750.0\" y=\"620.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge bpmnElement=\"flow1\" id=\"BPMNEdge_flow1\">\n        <omgdi:waypoint x=\"115.0\" y=\"224.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"159.0\" y=\"224.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow20\" id=\"BPMNEdge_flow20\">\n        <omgdi:waypoint x=\"1115.0\" y=\"224.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"1199.0\" y=\"224.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow28\" id=\"BPMNEdge_flow28\">\n        <omgdi:waypoint x=\"990.0\" y=\"453.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"892.0\" y=\"453.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow29\" id=\"BPMNEdge_flow29\">\n        <omgdi:waypoint x=\"787.0\" y=\"453.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"678.0\" y=\"453.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow30\" id=\"BPMNEdge_flow30\">\n        <omgdi:waypoint x=\"573.0\" y=\"453.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"465.0\" y=\"453.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow31\" id=\"BPMNEdge_flow31\">\n        <omgdi:waypoint x=\"360.0\" y=\"453.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"264.0\" y=\"451.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow34\" id=\"BPMNEdge_flow34\">\n        <omgdi:waypoint x=\"1199.0\" y=\"647.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"1155.0\" y=\"647.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow35\" id=\"BPMNEdge_flow35\">\n        <omgdi:waypoint x=\"1050.0\" y=\"647.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"1005.0\" y=\"647.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow37\" id=\"BPMNEdge_flow37\">\n        <omgdi:waypoint x=\"600.0\" y=\"647.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"555.0\" y=\"647.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow38\" id=\"BPMNEdge_flow38\">\n        <omgdi:waypoint x=\"450.0\" y=\"647.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"405.0\" y=\"647.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow39\" id=\"BPMNEdge_flow39\">\n        <omgdi:waypoint x=\"300.0\" y=\"647.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"264.0\" y=\"647.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow40\" id=\"BPMNEdge_flow40\">\n        <omgdi:waypoint x=\"159.0\" y=\"647.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"115.0\" y=\"647.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow44\" id=\"BPMNEdge_flow44\">\n        <omgdi:waypoint x=\"465.0\" y=\"224.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"573.0\" y=\"224.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"24.0\" x=\"501.0\" y=\"207.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow45\" id=\"BPMNEdge_flow45\">\n        <omgdi:waypoint x=\"678.0\" y=\"224.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"781.0\" y=\"224.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"24.0\" x=\"719.0\" y=\"207.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow46\" id=\"BPMNEdge_flow46\">\n        <omgdi:waypoint x=\"886.0\" y=\"224.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"1010.0\" y=\"224.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"24.0\" x=\"919.0\" y=\"207.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow56\" id=\"BPMNEdge_flow56\">\n        <omgdi:waypoint x=\"1199.0\" y=\"453.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"1095.0\" y=\"453.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"24.0\" x=\"1141.0\" y=\"438.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow57\" id=\"BPMNEdge_flow57\">\n        <omgdi:waypoint x=\"1251.0\" y=\"585.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"1251.0\" y=\"620.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow61\" id=\"BPMNEdge_flow61\">\n        <omgdi:waypoint x=\"211.0\" y=\"479.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"211.0\" y=\"557.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"1199.0\" y=\"557.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow62\" id=\"BPMNEdge_flow62\">\n        <omgdi:waypoint x=\"412.0\" y=\"252.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"412.0\" y=\"291.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"97.0\" y=\"291.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"97.0\" y=\"630.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"24.0\" x=\"290.0\" y=\"269.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow63\" id=\"BPMNEdge_flow63\">\n        <omgdi:waypoint x=\"625.0\" y=\"252.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"625.0\" y=\"325.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"97.0\" y=\"325.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"97.0\" y=\"630.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"24.0\" x=\"290.0\" y=\"309.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow64\" id=\"BPMNEdge_flow64\">\n        <omgdi:waypoint x=\"833.0\" y=\"252.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"833.0\" y=\"362.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"97.0\" y=\"362.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"97.0\" y=\"630.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"24.0\" x=\"290.0\" y=\"339.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow65\" id=\"BPMNEdge_flow65\">\n        <omgdi:waypoint x=\"412.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"413.0\" y=\"172.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"211.0\" y=\"172.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"211.0\" y=\"197.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"24.0\" x=\"289.0\" y=\"161.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow66\" id=\"BPMNEdge_flow66\">\n        <omgdi:waypoint x=\"625.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"625.0\" y=\"143.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"211.0\" y=\"143.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"211.0\" y=\"197.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"24.0\" x=\"290.0\" y=\"131.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow67\" id=\"BPMNEdge_flow67\">\n        <omgdi:waypoint x=\"833.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"833.0\" y=\"108.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"211.0\" y=\"108.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"211.0\" y=\"150.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"211.0\" y=\"197.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"24.0\" x=\"290.0\" y=\"91.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow69\" id=\"BPMNEdge_flow69\">\n        <omgdi:waypoint x=\"1251.0\" y=\"252.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"1251.0\" y=\"426.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow70\" id=\"BPMNEdge_flow70\">\n        <omgdi:waypoint x=\"1251.0\" y=\"481.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"1251.0\" y=\"530.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"14.0\" width=\"36.0\" x=\"1251.0\" y=\"499.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow71\" id=\"BPMNEdge_flow71\">\n        <omgdi:waypoint x=\"264.0\" y=\"224.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"360.0\" y=\"224.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow72\" id=\"BPMNEdge_flow72\">\n        <omgdi:waypoint x=\"900.0\" y=\"647.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"855.0\" y=\"647.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow73\" id=\"BPMNEdge_flow73\">\n        <omgdi:waypoint x=\"750.0\" y=\"647.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"705.0\" y=\"647.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>',0),('250003',1,'YtCarLoan.png','250001','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0�\0\0#\0\0\0�mq\0\0n�IDATx�\�\�o�$\�A\'�!$d���p���i\�EF\� y_\�q� q0pQ���\0#ta� \�`V\'#\���F��A\�a$�\�@\�\�\\\�	K\�\�\��!�I\�a\�I�\��\�\�n]\�=n������\�\��|�h\�\�S\��t=\�\�z��\�I\0\0\0\0\Zi&v\0\0\0\0\�,\0\0\04�e\0\0\0��,�\0\0\0\0\reY\0\0\0h(\�\"\0\0\0@CY\0\0\0\Zʲ\0\0\0\�P�E\0\0\0���,\0\0\04�e\0\0\0��,�\0\0\0\0\reY\0\0\0h(\�\"\0\0\0@CY\0\0\0\Zʲ\0\0\0\�P�E\0\0\0���,\0\0\04�e\0\0\0��,�\0\0\0\0\reY\0\0\0h(\�\"\0\0\0@CY\0\0\0\Zʲ\0\0\0\�P�E\0\0\0���,\0\0\04�e\0\0\0��,�\0\0\0\0\reY\0\0\0h(\�\"\0\0\0@CY\0\0\0\Zʲ\0\0\0\�P�E\0\0\0���,\0\0\04�e\0\0\0��,�\0\0\0\0\reY\0\0\0h(\�\"\0\0\0@CY\0\0\0\Zʲ\0\0\0\�P�E\0\0\0���,\0\0\04�e\0\0\0��,�\0\0\0\0\reY\0\0\0h(\�\"\0\0\0@CY\0\0\0\Zʲ\0\0\0\�P�E\0\0\0���,\0\0\04�e\0\0\0��,�\0\0\0\0\reY\0\0\0h(\�\"\0\0\0@CY\0\0\0\Zʲ\0\0\0\�P�E\0\0\0���,\0\0\04�e\0\0\0��,�\0\0\0\0\reY\0\0\0h(\�\"\0\0\0@CY\0\0\0\Zʲ\0\0\0\�P�E\0\0\0���,\0\0\04�e\0\0\0��,�\0\0\0\0\reY\0\0\0h(\�\"\0\0\0@CY\0\0\0\Zʲ\0\0\0\�P�E\0\0\0���,\0\0\04�e\0\0\0��,�\0\0\0\0\reY\0\0\0h(\�\"\0\0\0@CY\0\0\0\Zʲ\0\0\0\�P�E\0\0\0���,\0\0\04�e\0\0\0��,�\0\0\0\0\reY\0\0\0h(\�\"\0\0\0@CY\0\0\0\Zʲ\0\0\0\�P�E\0\0\0���,\0\0\04�e�`fff\�m\0\0\0B2�\�\��\�3ZI�\�\0\0\0ug�\��n����W\0\0\0L\�\\Bym\�\�{R\0\0@�̵ ��E���!�7>;cY\0\0�\�Z\��!\�I�\0\0@�̵ ��@2�w\0\0��kAP9�E|�\0\0 \0s-d\�׋�\�U\0\0��̵�t\���z\0\0\�2ׂ�үI��\0\0\0�f���\�j�w��|l\�\�\0\0h s-\0\0\0��,�\0\0\0\0\reY\0\0\0h(\�\"\0\0\0@CY\0\0\0\ZʲS�\�\�noo�9sf�E�V+��\�@\r�w�Ǿ\�qpkk�\�\�\�>,@\�Ya�loo///\�\�\��n��\�nǮ\Z\0��w�;<����KKK\'N�\�777cW\r\0j˲Saww�\�?ǜ�@���3XXX\�\�ى]\0�!\�\"ķ��5??\�;\�]\0�R\�ϟ_XX\�\�؈]\0�\�\"D������\�\�\0��\�\�:uj}}=vE\0�V,�S�\�^XX�&\0yt�\�\�\�\�s\�\�Ů\0ԇeb:y�s;\0ȯ\�n\�\�\�w�\�\����,B4���\�\�˱k\0s��鵵�ص\0���,B4KKK[[[�k\0���3??�\0P�E�cwwwnn.v-\0��|\n\0�bY�8|�\0&\�s4\0P\�\"\�\�|\0&\�\0�(�E�cqqq{{;v-\0��|�\0Ųq�P4\0L�\�n�Z�ص\0�:�,B���\�)]\�Z\0@U\�\�8��8�ǉ\':�N\�Z\0@UY�B8���9\08GR\0(�*q8��\�p$�B8���9\08GR\0(�*q8��\�p$�B8���9\08GR\0(�*q8��\�p$�B8���9\08GR\0(�*q4�d��\�7|W\00�\0(�*q4\�dn�O��\�\��H��`�94\0@!P���\'s\�:�ǜ���\Z\0��\�Ѵ���׆��\'\�\�\0pȡ\0\n\�JM;�X�\Z\�c\�3M\�]\0drh\0�B8�G\�N憯\r�M�\r\08\�\�\0\0�p@%���\�\r\\\0�y�ȸ\0p��\0\n\�J�=�˹,\�C4\0�sh\0�B8�GO\�F~���\\`2\r\0PT\�h\�\�ܸ\�>��^\0&\�\�\0\0�p@%�ƞ̥_-�\"Nu�V\r\0PT\�h\�\�\\�����\�\�ǖ]=\0�š\0\n\�J)\'s\�nw{{�̙3�/j�Z\�WR\0��7��E�qikk�\�\�-a�\�\"\0PT\�y2������<;;{0�\�~Q�\�^A�kz\�\�\�X\�����N�8\��677cW���,\0�p@%����\�\�݃��5\�\0�\��\Z\�\�\�\�\�\�N\�\�\\�E\0��\�\�2���5??ߛfī���?~aaacc#vEh(\�\"\0PT\�8<�\�\�\�\\\\\\�Y}���\�\�S�\�\�\�cW�&�,\0�p@%����v����`M��n����x\�ܹ\��q,�\0@!P�\�\�d\�\�ɓ\�@յ\�\����n��\"4�e\0(�*q�N\�677���cW�\0�O�^[[�]�Ų\0\��8z\'sKKK[[[�+P�������ص�Y,�\0@!P��w2777�\0��@�,\0�p@%�\�ɜO\�\0u\�s4fY\0\n\�J��9��N|_�Y�B8�G\�dn{{;v-\0\n\�\�E̲\0\��8z\'s>�\�I�\�n�Z�kA�X�B8�G\�d�7��]�\"����@!P��w2\�\�tb\��H���$o\0PT\�p2ԏ���\�\r\0\n\�JN\��1���@!P��\�\'s�o�\�\�Dw&$y�B8�G�N\�f��ߙ����Po\��tUB�7\0(�*q4�dn\�]����W��\�U	I\�\0��\�Ѵ���׆��\'\�\���\�U	I\�\0��\�Ѵ���E���!�7>;Ӵ\�����@!P��i\'s\�׆�\�&�0\�tUB�7\0(�*q4\�dn\��̫E\�\�\0���JH�\0�p@%�ƞ\�\�\\�!\Z�\"]��\�\r\0\n\�J\r<���\"�r\�DW%$y�B8�G�N\�\�]�\��B\�誄$o\0PT\�h\�\�\\�\�\")\�T8\n]��\�\r\0\n\�J)\'s\�\�\�w\�q\�\�ӧ_\�j�җ��^�p\�m��r\�ܹ���<fLS	H\�\0��\�1|2���ӛ\�\�\�\�\�{\�\�ֶ_\�n�cԑ)\�\��a\�\�^BN�<\�K\�\�\�x0=LS	I\�\0��\�\�2\�\�tVVV\�\�\�{\�\�\�\�݈��Zzi9{�l�\�Z]]\�v�����%o\0PT\�8<�\�\�\�\�Mk\�\�ףV�j;{�\�ɓ\';�N\�\�t���$o\0PT\�88�k�ۋ��>��?�\�ɓ�!.\�TB�7\0(�*q�N\�z3\���yk\"ekkkii)v-h4\�TB�7\0(�*q�N\�\�\�]jeyyyss3v-h.\�TB�7\0(�*q�N\�\�\�\�|\�b�\�\���y�\"\�TB�7\0(�*q�N斗�cׂ\ZZ\\\\\�\�ގ]\Z\�4��\�\r\0\n\�J��9}�2�={vuu5v-h(\�TB�7\0(�*q�N\���>e8��\�\�B\�Z\�P���$o\0PT\�\�\�\�\�\�Į5\�n�[�V\�Z\�P���$o\0PT\�\�\�u:�ص��L�E�I\�\0��\�\�d��H�\�!\�\0\��8�\�Q\�\"\�#$y�B8���9\�#]\�\"{�$o\0PT\�YZZ�\���W�b�ϟ�ٟŮ\Z�b�@,�GH�\0�p@%�����\�W��\��\�cW�Z1U \�#$y�B8�\�\�?>�&rp\�\�C=�jԊ��\�!\�\0\����雾�Y\�k�\�k���1v��Sb�=B�7\0(�*����\�5���/��\�<v��Sb�=B�7\0(�*��\�mo;X����\n\�*BL�E�I\�\0��D�W�\�`Y$vE�\'Sb�=B�7\0(�*|\��wy)���\�!\�\0\��8�\�Q\�\"\�#$y�B8�6K�\�\�\�\�8u\�\�\�\�b�՚i�\�{\�\�\�\�\����N��Y\�@��V\�w@���V	\�z@\\�Dl�M�Xi����^�\�q\�|\�;\��ݟz\�K{{\�,��\�\�w\�u׭�\�\�\�\'��.v\�T�h�VD\�\'~!ɛ�U���\�\�Fl�ɲH#t:�����o��\�\�>zi\�\�_��\�����svwwc7T���hE$~\���\�[����N@lĦ\�,�\�_o�[XXxǝ~i\�2���=\�\�\�\�v\�\�\���\�O�B�7y�q\�	��\�4�e��[YY\�\�W\�\��\�~ߍ7~\�\�\���\�O�B�7y�q\�	��\�4�e��\�\�ں�\�7\�]\�*yʯ�\�/\�~�\�\�n�j-ъH�\�/$y��\nWq��؈\r�E\�\�\��Z�\�>\�޻����\\x\�K\�_�Ɲ��\�M7\�DK�\"?�I\�\�B\�U\\\' 6bCbY�\�\�\�\�WVV�.?{XnZ�\����Q�*�\��۫����nډ�hE$~\���\�[����N@lĆĲH�-//\����|i�{�\���$���|r/��\�\���\�}.��\��\�S���C7�H7�\�\�\�}\�\'t\�C?{\�\�Eq���\�naa!v\�M;\���\�O�B�7y�q\�	��ؐX������~`\��3eff\�B�<s5y\�r�\�KɳI�K��[3����o^~l/y�b�\��I��|\�r�W�\���3\r,�yrvv6v\�M;\���\�O�B�7y�q\�	��ؐX�\�\�nnn�9sfyyy�EKKK�{666:�N\�\n\�u\�ĉ/<�\�\�\��7r={%�x\�گ._��\�߼�o��;�\�7~�.\'\�ӗ����/\�%����{?�?\�]hf\���\r7�DK�\"?�I\�\�B\�U\\\' 6bCbYd�\�\�\�\�\�\�\�\�\����3g\�\�]\��\�\�\�y\�o�\�o�:u�7v�<yr}}=ve�\�UO�ޏ\�\\N�|.�t\�\r:�\����\�\���\�\���w5��?�}��<�Q\�0�I���\�W�<�\�\�\�=|��_U\�7��i��)\�[EsUq��N\'�\�\"�Ο?�������\����\�\�\��rχ>|\�?�������\�i���?,׆�+\�\�&�_H��\�\�ŋ�ox\�\�̗\�\�̾\�\'n\�\�}�?0�\�F\�\\&ѪP��_����Y��щ_�\�7��i��\�\�[sUq���N!�\�\"Ξ=������?�� \�_\��\��7\�x\�m�\�\�\�vc��\�����\��EqO>�|\�\�\��\�\'�=�/\�]wݗ��+��u_{\�\'_6\�\��\��ۨb�\�$ZՍ\����o\\je&#~Ս߀J�Q\�*��J\�$\�Z��N�\�\"\�n�ԩS���GZ\�/�ߟ�\�\�\�\�\�\�n\�2\��P\�9,����|�{m���瓻\�\��\�\��k�\�\�_w\���/�\��$�p1y�\�\�s\�ށ\�6�\�2�V\�5|y���8ͳY\\\�W��\r�V\Z\�*y�V�J\"�U�\�T�!i��H�\�=y�\�\�\�\�\�k\"���\�=O�ݎ����\�\�\�_:,��7\�=��|\�R��>�P��\����~��>1y��|��<y1\�\rt�|\�ށ\�6�\�2�VU�ux\��\�#o�\��T�hį*�n�*�Qަ<o\�UI\�u\�\�:�\�FlH\Z�,r\�ԩ㯉~�\�\�ɓ\��i���j�?�O��s\�w>t�·�ć?�\���\�\����O��O�\����C��?�\�\'��O�\�η\��\�\�Íanj�V��u8aH�\�\�D2��P��\�.�Z\Z\�m��V\�\\�D\\�?�SHlĆ�\�\�\"gϞ=\�gg�\�]w�kyy9�\�z��a\��\�~\�\�F�7�Ooy\��Us�D�B\�:�0���MF\���/�_�\�7\�vI\�\�(oӟ�*\�$\�:�q�Bb#6$�]9��\�\�B�k\"\�g�\�\�\�\�o\�%�\�ܓ\�Q�a.�hU(Z��aÛ\rܞξ ~�\�p\�%UK��Mު����\��\�u\n��ؐ4vYdaaᾏ\�_��ȣ�}\���oM\�Gi�\rsW���\�2�V��5s��GM�3:�P��\�.�Z\Z\�m��V\�\\�D\\�?�SHlĆ��\�\"���\�\�˅�����\�\�\�\�b�\�\�sO(G-��L�U�h��0��?\�\�\�\�įB�n��ji��\�\�[sUq���N!��f.�,..��\���,�\�g�����_�?\�}^9j1\�e�\nE+ϋL*���U(~\�m�s�i�\�y���U1W%\�\�\��!i\�H�\�9q\�DIk\"\�n8w\�\\\�7z\��0��r\�b�\�$ZU�V������|�0n��\"~U�\�p\�%L��My\�*����\�\�u:��ؐ4pYd}}}ee�\�e�߽��\�\�\�`\�hcc�\�n��\��0���\���hE$~\���\�[����N@lĆt�k\�\�n�\�;\�(uY\��w`qq1\�\��\�\'>q��}\�k\�뮁\�\Z\�s-ъH�\�/$y��\nWq��؈\r�\ZלKKK\�~\�{K]�\�#�����0o�\�\��\��8\�^��W}\�w~g�J��0�o9\�ȍ�\�\�|Μ/Z\�\�U\�\�\�\�4\�4+0ZŖ	Z3VUEkbS��FG�*j\��?N�\�e\�5g̎t~5q\\�ʑzG\�\�\Ze�\�l�c�l���Ʀi\Zל%�i\����gfgg����������ʯ�\��\�?\���ʕ\�\�,\�6>�\�4 \��?dܓ��XR�����YQ\�*��L\�a\�k��(�\�[�2�3~�/-~5�y�\�p�䭙\n�\�@\��l6p\�p����	G\�?�c\�ioB\\K\�F�¸3�Qx K\Z��Fi\\s��G?�X�\�\"�\�\�\'���\��dHW�<�R&x`�\�\��U�6\�O8�\�2\�<���4\�4;\�.-�W`f(K\�u�Us\�*V�\�2~\��X5�c�\�d\�\�\��\��\�Q����)\�3�g��\�#�\�5����l�끢z�\��K\��\�T)��#뜾Y\�7���\"5�9\�\�\���\�,�{G�{\�\�;��\�Ⱦ�������ٔҿ��\��w��ϙ��#հ�:?*X�M�\�D�\�rX�<�[Uњ\�\�\�\�H1���¼��r�����&+<�\�G\�qg_çU\�\�\�\�2JG>w\�@�\'\��[�t��r)�0|gJ;\�2B\�\�\�4J㚳7��\�\�\�E:�\�Ao��������޿��\�\������\rF\�~q(��\�\�Ly��\�\�\��\�)\�VF��_\"L�M�cF�Ԓ3c�Ѫ-Z�My�ң%~�3�y\�L��F)#���\�q%�\�j �Ï\ZW�\��\�e>\�\�٦\�q-{�Ko�\�8\rl6\�\�\�d!i`l��q͹���;\�,uY\�}��n�v>�\�\�\�\�.--�Z�\�\�\�ި\��\�����)%�t\�mR�~\�\�ǽ\��f\�/7\�\�2\�<��a�o�3Z���)ʓ��\����?~)w�_\�T%o#���\�4\�\�5\�j\�\��9�e\�Z\�S��\�@�s�׉k٣\�@�l��ߎl��YFH\Z��i\\s����\�m�X\�\�;\��\�[*\�;\�\�\�\\__��\�3G�#�ʧ���Ʀ�\r�/G>[\�u6̍s�h�W\�e\�}�X\����\����+s�fә��1m c�\�X�\�u\��:\�w�6n��^s\n�\'�#\��T\�ޅ��T\�(�g\��\�\�P\�2B\�\�\�4J㚳7�Z�R�En��歭�\�o���\����ҿA\�\�Q�\\\�\�\��/=�T\�\�y\�n�\�t\�.\�,���(�\"\�*\�4�c\�ߊ_\rD\�[G:�\�[3M\�� ]7ҏ\�\�\���\�O5|j7\�\�5���<\�8�e�\rd\�!�\�kbs����O_x\�ĉ\�*�k��j;��5^;���1�ǁ{\����\������:�\�-��n\�\�ܓ%�qI\�o�̐Īy즫�\��\�įN�7\�p;\�	d�j\�[\�l�����e͌?y;\�X����q�LQ\�\��\�3��\�L\�YFHĦ��؜�~�\�\���ޓ\�~�/\�\���N)�d\�u\�5��F\�\�����_n\�ǹ�^\�\��\�]\�=YR���D��4|\�c7]Dl\�\�\�)�G�\�\�\�a\�F\�D\�\�7A��)\�<\��sܙؑb�\�\�\'�#gq\�\��\�\�\�3�qg�7\�\��\�\�C\"6�\�\�\�\�v��V\�\�\�>Vƥ\"�}kww7�[|�~\����e\�\�/�D�����؁\�\���{��>�Q뜾+b7ݴ;R�\n/#C2�}\�VU�\�0\rm���\�NC�\�\�jđ\�J���q\�5]\�N��:�B7R�m\�Y��\�T\�Бr�?n����8�e�Dlj��͹���\�[n���\"\�\�\�#9˸�\�\�\�\�\��%\�\�~;pO�S\�\�1뜹+b7ݴ;R�\n/���q\�VU�\��M��B2\��ژ�FL\�\�TUUޢ8jf��K\��\�[\�<��\�ᓏ�C���\�2t�7YJ���9gKy\��,#$bS{\�m\��\��\�w�&�?|��\�?}\�\�\�\�%�\��S\�Q�a.�h�VD\�\'~!ɛ�U���\�\�FlH��,\�\�tn�ᆢ�{��/<y��\�\�Gb���\�\�>��\�2��hE$~\���\�[����N@lĆ�\�\�\"=;;;7\�pçy\��k\"?�?�\���7�\Zd�3̕D�D+\"���\�M\�*D\\\�ub#6$\r_\�9���\�_χ>|�\�\�\�p\�\rS�&�\�sW�~B9j1\�e-ъH�\�/$y��\nWq��؈\r�e�d�\�47\�x\�o�\�o=�\'�� ��g�\�\�o?�$N\�71\��0�\�\�Q�a.�h�VD\�\'~!ɛ�U���\�\�FlH,�\�v�������7\���\�\���g򬉼\�\�;{ۿ\�m��\���]�����\�\�0�I�D+\"���\�M\�*D\\\�ub#6$�E�\�\�\�>}�ĉ?�?��;\�\��,��\�y\�;���\�rKo�[o��v��\����R�Zs�DK�\"?�I\�\�B\�U\\\' 6bCbYdX�\�\�\�\�\\YY���\��Vv\�r\�\�\�F�Ӊ]\�\\fgg�{W?��\�2��hE$~\���\�[����N@lĆĲH��Z�O�\�^}X9R1\�e-ъH�\�/$y��\nWq��؈\r�e�z[ZZ�_[w\\M�Q\�_�i\�o\�\�\�c7ݴ-ъH�\�/$y��\nWq��؈\r�e�z;{�\�\�\�OG8�U���ﮬ�\�n�i\'Z����_H�&o\"�\�:�\�\"�\�n�\�\�\��\�}W����ey�M�����nډ�hE$~\���\�[����N@lĆĲH흹涫\�ǔ<\�n�\�S��b7Z5��hE$~\���\�[����N@l\�\�\"5\�\�v�\�ܹ��$*\�ew�\���o\�t\�\�h\� Z����_H�&o\"�\�:�,�\�\�\�\�\�\�\�vv6�\�2��Ƹ\��`{�\�c7W���hE$~\���\�[����N@lĦ\�,�4¹s\�z#\�ٳ�9IP�\�\�\�\�\�\�[\�\��-vCU�h�VD\�\'~!ɛ�U���\�\�Fl�̲HSt�\�\�Օ\�\�\�]_�/��\�K���N\��ll�ީS7///�n\�n��-ъH�\�/$y��\nWq��؈McYi�\�\�핕�87�f��9qⵧN��7\�\�n�:�~������\�[?y�r\�\�O\\s�~b\��E�Z�g\�H�Iހz3\��e�VffkD#~�$o@�\�FԀZq%\"�#$y\�\�(G0�Ԋ#(�!\�PoF9�5�VA�H�Iހz3\����\�JD\�GH�ԛQ�`D\r�GP\"?B�7�ތr#j@�8������f�#Qj\���ď�\�\r�7���\ZP+��D$~�$o@�\�FԀZq%\"�#$y\�\�(G0�Ԋ#(�!\�PoF9�5�VA�H�Iހz3\����\�JD\�GH�ԛQ�`D\r�GP\"?B�7�ތr#j@�8������f�#Qj\���ď�\�\r�7���\ZP+��D$~�$o@�\�FԀZq%\"�#$y\�\�(G0��\�\���q$���FD\�GH�ԛQ�`D\r9\�g�o3�Y\�V�\�ED\�GH�ԛQ�`D\r\�_I\� \�6�\�.\"?B�7�ތr#jP��\�>F�ג\�ON��!\�PoF9�5$�C4��I��\r\�\�+\"?B�7�ތr#jȸь�6d\�G��\�+\"?B�7�ތr#jȸь\\��,21���ď�\�\r�7���\Z�n�2�\�\�f�G�\�owwwnn.v-h.]��\�\r�7���\Zr�\�\rq�L�\�n�Z�kAs鹄$o@�\�F\� �<��\���\r鶶����bׂ\�\�U	Iހz3\���A \�\�\"��X�̙}�kAs骄$o@�\�F\� ��\�\��!�[dKKK[[[�kAs骄$o@�\�FԀ�\�\�\�m�Z\�n7vEh.\'p�$o@�\�FԀ�X[[;}�t\�Z\�hN\�Iހz3\���u\�\�v[�\�\�\�n\�\�hN\�Iހz3\���u�������4�8B�7�ތr#j@孭�\�v\�m�kN\�Jހz3\���\�\�vWVV��0%�����f�#Q*�\�鬭��Z-��az8�#$y\�\�(G0�T\����ٳg���[�\�\�ӧ}\�*S\�	!\�PoF9��c\�v��Iڙ3g_ԛ�\�\0�\���\�\�\�\�\�\�N�{\0�A3N\�Hހz3\���Mh{{{yyyvv�7I;s\�\���\�\�v\��8B�7�ތr#jG���{pa\�\�\�f\�\00E�����f�#Q;�������\�\�\�\�`\�8�#$y\�\�(G0�v�������\�\0�������f�#Q˫\�n/,,X`\'p�$o@�\�F\��:y�\�s\�b\��\�\���\�\r�7���Z.���\�\�˱k�TsGH�ԛQ�`D-�������ص\0`�9�#$y\�\�(G0��mwwwnn.v-\0�vN\�Iހz3\���e�	\Z\0�pGH�ԛQ�`D-\�\�ӧ\�\�\�b\��i\���\�\r�7���Z�\�\�\�\�\�\�ص\0`\�9�#$y\�\�(G0��͟\� \'p�$o@�\�FԲ�Z�v��\0L;\'p�$o@�\�FԲ�8q�\�\�Į\0\�\�	!\�PoF9��l:$\0y8^���f�#Q˦C��\�!\�PoF9��l:$\0y8^���f�#Q˦C��\�!\�PoF9��l:$�\���m*G�%$y\�\�(G0��M���A�2�\��f�\�\n\�\�\�\�\�\�\\\�Z\� �@�\�FԲ\��Y$}��\��\�j�ۭV+v-hG�ތr#j\�tH�iຏ��\Z��d�~`\�mmm---Ů\r\�\0ԛQ�`D-�I!\�?D3�y��\�\0\�\�̾ص�A\Z�z3\���e\�!)ĸь�6d\�!�鷴�����4�CPoF9��l:$��!��k�E�Zvww[�V�ۍ]\Zġ�7���Z6�c\Z��\��o��j&�!\Z�����ӧOǮ\�\�\�\0ԛQ�`D-�I!���!R\�\�v[�\�\�\�n\�\�,�@�\�FԲ\�\"\�\'b2?hL�������ص�q\Z�z3\���e\�!)D��\��e#�E�*\�\�\�n�\��ص��\Z�z3\���e\�!9�	���\��)\�\�vWVV���CPoF9��l:$\0�:�\�\�\�Z�\��\�\"r~ԛQ�`D-�	@\����ٳg���[�\�\�ӧ}\�*q9?\�\�(G0��-�Cv�\�\�Y�3g_\�;W��\05\�\�WWW777;�N\�\��4c\�\0ԚQ�`D-\�\�������<;;\�;K>s\�\���\�\�v�\n\0�c\�\0ԛQ�`D-\�@�\�\�\�=�0dss3V�\0��3a\0\�\�(G0����Cnmm\�\�\�oooǫ\0�	PsF9��l�rsssqq\�G\��\�L�z3\���e;\�\�v{aa��\00\rL�z3\���e;\�\'O�<w\�\\\�\0\0\\c\�\0ԛQ�`D-[�Cnnn.//Ǯ\0�L�z3\���e\�uȥ�����\�\0x�	PoF9��l�977�\0\0/1a\0\�\�(G0���\�!}�\0�*&@�\�FԲ�:\�\�\�Z\�Z\0\0�Ą�7���Z�^�\�\�ގ]\0���0\0�f�#Q\�\�\��4/\00UL�z3\���e\�u\�v��\0\0/1a\0\�\�(G0���\�!;�N\�Z\0\0�Ą�7���Z6�B\�	R�6�@\n�	�ތr#j\�tH\nq��!\�\�l��\0L=G�ތr#j\�tH\nѿ,��A\�m\08\�\�\0ԛQ�`D-�\�1\r\\�12Qג\�\0� �z3\���e\�!)D��h>/��A\0H��\0ug�#Q˦CR�q�ym\��u%B�\0��ތr#j\�tH\n1\�C4#\�>,�\0�Ρ�7���Z6�c\Z��\��o��j&�!\Z\0�84\0�f�#Q˦CR�#}o�\��bwwwnn.v-\0J\�|�`D-�I!�|\"&�6\0\�\�n�[�V\�Z\0�\�	0��Z6�B�/�\\6bY�[[[KKK�kP\"\'�#j\�tH�o�?�\�E\0\�̾ص\0(�`��l:$\00U������b\��Dfa#j\�tH\0`z\�\�\�Z�n��\"\0%2#Q˦C\0\�cmm\��\�ӱkP.�0��l:$\00%�\�n�\�\�\�ݍ]�r����e\�!�)�������\0�3#Q˦C\0\�`mm\��\�n�]�\�\�FԲ\�\0@\\\�nweeŚ\�fa#j\�tH\0 �N����\�j�|vh�0��l:$\0\����ٳg���[�\�\�ӧ}\�*\�4fa#j\�R:d�\�흵�9sf�E�s�\0�\�\�T���nnnv:���=\0SbƲ��Z��r{{{yyyvv�w\�r\�̙\��\�\�\�\0\0�\�\"#j\�:\�\�\�\���!�����\0\0Pc�EFԲ�wȭ�����\�\�\�x\�\0\0�9\�\"#j\�;\�\�\�\�\�⢏�\0\0�ʲ��Z��\�n���\0\0\0�Ͳ��Z��y�\�\�s\�\�Ů\0\0@�Y!Q\�\�됛��\�\�˱+\0\0\��EFԲ�:\�\�\�\�\�\�V\�\0\0\04�e��l�977�\0\0\0MaY�`D-[�C�\r\0\0@0�EFԲ�:\�\�\�Z\�Z\0\0\04�e��l�����\0\0\0MaY�`D-[�C�Ӽ\0\0\0�X!Q\�\�\�\�v;v-\0\0\0�²��Z�^�\�t:�k\0\0\��EFԲ\�\0\0\0!����e\�!\0\0B2#Q˦C\0\0�dF0��M�\0\0\�,�`D-�	\0\0�Y��Z6\0\0 $�0��l:$\0\0@Hfa#j\�tH\0\0��\�\�FԲ\�\0\0\0!����e\�!\0\0B2#Q˦C\0\0�dF0��M�\0\0\�,�`D-�	\0\0�Y��Z6\0\0 $�0��l:$\0\0@Hfa#j\�tH\0\0��\�\�FԲ\�\0\0\0!����e\�!\0\0B2#Q˦C\0\0�dF0��M�\0\0\�,�`D-�	\0\0�Y��Z6\0\0 $�0��l:$\0\0@Hfa#j\�tH\0\0��\�\�FԲ\�\0\0\0!����e\�!\0\0B2#Q˦C\0\0�dF0��M�\0\0\�,�`D-�	\0\0�Y��Z6\0\0 $�0��l:$\0\0@Hfa#j\�tH\0\0��\�\�FԲ\�\0\0\0!����e\�!\0\0B2#Q˦C\0\0�dF0��M�\0\0\�,�`D-�	\0\0�Y��Z6\0\0 $�0��l:$\0\0@Hfa#j\�tH\0\0��mll�&_����sss�_�\�\�\�\�Į\ZufͲ\0\0@\�����zf\�M7ݴ���jԙ	6\�\"\0\0\0e\�v��~���\�D\��\�7\�\�\�u:�\�U�\�L��Y\0\0\�\�~\�\�^�\�W.���\���\�\�j\�JQs&�\�,�\0\0\0�q\�u\���\�r\�-�V�\�\�Ʈ5gͲ\0\0@�\�_��W�faKKK�U�\0L��Y\0\0\�Moz\���H\�\�&�\�\�,\�\�v766N�:���\�j���\�!zｷ���\�\�\�}�\0\0L�\�\�\�\�I��\�K���g�.\�\"[[[�V\�ԩS\�|\�;\��ݟz\�K{{\�,��\�\�w\�u׭�\�\�\�\'\�\�\�\0\0xImfaL?Q\�V�\�\�tVVVn��\�G?�襽KJy\�O\�z뭽������*̅H\\����X$���D�X0\"w@\�\Z���\0f*�,\�\�\�\��\�/\�]Tƕw�\�\�7\�pC�ݎ\�\\�\�B$\"E$~\��J`�L�9�k�jO�è��\�\�\�\���\��Jzy�\�\��\�\�\�\\\�B$\"E$~\��J`�L�9�k�jO�è��\�\�\�\�\�7�y\�rW\�S~\�W��\�\'v�U��\\����_\\(��0L\�D�\�*<\���\�\"\�n�\�j}���\�\�\�<\�\�3_���7�\�\�\\�\�B��\�O�\�@	,��	X`\"\'r\rW\�	H\�]Y__\�q{��=,7-�p\�/\�T�\�\����\�\�j즫\0\"�)\"���$PK%`�ȉU���T\�e�\�\�\�\���/����\�K�\�\\I>��|�b�\�\�\��\�\����{쩏\\J���|��\��l�\�?�硟�\�碯PD)��\�\�\�B즛v.Dr!RD\�\'~qI��J�,0�9\�\"yTwYd~~�\�ػ�\�A齑I�\�\�\�\�\�/%\�&\�/��oͼ\�N�y���\�ыɣ\�\'\�n�\�\�_�����<\��r\�\'gggc7ݴs!\�ŅHE?�K%�T&`���ȑX\�c��\�\"\'N���\�]�pPzo\�\�+\�\�+\�~u�\��\���\��]��p9I���<��|q/\�$\��\��\��Hw����-��&(.D*���_\\(��0L\�D�ĲH՝$\�/m<}Xz?>s9y�\�ҕ6\�t:�\��;��Ǐ~\�\�ߚڻ�\\\�_.��Gxl�Ju[<\"�)\"���$PK%`�ȉ�e�<�;I\�����\\[��<�l���d/I.]�8��7\�\�|�\�\�\�[~\�\��\�w��mT�n�\�B$\"E$~\��J`�L�9�#�,�GuC�?T=uX��\'�K>�t��\����뮻\�\�_�_���=��/[����<�Q��-��\\����_\\(��0L\�D�ĲH\�\r��P\�9,����|�{\�j�\'�O\�w绯�ޯ���݉��ӿ��\�\�\�\�\�ً\�xϹ{ۨR\�ƅH.D�H�\�/.	��R	��&r\"GbY$�ꆾW�˗�tX\�\�sW�]���K\�\�\���C\�\�\��n����\�\��n��n�\�\�\�b�\��{ۨR\�ƅH.D�H�\�/.	��R	X�vX��\�E��\�\�)rLLsf�n\��6o��c��\��\�9w~\�C�\�|\�O|�c��\�|�\���\��\�����?��?�{�}�_�\�\�\�|\�-o��<aYdj�ɅH���\�%�X*�z��k2\���\����G�Bh\�l\�\r���\��\�/�\�\�\�\��\��6�T�Ńq!���\�O�\�@	,��U=`9�B҅�\���JG�Bh\�l\�\r��P��r\�R\�ƅH�����\�%�X*�z���\�q�c\���\\\�#G!4g�\��\�0w\�\�QKu[<�\"�)���$PK%`�	Xf�fr\\W�\�\�&r�\�\�V\�\�_\�<��T�Ń�q!��\�?�K%�TV��\�Y)L������X�0r�\�\�V\�\�\�/�|^9j�n�3\�B$\"\�#~\��J`��6K_\�8�qf\�C4q�Eb7_\�F�\�М٪��a\�q娥�-��\\����_\\(���zl`\�#�PLٲH��\\��\�qL�3[uC�?\�\�*G-\�m�`\\�\�B��\�O�\�@	,��\�#`\�#\�D\�o#r��Ǥ9�U7��E�]\�\�\�h�\�a\�pJ�ɅH���\�%�X*�A�\�-��l{Y$~V�LU\�8>͙���\�\��-�o3�Qy�*O9|�qO\�ʋ\�vΧ\Z�\����\�\��\�O�\���B�\���\�Hb\�͊[T\�\'~qI��J����\�^-2��\��DZ�߂�+՝!2�\�\�V\�\��j~\�\�\�2K�f\�����{Fn3�!\�?�n\�I�gze�\�\�g8܇w\�q\�\�\�\��3�n\�\�\�\�\�\�Fl\�)\�Z\�Ԋ\�d\�O�\�@	,��\�#`#8RV=\"N7D��\�Qu�3[uC���XJI]\�H{Ը\�6\��WO�\�ȗK\�,\�[;ܸ��vvv��ۿ���\'O�l�Z�[u*\�t�P\�<9_hf\n.2:\�HV\�&VT�<\�\�\�8\�9_E��\�dM3��\�s�L�A����LJ`N����6h��\�H�lKzk��P��d\�1mX�oGn�?u��3k2Y\�͙�������ٔ2n����o\�3|c\�S�|H�</7|��qO����Ͽ���9�7\\��o�\\����\�6\�&\�EF�/D�\�vLE�\�a��g\\~2�IƎ�<\�7�&k��$\�\�@�t\�\�\�\��\�_��LJ`N����n\��m�?Oz�\�(6�\�\�e�Q)\�3�W3c���A:j\�&�s\�\�Q�3[uC�\�\�M)\�6��\�\�\�;~�Uߡ�h�\���\�/����zf9h�v��?�\��-\�r��^�\�\�.,,\�nթ0�㢛\�Kr�t\�O\�\�~y�Q\�wmŭ��\�\�\�&O�\�3�#_Q�*\�8yK��\��m`�\��3��\'{%erFs+�\�\�iБ\�I\�`��xw3v�\��\�s���m\�\�\�|�\�W\��\�_e��~�\�\�\�\�Isf�n\�������q\�?~|y\�c��yc\�	\�my�\�\�\����^�k{�\�\�\�[[[��\�����\�^�\�Ww�݈m:%��j\�E79�T\Z�T)ϟ���\�\�\�\��\�.2\���+n\�VHsd\�\�H\��\��_\�M\�\"#2����wde\�\�pd\�_��LJ`NEu�\��?NJ<�� �F����G\�g`����$\�\�\'?N��\�����64g�\�~&ǲ\���({1%��<[�<p�J#�\�\�N�,\�\�\�vϜ9�\����\�j\�\��\�\�\�j\�鱿3���\�s�\�ȧ:��/�#.&�����_�t��\�\�\n�\�\��\�UfTRG\�A\��\�7\�\�(Ը�df`xp\�|l\�\\\�\�\��3)�9\�\�ǥ��q/%�%�#+\�d\r��\�����:\�m�>j\�͙���\�\�\�9f\Z;>s��#o�oy��\�G\�?�Z\��\�3��\�:��v��<�3\�\�����\�\�f�v�B3�ט�����&K[)X2\�~ܿ)�e\�*P`��\�V�BZg8�\�!�c�|\'<\�yį*&h�<\�\����6\�H��r)\'Ϥ\�T\�0N�\�&~�q�+\�\r�\�F˯\�v\�\���\�\�0a9�Nsf�n词W\�9K�\�\�\��1\�i_�\�?sz}�Tux��{�\�\�x0\�?ؤ��\�wR5�͕Qӆ�W\�s$.�j\�\��\ni�<yȟ�#%6�I��M�	ڥ�я4\��\��>�yOٙ���J�\�M�\�ʸ񰤷6�3,���K\��gX\��\�qJ?�f\�\'\�=�D�\�Ҝ٪�k��\�S\�����o�r\�K#\�\�\��_b\��\�;ǎhC\�9򅆟|�\�\�R\�f��1x�\�Q�B\Z��\'�\�qW\�9�W�.2��B$���FImF\�c\\h��2p{\�\�M�*g�v��A���;�i3���\�3)�9\��S\Zt�q3�\��<#sU\���B�i\�=<O\�F\�#}�\�y\�5��.rM�9�U7�\�:�\�I)l6p\�\�@6���6\�Iy\�q�L��\�_�Wx�Ƹ��{�\�M7\���d\��\�/��T�wl��\�)���\�\�\�\�&xױ��\ni�<O22\'\�rpc�!/�?����J��]���Cd\��i\\\�r&gdPG>��LJ`N\�v�\�\�\�3e�u���\�1#$`%��Q\�\rk�\�y=R��zG\�\"\��3[uC�\�\�W�;4��\�l\��\�m\�5���O�.�9S^(\�\�\��\�\��n̾\�&υ9��l3��\�̄�\�ȅH�\�\"�O�\'l9�\�O]捑\�#~�0A��\�\�\�hef`d\ZS\"z\���I	̩�^?��ӏ�)�R�+|�R\�4+\�d�2nXK	FfxRj�rT͓�q�m·�\\h\�l\�\r�~\'��r\�R\�f?Z\�\�\�\�0g\�G)4\�y\���)�BZd\\\��ߓ�\��ȍ\�r\��_�L\�(9Ǻ\�ܓ�9\�3\�Ϥ\�T`�Oi�힞�\�m�<d\�v\�N��i\�1-}L\�ƍ{W^>|\�\��*�x�^����\\\�i\�l\�\r�~\'��r\�R\�f?Z\�\�*\'�W��9�N\�EF9\�r즫��\�7\�y�\���O2�\�\�\�)~�3A��̑���{��%\�=s�����\��\��\\\�\�`�W\�F\���1=*%�;;��6\�p6��\�\�\�<N��\"\�p�3[uC?cYĲH9�����\�\�*���_\\(��0L\�D�ĲH\�\r}�\�W�~B9j�n�c\�͊[D\�\'~qI��J�,0�9\�\"yT7��\�\"���T�Ńqu�H�\�/.	��R	��&r\"GbY$�\�~YdG9j�n�\�B$\"E$~\��J`�L�9�#�,�GuC�?\���r\�R\�ƅH.D�H�\�/.	��R	��&r\"GbY$�\�~vv��\��z�\�ʑJu[<\"�)\"���$PK%`�ȉ�e�<��V��\�O�\�ի+G*\�m�`\\�\�B��\�O�\�@	,��	X`\"\'r$�E�n藖��\�\�W�T�\������\�M7\�\\�\�B��\�O�\�@	,��	X`\"\'r$�E�n\�Ϟ=���\�\�\Z�U���ﮬ�\�n�i\�B$\"E$~\��J`�L�9�#�,�GuC\�n�\�\�\��\�}W����ey�M�����nڹi�\�B�����\�%�X*��DN\�H,�\�Q\�e��3\�\�v5�����ύ�z\�\�R\�F�\0\"MP\\�T���$PK%`�ȉ�e�<*�,\�\�v�\�ܹ��$*\�ew�\���o\�t\�\�h\�B$\"E$~\��J`�L�9�#�,�G��Ezvvvް�\�\�\�qew�\�\�\�\�\�\���\�\�U.Dr!RD\�\'~qI��J�,0�9�=\��\�\�\"=\�Ν[Xx\�ٳ�9IP�\�\�\�\�\�\�[\�\��-vCU��\\����_\\(��0L\�D�\�O����H�?ޭ��,.~\���\�\�}_�ܯt:�gc\��N��yyy�w;vU��\\����_\\(��0L\�D�\�\�0\�/[=�Eloo���ǹ��0\�\�̉�=u\�\���Y*̅H.D�H�\�/.	��R	��&r\"\�d���g�F\�\"\�÷7׆�\\����_\\(��0L\�D��L��Y)��Z3.D\�\�B��į���\'��$�p\�O��~\"\���\�fL\�K`�\0\0㸺�`LM�����^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�1_ Q˦C��^\0\0\�9\�|\�p����0�Xd\�y\�`�\0\0\�\�dI^>�w{\�9ˮ6U$\�t�2ث\0\0�8\���{R�B2�Wh8!Ȧ���^\0\0\�ɹ,�\�#ϧlh&�Ȧ۔�^\0\0\����g\��\r\�D \�t�2ث\0\0�8\�_&2n\�q�\r\�\�A6���*\0\00\��g^\�?�\�\�3\�\�`J\�9Ȧ���^\0\0\�IY\rI_�\�\���\� �\�R{\0\0g࢏��\Zw]\�\�ߎ�A\�\�A6���*\0\00Nί\\\��ͬ�EG�\�-e�W\0�q�w��Z\��\�7��\� �\�R{\0\0\�H���6e\�\�L��M�)��\n\0\0�c�@0��M�,��\n\0\0�c�@0��M�,��\n\0\0�c�@0��M�,��\n\0\0�c�@0��M�,��\n\0\0�c�@0��M�,��\n\0\0�c�@0��M�,��\n\0\0�c�@0��M�,��\n\0\0�c�@0��M�,��\n\0\0�\�\�\�\�Mfggz7\�\�\�z��\�5�\�\�ى]5\�\�\�4�	|\�U\0\0�\�_��_\��馛677cW�:35\�f_{\0\0\�\�\�v_�\�W�����o���\�t:��F���f3�/��\n\0\0��_��W��\�\"?��?���\Z�RԜ�i6�2ث\0\0��뮻\�`M\�[ni�Z\�n7v��9S\�l&�e�W\0�a�\�_��W�\�KKK�U�\0LM�����^\0\0Fzӛ\�t�,�\"4��i6�2ث\0\0�H�������\�K��\�L\�\�`�\0\0\�/��e\�!\�`�\0��\�v��N�Z\\\\l�Z3M\�{\�=������\�\�מ�i��ث\0\00U���Z�֩S�\��\�w��\�?�\�#����Yzｷ\�\�[o���O\�\�\�c7%25\�f_{\0\0�D�\�YYY��\��죗�.)�\�/<q뭷�v\�\�\�n솢��\�L\�\�`�\0�4\�t:\��\�/\�]Tƕw�\�\�7\�pC�ݎ\�\\\�\�4�	|\�U\0\0�+++�k\"\�+\�\��w�\�\��?vsQ<S\�l&�e�W\0 �����o~�\�宒��ʯ��\���N\�F�`��\�L\�\�`�\0@\\\�n�\�j}���\�\�\�<\�\�3_���7\�\�\�\�n:�dj�\���*\0\0ĵ������w�\�\�r\�\�\�����jT���\�^]]�\�t\�\�4�	|\�U\0\0�kyy��w�\�Kk\"o��ߒ\�3W�O\�%��<x1�\�\�\�w}\�\�{\�#��\�&\�&�<��\��\�\�y\�go��\�+Q\�G\�?����\�(��i6�2ث\0\0\����\�?�w���\�;E��$\�\\M���|�R�l��ү�\�\�+�\�䛗\�K��<�|\�\�&����\�\�?��\�3\r,�yrvv6v\�Q$S\�l&�e�W\0 �\'N|\�\�\��._8(�S�g�$�\\�\�\�\������\�7~\�w�\�\���\�$y�r�\�^�Ž��$\��c�\�\"�Y\�ejFsf�2ث\0\0\��\�\�Ӈ��\�3��\'�K.]ya�N��������\�\�v{?\�]M.\�/�|��<�Q\�\\�f4g6�/\�\�\�l�ۍ]\0\0h����?,זE�$O<�<~!\�K�K/ο\�\r33_>33��������\����cU\�kFsf�2�Z�v��\0\0\�\\�KO��\�<�\\򹧓\�?�\���\\w\�u_�ʯ�\�\�}���|ٲȽ�్*f�5�9�	}Ο?�\0\0\�\\�K�\�\���\��׮y\��\�\�{w���\��گ��ם�\�?���z>I.\\L��x\����w్*f�5�9�	}���c\�\0\0��7ӹ|�K�\�`\��\�\�k_���K\�\�\���C\�\�\��n����\�\��n��n�\�\�\�b�\��{ۨb�X3�3�Зaeee}}=v-�_{w#\�Y\�|�\�x�b1\�.��>�?��$\�_�v\"\�r���?��`�\�gE7$2{\�٬N\�e���\�F9��\�ia$^n\�7\�ٰ{���_��\rcl\���\�ݝ\�l�\�nw\�KwOMU?�|>�i\�]]]]�|\�\��iv\0\0\�\�\�ژ���;\�\�\�\�n_����ͷ\��\�;O�\����|\����p���o�\�\����\�\'\�}\��\�Õ�\'�E(�8�9\��\����\�\�b\�{\0\0�j�E~\�^��\�\'\�z�\��P\��*w�#F����{a}}}zz�\�\0\0�x5\�\"O�~\�\�g>\'��\0@�ζE\�<��-w�#F����{\��\�\�W]uU\�{\0\0�j�ES��;\�#\�|N�=R�զ��677�\�\0\0�Q�-�s\�o�C1\�\�\�\�;kkk���U\�\0\0Ĩ\�yT�[\�G�8�9\��\����S\Z\0\0\�#+++�/5\�\"��\�r�8bę\�I�ז��\�\�涶��\�\0\0)�\�{o�W\�^x\�G�\�xU[D[���H/��%8z�\�\�\�\����W#\0\0P�Z�v\�9\�4;#\�w\�;\��\���i�E~VHelj�O\�\�-�\�t/,�۷Y]�O����\�\�\�\�:x�\�\�\�\�\�\�\�΃�����\0\0�7999\�\�5�y\�G?�\�Z�Vo\�\�9�\�B����W\�~�{���{�\��$\��>تS�H\�\�\�/\�\��\�ѣ���M��\0\0�8s\�\�Wk;\�\�\�xګ\�[\�@�:ƎmV}\�D�ę\�I\0\0굯}m�w0\�0;;���^�E\�}��Ӿ�\�\'�ڽ�cI\��Ӷ\�\�:)\�`�[�:U�$\�|Nz\0\0 D[[[͎����\�>���?WVVZ�6:\��^\�8����\rѹB��7ҽ��M%n!\�\n9\�0S\n\'\�|Nz\0\0 D>�\����\�\�\�\�\�\�\�\�R\�/l�~��jn�c;ݛm-\�~��\�\�\�i�w){�]uU��ę\�I\0\0juuuyy��д\�&H\�Dd�E2Zm�\�\�6k�Ehg>\'=\0\00z\Z��w_\�\�\�lkI���u\�\�#a˹�3���\�::�$\�|Nz\0\0`��\�lo\�ڷ�r�k��\�\���jV\�뽉�P\��VEg>\'=\0\00z\Z��v_�\�4��\�Zޱ0�_\�X�c�ُ�Z\'ls\�UGG�ę\�I\0\0��F�\�ǻ�\�vZ[\�\�AƦ�w/c�o/\�`���::�$\�|Nz\0\0`�4:\'w_\�I\�l��I}�}�\�\�^޾B\�F>ު��H\�\�\�\0\0FO�Sp�\�\�!�q\�s\�\0\0��\��O�[\�G�8�9\�\0�ѣ-�-B][�Nz\0\0`�\�\�\�lo߫�-w�#F����\0\0�\�i�E\�Q��;\�#\�|Nz\0\0`�4\�\"\�\�r�8bę\�I\0\0��F[\�n\�o�C1\�\�\�\0\0F\�����\�޶��#\�W�C1\�\�\�\0\0F\�\�\�\�|s{�.\�W�C1\�\�\�\0\0F\�\�\�\�\��~��C\�{ݽ�\�\�\�骣�Hn��i�\0\0\0�\�СCKK��\�V�\��5���UGG�\��\�\�\0\0F\�\�\�\���۞�ݲ]?�z�������VErßO[\0\0IϺb�~�\��j\�\����\�ϧ-\0\0��Z�6;��c\���^�Ce\�\�\�\r\�\�o\�ں�\�\�(��|\�\"\0\0��Z__��y\���j�~�J�\�\�fg߳��gU\�E�\��\�\�\0\0Fرc\�ff\�q\�\�\�\�뷩\�Z]��\�驵�?�:(���|\�\"\0\0�h�\�jKK���\�^^��\�\�o\�\�\�\�\�\�߯�|na\����\�\�\�#b��\�ϧ-\0\0\�`mmmq�7\'\'}�����޿��cao�\�\�7�-\0\0P�\�\�Ūw�X�\�ϧ-\0\0P&wa�Ʃ�τ\0\0(��0J\�T\�gB\0\0�\�]�q�\�3!\0\0\�\�.�\�8\��\0\0\0erFi�j�LH\0\0�2��4N�|&$\0\0@�܅Q\Z�Z>\0\0�L\�\�(�S-�		\0\0P&wa�Ʃ�τ\0\0(��0J\�T\�gB\0\0�\�]�q�\�3!\0\0\�\�.�\�8\��\0\0\0erFi�j�LH\0\0�2��4N�|&$\0\0@�܅Q\Z�Z>\0\0�L\�\�(�S-�		\0\0P&wa�Ʃ�τ\0\0(��0J\�T\�gB\0\0�\�]�q�\�3!\0\0\�\�.�\�8\��\0\0\0erFi�j�LH\0\0�2��4N�|&$\0\0@�܅Q\Z�Z>\0\0�L\�\�(�S-�		\0\0P&wa�Ʃ�τ\0\0\�k+++;7_\�\�\�333;&\'\'w��\��\�\�׫\�5F��|\�\"\0\0\0{\�+_�\�X�K/�tuu�\�]c��\�ϧ-\0\0�\�j�\��\�\�\�y׻\�599���U��1\�\��\�\�\0\0(�g>�s\�=�\��\�\'?���T�N1\�\��\�\�\0\0(\�E]\�\�\\v\�eSSS�Z�\�=bĹ\�ϧ-\0\0P�\�|\�;\�w\�\�]\�\�ܜ�U��\�ϧ-\0\0P�����ͶH\�;B\��\�\�\0\0(\�\�\�\�\�]�\�\�K9\��\�\�\0\0(��0J\�T\�7J�V����,,,\�\�\�NMMu�V�H\��\�\�\�\�///\��SӐǔA�M�C\'�\�I0t�&(��@\�c0�s\�_����\�|8\�sڧ\�����wmpG�ݙ\�;׸/}\�K߾\��O�|\�ԩ8k\�\�wF\�ȑ#�_~�Θ\�\\\�\�eb\n\"��\�ȔC/	�^�BLP|A\�\���E�}\�\�n�{\��\��޵Almm-..8pࡇz\�\���{����\�\�\�lnn�ihkxb\� A	�pI0��`\�%�\�k�_\��K\�\"\�}�ю�H�\�FN�8Q���m\�\Z733�\�_��N=�\�\�k_�\�\�_���!�a�\�c\� A	\�P�$zI0�\Z\�\�t|잶H�7��\�m�׽\�uox\��ީA,..6�qϩ\���\rߺ\�%�!�jc\� A	FR�$zI0�\Z\�\�t|잶H�VO\�.xի^�裏V�G};z�\�\�?u��z�O�\���\�?ӐWU1e���*	�^�$z\r[�\�:>\n�-�\�\�+�l�E^�\�W����\�j�����\�8u�Y\�K=��/�\�{Wɿ ]LAĔA���$zI0��`\�5T	�/\��(��H��\�;�\��zG������x\��3��t\�\���+�\�\�U]{\�]ZZӐW�1e��#,	�^�$z\rO�\�:>��-�\�\�o���\�\�\���_�|�{���\�\���\�w���\�\�w<_�\�Ӈ�|\�7�\��_��\�Z����M\�Կ�\\�\�t\�\�W|��+N%u\��c333b\Z�*?��`�%�\�K���C�\�IP|A\�GQ�E򍍅:J\�\�\�w\�u۩\�O7k\�@��ןޮ�\�t�/ԟ�\��\��\�\�9�h��\�9U\���C\�\�7j��O\��\�{w4\Z�OGXO=�\�������ʏ)�%aI0��`\�%�\�kx_\��Q�Po��T�V[]]=x�\����\�K\�\�\�v�,//�۪\'&&\�S��j\�Ε\�3�\�Ϝ}\���\�?������\��\�5��t��\�\���N\�q��U�\�w6.sO\�Y%7\�\�DL$(�8K���C/	�^C���������VWW\�\�\�s�\�\�\�\��\�__�ժ\�\��KՓ�\�y��\��\�\�_8�\�\n[[[�\��\��\�?�ӳ��S\��\Z��\�\�zG\�{���/sb\n\"��`�%�\�K���C�!IP|A\�GQ\���������\�6D\�MMM���V�\�Y\Z���ת���3�Ǟ�?�T�T��\��\�O�\�cc�666��y�o9~[\�{��*\�\"b\Z��2HP�q�C/	�^��$A�E\�\�2���\��� ���\�9�\�o\�pc�����\�Xs~~~kk�\�HָT��Uc��{\�\��O������-w����.��s_��\��\�\�G^q����\�;\�UU\�ӰǔA���$zI0��`\�5$	�/\��(J\�qnnnv��ȕW�\��\'O�p\�tZ=����\�\�\�\�����۫>��K\�V�v�>�]�E\�l���\�\�7�`�_\�{�o���ډ�\'�\�o��ןz��\��g\�xӱt�7���-\"�a�)�%gI0��`\�%�\�kH_\��Q��\�\�\�ؘ��ju7\�\�\�\"͑���l\�\�\�\�ǎ���:\�\�\�\�ӿlUs�\�\\\�~u��\�\�?}�\�wOl\���\��_���?_�V�y��\����\�M\��A\�{���\�\"b\Z��2HP�q�C/	�^��$A�E�7\�Z�\��s\"\�\\{m�\r���җ����x\�gF�\�\�t\\�f/�\�λ\�\�\���\�\�o>�~�m�~�Γ��}\�\�\�9~\�?�\�\�\�\�9vǽ\'\��\�u_�\�/�p嗛H.sb\n\"��`�%�\�K���C�!IP|A\�GQ\�saa�\�9r\�\��D�u˭\�\'&&�ۙ�����^�q��E{}\�S�\��o\�Co���h��i\�c\� A	\�Y�$zI0�\Z�\�t|%\�8WWW[Sz��i��}���>|�\�{Y\�2��\�J�̉)��2HP�q�C/	�^��$A�E�4Ι��fcnnn�=�f����\�\�\�Z�V��\�\�e\�\�\�ߪ�-R�!�X\��m$A	\�Y�$zI0�\Z�\�t|%\�8WVV�-����~���ȓO=\��\�4W]uUՇ��\�e\�1\�oU\������\��6��\�,	�^�$z\rI�\�:>�c����\��ŕW�n!=�f���\�\�\�\�\�DՇ��\�e\�\�ߪ�-R�QW\��m$A	\�Y�$zI0�\Z�\�t|%�8���Z�HQ?*Ҫ��u��嵵����\�e\�Q\�oU\������\��6��\�,	�^�$z\rI�\�:>�]�\�\�\�\�\�\�\�\�l�=����\�_�����?}eeecc���m\\\�6U��v�ۣ�\�DL���\���C/	�^C������@E\�W\\\�\�\\\��\�t׷o��������\�\�\�\�G>�\�K��\�K�ҹ\�r�\�\��\�DL���\���C/	�^C���\n��\�E\�\�\�\\�r���\��\'O67>55\��\�믿~||��|\��\�\�\�\�\�f9۸\�����Kڗw�\�\�K}�\�\�ۓv �-헹\�\��vc�ƪ\���ˌ��Ӧ\�nF�\�-�m�\�ɸ\�dCO0mpJ��6�����`/C=�<\�%�=\�+\����I��\��H\�\�zC�`�_�\��1��:\r\n��]��_\�{˭\�o�\�T\�t\�\�\�\�\������\�߿��c�\�v>�̙��WsI��\�u�\�\�X���\�ڷ\�� m7?(\�\�\�\�\�F �\�ʌ/{gz�\�CK|�;P%��\�[fL{�`��v�\�1�\�O�d�\�O��\�LZܱ%�{�go��q\��\�s \�\�(*�̍)7�3�\�p,e���W�	&F\��\�,?�\�!\�~5m�Ǻ�ɉ�SB�C�`Q\�ՑN�্|i�AQ�12����kt\�?yr/\�\"�\��~\�M�Μy�U��\�˻\�\�ek\�J\�N\�\n/u\�L\�[z\�\�\�I\\���%Ǘq,�V�\�^a���H�d���h�mj,3�ą�\�ս���w|\��#z�����{ƻr\�Xg���F>�\�\�\�\�\�τ\�M�\�e^&\�˘w�\���;�ܭ�Ip\�G�8���%c�XJL����wH,<��?\�\�؇�RN�B�\��Z�]�\�\�\�͹�û\�ڋ�H\�\�\�v>kcc\�}\�{ߛ\��\�ք��\�gffJ;\�\���Uͧ)W�W�\�Ke�+c;�\�\�X3w�z\�\�\�W{\�ɒ\�\�}\��\�e�Uڀ|�e\�Tl�\�^\�\��\�ݟ��${2v/LܟHL\�r.���Q�\�5�	�2�\�\��8O;V+-�L��ɒ�KK0w��qn\�ݟ�xю\�*��\�I���\�\������E\�\�Ȉ.\�VS�\�7\�XxO\�ǟhn|bb���G�}\�[\���7���\��\�_�\�\�9\�\�\��Y/]�^|ܾ��8���M%\�~o��\�iO�\'n�ca�v\�p\�\�\�^f|i\�\�{uQ\�@%�m\�>�Q�S�	���{$��,���\�\�\�\�O\�Ձ\r:�\�cI���\�8\�t�\��\�{�\�h\'�=h\�\�{����{�W�	�I�P�Ѥ%+�\�L�\�u/L\�u��\�}�L��ef:$	\���:\�9m�\�\"\�^��Ӡ\��\�Ź��؜��\�\�\�\"?�\�\�\�;Z�;׵��\�-o\�Y��\�\��\�^\��6��OZ\�zھ<m�^\�\�|\�\�:\�\�J\�N\��\�=\���\�\�~��B��\�\�O�\�>\\iggWՀ|�e\�Tl�io\�ݺ\�X�\�i����=�9�\�\����i�,w�\��\Z�32\�\�:w�vL\�ĕ\�\�+\�I\\�\�$\�1q\�I�\�\r�i+���\�s-\�\�:�Ibi\�1\�J8\r\n��\�E\�C��s��\��C\�m�k����񅅅\�\�\�\�X^^^]]-\�`\�.+�ޯV�\�d,ɽ��ri\�\�\�\"\�2�\�r/��������o��P�ͷ��xˌ�\��7m\0�G�=��\�#\�>1��\�嬋0�\�tǧ�	���\�M�\�\�\'�x����\�\�=��\�+�3\�\�\r1mk\�\�Ӿβ��22\�^\�\�%��L�$�B*\�k�{y\�\n�o\�\�\�`�\�#\\\�Ź��ޜ3O>�t�m�K.����\�Y\�zV\�*�`���v�Қ����Ӿ���\�\�I��\�wu|b���&\�d\�:\�ޱr�1\r\\;\�`V2\�o�1e(�2\�0c\�Co߫\�ǉK7�h\�)g�\�|vp�Cݾ��t�ߒ���F>�Brψ5-�\��<���H��\'�DEiڰ\'��Nv�c]\�\�\�\�\�tH\��Ae�X\�\�\��ħ%�#E�1Ω��\�8r\�\��D\�?y�5߶���>ʳ\�\��\�Vu<M�\�:\�+�m�����t��\�S\�\�X��ƴ\r\�i\�8�|�\�%�^�{2���xˌ)\�.0-�\�\�\�޾<\�?\�\��\�\�\�\�)[��EQ\�ރ(0��O��|����s/��\�g�\��qy\�=	&*�o2�u��˿�T��7�	~Pa��K\�uu�N�����\�\�\�\�Rs\"\�۷���w��[\�\�\�\�\�W}�/j\\hU\�i��]��\�%)\�-\�o\�~W\��]\�^���{�qhi;Y�e.c���\�\�\�iU>��S��+c\03v̸�%\�\�L\�1�A\�ْ�gl	�r§�a\�\�]`s�\�E^#�`Z������&滧yE�`ZR�+d/�`��3c<\�\�?7ٌ/��W��[oh,6�����ݔYi��\�\�GQb�skkkrr�9����\�Bz\"7\��\�\�U�\��\�*[c���Uͧ;�d���$q;��*{��$\�a\�8��VaL�U\�A��N%>�!�S�-qL�G�c֤M\�\�qN�S�L�\�7v\�\�n�\r:�3\�q̳��m\'�\"Vx^#�`��0O\�)9�\�̘Yi$ػ�3틬���\�K�{�\�$��#j�2�QJ�Z�����קA\��Q�H\�<|�psr���\��7�\��d�\�r\�WT}p/k\����z\�zt���\�[��\�啻�о<탺_Jܫ�MeB\�>gQڧW\�\0\�1\\i���NU>�Q�S�~�(#�\�Y��A\�\�M<�w���2Ι�O0cFd��;;23c\�3\�W�y�|��g�n\�i{U\�%�\�g\\�r	f+��4;\�\�\�ֽ�\�3g\�2�<E\�S\��\� J>\rB���\�\�����crr���\'\�<�\�\���\�kmjss�\�#{Yc\�߯���/sb\n\"��`�%�\�K���C�!IP|A\�GQ\�scccbb�\�θ\�\�\��Dz��VOd|||mm�\�\�z�\�e\�>\�oU\������\��6��\�,	�^�$z\rI�\�:>�u�kkk��\Z��u\�������\�̎ÇW}@�\\悸̉)��2HP�q�C/	�^��$A�E�=\�\�\�\�\�ό�5~7\�׾��^~H\�×]\��OԆ�\'Ro\\涷\�U�V�m�\�9\�\Z�o#	J0Β`\�%�\�K��א$(��\�(⬯��OOO��8�\�\�w�՟�\�]wuwC>\�uh_ybbb\��\�LK\�2w�귪h�T\��\��|IP�q�C/	�^��$A�E\�Y[[[Kr�\������0T�\�j�\�en]�[U�E�?\�\�jx��$(�8K���C/	�^C���������e�������\�n���ǎ�z�s4.sw�~���H�G\\\rϷ�%gI0��`\�%�\�kH_\��Qqv�\�j+++���333��������믿~�B�\�����\�޶��#\�W�|�S1e��\�,	�^�$z\rI�\�:>�\"\�Q655��\�\�޾K�U%_\�\�DL$(�8K���C/	�^C��������s�\�\�\��\�\�\�\�?T�\�\�\�_���ӐW�1e��#,	�^�$z\rO�\�:>��-2\�:���\�\�/a\�_,_���(�!��c\� A	FX�$zI0�\Z�\�t|E[d�mllLO�\�\�\�-\���ǚ�\�\�ꪘ��ʏ)�%aI0��`\�%�\�kx_\��Qm�w�+�\�w�^\�V�paaNLC^UŔA���$zI0��`\�5l	�/\��(��Ȉ�\�j��\�9v\�/\��;Tvmn\�0=�����\�4\�UaL$(�xJ���C/	�^C������Bh��������w���\�뷫�ڹ\�\�|�������*�)�%CI0��`\�%�\�kh_\��{\�\"Q8v\�\�Ε\�Сߩ\�oSݵ��G\�\�Skk*�a�!�)�%8\�%�\�K���C�!OP|A\�\�.i�ĢV�---\�ξ{y��77�U�W[[��򹅅��;���\�,1S	Jp�J���C/	�^%(��\�c7�EⲶ��������>\�\�\�\�ą\�߹\�UK\'1�ژ2H��C\'�\�I0t]p	��]p�1m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0)m\0\0\0 R\�\"\0\0\0@��E\0\0\0�Hi�\0\0\0\0�\�\0\0\0\"�-\0\0\0DJ[\0\0\0���\0\0\0��?�vi\�n\0\0\0\0IEND�B`�',0),('250012',2,'var-branchCheckUser',NULL,'�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0\0w\0\0\0\0x',NULL),('250014',2,'hist.var-branchCheckUser',NULL,'�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0\0w\0\0\0\0x',NULL),('250039',2,'hist.var-branchCheckUser',NULL,'�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0t\075x',NULL),('250064',1,'hist.var-cooperateFinanceUser',NULL,'�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0t\072x',NULL),('252524',2,'hist.var-branchCheckUser',NULL,'�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0t\084x',NULL),('252549',1,'hist.var-cooperateFinanceUser',NULL,'�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0t\072x',NULL),('257508',2,'var-branchCheckUser',NULL,'�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0t\077x',NULL),('257510',2,'hist.var-branchCheckUser',NULL,'�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0t\077x',NULL),('257533',1,'var-cooperateFinanceUser',NULL,'�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0t\079t\089x',NULL),('257535',1,'hist.var-cooperateFinanceUser',NULL,'�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0t\079t\089x',NULL),('262510',2,'hist.var-branchCheckUser',NULL,'�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0t\085x',NULL),('262535',1,'hist.var-cooperateFinanceUser',NULL,'�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0t\079t\089x',NULL),('267508',2,'var-branchCheckUser',NULL,'�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0t\075x',NULL),('267510',2,'hist.var-branchCheckUser',NULL,'�\�\0sr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0t\075x',NULL);
/*!40000 ALTER TABLE `act_ge_bytearray` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ge_property`
--

DROP TABLE IF EXISTS `act_ge_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ge_property`
--

LOCK TABLES `act_ge_property` WRITE;
/*!40000 ALTER TABLE `act_ge_property` DISABLE KEYS */;
INSERT INTO `act_ge_property` VALUES ('next.dbid','270001',109),('schema.history','create(5.18.0.0)',1),('schema.version','5.18.0.0',1);
/*!40000 ALTER TABLE `act_ge_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_actinst`
--

DROP TABLE IF EXISTS `act_hi_actinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_actinst`
--

LOCK TABLES `act_hi_actinst` WRITE;
/*!40000 ALTER TABLE `act_hi_actinst` DISABLE KEYS */;
INSERT INTO `act_hi_actinst` VALUES ('250006','YtCarLoan:1:250004','250005','250005','startevent1',NULL,NULL,'Start','startEvent',NULL,'2017-04-10 14:59:38','2017-04-10 14:59:38',4,''),('250008','YtCarLoan:1:250004','250005','250005','usertask1','250009',NULL,'申请人确认申请','userTask','71','2017-04-10 14:59:38','2017-04-10 15:00:38',60572,''),('250015','YtCarLoan:1:250004','250005','250005','usertask2','250016',NULL,'初审','userTask',NULL,'2017-04-10 15:00:38','2017-04-10 15:06:05',327818,''),('250021','YtCarLoan:1:250004','250005','250005','usertask1','250022',NULL,'申请人确认申请','userTask','71','2017-04-10 15:06:05','2017-04-10 15:20:36',871958,''),('250024','YtCarLoan:1:250004','250005','250005','usertask2','250025',NULL,'初审','userTask',NULL,'2017-04-10 15:20:36','2017-04-10 15:21:58',82803,''),('250028','YtCarLoan:1:250004','250005','250005','usertask3','250029',NULL,'复审','userTask',NULL,'2017-04-10 15:21:58',NULL,NULL,''),('250031','YtCarLoan:1:250004','250030','250030','startevent1',NULL,NULL,'Start','startEvent',NULL,'2017-04-10 15:47:35','2017-04-10 15:47:35',1,''),('250033','YtCarLoan:1:250004','250030','250030','usertask1','250034',NULL,'申请人确认申请','userTask','71','2017-04-10 15:47:35','2017-04-10 15:49:07',92199,''),('250040','YtCarLoan:1:250004','250030','250030','usertask2','250041',NULL,'初审','userTask',NULL,'2017-04-10 15:49:07','2017-04-10 15:49:59',52068,''),('250048','YtCarLoan:1:250004','250030','250030','usertask3','250049',NULL,'复审','userTask',NULL,'2017-04-10 15:49:59','2017-04-10 15:50:21',22102,''),('250052','YtCarLoan:1:250004','250030','250030','usertask4','250053',NULL,'终审','userTask',NULL,'2017-04-10 15:50:21','2017-04-10 15:51:56',95925,''),('250057','YtCarLoan:1:250004','250030','250030','usertask5','250058',NULL,'垫付账户放款','userTask',NULL,'2017-04-10 15:51:56','2017-04-10 15:55:49',233239,''),('250065','YtCarLoan:1:250004','250030','250030','usertask7','250066',NULL,'验收垫付款','userTask',NULL,'2017-04-10 15:55:49','2017-04-10 15:58:09',140022,''),('250070','YtCarLoan:1:250004','250030','250030','usertask8','250071',NULL,'是否发布产品','userTask',NULL,'2017-04-10 15:58:09','2017-04-10 16:22:26',1457103,''),('250075','YtCarLoan:1:250004','250030','250030','usertask11','250076',NULL,'募集完成','userTask',NULL,'2017-04-10 16:22:26','2017-04-10 16:24:09',103557,''),('250079','YtCarLoan:1:250004','250030','250030','usertask12','250080',NULL,'借款账户放款','userTask',NULL,'2017-04-10 16:24:09','2017-04-10 16:27:32',203754,''),('250083','YtCarLoan:1:250004','250030','250030','usertask13','250084',NULL,'供应商收款','userTask',NULL,'2017-04-10 16:27:32','2017-04-10 16:32:24',292500,''),('250087','YtCarLoan:1:250004','250030','250030','usertask14','250088',NULL,'归还垫付款','userTask',NULL,'2017-04-10 16:32:24','2017-04-10 16:33:16',52878,''),('250091','YtCarLoan:1:250004','250030','250030','usertask15','250092',NULL,'总部回收垫付款','userTask',NULL,'2017-04-10 16:33:16','2017-04-10 16:34:35',79002,''),('250095','YtCarLoan:1:250004','250030','250030','usertask9','250096',NULL,'保证金申请','userTask',NULL,'2017-04-10 16:34:35','2017-04-10 16:35:35',60599,''),('250099','YtCarLoan:1:250004','250030','250030','usertask16','250100',NULL,'缴纳保证金','userTask',NULL,'2017-04-10 16:35:35','2017-04-10 16:37:04',89368,''),('250103','YtCarLoan:1:250004','250030','250030','usertask17','250104',NULL,'保证金收款','userTask',NULL,'2017-04-10 16:37:04','2017-04-10 16:38:38',94502,''),('250107','YtCarLoan:1:250004','250030','250030','usertask18','250108',NULL,'是否催款','userTask',NULL,'2017-04-10 16:38:38','2017-04-10 16:40:27',109238,''),('250112','YtCarLoan:1:250004','250030','250030','usertask23','250113',NULL,'总部催款','userTask',NULL,'2017-04-10 16:40:27','2017-04-10 16:43:57',210446,''),('250116','YtCarLoan:1:250004','250030','250030','usertask19','250117',NULL,'供应商还款','userTask',NULL,'2017-04-10 16:43:57','2017-04-10 17:37:54',3237001,''),('252502','YtCarLoan:1:250004','250030','250030','usertask20','252503',NULL,'总部确认收款','userTask',NULL,'2017-04-10 17:37:54','2017-04-10 17:44:14',380846,''),('252506','YtCarLoan:1:250004','250030','250030','usertask21','252507',NULL,'退还保证金','userTask',NULL,'2017-04-10 17:44:14','2017-04-10 17:46:19',125821,''),('252510','YtCarLoan:1:250004','250030','250030','usertask22','252511',NULL,'供应商回收保证金','userTask',NULL,'2017-04-10 17:46:19','2017-04-10 17:47:32',73808,''),('252514','YtCarLoan:1:250004','250030','250030','endevent1',NULL,NULL,'End','endEvent',NULL,'2017-04-10 17:47:32','2017-04-10 17:47:32',0,''),('252516','YtCarLoan:1:250004','252515','252515','startevent1',NULL,NULL,'Start','startEvent',NULL,'2017-04-11 09:42:30','2017-04-11 09:42:30',0,''),('252518','YtCarLoan:1:250004','252515','252515','usertask1','252519',NULL,'申请人确认申请','userTask','71','2017-04-11 09:42:30','2017-04-11 09:46:42',252265,''),('252525','YtCarLoan:1:250004','252515','252515','usertask2','252526',NULL,'初审','userTask',NULL,'2017-04-11 09:46:42','2017-04-11 09:57:37',655796,''),('252533','YtCarLoan:1:250004','252515','252515','usertask3','252534',NULL,'复审','userTask',NULL,'2017-04-11 09:57:37','2017-04-11 10:07:40',603214,''),('252537','YtCarLoan:1:250004','252515','252515','usertask4','252538',NULL,'终审','userTask',NULL,'2017-04-11 10:07:40','2017-04-11 10:21:43',843562,''),('252542','YtCarLoan:1:250004','252515','252515','usertask5','252543',NULL,'垫付账户放款','userTask',NULL,'2017-04-11 10:21:43','2017-04-11 10:23:12',89148,''),('252550','YtCarLoan:1:250004','252515','252515','usertask7','252551',NULL,'验收垫付款','userTask',NULL,'2017-04-11 10:23:12','2017-04-11 10:27:31',259961,''),('252555','YtCarLoan:1:250004','252515','252515','usertask8','252556',NULL,'是否发布产品','userTask',NULL,'2017-04-11 10:27:31','2017-04-11 10:41:42',851204,''),('252560','YtCarLoan:1:250004','252515','252515','usertask11','252561',NULL,'募集完成','userTask',NULL,'2017-04-11 10:41:42','2017-04-11 10:43:13',91298,''),('252564','YtCarLoan:1:250004','252515','252515','usertask12','252565',NULL,'借款账户放款','userTask',NULL,'2017-04-11 10:43:13','2017-04-11 10:50:29',436216,''),('252568','YtCarLoan:1:250004','252515','252515','usertask13','252569',NULL,'供应商收款','userTask',NULL,'2017-04-11 10:50:29','2017-04-11 11:03:01',752609,''),('252572','YtCarLoan:1:250004','252515','252515','usertask14','252573',NULL,'归还垫付款','userTask',NULL,'2017-04-11 11:03:01','2017-04-11 11:27:07',1446311,''),('255002','YtCarLoan:1:250004','252515','252515','usertask15','255003',NULL,'总部回收垫付款','userTask',NULL,'2017-04-11 11:27:07','2017-04-11 11:27:55',48036,''),('255008','YtCarLoan:1:250004','252515','252515','usertask9','255009',NULL,'保证金申请','userTask',NULL,'2017-04-11 11:27:55','2017-04-11 11:28:50',55184,''),('255013','YtCarLoan:1:250004','252515','252515','usertask16','255014',NULL,'缴纳保证金','userTask',NULL,'2017-04-11 11:28:50','2017-04-11 11:29:29',39553,''),('255017','YtCarLoan:1:250004','252515','252515','usertask17','255018',NULL,'保证金收款','userTask',NULL,'2017-04-11 11:29:29','2017-04-11 11:30:45',76847,''),('255023','YtCarLoan:1:250004','252515','252515','usertask18','255024',NULL,'是否催款','userTask',NULL,'2017-04-11 11:30:45','2017-04-11 11:33:41',176928,''),('255028','YtCarLoan:1:250004','252515','252515','usertask23','255029',NULL,'总部催款','userTask',NULL,'2017-04-11 11:33:41','2017-04-11 11:45:21',700012,''),('255033','YtCarLoan:1:250004','252515','252515','usertask19','255034',NULL,'供应商还款','userTask',NULL,'2017-04-11 11:45:21','2017-04-11 11:50:06',285519,''),('255037','YtCarLoan:1:250004','252515','252515','usertask20','255038',NULL,'总部确认收款','userTask',NULL,'2017-04-11 11:50:06','2017-04-11 11:50:41',35621,''),('255041','YtCarLoan:1:250004','252515','252515','usertask21','255042',NULL,'退还保证金','userTask',NULL,'2017-04-11 11:50:41','2017-04-11 11:51:07',26429,''),('255045','YtCarLoan:1:250004','252515','252515','usertask22','255046',NULL,'供应商回收保证金','userTask',NULL,'2017-04-11 11:51:07','2017-04-11 11:51:49',42555,''),('255049','YtCarLoan:1:250004','252515','252515','endevent1',NULL,NULL,'End','endEvent',NULL,'2017-04-11 11:51:49','2017-04-11 11:51:49',1,''),('257502','YtCarLoan:1:250004','257501','257501','startevent1',NULL,NULL,'Start','startEvent',NULL,'2017-04-12 10:00:32','2017-04-12 10:00:32',19,''),('257504','YtCarLoan:1:250004','257501','257501','usertask1','257505',NULL,'申请人确认申请','userTask','78','2017-04-12 10:00:32','2017-04-12 10:00:38',6855,''),('257511','YtCarLoan:1:250004','257501','257501','usertask2','257512',NULL,'初审','userTask',NULL,'2017-04-12 10:00:38','2017-04-12 10:02:06',88435,''),('257519','YtCarLoan:1:250004','257501','257501','usertask3','257520',NULL,'复审','userTask',NULL,'2017-04-12 10:02:06','2017-04-12 10:03:08',62642,''),('257523','YtCarLoan:1:250004','257501','257501','usertask4','257524',NULL,'终审','userTask',NULL,'2017-04-12 10:03:08','2017-04-12 10:03:54',46024,''),('257528','YtCarLoan:1:250004','257501','257501','usertask5','257529',NULL,'垫付账户放款','userTask',NULL,'2017-04-12 10:03:54','2017-04-12 10:04:41',47591,''),('257536','YtCarLoan:1:250004','257501','257501','usertask7','257537',NULL,'验收垫付款','userTask',NULL,'2017-04-12 10:04:41','2017-04-12 10:05:44',63433,''),('257543','YtCarLoan:1:250004','257501','257501','usertask8','257544',NULL,'是否发布产品','userTask',NULL,'2017-04-12 10:05:44','2017-04-12 10:14:15',511625,''),('260002','YtCarLoan:1:250004','257501','257501','usertask11','260003',NULL,'募集完成','userTask',NULL,'2017-04-12 10:14:15',NULL,NULL,''),('262502','YtCarLoan:1:250004','262501','262501','startevent1',NULL,NULL,'Start','startEvent',NULL,'2017-04-12 10:17:48','2017-04-12 10:17:48',9,''),('262504','YtCarLoan:1:250004','262501','262501','usertask1','262505',NULL,'申请人确认申请','userTask','78','2017-04-12 10:17:48','2017-04-12 10:18:48',60015,''),('262511','YtCarLoan:1:250004','262501','262501','usertask2','262512',NULL,'初审','userTask',NULL,'2017-04-12 10:18:48','2017-04-12 10:21:23',155830,''),('262519','YtCarLoan:1:250004','262501','262501','usertask3','262520',NULL,'复审','userTask',NULL,'2017-04-12 10:21:23','2017-04-12 10:22:40',77136,''),('262523','YtCarLoan:1:250004','262501','262501','usertask4','262524',NULL,'终审','userTask',NULL,'2017-04-12 10:22:40','2017-04-12 10:23:43',63390,''),('262528','YtCarLoan:1:250004','262501','262501','usertask5','262529',NULL,'垫付账户放款','userTask',NULL,'2017-04-12 10:23:43','2017-04-12 10:27:38',235968,''),('262536','YtCarLoan:1:250004','262501','262501','usertask7','262537',NULL,'验收垫付款','userTask',NULL,'2017-04-12 10:27:38','2017-04-12 10:30:03',145974,''),('262543','YtCarLoan:1:250004','262501','262501','usertask8','262544',NULL,'是否发布产品','userTask',NULL,'2017-04-12 10:30:03','2017-04-12 10:32:52',169576,''),('262548','YtCarLoan:1:250004','262501','262501','usertask9','262549',NULL,'保证金申请','userTask',NULL,'2017-04-12 10:32:52','2017-04-12 10:36:29',217151,''),('262552','YtCarLoan:1:250004','262501','262501','usertask16','262553',NULL,'缴纳保证金','userTask',NULL,'2017-04-12 10:36:29','2017-04-12 10:37:29',60313,''),('262557','YtCarLoan:1:250004','262501','262501','usertask17','262558',NULL,'保证金收款','userTask',NULL,'2017-04-12 10:37:29','2017-04-12 10:43:50',381947,''),('265002','YtCarLoan:1:250004','262501','262501','usertask18','265003',NULL,'是否催款','userTask',NULL,'2017-04-12 10:43:50','2017-04-12 10:44:35',45549,''),('265007','YtCarLoan:1:250004','262501','262501','usertask23','265008',NULL,'总部催款','userTask',NULL,'2017-04-12 10:44:35','2017-04-12 10:45:21',46807,''),('265011','YtCarLoan:1:250004','262501','262501','usertask19','265012',NULL,'供应商还款','userTask',NULL,'2017-04-12 10:45:21','2017-04-12 10:46:15',54610,''),('265016','YtCarLoan:1:250004','262501','262501','usertask20','265017',NULL,'总部确认收款','userTask',NULL,'2017-04-12 10:46:15','2017-04-12 10:46:59',44110,''),('265020','YtCarLoan:1:250004','262501','262501','usertask21','265021',NULL,'退还保证金','userTask',NULL,'2017-04-12 10:46:59','2017-04-12 10:50:04',185517,''),('265024','YtCarLoan:1:250004','262501','262501','usertask22','265025',NULL,'供应商回收保证金','userTask',NULL,'2017-04-12 10:50:04','2017-04-12 10:51:03',59159,''),('265029','YtCarLoan:1:250004','262501','262501','endevent1',NULL,NULL,'End','endEvent',NULL,'2017-04-12 10:51:03','2017-04-12 10:51:03',0,''),('267502','YtCarLoan:1:250004','267501','267501','startevent1',NULL,NULL,'Start','startEvent',NULL,'2017-04-13 12:06:59','2017-04-13 12:06:59',9,''),('267504','YtCarLoan:1:250004','267501','267501','usertask1','267505',NULL,'申请人确认申请','userTask','71','2017-04-13 12:06:59','2017-04-13 12:07:46',47279,''),('267511','YtCarLoan:1:250004','267501','267501','usertask2','267512',NULL,'初审','userTask',NULL,'2017-04-13 12:07:46','2017-04-13 12:10:23',157519,''),('267519','YtCarLoan:1:250004','267501','267501','usertask3','267520',NULL,'复审','userTask',NULL,'2017-04-13 12:10:23','2017-04-13 12:11:23',60275,''),('267523','YtCarLoan:1:250004','267501','267501','usertask4','267524',NULL,'终审','userTask',NULL,'2017-04-13 12:11:23',NULL,NULL,'');
/*!40000 ALTER TABLE `act_hi_actinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_attachment`
--

DROP TABLE IF EXISTS `act_hi_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_attachment`
--

LOCK TABLES `act_hi_attachment` WRITE;
/*!40000 ALTER TABLE `act_hi_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_comment`
--

DROP TABLE IF EXISTS `act_hi_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_comment`
--

LOCK TABLES `act_hi_comment` WRITE;
/*!40000 ALTER TABLE `act_hi_comment` DISABLE KEYS */;
INSERT INTO `act_hi_comment` VALUES ('250011','comment','2017-04-10 15:00:38','71','250009','250005','AddComment','完成','完成'),('250019','comment','2017-04-10 15:06:05','75','250016','250005','AddComment','不通过','不通过'),('250023','comment','2017-04-10 15:20:36','71','250022','250005','AddComment','完成','完成'),('250027','comment','2017-04-10 15:21:58','75','250025','250005','AddComment','同意','同意'),('250036','comment','2017-04-10 15:49:07','71','250034','250030','AddComment','完成','完成'),('250046','comment','2017-04-10 15:49:59','84','250041','250030','AddComment','通过','通过'),('250051','comment','2017-04-10 15:50:21','75','250049','250030','AddComment','通过','通过'),('250056','comment','2017-04-10 15:51:56','74','250053','250030','AddComment','通过','通过'),('250061','comment','2017-04-10 15:55:49','73','250058','250030','AddComment','已放款。&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/众和胜付款梓彬汇金（现代途胜）垫付款11.30.jpeg','已放款。&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/众和胜付款梓彬汇金（现代途胜）垫付款11.30.jpeg'),('250069','comment','2017-04-10 15:58:08','72','250066','250030','AddComment','已收款&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金收款众合胜（现代途胜）垫付款11.30.png','已收款&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金收款众合胜（现代途胜）垫付款11.30.png'),('250074','comment','2017-04-10 16:22:26','69','250071','250030','AddComment','已发布产品：车贷宝-安心贷计划0016期.','已发布产品：车贷宝-安心贷计划0016期.'),('250078','comment','2017-04-10 16:24:09','69','250076','250030','AddComment','募集完成，募集金额：22000元','募集完成，募集金额：22000元'),('250082','comment','2017-04-10 16:27:32','73','250080','250030','AddComment','已打款：22000元&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/盈通付款梓杉汇金（现代途胜）借款12.6.jpeg','已打款：22000元&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/盈通付款梓杉汇金（现代途胜）借款12.6.jpeg'),('250086','comment','2017-04-10 16:32:24','72','250084','250030','AddComment','已收款：22000元.&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金付款众和胜（途胜）回款12.6.png','已收款：22000元.&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金付款众和胜（途胜）回款12.6.png'),('250090','comment','2017-04-10 16:33:16','72','250088','250030','AddComment','已还垫付款：22000元&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金付款众和胜（途胜）回款12.6.png','已还垫付款：22000元&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金付款众和胜（途胜）回款12.6.png'),('250094','comment','2017-04-10 16:34:34','73','250092','250030','AddComment','已收垫付款：22000&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/众合胜收款梓杉汇金（现代途胜）垫付款12.6.jpeg','已收垫付款：22000&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/众合胜收款梓杉汇金（现代途胜）垫付款12.6.jpeg'),('250098','comment','2017-04-10 16:35:35','73','250096','250030','AddComment','请付保证金:5500元。','请付保证金:5500元。'),('250102','comment','2017-04-10 16:37:04','72','250100','250030','AddComment','已付保证金：5500元&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金付款盈通（途胜、标志）保证金12.6.png','已付保证金：5500元&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金付款盈通（途胜、标志）保证金12.6.png'),('250106','comment','2017-04-10 16:38:38','73','250104','250030','AddComment','已收款：5500元&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/盈通收款梓杉汇金（现代途胜、标志508）保证金12.6.jpeg','已收款：5500元&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/盈通收款梓杉汇金（现代途胜、标志508）保证金12.6.jpeg'),('250111','comment','2017-04-10 16:40:27','1','250108','250030','AddComment','请还款','请还款'),('250115','comment','2017-04-10 16:43:57','73','250113','250030','AddComment','请还款至：众和胜平安88000元，众和胜建行2814.19元，盈通招行22440.6元。','请还款至：众和胜平安88000元，众和胜建行2814.19元，盈通招行22440.6元。'),('252501','comment','2017-04-10 17:37:53','72','250117','250030','AddComment','已付款&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金还款睿博盈通本息22440.6元2.28.png,http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_14918096184...','已付款&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金还款睿博盈通本息22440.6元2.28.png,http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金还款众合胜本金8.8w2.28.png,http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金还款众合胜利息2814.19元2.28.png'),('252505','comment','2017-04-10 17:44:14','73','252503','250030','AddComment','已全部收款。','已全部收款。'),('252509','comment','2017-04-10 17:46:19','73','252507','250030','AddComment','退还保证金：5500元&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/盈通付款中嵩（贵士、保时捷）保证金2.28.jpeg','退还保证金：5500元&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/盈通付款中嵩（贵士、保时捷）保证金2.28.jpeg'),('252513','comment','2017-04-10 17:47:32','72','252511','250030','AddComment','已收保证金。&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/睿博盈通退梓杉汇金保证金（别克君越）5500元2.28.png','已收保证金。&&http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/睿博盈通退梓杉汇金保证金（别克君越）5500元2.28.png'),('252521','comment','2017-04-11 09:46:42','71','252519','252515','AddComment','提交','提交'),('252531','comment','2017-04-11 09:57:37','75','252526','252515','AddComment','同意','同意'),('252536','comment','2017-04-11 10:07:40','84','252534','252515','AddComment','同意','同意'),('252541','comment','2017-04-11 10:21:43','74','252538','252515','AddComment','同意','同意'),('252546','comment','2017-04-11 10:23:12','73','252543','252515','AddComment','已付款','已付款'),('252554','comment','2017-04-11 10:27:31','72','252551','252515','AddComment','已收款330000','已收款330000'),('252559','comment','2017-04-11 10:41:42','69','252556','252515','AddComment','已发布车贷宝-安心贷计划0025期 ','已发布车贷宝-安心贷计划0025期\r\n'),('252563','comment','2017-04-11 10:43:13','69','252561','252515','AddComment','已募集完成','已募集完成'),('252567','comment','2017-04-11 10:50:29','73','252565','252515','AddComment','已付款12000 ','已付款12000\r\n'),('252571','comment','2017-04-11 11:03:01','72','252569','252515','AddComment','已收到款12000','已收到款12000'),('255001','comment','2017-04-11 11:27:07','72','252573','252515','AddComment','已付款12000','已付款12000'),('255007','comment','2017-04-11 11:27:54','73','255003','252515','AddComment','已收到12000','已收到12000'),('255012','comment','2017-04-11 11:28:50','73','255009','252515','AddComment','请付保证金16500.00 ','请付保证金16500.00 \r\n'),('255016','comment','2017-04-11 11:29:29','72','255014','252515','AddComment','已付保证金16500.00 ','已付保证金16500.00 \r\n'),('255022','comment','2017-04-11 11:30:45','73','255018','252515','AddComment','已收到保证金16500','已收到保证金16500'),('255027','comment','2017-04-11 11:33:41','1','255024','252515','AddComment','请还款。','请还款。'),('255032','comment','2017-04-11 11:45:20','73','255029','252515','AddComment','请还款众合胜（平安)318000.00 盈通招行12234.74 众合胜建行9529.64 ','请还款众合胜（平安)318000.00 \r\n盈通招行12234.74 \r\n众合胜建行9529.64 \r\n'),('255036','comment','2017-04-11 11:50:06','72','255034','252515','AddComment','已还款众合胜（平安)318000.00 盈通招行12234.74 众合胜建行9529.64','已还款众合胜（平安)318000.00 盈通招行12234.74 众合胜建行9529.64'),('255040','comment','2017-04-11 11:50:41','73','255038','252515','AddComment','已收到众合胜（平安)318000.00 盈通招行12234.74 众合胜建行9529.64','已收到众合胜（平安)318000.00 盈通招行12234.74 众合胜建行9529.64'),('255044','comment','2017-04-11 11:51:07','73','255042','252515','AddComment','退还保证金16500','退还保证金16500'),('255048','comment','2017-04-11 11:51:49','72','255046','252515','AddComment','已收到退还保证金16500','已收到退还保证金16500'),('257507','comment','2017-04-12 10:00:38','78','257505','257501','AddComment','123','123'),('257517','comment','2017-04-12 10:02:06','85','257512','257501','AddComment','123','123'),('257522','comment','2017-04-12 10:03:08','77','257520','257501','AddComment','123','123'),('257527','comment','2017-04-12 10:03:53','74','257524','257501','AddComment','123','123'),('257532','comment','2017-04-12 10:04:41','73','257529','257501','AddComment','123','123'),('257542','comment','2017-04-12 10:05:44','79','257537','257501','AddComment','123','123'),('260001','comment','2017-04-12 10:14:15','69','257544','257501','AddComment','132','132'),('262507','comment','2017-04-12 10:18:47','78','262505','262501','AddComment','请审核。','请审核。'),('262517','comment','2017-04-12 10:21:23','77','262512','262501','AddComment','通过。','通过。'),('262522','comment','2017-04-12 10:22:40','85','262520','262501','AddComment','同意。','同意。'),('262527','comment','2017-04-12 10:23:43','74','262524','262501','AddComment','同意。','同意。'),('262532','comment','2017-04-12 10:27:38','73','262529','262501','AddComment','已付款。&&http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/1.jpg','已付款。&&http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/1.jpg'),('262542','comment','2017-04-12 10:30:03','79','262537','262501','AddComment','已收到。&&http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/9.jpg','已收到。&&http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/9.jpg'),('262547','comment','2017-04-12 10:32:52','69','262544','262501','AddComment','缺少机动车登记证，无法上平台。','缺少机动车登记证，无法上平台。'),('262551','comment','2017-04-12 10:36:29','73','262549','262501','AddComment','请交保证金20000元。','请交保证金20000元。'),('262556','comment','2017-04-12 10:37:29','79','262553','262501','AddComment','已交保证金20000元。&&http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/7.jpg','已交保证金20000元。&&http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/7.jpg'),('265001','comment','2017-04-12 10:43:50','73','262558','262501','AddComment','收到保证金20000元。&&http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/6.jpg','收到保证金20000元。&&http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/6.jpg'),('265006','comment','2017-04-12 10:44:35','1','265003','262501','AddComment','请及时还款。','请及时还款。'),('265010','comment','2017-04-12 10:45:21','73','265008','262501','AddComment','请及时还款。','请及时还款。'),('265015','comment','2017-04-12 10:46:15','79','265012','262501','AddComment','已还款。&&http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/8.jpg','已还款。&&http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/8.jpg'),('265019','comment','2017-04-12 10:46:59','73','265017','262501','AddComment','收到还款。&&http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/7.jpg','收到还款。&&http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/7.jpg'),('265023','comment','2017-04-12 10:50:04','73','265021','262501','AddComment','已退还保证金。','已退还保证金。'),('265028','comment','2017-04-12 10:51:03','79','265025','262501','AddComment','收回保证金。','收回保证金。'),('267507','comment','2017-04-13 12:07:46','71','267505','267501','AddComment','资料已上传。','资料已上传。'),('267517','comment','2017-04-13 12:10:23','84','267512','267501','AddComment','通过。','通过。'),('267522','comment','2017-04-13 12:11:23','75','267520','267501','AddComment','通过。','通过。');
/*!40000 ALTER TABLE `act_hi_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_detail`
--

DROP TABLE IF EXISTS `act_hi_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_detail`
--

LOCK TABLES `act_hi_detail` WRITE;
/*!40000 ALTER TABLE `act_hi_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_identitylink`
--

DROP TABLE IF EXISTS `act_hi_identitylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_identitylink`
--

LOCK TABLES `act_hi_identitylink` WRITE;
/*!40000 ALTER TABLE `act_hi_identitylink` DISABLE KEYS */;
INSERT INTO `act_hi_identitylink` VALUES ('250010',NULL,'participant','71',NULL,'250005'),('250017',NULL,'candidate','75','250016',NULL),('250018',NULL,'participant','75',NULL,'250005'),('250026',NULL,'candidate','75','250025',NULL),('250035',NULL,'participant','71',NULL,'250030'),('250042',NULL,'candidate','75','250041',NULL),('250043',NULL,'participant','75',NULL,'250030'),('250044',NULL,'candidate','84','250041',NULL),('250045',NULL,'participant','84',NULL,'250030'),('250050',NULL,'candidate','75','250049',NULL),('250054',NULL,'candidate','74','250053',NULL),('250055',NULL,'participant','74',NULL,'250030'),('250059',NULL,'candidate','73','250058',NULL),('250060',NULL,'participant','73',NULL,'250030'),('250067',NULL,'candidate','72','250066',NULL),('250068',NULL,'participant','72',NULL,'250030'),('250072',NULL,'candidate','69','250071',NULL),('250073',NULL,'participant','69',NULL,'250030'),('250077',NULL,'candidate','69','250076',NULL),('250081',NULL,'candidate','73','250080',NULL),('250085',NULL,'candidate','72','250084',NULL),('250089',NULL,'candidate','72','250088',NULL),('250093',NULL,'candidate','73','250092',NULL),('250097',NULL,'candidate','73','250096',NULL),('250101',NULL,'candidate','72','250100',NULL),('250105',NULL,'candidate','73','250104',NULL),('250109',NULL,'candidate','1','250108',NULL),('250110',NULL,'participant','1',NULL,'250030'),('250114',NULL,'candidate','73','250113',NULL),('250118',NULL,'candidate','72','250117',NULL),('252504',NULL,'candidate','73','252503',NULL),('252508',NULL,'candidate','73','252507',NULL),('252512',NULL,'candidate','72','252511',NULL),('252520',NULL,'participant','71',NULL,'252515'),('252527',NULL,'candidate','75','252526',NULL),('252528',NULL,'participant','75',NULL,'252515'),('252529',NULL,'candidate','84','252526',NULL),('252530',NULL,'participant','84',NULL,'252515'),('252535',NULL,'candidate','84','252534',NULL),('252539',NULL,'candidate','74','252538',NULL),('252540',NULL,'participant','74',NULL,'252515'),('252544',NULL,'candidate','73','252543',NULL),('252545',NULL,'participant','73',NULL,'252515'),('252552',NULL,'candidate','72','252551',NULL),('252553',NULL,'participant','72',NULL,'252515'),('252557',NULL,'candidate','69','252556',NULL),('252558',NULL,'participant','69',NULL,'252515'),('252562',NULL,'candidate','69','252561',NULL),('252566',NULL,'candidate','73','252565',NULL),('252570',NULL,'candidate','72','252569',NULL),('252574',NULL,'candidate','72','252573',NULL),('255004',NULL,'candidate','73','255003',NULL),('255005',NULL,'candidate','87','255003',NULL),('255006',NULL,'participant','87',NULL,'252515'),('255010',NULL,'candidate','73','255009',NULL),('255011',NULL,'candidate','87','255009',NULL),('255015',NULL,'candidate','72','255014',NULL),('255019',NULL,'candidate','73','255018',NULL),('255020',NULL,'candidate','88','255018',NULL),('255021',NULL,'participant','88',NULL,'252515'),('255025',NULL,'candidate','1','255024',NULL),('255026',NULL,'participant','1',NULL,'252515'),('255030',NULL,'candidate','73','255029',NULL),('255031',NULL,'candidate','88','255029',NULL),('255035',NULL,'candidate','72','255034',NULL),('255039',NULL,'candidate','73','255038',NULL),('255043',NULL,'candidate','73','255042',NULL),('255047',NULL,'candidate','72','255046',NULL),('257506',NULL,'participant','78',NULL,'257501'),('257513',NULL,'candidate','77','257512',NULL),('257514',NULL,'participant','77',NULL,'257501'),('257515',NULL,'candidate','85','257512',NULL),('257516',NULL,'participant','85',NULL,'257501'),('257521',NULL,'candidate','77','257520',NULL),('257525',NULL,'candidate','74','257524',NULL),('257526',NULL,'participant','74',NULL,'257501'),('257530',NULL,'candidate','73','257529',NULL),('257531',NULL,'participant','73',NULL,'257501'),('257538',NULL,'candidate','79','257537',NULL),('257539',NULL,'participant','79',NULL,'257501'),('257540',NULL,'candidate','89','257537',NULL),('257541',NULL,'participant','89',NULL,'257501'),('257545',NULL,'candidate','69','257544',NULL),('257546',NULL,'participant','69',NULL,'257501'),('260004',NULL,'candidate','69','260003',NULL),('262506',NULL,'participant','78',NULL,'262501'),('262513',NULL,'candidate','77','262512',NULL),('262514',NULL,'participant','77',NULL,'262501'),('262515',NULL,'candidate','85','262512',NULL),('262516',NULL,'participant','85',NULL,'262501'),('262521',NULL,'candidate','85','262520',NULL),('262525',NULL,'candidate','74','262524',NULL),('262526',NULL,'participant','74',NULL,'262501'),('262530',NULL,'candidate','73','262529',NULL),('262531',NULL,'participant','73',NULL,'262501'),('262538',NULL,'candidate','79','262537',NULL),('262539',NULL,'participant','79',NULL,'262501'),('262540',NULL,'candidate','89','262537',NULL),('262541',NULL,'participant','89',NULL,'262501'),('262545',NULL,'candidate','69','262544',NULL),('262546',NULL,'participant','69',NULL,'262501'),('262550',NULL,'candidate','73','262549',NULL),('262554',NULL,'candidate','79','262553',NULL),('262555',NULL,'candidate','89','262553',NULL),('262559',NULL,'candidate','73','262558',NULL),('265004',NULL,'candidate','1','265003',NULL),('265005',NULL,'participant','1',NULL,'262501'),('265009',NULL,'candidate','73','265008',NULL),('265013',NULL,'candidate','79','265012',NULL),('265014',NULL,'candidate','89','265012',NULL),('265018',NULL,'candidate','73','265017',NULL),('265022',NULL,'candidate','73','265021',NULL),('265026',NULL,'candidate','79','265025',NULL),('265027',NULL,'candidate','89','265025',NULL),('267506',NULL,'participant','71',NULL,'267501'),('267513',NULL,'candidate','75','267512',NULL),('267514',NULL,'participant','75',NULL,'267501'),('267515',NULL,'candidate','84','267512',NULL),('267516',NULL,'participant','84',NULL,'267501'),('267521',NULL,'candidate','75','267520',NULL),('267525',NULL,'candidate','74','267524',NULL),('267526',NULL,'participant','74',NULL,'267501');
/*!40000 ALTER TABLE `act_hi_identitylink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_procinst`
--

DROP TABLE IF EXISTS `act_hi_procinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_procinst`
--

LOCK TABLES `act_hi_procinst` WRITE;
/*!40000 ALTER TABLE `act_hi_procinst` DISABLE KEYS */;
INSERT INTO `act_hi_procinst` VALUES ('250005','250005','QDFGS_001_QDSHQ_1491807556058','YtCarLoan:1:250004','2017-04-10 14:59:38',NULL,NULL,NULL,'startevent1',NULL,NULL,NULL,'',NULL),('250030','250030','QDFGS_001_QDSHQ_1491809618480','YtCarLoan:1:250004','2017-04-10 15:47:35','2017-04-10 17:47:32',7197811,NULL,'startevent1','endevent1',NULL,NULL,'',NULL),('252515','252515','QDFGS_001_QDSHQ_1491873753448','YtCarLoan:1:250004','2017-04-11 09:42:30','2017-04-11 11:51:49',7759557,NULL,'startevent1','endevent1',NULL,NULL,'',NULL),('257501','257501','BJYF_001_BJSHQ_1491962355830','YtCarLoan:1:250004','2017-04-12 10:00:32',NULL,NULL,NULL,'startevent1',NULL,NULL,NULL,'',NULL),('262501','262501','BJYF_001_BJSHQ_1491962869885','YtCarLoan:1:250004','2017-04-12 10:17:48','2017-04-12 10:51:03',1995161,NULL,'startevent1','endevent1',NULL,NULL,'',NULL),('267501','267501','QDFGS_001_QDSHQ_1492055918019','YtCarLoan:1:250004','2017-04-13 12:06:59',NULL,NULL,NULL,'startevent1',NULL,NULL,NULL,'',NULL);
/*!40000 ALTER TABLE `act_hi_procinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_taskinst`
--

DROP TABLE IF EXISTS `act_hi_taskinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `CLAIM_TIME_` datetime DEFAULT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_taskinst`
--

LOCK TABLES `act_hi_taskinst` WRITE;
/*!40000 ALTER TABLE `act_hi_taskinst` DISABLE KEYS */;
INSERT INTO `act_hi_taskinst` VALUES ('250009','YtCarLoan:1:250004','usertask1','250005','250005','申请人确认申请',NULL,NULL,NULL,'71','2017-04-10 14:59:38',NULL,'2017-04-10 15:00:38',60568,'completed',50,NULL,NULL,NULL,''),('250016','YtCarLoan:1:250004','usertask2','250005','250005','初审',NULL,NULL,NULL,NULL,'2017-04-10 15:00:38',NULL,'2017-04-10 15:06:05',327806,'completed',50,NULL,NULL,NULL,''),('250022','YtCarLoan:1:250004','usertask1','250005','250005','申请人确认申请',NULL,NULL,NULL,'71','2017-04-10 15:06:05',NULL,'2017-04-10 15:20:36',871955,'completed',50,NULL,NULL,NULL,''),('250025','YtCarLoan:1:250004','usertask2','250005','250005','初审',NULL,NULL,NULL,NULL,'2017-04-10 15:20:36',NULL,'2017-04-10 15:21:58',82800,'completed',50,NULL,NULL,NULL,''),('250029','YtCarLoan:1:250004','usertask3','250005','250005','复审',NULL,NULL,NULL,NULL,'2017-04-10 15:21:58',NULL,NULL,NULL,NULL,50,NULL,NULL,NULL,''),('250034','YtCarLoan:1:250004','usertask1','250030','250030','申请人确认申请',NULL,NULL,NULL,'71','2017-04-10 15:47:35',NULL,'2017-04-10 15:49:07',92191,'completed',50,NULL,NULL,NULL,''),('250041','YtCarLoan:1:250004','usertask2','250030','250030','初审',NULL,NULL,NULL,NULL,'2017-04-10 15:49:07',NULL,'2017-04-10 15:49:59',52060,'completed',50,NULL,NULL,NULL,''),('250049','YtCarLoan:1:250004','usertask3','250030','250030','复审',NULL,NULL,NULL,NULL,'2017-04-10 15:49:59',NULL,'2017-04-10 15:50:21',22099,'completed',50,NULL,NULL,NULL,''),('250053','YtCarLoan:1:250004','usertask4','250030','250030','终审',NULL,NULL,NULL,NULL,'2017-04-10 15:50:21',NULL,'2017-04-10 15:51:56',95917,'completed',50,NULL,NULL,NULL,''),('250058','YtCarLoan:1:250004','usertask5','250030','250030','垫付账户放款',NULL,NULL,NULL,NULL,'2017-04-10 15:51:56',NULL,'2017-04-10 15:55:49',233236,'completed',50,NULL,NULL,NULL,''),('250066','YtCarLoan:1:250004','usertask7','250030','250030','验收垫付款',NULL,NULL,NULL,NULL,'2017-04-10 15:55:49',NULL,'2017-04-10 15:58:09',140019,'completed',50,NULL,NULL,NULL,''),('250071','YtCarLoan:1:250004','usertask8','250030','250030','是否发布产品',NULL,NULL,NULL,NULL,'2017-04-10 15:58:09',NULL,'2017-04-10 16:22:26',1457088,'completed',50,NULL,NULL,NULL,''),('250076','YtCarLoan:1:250004','usertask11','250030','250030','募集完成',NULL,NULL,NULL,NULL,'2017-04-10 16:22:26',NULL,'2017-04-10 16:24:09',103550,'completed',50,NULL,NULL,NULL,''),('250080','YtCarLoan:1:250004','usertask12','250030','250030','借款账户放款',NULL,NULL,NULL,NULL,'2017-04-10 16:24:09',NULL,'2017-04-10 16:27:32',203746,'completed',50,NULL,NULL,NULL,''),('250084','YtCarLoan:1:250004','usertask13','250030','250030','供应商收款',NULL,NULL,NULL,NULL,'2017-04-10 16:27:32',NULL,'2017-04-10 16:32:24',292498,'completed',50,NULL,NULL,NULL,''),('250088','YtCarLoan:1:250004','usertask14','250030','250030','归还垫付款',NULL,NULL,NULL,NULL,'2017-04-10 16:32:24',NULL,'2017-04-10 16:33:16',52875,'completed',50,NULL,NULL,NULL,''),('250092','YtCarLoan:1:250004','usertask15','250030','250030','总部回收垫付款',NULL,NULL,NULL,NULL,'2017-04-10 16:33:16',NULL,'2017-04-10 16:34:34',78999,'completed',50,NULL,NULL,NULL,''),('250096','YtCarLoan:1:250004','usertask9','250030','250030','保证金申请',NULL,NULL,NULL,NULL,'2017-04-10 16:34:35',NULL,'2017-04-10 16:35:35',60596,'completed',50,NULL,NULL,NULL,''),('250100','YtCarLoan:1:250004','usertask16','250030','250030','缴纳保证金',NULL,NULL,NULL,NULL,'2017-04-10 16:35:35',NULL,'2017-04-10 16:37:04',89366,'completed',50,NULL,NULL,NULL,''),('250104','YtCarLoan:1:250004','usertask17','250030','250030','保证金收款',NULL,NULL,NULL,NULL,'2017-04-10 16:37:04',NULL,'2017-04-10 16:38:38',94500,'completed',50,NULL,NULL,NULL,''),('250108','YtCarLoan:1:250004','usertask18','250030','250030','是否催款',NULL,NULL,NULL,NULL,'2017-04-10 16:38:38',NULL,'2017-04-10 16:40:27',109235,'completed',50,NULL,NULL,NULL,''),('250113','YtCarLoan:1:250004','usertask23','250030','250030','总部催款',NULL,NULL,NULL,NULL,'2017-04-10 16:40:27',NULL,'2017-04-10 16:43:57',210443,'completed',50,NULL,NULL,NULL,''),('250117','YtCarLoan:1:250004','usertask19','250030','250030','供应商还款',NULL,NULL,NULL,NULL,'2017-04-10 16:43:57',NULL,'2017-04-10 17:37:53',3236985,'completed',50,NULL,NULL,NULL,''),('252503','YtCarLoan:1:250004','usertask20','250030','250030','总部确认收款',NULL,NULL,NULL,NULL,'2017-04-10 17:37:54',NULL,'2017-04-10 17:44:14',380841,'completed',50,NULL,NULL,NULL,''),('252507','YtCarLoan:1:250004','usertask21','250030','250030','退还保证金',NULL,NULL,NULL,NULL,'2017-04-10 17:44:14',NULL,'2017-04-10 17:46:19',125816,'completed',50,NULL,NULL,NULL,''),('252511','YtCarLoan:1:250004','usertask22','250030','250030','供应商回收保证金',NULL,NULL,NULL,NULL,'2017-04-10 17:46:19',NULL,'2017-04-10 17:47:32',73804,'completed',50,NULL,NULL,NULL,''),('252519','YtCarLoan:1:250004','usertask1','252515','252515','申请人确认申请',NULL,NULL,NULL,'71','2017-04-11 09:42:30',NULL,'2017-04-11 09:46:42',252262,'completed',50,NULL,NULL,NULL,''),('252526','YtCarLoan:1:250004','usertask2','252515','252515','初审',NULL,NULL,NULL,NULL,'2017-04-11 09:46:42',NULL,'2017-04-11 09:57:37',655782,'completed',50,NULL,NULL,NULL,''),('252534','YtCarLoan:1:250004','usertask3','252515','252515','复审',NULL,NULL,NULL,NULL,'2017-04-11 09:57:37',NULL,'2017-04-11 10:07:40',603210,'completed',50,NULL,NULL,NULL,''),('252538','YtCarLoan:1:250004','usertask4','252515','252515','终审',NULL,NULL,NULL,NULL,'2017-04-11 10:07:40',NULL,'2017-04-11 10:21:43',843559,'completed',50,NULL,NULL,NULL,''),('252543','YtCarLoan:1:250004','usertask5','252515','252515','垫付账户放款',NULL,NULL,NULL,NULL,'2017-04-11 10:21:43',NULL,'2017-04-11 10:23:12',89145,'completed',50,NULL,NULL,NULL,''),('252551','YtCarLoan:1:250004','usertask7','252515','252515','验收垫付款',NULL,NULL,NULL,NULL,'2017-04-11 10:23:12',NULL,'2017-04-11 10:27:31',259957,'completed',50,NULL,NULL,NULL,''),('252556','YtCarLoan:1:250004','usertask8','252515','252515','是否发布产品',NULL,NULL,NULL,NULL,'2017-04-11 10:27:31',NULL,'2017-04-11 10:41:42',851195,'completed',50,NULL,NULL,NULL,''),('252561','YtCarLoan:1:250004','usertask11','252515','252515','募集完成',NULL,NULL,NULL,NULL,'2017-04-11 10:41:42',NULL,'2017-04-11 10:43:13',91295,'completed',50,NULL,NULL,NULL,''),('252565','YtCarLoan:1:250004','usertask12','252515','252515','借款账户放款',NULL,NULL,NULL,NULL,'2017-04-11 10:43:13',NULL,'2017-04-11 10:50:29',436213,'completed',50,NULL,NULL,NULL,''),('252569','YtCarLoan:1:250004','usertask13','252515','252515','供应商收款',NULL,NULL,NULL,NULL,'2017-04-11 10:50:29',NULL,'2017-04-11 11:03:01',752606,'completed',50,NULL,NULL,NULL,''),('252573','YtCarLoan:1:250004','usertask14','252515','252515','归还垫付款',NULL,NULL,NULL,NULL,'2017-04-11 11:03:01',NULL,'2017-04-11 11:27:07',1446296,'completed',50,NULL,NULL,NULL,''),('255003','YtCarLoan:1:250004','usertask15','252515','252515','总部回收垫付款',NULL,NULL,NULL,NULL,'2017-04-11 11:27:07',NULL,'2017-04-11 11:27:55',48031,'completed',50,NULL,NULL,NULL,''),('255009','YtCarLoan:1:250004','usertask9','252515','252515','保证金申请',NULL,NULL,NULL,NULL,'2017-04-11 11:27:55',NULL,'2017-04-11 11:28:50',55180,'completed',50,NULL,NULL,NULL,''),('255014','YtCarLoan:1:250004','usertask16','252515','252515','缴纳保证金',NULL,NULL,NULL,NULL,'2017-04-11 11:28:50',NULL,'2017-04-11 11:29:29',39550,'completed',50,NULL,NULL,NULL,''),('255018','YtCarLoan:1:250004','usertask17','252515','252515','保证金收款',NULL,NULL,NULL,NULL,'2017-04-11 11:29:29',NULL,'2017-04-11 11:30:45',76843,'completed',50,NULL,NULL,NULL,''),('255024','YtCarLoan:1:250004','usertask18','252515','252515','是否催款',NULL,NULL,NULL,NULL,'2017-04-11 11:30:45',NULL,'2017-04-11 11:33:41',176924,'completed',50,NULL,NULL,NULL,''),('255029','YtCarLoan:1:250004','usertask23','252515','252515','总部催款',NULL,NULL,NULL,NULL,'2017-04-11 11:33:41',NULL,'2017-04-11 11:45:21',700009,'completed',50,NULL,NULL,NULL,''),('255034','YtCarLoan:1:250004','usertask19','252515','252515','供应商还款',NULL,NULL,NULL,NULL,'2017-04-11 11:45:21',NULL,'2017-04-11 11:50:06',285516,'completed',50,NULL,NULL,NULL,''),('255038','YtCarLoan:1:250004','usertask20','252515','252515','总部确认收款',NULL,NULL,NULL,NULL,'2017-04-11 11:50:06',NULL,'2017-04-11 11:50:41',35613,'completed',50,NULL,NULL,NULL,''),('255042','YtCarLoan:1:250004','usertask21','252515','252515','退还保证金',NULL,NULL,NULL,NULL,'2017-04-11 11:50:41',NULL,'2017-04-11 11:51:07',26426,'completed',50,NULL,NULL,NULL,''),('255046','YtCarLoan:1:250004','usertask22','252515','252515','供应商回收保证金',NULL,NULL,NULL,NULL,'2017-04-11 11:51:07',NULL,'2017-04-11 11:51:49',42552,'completed',50,NULL,NULL,NULL,''),('257505','YtCarLoan:1:250004','usertask1','257501','257501','申请人确认申请',NULL,NULL,NULL,'78','2017-04-12 10:00:32',NULL,'2017-04-12 10:00:38',6844,'completed',50,NULL,NULL,NULL,''),('257512','YtCarLoan:1:250004','usertask2','257501','257501','初审',NULL,NULL,NULL,NULL,'2017-04-12 10:00:38',NULL,'2017-04-12 10:02:06',88427,'completed',50,NULL,NULL,NULL,''),('257520','YtCarLoan:1:250004','usertask3','257501','257501','复审',NULL,NULL,NULL,NULL,'2017-04-12 10:02:06',NULL,'2017-04-12 10:03:08',62635,'completed',50,NULL,NULL,NULL,''),('257524','YtCarLoan:1:250004','usertask4','257501','257501','终审',NULL,NULL,NULL,NULL,'2017-04-12 10:03:08',NULL,'2017-04-12 10:03:54',46015,'completed',50,NULL,NULL,NULL,''),('257529','YtCarLoan:1:250004','usertask5','257501','257501','垫付账户放款',NULL,NULL,NULL,NULL,'2017-04-12 10:03:54',NULL,'2017-04-12 10:04:41',47585,'completed',50,NULL,NULL,NULL,''),('257537','YtCarLoan:1:250004','usertask7','257501','257501','验收垫付款',NULL,NULL,NULL,NULL,'2017-04-12 10:04:41',NULL,'2017-04-12 10:05:44',63427,'completed',50,NULL,NULL,NULL,''),('257544','YtCarLoan:1:250004','usertask8','257501','257501','是否发布产品',NULL,NULL,NULL,NULL,'2017-04-12 10:05:44',NULL,'2017-04-12 10:14:15',511594,'completed',50,NULL,NULL,NULL,''),('260003','YtCarLoan:1:250004','usertask11','257501','257501','募集完成',NULL,NULL,NULL,NULL,'2017-04-12 10:14:15',NULL,NULL,NULL,NULL,50,NULL,NULL,NULL,''),('262505','YtCarLoan:1:250004','usertask1','262501','262501','申请人确认申请',NULL,NULL,NULL,'78','2017-04-12 10:17:48',NULL,'2017-04-12 10:18:48',60008,'completed',50,NULL,NULL,NULL,''),('262512','YtCarLoan:1:250004','usertask2','262501','262501','初审',NULL,NULL,NULL,NULL,'2017-04-12 10:18:48',NULL,'2017-04-12 10:21:23',155823,'completed',50,NULL,NULL,NULL,''),('262520','YtCarLoan:1:250004','usertask3','262501','262501','复审',NULL,NULL,NULL,NULL,'2017-04-12 10:21:23',NULL,'2017-04-12 10:22:40',77133,'completed',50,NULL,NULL,NULL,''),('262524','YtCarLoan:1:250004','usertask4','262501','262501','终审',NULL,NULL,NULL,NULL,'2017-04-12 10:22:40',NULL,'2017-04-12 10:23:43',63386,'completed',50,NULL,NULL,NULL,''),('262529','YtCarLoan:1:250004','usertask5','262501','262501','垫付账户放款',NULL,NULL,NULL,NULL,'2017-04-12 10:23:43',NULL,'2017-04-12 10:27:38',235964,'completed',50,NULL,NULL,NULL,''),('262537','YtCarLoan:1:250004','usertask7','262501','262501','验收垫付款',NULL,NULL,NULL,NULL,'2017-04-12 10:27:38',NULL,'2017-04-12 10:30:03',145969,'completed',50,NULL,NULL,NULL,''),('262544','YtCarLoan:1:250004','usertask8','262501','262501','是否发布产品',NULL,NULL,NULL,NULL,'2017-04-12 10:30:03',NULL,'2017-04-12 10:32:52',169566,'completed',50,NULL,NULL,NULL,''),('262549','YtCarLoan:1:250004','usertask9','262501','262501','保证金申请',NULL,NULL,NULL,NULL,'2017-04-12 10:32:52',NULL,'2017-04-12 10:36:29',217148,'completed',50,NULL,NULL,NULL,''),('262553','YtCarLoan:1:250004','usertask16','262501','262501','缴纳保证金',NULL,NULL,NULL,NULL,'2017-04-12 10:36:29',NULL,'2017-04-12 10:37:29',60310,'completed',50,NULL,NULL,NULL,''),('262558','YtCarLoan:1:250004','usertask17','262501','262501','保证金收款',NULL,NULL,NULL,NULL,'2017-04-12 10:37:29',NULL,'2017-04-12 10:43:50',381932,'completed',50,NULL,NULL,NULL,''),('265003','YtCarLoan:1:250004','usertask18','262501','262501','是否催款',NULL,NULL,NULL,NULL,'2017-04-12 10:43:50',NULL,'2017-04-12 10:44:35',45545,'completed',50,NULL,NULL,NULL,''),('265008','YtCarLoan:1:250004','usertask23','262501','262501','总部催款',NULL,NULL,NULL,NULL,'2017-04-12 10:44:35',NULL,'2017-04-12 10:45:21',46803,'completed',50,NULL,NULL,NULL,''),('265012','YtCarLoan:1:250004','usertask19','262501','262501','供应商还款',NULL,NULL,NULL,NULL,'2017-04-12 10:45:21',NULL,'2017-04-12 10:46:15',54606,'completed',50,NULL,NULL,NULL,''),('265017','YtCarLoan:1:250004','usertask20','262501','262501','总部确认收款',NULL,NULL,NULL,NULL,'2017-04-12 10:46:15',NULL,'2017-04-12 10:46:59',44105,'completed',50,NULL,NULL,NULL,''),('265021','YtCarLoan:1:250004','usertask21','262501','262501','退还保证金',NULL,NULL,NULL,NULL,'2017-04-12 10:46:59',NULL,'2017-04-12 10:50:04',185513,'completed',50,NULL,NULL,NULL,''),('265025','YtCarLoan:1:250004','usertask22','262501','262501','供应商回收保证金',NULL,NULL,NULL,NULL,'2017-04-12 10:50:04',NULL,'2017-04-12 10:51:03',59154,'completed',50,NULL,NULL,NULL,''),('267505','YtCarLoan:1:250004','usertask1','267501','267501','申请人确认申请',NULL,NULL,NULL,'71','2017-04-13 12:06:59',NULL,'2017-04-13 12:07:46',47272,'completed',50,NULL,NULL,NULL,''),('267512','YtCarLoan:1:250004','usertask2','267501','267501','初审',NULL,NULL,NULL,NULL,'2017-04-13 12:07:46',NULL,'2017-04-13 12:10:23',157513,'completed',50,NULL,NULL,NULL,''),('267520','YtCarLoan:1:250004','usertask3','267501','267501','复审',NULL,NULL,NULL,NULL,'2017-04-13 12:10:23',NULL,'2017-04-13 12:11:23',60270,'completed',50,NULL,NULL,NULL,''),('267524','YtCarLoan:1:250004','usertask4','267501','267501','终审',NULL,NULL,NULL,NULL,'2017-04-13 12:11:23',NULL,NULL,NULL,NULL,50,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `act_hi_taskinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_varinst`
--

DROP TABLE IF EXISTS `act_hi_varinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_varinst`
--

LOCK TABLES `act_hi_varinst` WRITE;
/*!40000 ALTER TABLE `act_hi_varinst` DISABLE KEYS */;
INSERT INTO `act_hi_varinst` VALUES ('250007','250005','250005',NULL,'inputUser','integer',1,NULL,NULL,71,'71',NULL,'2017-04-10 14:59:38','2017-04-10 15:06:05'),('250013','250005','250005',NULL,'branchCheckUser','serializable',2,'250014',NULL,NULL,NULL,NULL,'2017-04-10 15:00:38','2017-04-10 15:21:58'),('250020','250005','250005',NULL,'outcome','string',1,NULL,NULL,NULL,'通过',NULL,'2017-04-10 15:06:05','2017-04-10 15:21:58'),('250032','250030','250030',NULL,'inputUser','long',1,NULL,NULL,71,'71',NULL,'2017-04-10 15:47:35','2017-04-10 17:47:32'),('250038','250030','250030',NULL,'branchCheckUser','serializable',2,'250039',NULL,NULL,NULL,NULL,'2017-04-10 15:49:07','2017-04-10 17:47:32'),('250047','250030','250030',NULL,'outcome','string',4,NULL,NULL,NULL,'发布',NULL,'2017-04-10 15:49:59','2017-04-10 17:47:32'),('250063','250030','250030',NULL,'cooperateFinanceUser','serializable',6,'250064',NULL,NULL,NULL,NULL,'2017-04-10 15:55:49','2017-04-10 17:47:32'),('252517','252515','252515',NULL,'inputUser','long',1,NULL,NULL,71,'71',NULL,'2017-04-11 09:42:30','2017-04-11 11:51:49'),('252523','252515','252515',NULL,'branchCheckUser','serializable',2,'252524',NULL,NULL,NULL,NULL,'2017-04-11 09:46:42','2017-04-11 11:51:49'),('252532','252515','252515',NULL,'outcome','string',4,NULL,NULL,NULL,'发布',NULL,'2017-04-11 09:57:37','2017-04-11 11:51:49'),('252548','252515','252515',NULL,'cooperateFinanceUser','serializable',6,'252549',NULL,NULL,NULL,NULL,'2017-04-11 10:23:12','2017-04-11 11:51:49'),('257503','257501','257501',NULL,'inputUser','long',0,NULL,NULL,78,'78',NULL,'2017-04-12 10:00:32','2017-04-12 10:00:32'),('257509','257501','257501',NULL,'branchCheckUser','serializable',1,'257510',NULL,NULL,NULL,NULL,'2017-04-12 10:00:38','2017-04-12 10:02:06'),('257518','257501','257501',NULL,'outcome','string',3,NULL,NULL,NULL,'发布',NULL,'2017-04-12 10:02:06','2017-04-12 10:14:15'),('257534','257501','257501',NULL,'cooperateFinanceUser','serializable',0,'257535',NULL,NULL,NULL,NULL,'2017-04-12 10:04:41','2017-04-12 10:04:41'),('262503','262501','262501',NULL,'inputUser','long',1,NULL,NULL,78,'78',NULL,'2017-04-12 10:17:48','2017-04-12 10:51:03'),('262509','262501','262501',NULL,'branchCheckUser','serializable',2,'262510',NULL,NULL,NULL,NULL,'2017-04-12 10:18:48','2017-04-12 10:51:03'),('262518','262501','262501',NULL,'outcome','string',4,NULL,NULL,NULL,'不发布',NULL,'2017-04-12 10:21:23','2017-04-12 10:51:03'),('262534','262501','262501',NULL,'cooperateFinanceUser','serializable',4,'262535',NULL,NULL,NULL,NULL,'2017-04-12 10:27:38','2017-04-12 10:51:03'),('267503','267501','267501',NULL,'inputUser','long',0,NULL,NULL,71,'71',NULL,'2017-04-13 12:06:59','2017-04-13 12:06:59'),('267509','267501','267501',NULL,'branchCheckUser','serializable',1,'267510',NULL,NULL,NULL,NULL,'2017-04-13 12:07:46','2017-04-13 12:10:23'),('267518','267501','267501',NULL,'outcome','string',1,NULL,NULL,NULL,'通过',NULL,'2017-04-13 12:10:23','2017-04-13 12:11:23');
/*!40000 ALTER TABLE `act_hi_varinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_group`
--

DROP TABLE IF EXISTS `act_id_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_group`
--

LOCK TABLES `act_id_group` WRITE;
/*!40000 ALTER TABLE `act_id_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_info`
--

DROP TABLE IF EXISTS `act_id_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_info`
--

LOCK TABLES `act_id_info` WRITE;
/*!40000 ALTER TABLE `act_id_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_membership`
--

DROP TABLE IF EXISTS `act_id_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_membership`
--

LOCK TABLES `act_id_membership` WRITE;
/*!40000 ALTER TABLE `act_id_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_user`
--

DROP TABLE IF EXISTS `act_id_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_user`
--

LOCK TABLES `act_id_user` WRITE;
/*!40000 ALTER TABLE `act_id_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_deployment`
--

DROP TABLE IF EXISTS `act_re_deployment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_deployment`
--

LOCK TABLES `act_re_deployment` WRITE;
/*!40000 ALTER TABLE `act_re_deployment` DISABLE KEYS */;
INSERT INTO `act_re_deployment` VALUES ('250001','车贷流程',NULL,'','2017-04-10 06:54:18');
/*!40000 ALTER TABLE `act_re_deployment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_model`
--

DROP TABLE IF EXISTS `act_re_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_model`
--

LOCK TABLES `act_re_model` WRITE;
/*!40000 ALTER TABLE `act_re_model` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_procdef`
--

DROP TABLE IF EXISTS `act_re_procdef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_procdef`
--

LOCK TABLES `act_re_procdef` WRITE;
/*!40000 ALTER TABLE `act_re_procdef` DISABLE KEYS */;
INSERT INTO `act_re_procdef` VALUES ('YtCarLoan:1:250004',1,'http://www.activiti.org/test','YtCarLoanProcess','YtCarLoan',1,'250001','YtCarLoan.bpmn','YtCarLoan.png',NULL,0,1,1,'');
/*!40000 ALTER TABLE `act_re_procdef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_event_subscr`
--

DROP TABLE IF EXISTS `act_ru_event_subscr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_event_subscr`
--

LOCK TABLES `act_ru_event_subscr` WRITE;
/*!40000 ALTER TABLE `act_ru_event_subscr` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_event_subscr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_execution`
--

DROP TABLE IF EXISTS `act_ru_execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_execution`
--

LOCK TABLES `act_ru_execution` WRITE;
/*!40000 ALTER TABLE `act_ru_execution` DISABLE KEYS */;
INSERT INTO `act_ru_execution` VALUES ('250005',5,'250005','QDFGS_001_QDSHQ_1491807556058',NULL,'YtCarLoan:1:250004',NULL,'usertask3',1,0,1,0,1,2,'',NULL,NULL),('257501',8,'257501','BJYF_001_BJSHQ_1491962355830',NULL,'YtCarLoan:1:250004',NULL,'usertask11',1,0,1,0,1,2,'',NULL,NULL),('267501',4,'267501','QDFGS_001_QDSHQ_1492055918019',NULL,'YtCarLoan:1:250004',NULL,'usertask4',1,0,1,0,1,2,'',NULL,NULL);
/*!40000 ALTER TABLE `act_ru_execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_identitylink`
--

DROP TABLE IF EXISTS `act_ru_identitylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_identitylink`
--

LOCK TABLES `act_ru_identitylink` WRITE;
/*!40000 ALTER TABLE `act_ru_identitylink` DISABLE KEYS */;
INSERT INTO `act_ru_identitylink` VALUES ('250010',1,NULL,'participant','71',NULL,'250005',NULL),('250018',1,NULL,'participant','75',NULL,'250005',NULL),('257506',1,NULL,'participant','78',NULL,'257501',NULL),('257514',1,NULL,'participant','77',NULL,'257501',NULL),('257516',1,NULL,'participant','85',NULL,'257501',NULL),('257526',1,NULL,'participant','74',NULL,'257501',NULL),('257531',1,NULL,'participant','73',NULL,'257501',NULL),('257539',1,NULL,'participant','79',NULL,'257501',NULL),('257541',1,NULL,'participant','89',NULL,'257501',NULL),('257546',1,NULL,'participant','69',NULL,'257501',NULL),('260004',1,NULL,'candidate','69','260003',NULL,NULL),('267506',1,NULL,'participant','71',NULL,'267501',NULL),('267514',1,NULL,'participant','75',NULL,'267501',NULL),('267516',1,NULL,'participant','84',NULL,'267501',NULL),('267525',1,NULL,'candidate','74','267524',NULL,NULL),('267526',1,NULL,'participant','74',NULL,'267501',NULL);
/*!40000 ALTER TABLE `act_ru_identitylink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_job`
--

DROP TABLE IF EXISTS `act_ru_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_job`
--

LOCK TABLES `act_ru_job` WRITE;
/*!40000 ALTER TABLE `act_ru_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_task`
--

DROP TABLE IF EXISTS `act_ru_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DUE_DATE_` datetime DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_task`
--

LOCK TABLES `act_ru_task` WRITE;
/*!40000 ALTER TABLE `act_ru_task` DISABLE KEYS */;
INSERT INTO `act_ru_task` VALUES ('250029',1,'250005','250005','YtCarLoan:1:250004','复审',NULL,NULL,'usertask3',NULL,NULL,NULL,50,'2017-04-10 07:21:58',NULL,NULL,1,'',NULL),('260003',1,'257501','257501','YtCarLoan:1:250004','募集完成',NULL,NULL,'usertask11',NULL,NULL,NULL,50,'2017-04-12 02:14:15',NULL,NULL,1,'',NULL),('267524',1,'267501','267501','YtCarLoan:1:250004','终审',NULL,NULL,'usertask4',NULL,NULL,NULL,50,'2017-04-13 04:11:23',NULL,NULL,1,'',NULL);
/*!40000 ALTER TABLE `act_ru_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_variable`
--

DROP TABLE IF EXISTS `act_ru_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_variable`
--

LOCK TABLES `act_ru_variable` WRITE;
/*!40000 ALTER TABLE `act_ru_variable` DISABLE KEYS */;
INSERT INTO `act_ru_variable` VALUES ('250007',2,'integer','inputUser','250005','250005',NULL,NULL,NULL,71,'71',NULL),('250013',1,'serializable','branchCheckUser','250005','250005',NULL,'250012',NULL,NULL,NULL,NULL),('250020',2,'string','outcome','250005','250005',NULL,NULL,NULL,NULL,'通过',NULL),('257503',1,'long','inputUser','257501','257501',NULL,NULL,NULL,78,'78',NULL),('257509',1,'serializable','branchCheckUser','257501','257501',NULL,'257508',NULL,NULL,NULL,NULL),('257518',2,'string','outcome','257501','257501',NULL,NULL,NULL,NULL,'发布',NULL),('257534',1,'serializable','cooperateFinanceUser','257501','257501',NULL,'257533',NULL,NULL,NULL,NULL),('267503',1,'long','inputUser','267501','267501',NULL,NULL,NULL,71,'71',NULL),('267509',1,'serializable','branchCheckUser','267501','267501',NULL,'267508',NULL,NULL,NULL,NULL),('267518',1,'string','outcome','267501','267501',NULL,NULL,NULL,NULL,'通过',NULL);
/*!40000 ALTER TABLE `act_ru_variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_status`
--

DROP TABLE IF EXISTS `data_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_status` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_status`
--

LOCK TABLES `data_status` WRITE;
/*!40000 ALTER TABLE `data_status` DISABLE KEYS */;
INSERT INTO `data_status` VALUES (1,'初始录入'),(2,'已发起'),(3,'初审中'),(4,'复审中'),(5,'终审中'),(6,'已通过'),(7,'垫付款已放款'),(8,'垫付款已收款'),(9,'募集中'),(10,'募集完成'),(11,'借款账户已放款'),(12,'供应商已收款'),(13,'垫付款已还款'),(14,'垫付款还款已收款'),(15,'保证金已申请'),(16,'保证金已缴纳'),(17,'借款中'),(18,'需催款'),(19,'需还款'),(20,'供应商已还款'),(21,'总部已收款'),(22,'保证金退还中'),(23,'保证金退还完成'),(24,'已完成'),(25,'已驳回'),(26,'已拒绝');
/*!40000 ALTER TABLE `data_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `code` varchar(64) NOT NULL,
  `icon` varchar(32) DEFAULT NULL,
  `pid` bigint(19) DEFAULT NULL,
  `seq` tinyint(2) NOT NULL DEFAULT '0',
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='组织机构';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (1,'总部','北京','01','icon-company',NULL,0,'2014-02-19 01:00:00'),(7,'青岛分公司','青岛','02','icon-company',NULL,3,'2017-02-20 15:13:52'),(9,'杭州分公司','杭州','03','icon-company',NULL,4,'2017-03-03 17:17:34'),(10,'北京一分','北京','04','icon-company',NULL,1,'2017-03-06 11:38:42'),(20,'杭州海俊','杭州','001','icon-folder',9,0,'2017-04-07 10:51:20'),(21,'青岛梓杉','青岛','001','icon-folder',7,0,'2017-04-07 10:53:00'),(22,'北京中嵩','北京','001','icon-folder',10,0,'2017-04-07 10:53:23'),(23,'李洋','北京','002','icon-folder',10,0,'2017-04-07 10:53:39');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource`
--

DROP TABLE IF EXISTS `resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `url` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `icon` varchar(32) DEFAULT NULL,
  `pid` bigint(19) DEFAULT NULL,
  `seq` tinyint(2) NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `resourcetype` tinyint(2) NOT NULL DEFAULT '0',
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8 COMMENT='资源';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource`
--

LOCK TABLES `resource` WRITE;
/*!40000 ALTER TABLE `resource` DISABLE KEYS */;
INSERT INTO `resource` VALUES (1,'系统管理','','系统管理','icon-company',NULL,9,0,0,'2014-02-19 01:00:00'),(11,'资源管理','/resource/manager','资源管理','icon-folder',1,1,0,0,'2014-02-19 01:00:00'),(12,'角色管理','/role/manager','角色管理','icon-folder',1,2,0,0,'2014-02-19 01:00:00'),(13,'用户管理','/user/manager','用户管理','icon-folder',1,3,0,0,'2014-02-19 01:00:00'),(14,'部门管理','/organization/manager','部门管理','icon-folder',1,4,0,0,'2014-02-19 01:00:00'),(111,'列表','/resource/treeGrid','资源列表','icon-list',11,0,0,1,'2014-02-19 01:00:00'),(112,'添加','/resource/add','资源添加','icon-add',11,0,0,1,'2014-02-19 01:00:00'),(113,'编辑','/resource/edit','资源编辑','icon-edit',11,0,0,1,'2014-02-19 01:00:00'),(114,'删除','/resource/delete','资源删除','icon-del',11,0,0,1,'2014-02-19 01:00:00'),(121,'列表','/role/dataGrid','角色列表','icon-list',12,0,0,1,'2014-02-19 01:00:00'),(122,'添加','/role/add','角色添加','icon-add',12,0,0,1,'2014-02-19 01:00:00'),(123,'编辑','/role/edit','角色编辑','icon-edit',12,0,0,1,'2014-02-19 01:00:00'),(124,'删除','/role/delete','角色删除','icon-del',12,0,0,1,'2014-02-19 01:00:00'),(125,'授权','/role/grant','角色授权','icon-ok',12,0,0,1,'2014-02-19 01:00:00'),(131,'列表','/user/dataGrid','用户列表','icon-list',13,0,0,1,'2014-02-19 01:00:00'),(132,'添加','/user/add','用户添加','icon-add',13,0,0,1,'2014-02-19 01:00:00'),(133,'编辑','/user/edit','用户编辑','icon-edit',13,0,0,1,'2014-02-19 01:00:00'),(134,'删除','/user/delete','用户删除','icon-del',13,0,0,1,'2014-02-19 01:00:00'),(141,'列表','/organization/treeGrid','用户列表','icon-list',14,0,0,1,'2014-02-19 01:00:00'),(142,'添加','/organization/add','部门添加','icon-add',14,0,0,1,'2014-02-19 01:00:00'),(143,'编辑','/organization/edit','部门编辑','icon-edit',14,0,0,1,'2014-02-19 01:00:00'),(144,'删除','/organization/delete','部门删除','icon-del',14,0,0,1,'2014-02-19 01:00:00'),(226,'修改密码','/user/editPwdPage',NULL,'icon-edit',NULL,3,0,1,'2015-12-07 20:23:06'),(227,'车贷业务','',NULL,'icon-company',NULL,0,0,0,'2017-02-20 15:25:06'),(228,'合作机构管理','/cooperate/manager',NULL,'icon-folder',227,0,0,0,'2017-02-20 15:25:49'),(229,'车贷信息管理','/business/manager',NULL,'icon-folder',227,1,0,0,'2017-02-20 15:28:51'),(230,'添加','/cooperate/add',NULL,'icon-add',228,0,0,1,'2017-02-20 17:10:14'),(236,'编辑联系人','/cooperate/editLinkman',NULL,'icon-edit',228,0,0,1,'2017-02-23 18:08:16'),(237,'添加联系人','/cooperate/addLinkman',NULL,'icon-add',228,0,0,1,'2017-02-23 18:09:06'),(238,'删除联系人','/cooperate/deleteLinkman',NULL,'icon-del',228,0,0,1,'2017-02-23 18:11:13'),(239,'指纹录入','/fingerprint/manager',NULL,'icon-folder',1,5,0,0,'2017-02-23 20:14:32'),(242,'添加银行账户','/cooperate/addBank',NULL,'icon-add',228,0,0,1,'2017-02-24 17:13:10'),(243,'删除银行账户','/cooperate/deleteBank',NULL,'icon-del',228,0,0,1,'2017-02-24 17:22:51'),(245,'流程部署管理','/process/manager',NULL,'icon-folder',1,6,0,0,'2017-03-01 18:01:18'),(246,'申请贷款','/business/add',NULL,'icon-add',229,0,0,1,'2017-03-07 15:51:36'),(247,'上传资料','/business/upload',NULL,'icon-upload',229,0,0,1,'2017-03-09 10:16:51'),(248,'贷款详情','/business/dataDetail',NULL,'icon-search',229,0,0,1,'2017-03-10 09:50:20'),(249,'发起申请','/business/start',NULL,'icon-ok',229,0,0,1,'2017-03-10 13:55:53'),(250,'删除','/process/delete',NULL,'icon-del',245,0,0,1,'2017-03-13 09:28:49'),(251,'查看流程图','/process/viewImg',NULL,'icon-search',245,0,0,1,'2017-03-13 09:36:12'),(252,'编辑','/business/edit',NULL,'icon-edit',229,0,0,1,'2017-03-13 10:40:16'),(254,'个人任务管理','/personalTask/manager',NULL,'icon-folder',227,1,0,0,'2017-03-13 11:34:52'),(256,'办理任务','/personalTask/transactTask',NULL,'icon-ok',254,0,0,1,'2017-03-13 15:27:48'),(257,'查看当前流程图','/personalTask/currentImg',NULL,'icon-search',254,0,0,1,'2017-03-13 15:28:22'),(258,'历史审批','/business/hisComment',NULL,'icon-search',229,0,0,1,'2017-03-15 15:55:47'),(259,'完成','/business/complete',NULL,'icon-ok',229,0,0,1,'2017-03-15 15:56:26'),(260,'发布产品','/personalTask/publishProduct',NULL,'icon-world_add',254,0,0,1,'2017-03-16 16:40:00'),(261,'下载资料','/business/downloadFile',NULL,'icon-download',229,0,0,1,'2017-03-29 14:19:13'),(262,'编辑银行账户','/cooperate/editBank',NULL,'icon-edit',228,0,0,1,'2017-04-07 14:23:13'),(263,'信用信息','',NULL,'',NULL,1,0,0,'2017-08-14 14:43:12'),(264,'致诚阿福','/echoApi/manager',NULL,'',263,1,0,0,'2017-08-14 14:44:27'),(265,'计划任务管理','/schedule/manager',NULL,'',1,7,0,0,'2017-08-15 19:13:10'),(266,'添加借款人信息','/echoApi/mortgagorAdd',NULL,'',264,1,0,1,'2017-08-17 16:55:31'),(268,'天机360','/tianji360/tianji360Manager',NULL,'',263,2,0,0,'2018-02-27 11:29:24');
/*!40000 ALTER TABLE `resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `seq` tinyint(2) NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='角色';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'超级管理员',0,'超级管理员',0),(9,'供应商申请人',1,'供应商申请人',0),(10,'供应商财务',2,'供应商财务',0),(11,'分公司审核',3,'分公司审核',0),(12,'总部审核',4,'总部审核',0),(13,'总部财务',5,'总部财务',0),(14,'总部产品',6,'总部产品',0),(15,'管理员',7,'普通管理员',0),(16,'测试账户',8,'测试账户',0);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_resource`
--

DROP TABLE IF EXISTS `role_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_resource` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(19) NOT NULL,
  `resource_id` bigint(19) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2348 DEFAULT CHARSET=utf8 COMMENT='角色资源';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_resource`
--

LOCK TABLES `role_resource` WRITE;
/*!40000 ALTER TABLE `role_resource` DISABLE KEYS */;
INSERT INTO `role_resource` VALUES (1345,10,227),(1346,10,229),(1347,10,258),(1348,10,248),(1349,10,254),(1350,10,256),(1351,10,257),(1493,11,227),(1494,11,229),(1495,11,258),(1496,11,261),(1497,11,248),(1498,11,254),(1499,11,256),(1500,11,257),(1501,12,227),(1502,12,229),(1503,12,258),(1504,12,259),(1505,12,261),(1506,12,248),(1507,12,254),(1508,12,256),(1509,12,257),(1510,13,227),(1511,13,229),(1512,13,258),(1513,13,259),(1514,13,248),(1515,13,254),(1516,13,256),(1517,13,257),(1622,9,227),(1623,9,229),(1624,9,258),(1625,9,261),(1626,9,246),(1627,9,247),(1628,9,248),(1629,9,249),(1630,9,252),(1631,9,254),(1632,9,256),(1633,9,257),(1839,16,227),(1840,16,228),(1841,16,230),(1842,16,236),(1843,16,237),(1844,16,238),(1845,16,242),(1846,16,243),(1847,16,229),(1848,16,258),(1849,16,259),(1850,16,261),(1851,16,246),(1852,16,247),(1853,16,248),(1854,16,249),(1855,16,252),(1856,16,254),(1857,16,256),(1858,16,257),(1859,16,260),(1860,16,1),(1861,16,12),(1862,16,121),(1863,16,122),(1864,16,123),(1865,16,124),(1866,16,13),(1867,16,131),(1868,16,132),(1869,16,133),(1870,16,134),(1871,16,14),(1872,16,141),(1873,16,142),(1874,16,143),(1875,16,144),(1876,16,239),(1877,16,245),(1878,16,251),(1996,14,227),(1997,14,229),(1998,14,258),(1999,14,261),(2000,14,248),(2001,14,254),(2002,14,256),(2003,14,257),(2004,14,260),(2005,15,227),(2006,15,228),(2007,15,230),(2008,15,236),(2009,15,237),(2010,15,238),(2011,15,242),(2012,15,243),(2013,15,229),(2014,15,258),(2015,15,259),(2016,15,261),(2017,15,246),(2018,15,247),(2019,15,248),(2020,15,249),(2021,15,252),(2022,15,254),(2023,15,256),(2024,15,257),(2025,15,260),(2026,15,1),(2027,15,13),(2028,15,131),(2029,15,132),(2030,15,133),(2031,15,134),(2032,15,14),(2033,15,141),(2034,15,142),(2035,15,143),(2036,15,144),(2037,15,239),(2296,1,227),(2297,1,228),(2298,1,262),(2299,1,230),(2300,1,236),(2301,1,237),(2302,1,238),(2303,1,242),(2304,1,243),(2305,1,229),(2306,1,258),(2307,1,259),(2308,1,261),(2309,1,246),(2310,1,247),(2311,1,248),(2312,1,249),(2313,1,252),(2314,1,254),(2315,1,256),(2316,1,257),(2317,1,260),(2318,1,263),(2319,1,264),(2320,1,266),(2321,1,1),(2322,1,11),(2323,1,111),(2324,1,112),(2325,1,113),(2326,1,114),(2327,1,12),(2328,1,121),(2329,1,122),(2330,1,123),(2331,1,124),(2332,1,125),(2333,1,13),(2334,1,131),(2335,1,132),(2336,1,133),(2337,1,134),(2338,1,14),(2339,1,141),(2340,1,142),(2341,1,143),(2342,1,144),(2343,1,239),(2344,1,245),(2345,1,250),(2346,1,251),(2347,1,265);
/*!40000 ALTER TABLE `role_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_job`
--

DROP TABLE IF EXISTS `schedule_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_job` (
  `job_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `job_name` varchar(100) DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(100) DEFAULT NULL COMMENT '任务分组',
  `cron_Expression` varchar(50) DEFAULT NULL COMMENT 'cron表达式',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `bean_class` varchar(255) DEFAULT NULL COMMENT '任务执行时调用哪个类的方法 包名+类名',
  `is_concurrent` int(1) DEFAULT '0' COMMENT '是否允许并发 0 否 1是',
  `spring_id` varchar(255) DEFAULT NULL COMMENT 'spring bean',
  `method_name` varchar(255) DEFAULT NULL COMMENT '任务调用的方法名',
  `job_status` int(1) DEFAULT '0' COMMENT '任务状态 0-停止 1启动 2暂停 3删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='定时任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_job`
--

LOCK TABLES `schedule_job` WRITE;
/*!40000 ALTER TABLE `schedule_job` DISABLE KEYS */;
INSERT INTO `schedule_job` VALUES (1,'2','3','4',NULL,NULL,0,NULL,NULL,0,'2017-08-16 03:13:51','0000-00-00 00:00:00'),(2,'天机360','1','0 0/5 * * * ?','','com.mrbt.yeston.task.ScheduleTianjiTask',0,'scheduleTianjiTask','getMarkedInputstream',1,'2018-03-08 08:08:21','2018-03-09 01:16:21');
/*!40000 ALTER TABLE `schedule_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_log`
--

DROP TABLE IF EXISTS `schedule_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) unsigned DEFAULT NULL COMMENT 'schedule_job id',
  `execute_time` datetime NOT NULL COMMENT '执行时间',
  `description` varchar(250) NOT NULL COMMENT '执行记录描述',
  `error_log` text COMMENT '错误日志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1489 DEFAULT CHARSET=utf8 COMMENT='定时任务执行日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_log`
--

LOCK TABLES `schedule_log` WRITE;
/*!40000 ALTER TABLE `schedule_log` DISABLE KEYS */;
INSERT INTO `schedule_log` VALUES (1,1,'2017-08-16 11:40:09','初始化任务成功:2',NULL),(2,1,'2017-08-16 11:40:10','初始化任务成功:2',NULL),(3,1,'2017-08-16 11:40:21','初始化任务成功:2',NULL),(4,1,'2017-08-16 11:40:22','初始化任务成功:2',NULL),(5,1,'2017-08-16 11:40:52','初始化任务成功:2',NULL),(6,1,'2017-08-16 11:40:53','初始化任务成功:2',NULL),(7,1,'2017-08-16 13:40:38','初始化任务成功:2',NULL),(8,1,'2017-08-16 13:40:39','初始化任务成功:2',NULL),(9,1,'2017-08-16 13:41:00','初始化任务成功:2',NULL),(10,1,'2017-08-16 13:41:01','初始化任务成功:2',NULL),(11,1,'2017-08-16 13:43:32','初始化任务成功:2',NULL),(12,1,'2017-08-16 13:43:34','初始化任务成功:2',NULL),(13,1,'2017-08-16 13:43:54','初始化任务成功:2',NULL),(14,1,'2017-08-16 13:43:55','初始化任务成功:2',NULL),(15,1,'2017-08-16 13:48:30','初始化任务成功:2',NULL),(16,1,'2017-08-16 13:48:31','初始化任务成功:2',NULL),(17,1,'2017-08-16 13:48:42','初始化任务成功:2',NULL),(18,1,'2017-08-16 13:48:44','初始化任务成功:2',NULL),(19,1,'2017-08-16 13:56:45','初始化任务成功:2',NULL),(20,1,'2017-08-16 13:56:47','初始化任务成功:2',NULL),(21,1,'2017-08-16 13:56:57','初始化任务成功:2',NULL),(22,1,'2017-08-16 13:56:59','初始化任务成功:2',NULL),(23,1,'2017-08-16 14:50:39','初始化任务成功:2',NULL),(24,1,'2017-08-16 14:50:40','初始化任务成功:2',NULL),(25,1,'2017-08-16 14:54:22','初始化任务成功:2',NULL),(26,1,'2017-08-16 14:54:23','初始化任务成功:2',NULL),(27,1,'2017-08-16 15:04:23','初始化任务成功:2',NULL),(28,1,'2017-08-16 15:04:25','初始化任务成功:2',NULL),(29,1,'2017-08-16 15:04:35','初始化任务成功:2',NULL),(30,1,'2017-08-16 15:04:36','初始化任务成功:2',NULL),(31,1,'2017-08-16 15:31:59','初始化任务成功:2',NULL),(32,1,'2017-08-16 15:32:00','初始化任务成功:2',NULL),(33,1,'2017-08-16 15:32:11','初始化任务成功:2',NULL),(34,1,'2017-08-16 15:32:12','初始化任务成功:2',NULL),(35,1,'2017-08-16 15:33:33','初始化任务成功:2',NULL),(36,1,'2017-08-16 15:33:34','初始化任务成功:2',NULL),(37,1,'2017-08-16 15:37:55','初始化任务成功:2',NULL),(38,1,'2017-08-16 15:37:57','初始化任务成功:2',NULL),(39,1,'2017-08-16 15:52:50','初始化任务成功:2',NULL),(40,1,'2017-08-16 15:52:51','初始化任务成功:2',NULL),(41,1,'2017-08-16 15:54:02','初始化任务成功:2',NULL),(42,1,'2017-08-16 15:54:03','初始化任务成功:2',NULL),(43,1,'2017-08-16 15:56:05','初始化任务成功:2',NULL),(44,1,'2017-08-16 15:56:06','初始化任务成功:2',NULL),(45,1,'2017-08-16 15:56:26','初始化任务成功:2',NULL),(46,1,'2017-08-16 15:56:28','初始化任务成功:2',NULL),(47,1,'2017-08-16 15:58:19','初始化任务成功:2',NULL),(48,1,'2017-08-16 15:58:20','初始化任务成功:2',NULL),(49,1,'2017-08-16 16:05:13','初始化任务成功:2',NULL),(50,1,'2017-08-16 16:05:15','初始化任务成功:2',NULL),(51,1,'2017-08-16 16:05:35','初始化任务成功:2',NULL),(52,1,'2017-08-16 16:05:37','初始化任务成功:2',NULL),(53,1,'2017-08-16 16:05:59','初始化任务成功:2',NULL),(54,1,'2017-08-16 16:06:01','初始化任务成功:2',NULL),(55,1,'2017-08-16 16:08:12','初始化任务成功:2',NULL),(56,1,'2017-08-16 16:08:14','初始化任务成功:2',NULL),(57,1,'2017-08-16 16:41:55','初始化任务成功:2',NULL),(58,1,'2017-08-16 16:41:56','初始化任务成功:2',NULL),(59,1,'2017-08-16 16:42:07','初始化任务成功:2',NULL),(60,1,'2017-08-16 16:42:08','初始化任务成功:2',NULL),(61,1,'2017-08-16 16:43:08','初始化任务成功:2',NULL),(62,1,'2017-08-16 16:43:09','初始化任务成功:2',NULL),(63,1,'2017-08-16 16:43:20','初始化任务成功:2',NULL),(64,1,'2017-08-16 16:43:21','初始化任务成功:2',NULL),(65,1,'2017-08-16 16:45:12','初始化任务成功:2',NULL),(66,1,'2017-08-16 16:45:13','初始化任务成功:2',NULL),(67,1,'2017-08-16 17:27:18','初始化任务成功:2',NULL),(68,1,'2017-08-16 17:27:20','初始化任务成功:2',NULL),(69,1,'2017-08-16 17:27:31','初始化任务成功:2',NULL),(70,1,'2017-08-16 17:27:32','初始化任务成功:2',NULL),(71,1,'2017-08-16 17:35:56','初始化任务成功:2',NULL),(72,1,'2017-08-16 17:35:57','初始化任务成功:2',NULL),(73,1,'2017-08-16 17:36:08','初始化任务成功:2',NULL),(74,1,'2017-08-16 17:36:10','初始化任务成功:2',NULL),(75,1,'2017-08-16 17:39:11','初始化任务成功:2',NULL),(76,1,'2017-08-16 17:39:12','初始化任务成功:2',NULL),(77,1,'2017-08-16 18:12:39','初始化任务成功:2',NULL),(78,1,'2017-08-16 18:12:41','初始化任务成功:2',NULL),(79,1,'2017-08-16 18:12:51','初始化任务成功:2',NULL),(80,1,'2017-08-16 18:12:53','初始化任务成功:2',NULL),(81,1,'2017-08-16 18:14:13','初始化任务成功:2',NULL),(82,1,'2017-08-16 18:14:14','初始化任务成功:2',NULL),(83,1,'2017-08-17 09:07:15','初始化任务成功:2',NULL),(84,1,'2017-08-17 09:07:16','初始化任务成功:2',NULL),(85,1,'2017-08-17 09:07:27','初始化任务成功:2',NULL),(86,1,'2017-08-17 09:07:28','初始化任务成功:2',NULL),(87,1,'2017-08-17 10:26:05','初始化任务成功:2',NULL),(88,1,'2017-08-17 10:26:06','初始化任务成功:2',NULL),(89,1,'2017-08-17 10:26:17','初始化任务成功:2',NULL),(90,1,'2017-08-17 10:26:18','初始化任务成功:2',NULL),(91,1,'2017-08-17 10:37:43','初始化任务成功:2',NULL),(92,1,'2017-08-17 10:37:44','初始化任务成功:2',NULL),(93,1,'2017-08-17 10:37:55','初始化任务成功:2',NULL),(94,1,'2017-08-17 10:37:56','初始化任务成功:2',NULL),(95,1,'2017-08-17 10:39:16','初始化任务成功:2',NULL),(96,1,'2017-08-17 10:39:17','初始化任务成功:2',NULL),(97,1,'2017-08-17 10:53:41','初始化任务成功:2',NULL),(98,1,'2017-08-17 10:53:42','初始化任务成功:2',NULL),(99,1,'2017-08-17 11:35:07','初始化任务成功:2',NULL),(100,1,'2017-08-17 11:35:09','初始化任务成功:2',NULL),(101,1,'2017-08-17 11:36:51','初始化任务成功:2',NULL),(102,1,'2017-08-17 11:36:54','初始化任务成功:2',NULL),(103,1,'2017-08-17 11:37:18','初始化任务成功:2',NULL),(104,1,'2017-08-17 11:37:21','初始化任务成功:2',NULL),(105,1,'2017-08-17 11:39:30','初始化任务成功:2',NULL),(106,1,'2017-08-17 11:39:33','初始化任务成功:2',NULL),(107,1,'2017-08-17 11:49:27','初始化任务成功:2',NULL),(108,1,'2017-08-17 12:01:34','初始化任务成功:2',NULL),(109,1,'2017-08-17 13:54:50','初始化任务成功:2',NULL),(110,1,'2017-08-17 13:54:51','初始化任务成功:2',NULL),(111,1,'2017-08-17 13:55:02','初始化任务成功:2',NULL),(112,1,'2017-08-17 13:55:03','初始化任务成功:2',NULL),(113,1,'2017-08-17 16:01:20','初始化任务成功:2',NULL),(114,1,'2017-08-17 16:01:21','初始化任务成功:2',NULL),(115,1,'2017-08-17 16:01:31','初始化任务成功:2',NULL),(116,1,'2017-08-17 16:01:32','初始化任务成功:2',NULL),(117,1,'2017-08-17 16:41:52','初始化任务成功:2',NULL),(118,1,'2017-08-17 16:41:53','初始化任务成功:2',NULL),(119,1,'2017-08-17 16:42:03','初始化任务成功:2',NULL),(120,1,'2017-08-17 16:42:04','初始化任务成功:2',NULL),(121,1,'2017-08-17 16:54:27','初始化任务成功:2',NULL),(122,1,'2017-08-17 16:54:28','初始化任务成功:2',NULL),(123,1,'2017-08-17 17:02:00','初始化任务成功:2',NULL),(124,1,'2017-08-17 17:02:01','初始化任务成功:2',NULL),(125,1,'2017-08-17 17:02:21','初始化任务成功:2',NULL),(126,1,'2017-08-17 17:02:23','初始化任务成功:2',NULL),(127,1,'2017-08-18 10:42:59','初始化任务成功:2',NULL),(128,1,'2017-08-18 10:43:00','初始化任务成功:2',NULL),(129,1,'2017-08-18 10:43:09','初始化任务成功:2',NULL),(130,1,'2017-08-18 10:43:10','初始化任务成功:2',NULL),(131,1,'2017-08-18 14:00:21','初始化任务成功:2',NULL),(132,1,'2017-08-18 14:01:37','初始化任务成功:2',NULL),(133,1,'2017-08-18 14:18:07','初始化任务成功:2',NULL),(134,1,'2017-08-18 14:18:08','初始化任务成功:2',NULL),(135,1,'2017-08-18 14:18:18','初始化任务成功:2',NULL),(136,1,'2017-08-18 14:18:19','初始化任务成功:2',NULL),(137,1,'2017-08-21 09:42:12','初始化任务成功:2',NULL),(138,1,'2017-08-21 09:42:14','初始化任务成功:2',NULL),(139,1,'2017-08-21 09:47:31','初始化任务成功:2',NULL),(140,1,'2017-08-21 09:47:33','初始化任务成功:2',NULL),(141,1,'2017-08-21 09:47:49','初始化任务成功:2',NULL),(142,1,'2017-08-21 09:47:51','初始化任务成功:2',NULL),(143,1,'2017-08-21 11:26:36','初始化任务成功:2',NULL),(144,1,'2017-08-21 11:26:37','初始化任务成功:2',NULL),(145,1,'2017-08-21 11:27:29','初始化任务成功:2',NULL),(146,1,'2017-08-21 11:27:31','初始化任务成功:2',NULL),(147,1,'2017-08-21 11:30:03','初始化任务成功:2',NULL),(148,1,'2017-08-21 11:30:04','初始化任务成功:2',NULL),(149,1,'2017-08-21 13:49:58','初始化任务成功:2',NULL),(150,1,'2017-08-21 13:50:00','初始化任务成功:2',NULL),(151,1,'2017-08-21 13:50:17','初始化任务成功:2',NULL),(152,1,'2017-08-21 13:50:18','初始化任务成功:2',NULL),(153,1,'2017-08-21 14:55:30','初始化任务成功:2',NULL),(154,1,'2017-08-21 14:55:31','初始化任务成功:2',NULL),(155,1,'2017-08-21 14:57:39','初始化任务成功:2',NULL),(156,1,'2017-08-21 14:57:40','初始化任务成功:2',NULL),(157,1,'2017-08-22 10:58:20','初始化任务成功:2',NULL),(158,1,'2017-08-22 10:58:22','初始化任务成功:2',NULL),(159,1,'2017-08-22 11:02:19','初始化任务成功:2',NULL),(160,1,'2017-08-22 11:02:20','初始化任务成功:2',NULL),(161,1,'2017-08-22 11:40:48','初始化任务成功:2',NULL),(162,1,'2017-08-22 11:40:50','初始化任务成功:2',NULL),(163,1,'2017-08-22 11:43:35','初始化任务成功:2',NULL),(164,1,'2017-08-22 11:43:36','初始化任务成功:2',NULL),(165,1,'2017-08-22 11:45:52','初始化任务成功:2',NULL),(166,1,'2017-08-22 11:45:53','初始化任务成功:2',NULL),(167,1,'2017-08-22 13:33:08','初始化任务成功:2',NULL),(168,1,'2017-08-22 13:33:10','初始化任务成功:2',NULL),(169,1,'2017-08-22 14:17:55','初始化任务成功:2',NULL),(170,1,'2017-08-22 14:17:56','初始化任务成功:2',NULL),(171,1,'2017-08-22 14:20:46','初始化任务成功:2',NULL),(172,1,'2017-08-22 14:20:48','初始化任务成功:2',NULL),(173,1,'2017-08-22 14:39:46','初始化任务成功:2',NULL),(174,1,'2017-08-22 14:39:48','初始化任务成功:2',NULL),(175,1,'2017-08-22 14:49:01','初始化任务成功:2',NULL),(176,1,'2017-08-22 14:49:02','初始化任务成功:2',NULL),(177,1,'2017-08-22 14:51:35','初始化任务成功:2',NULL),(178,1,'2017-08-22 14:51:37','初始化任务成功:2',NULL),(179,1,'2017-08-22 14:54:41','初始化任务成功:2',NULL),(180,1,'2017-08-22 14:54:42','初始化任务成功:2',NULL),(181,1,'2017-08-22 14:56:17','初始化任务成功:2',NULL),(182,1,'2017-08-22 14:56:18','初始化任务成功:2',NULL),(183,1,'2017-08-22 15:19:54','初始化任务成功:2',NULL),(184,1,'2017-08-22 15:19:55','初始化任务成功:2',NULL),(185,1,'2017-08-22 15:32:40','初始化任务成功:2',NULL),(186,1,'2017-08-22 15:32:41','初始化任务成功:2',NULL),(187,1,'2017-08-22 15:36:37','初始化任务成功:2',NULL),(188,1,'2017-08-22 15:36:39','初始化任务成功:2',NULL),(189,1,'2017-08-22 15:55:14','初始化任务成功:2',NULL),(190,1,'2017-08-22 15:55:16','初始化任务成功:2',NULL),(191,1,'2017-08-22 16:57:38','初始化任务成功:2',NULL),(192,1,'2017-08-22 16:57:40','初始化任务成功:2',NULL),(193,1,'2017-08-22 17:18:21','初始化任务成功:2',NULL),(194,1,'2017-08-22 17:18:22','初始化任务成功:2',NULL),(195,1,'2017-08-22 17:42:58','初始化任务成功:2',NULL),(196,1,'2017-08-22 17:43:00','初始化任务成功:2',NULL),(197,1,'2017-08-22 17:58:30','初始化任务成功:2',NULL),(198,1,'2017-08-22 17:58:32','初始化任务成功:2',NULL),(199,1,'2017-08-22 18:18:30','初始化任务成功:2',NULL),(200,1,'2017-08-22 18:18:31','初始化任务成功:2',NULL),(201,1,'2017-08-23 09:12:12','初始化任务成功:2',NULL),(202,1,'2017-08-23 09:12:14','初始化任务成功:2',NULL),(203,1,'2017-08-23 09:22:01','初始化任务成功:2',NULL),(204,1,'2017-08-23 09:22:03','初始化任务成功:2',NULL),(205,1,'2017-08-23 09:32:29','初始化任务成功:2',NULL),(206,1,'2017-08-23 09:32:30','初始化任务成功:2',NULL),(207,1,'2017-08-23 10:03:48','初始化任务成功:2',NULL),(208,1,'2017-08-23 10:03:50','初始化任务成功:2',NULL),(209,1,'2017-08-23 10:18:32','初始化任务成功:2',NULL),(210,1,'2017-08-23 10:18:34','初始化任务成功:2',NULL),(211,1,'2017-08-23 10:21:07','初始化任务成功:2',NULL),(212,1,'2017-08-23 10:21:09','初始化任务成功:2',NULL),(213,1,'2017-08-23 15:06:47','初始化任务成功:2',NULL),(214,1,'2017-08-23 15:06:49','初始化任务成功:2',NULL),(215,1,'2017-08-23 15:07:53','初始化任务成功:2',NULL),(216,1,'2017-08-23 15:07:54','初始化任务成功:2',NULL),(217,1,'2017-08-23 16:05:02','初始化任务成功:2',NULL),(218,1,'2017-08-23 16:05:04','初始化任务成功:2',NULL),(219,1,'2017-08-23 17:30:38','初始化任务成功:2',NULL),(220,1,'2017-08-23 17:30:41','初始化任务成功:2',NULL),(221,1,'2017-08-23 17:31:05','初始化任务成功:2',NULL),(222,1,'2017-08-23 17:31:08','初始化任务成功:2',NULL),(223,1,'2017-08-23 18:38:00','初始化任务成功:2',NULL),(224,1,'2017-08-23 18:38:01','初始化任务成功:2',NULL),(225,1,'2017-08-23 19:08:33','初始化任务成功:2',NULL),(226,1,'2017-08-23 19:08:34','初始化任务成功:2',NULL),(227,1,'2017-08-23 20:37:05','初始化任务成功:2',NULL),(228,1,'2017-08-23 20:37:06','初始化任务成功:2',NULL),(229,1,'2017-08-24 14:38:22','初始化任务成功:2',NULL),(230,1,'2017-08-24 14:38:23','初始化任务成功:2',NULL),(231,1,'2017-08-24 14:54:18','初始化任务成功:2',NULL),(232,1,'2017-08-24 14:54:19','初始化任务成功:2',NULL),(233,1,'2017-08-24 15:16:51','初始化任务成功:2',NULL),(234,1,'2017-08-24 15:16:53','初始化任务成功:2',NULL),(235,1,'2017-08-24 15:22:00','初始化任务成功:2',NULL),(236,1,'2017-08-24 15:22:02','初始化任务成功:2',NULL),(237,1,'2017-08-24 15:37:20','初始化任务成功:2',NULL),(238,1,'2017-08-24 15:37:21','初始化任务成功:2',NULL),(239,1,'2017-08-24 15:49:33','初始化任务成功:2',NULL),(240,1,'2017-08-24 15:49:35','初始化任务成功:2',NULL),(241,1,'2017-08-24 16:05:28','初始化任务成功:2',NULL),(242,1,'2017-08-24 16:05:29','初始化任务成功:2',NULL),(243,1,'2017-08-24 16:12:52','初始化任务成功:2',NULL),(244,1,'2017-08-24 16:12:53','初始化任务成功:2',NULL),(245,1,'2017-08-24 16:18:49','初始化任务成功:2',NULL),(246,1,'2017-08-24 16:18:50','初始化任务成功:2',NULL),(247,1,'2017-08-24 16:20:02','初始化任务成功:2',NULL),(248,1,'2017-08-24 16:20:03','初始化任务成功:2',NULL),(249,1,'2017-08-24 16:40:52','初始化任务成功:2',NULL),(250,1,'2017-08-24 16:40:53','初始化任务成功:2',NULL),(251,1,'2017-08-24 17:27:44','初始化任务成功:2',NULL),(252,1,'2017-08-24 17:27:46','初始化任务成功:2',NULL),(253,1,'2017-08-24 17:30:13','初始化任务成功:2',NULL),(254,1,'2017-08-24 17:30:15','初始化任务成功:2',NULL),(255,1,'2017-08-25 11:18:34','初始化任务成功:2',NULL),(256,1,'2017-08-25 11:18:38','初始化任务成功:2',NULL),(257,1,'2017-08-25 11:19:21','初始化任务成功:2',NULL),(258,1,'2017-08-25 11:19:22','初始化任务成功:2',NULL),(259,1,'2017-08-25 11:19:33','初始化任务成功:2',NULL),(260,1,'2017-08-25 11:19:34','初始化任务成功:2',NULL),(261,1,'2017-08-25 11:42:39','初始化任务成功:2',NULL),(262,1,'2017-08-25 11:42:41','初始化任务成功:2',NULL),(263,1,'2017-08-25 14:09:35','初始化任务成功:2',NULL),(264,1,'2017-08-25 14:09:37','初始化任务成功:2',NULL),(265,1,'2017-08-25 14:11:10','初始化任务成功:2',NULL),(266,1,'2017-08-25 14:11:11','初始化任务成功:2',NULL),(267,1,'2017-08-25 14:15:54','初始化任务成功:2',NULL),(268,1,'2017-08-25 14:15:56','初始化任务成功:2',NULL),(269,1,'2017-08-25 15:51:30','初始化任务成功:2',NULL),(270,1,'2017-08-25 15:51:32','初始化任务成功:2',NULL),(271,1,'2017-08-25 15:52:05','初始化任务成功:2',NULL),(272,1,'2017-08-25 15:52:06','初始化任务成功:2',NULL),(273,1,'2017-08-25 15:52:16','初始化任务成功:2',NULL),(274,1,'2017-08-25 15:52:17','初始化任务成功:2',NULL),(275,1,'2017-08-25 15:56:28','初始化任务成功:2',NULL),(276,1,'2017-08-25 15:56:29','初始化任务成功:2',NULL),(277,1,'2017-08-25 16:23:53','初始化任务成功:2',NULL),(278,1,'2017-08-25 16:23:54','初始化任务成功:2',NULL),(279,1,'2017-08-25 16:24:19','初始化任务成功:2',NULL),(280,1,'2017-08-25 16:24:20','初始化任务成功:2',NULL),(281,1,'2017-08-25 16:24:31','初始化任务成功:2',NULL),(282,1,'2017-08-25 16:24:32','初始化任务成功:2',NULL),(283,1,'2017-08-25 16:25:25','初始化任务成功:2',NULL),(284,1,'2017-08-25 16:25:26','初始化任务成功:2',NULL),(285,1,'2017-08-25 16:25:37','初始化任务成功:2',NULL),(286,1,'2017-08-25 16:25:38','初始化任务成功:2',NULL),(287,1,'2017-08-25 17:20:23','初始化任务成功:2',NULL),(288,1,'2017-08-25 17:20:24','初始化任务成功:2',NULL),(289,1,'2017-08-25 17:20:35','初始化任务成功:2',NULL),(290,1,'2017-08-25 17:20:36','初始化任务成功:2',NULL),(291,1,'2017-09-04 14:06:48','初始化任务成功:2',NULL),(292,1,'2017-09-04 14:06:51','初始化任务成功:2',NULL),(293,1,'2017-09-07 14:09:19','初始化任务成功:2',NULL),(294,1,'2017-09-07 14:09:20','初始化任务成功:2',NULL),(295,1,'2017-09-07 14:09:31','初始化任务成功:2',NULL),(296,1,'2017-09-07 14:09:32','初始化任务成功:2',NULL),(297,1,'2017-09-13 17:38:58','初始化任务成功:2',NULL),(298,1,'2017-09-13 17:39:00','初始化任务成功:2',NULL),(299,1,'2017-09-13 17:39:12','初始化任务成功:2',NULL),(300,1,'2017-09-13 17:39:13','初始化任务成功:2',NULL),(301,1,'2017-09-13 17:49:31','初始化任务成功:2',NULL),(302,1,'2017-09-13 17:49:32','初始化任务成功:2',NULL),(303,1,'2017-09-13 17:49:44','初始化任务成功:2',NULL),(304,1,'2017-09-13 17:49:46','初始化任务成功:2',NULL),(305,1,'2017-09-21 11:36:35','初始化任务成功:2',NULL),(306,1,'2017-09-21 11:36:38','初始化任务成功:2',NULL),(307,1,'2017-09-22 15:21:47','初始化任务成功:2',NULL),(308,1,'2017-09-22 15:21:48','初始化任务成功:2',NULL),(309,1,'2017-09-22 15:21:59','初始化任务成功:2',NULL),(310,1,'2017-09-22 15:22:00','初始化任务成功:2',NULL),(311,1,'2017-10-24 09:05:30','初始化任务成功:2',NULL),(312,1,'2017-10-24 09:05:33','初始化任务成功:2',NULL),(313,1,'2018-02-22 11:36:00','初始化任务成功:2',NULL),(314,1,'2018-02-22 11:36:01','初始化任务成功:2',NULL),(315,1,'2018-02-22 11:36:43','初始化任务成功:2',NULL),(316,1,'2018-02-22 11:36:48','初始化任务成功:2',NULL),(317,1,'2018-02-22 11:42:52','初始化任务成功:2',NULL),(318,1,'2018-02-22 11:43:00','初始化任务成功:2',NULL),(319,1,'2018-02-22 11:54:45','初始化任务成功:2',NULL),(320,1,'2018-02-22 11:54:48','初始化任务成功:2',NULL),(321,1,'2018-02-22 11:56:31','初始化任务成功:2',NULL),(322,1,'2018-02-22 11:56:33','初始化任务成功:2',NULL),(323,1,'2018-02-22 11:56:55','初始化任务成功:2',NULL),(324,1,'2018-02-22 11:56:58','初始化任务成功:2',NULL),(325,1,'2018-02-22 13:36:19','初始化任务成功:2',NULL),(326,1,'2018-02-22 13:36:28','初始化任务成功:2',NULL),(327,1,'2018-02-22 13:43:14','初始化任务成功:2',NULL),(328,1,'2018-02-22 13:43:24','初始化任务成功:2',NULL),(329,1,'2018-02-22 13:48:06','初始化任务成功:2',NULL),(330,1,'2018-02-22 13:48:07','初始化任务成功:2',NULL),(331,1,'2018-02-22 13:54:03','初始化任务成功:2',NULL),(332,1,'2018-02-22 13:54:07','初始化任务成功:2',NULL),(333,1,'2018-02-22 14:43:16','初始化任务成功:2',NULL),(334,1,'2018-02-22 14:43:18','初始化任务成功:2',NULL),(335,1,'2018-02-27 11:12:04','初始化任务成功:2',NULL),(336,1,'2018-02-27 11:12:05','初始化任务成功:2',NULL),(337,1,'2018-02-27 11:12:20','初始化任务成功:2',NULL),(338,1,'2018-02-27 11:12:22','初始化任务成功:2',NULL),(339,1,'2018-02-27 11:53:26','初始化任务成功:2',NULL),(340,1,'2018-02-27 11:53:28','初始化任务成功:2',NULL),(341,1,'2018-02-27 11:53:43','初始化任务成功:2',NULL),(342,1,'2018-02-27 11:53:44','初始化任务成功:2',NULL),(343,1,'2018-02-27 14:59:06','初始化任务成功:2',NULL),(344,1,'2018-02-27 14:59:08','初始化任务成功:2',NULL),(345,1,'2018-02-27 14:59:23','初始化任务成功:2',NULL),(346,1,'2018-02-27 14:59:25','初始化任务成功:2',NULL),(347,1,'2018-02-28 13:34:24','初始化任务成功:2',NULL),(348,1,'2018-02-28 13:34:26','初始化任务成功:2',NULL),(349,1,'2018-02-28 13:34:47','初始化任务成功:2',NULL),(350,1,'2018-02-28 13:34:50','初始化任务成功:2',NULL),(351,1,'2018-02-28 13:40:50','初始化任务成功:2',NULL),(352,1,'2018-02-28 13:40:52','初始化任务成功:2',NULL),(353,1,'2018-02-28 13:43:11','初始化任务成功:2',NULL),(354,1,'2018-02-28 13:43:13','初始化任务成功:2',NULL),(355,1,'2018-02-28 13:44:17','初始化任务成功:2',NULL),(356,1,'2018-02-28 13:44:19','初始化任务成功:2',NULL),(357,1,'2018-02-28 13:44:37','初始化任务成功:2',NULL),(358,1,'2018-02-28 13:44:40','初始化任务成功:2',NULL),(359,1,'2018-02-28 13:46:59','初始化任务成功:2',NULL),(360,1,'2018-02-28 13:47:01','初始化任务成功:2',NULL),(361,1,'2018-02-28 13:48:18','初始化任务成功:2',NULL),(362,1,'2018-02-28 13:48:21','初始化任务成功:2',NULL),(363,1,'2018-02-28 14:08:39','初始化任务成功:2',NULL),(364,1,'2018-02-28 14:08:41','初始化任务成功:2',NULL),(365,1,'2018-02-28 14:09:49','初始化任务成功:2',NULL),(366,1,'2018-02-28 14:09:53','初始化任务成功:2',NULL),(367,1,'2018-02-28 14:33:49','初始化任务成功:2',NULL),(368,1,'2018-02-28 14:33:51','初始化任务成功:2',NULL),(369,1,'2018-02-28 14:34:09','初始化任务成功:2',NULL),(370,1,'2018-02-28 14:34:11','初始化任务成功:2',NULL),(371,1,'2018-02-28 14:36:02','初始化任务成功:2',NULL),(372,1,'2018-02-28 14:36:04','初始化任务成功:2',NULL),(373,1,'2018-02-28 14:49:39','初始化任务成功:2',NULL),(374,1,'2018-02-28 14:49:42','初始化任务成功:2',NULL),(375,1,'2018-02-28 14:50:00','初始化任务成功:2',NULL),(376,1,'2018-02-28 14:50:02','初始化任务成功:2',NULL),(377,1,'2018-02-28 14:52:18','初始化任务成功:2',NULL),(378,1,'2018-02-28 14:52:20','初始化任务成功:2',NULL),(379,1,'2018-02-28 14:52:38','初始化任务成功:2',NULL),(380,1,'2018-02-28 14:52:40','初始化任务成功:2',NULL),(381,1,'2018-02-28 15:00:32','初始化任务成功:2',NULL),(382,1,'2018-02-28 15:00:35','初始化任务成功:2',NULL),(383,1,'2018-02-28 15:02:54','初始化任务成功:2',NULL),(384,1,'2018-02-28 15:02:56','初始化任务成功:2',NULL),(385,1,'2018-02-28 15:03:23','初始化任务成功:2',NULL),(386,1,'2018-02-28 15:03:25','初始化任务成功:2',NULL),(387,1,'2018-02-28 15:06:45','初始化任务成功:2',NULL),(388,1,'2018-02-28 15:06:47','初始化任务成功:2',NULL),(389,1,'2018-02-28 15:08:25','初始化任务成功:2',NULL),(390,1,'2018-02-28 16:01:23','初始化任务成功:2',NULL),(391,1,'2018-02-28 16:01:26','初始化任务成功:2',NULL),(392,1,'2018-02-28 16:01:44','初始化任务成功:2',NULL),(393,1,'2018-02-28 16:01:46','初始化任务成功:2',NULL),(394,1,'2018-02-28 16:04:16','初始化任务成功:2',NULL),(395,1,'2018-02-28 16:04:19','初始化任务成功:2',NULL),(396,1,'2018-02-28 16:04:37','初始化任务成功:2',NULL),(397,1,'2018-02-28 16:04:40','初始化任务成功:2',NULL),(398,1,'2018-02-28 16:09:44','初始化任务成功:2',NULL),(399,1,'2018-02-28 16:09:46','初始化任务成功:2',NULL),(400,1,'2018-02-28 16:20:14','初始化任务成功:2',NULL),(401,1,'2018-02-28 16:20:17','初始化任务成功:2',NULL),(402,1,'2018-02-28 16:20:36','初始化任务成功:2',NULL),(403,1,'2018-02-28 16:20:39','初始化任务成功:2',NULL),(404,1,'2018-02-28 17:04:37','初始化任务成功:2',NULL),(405,1,'2018-02-28 17:04:39','初始化任务成功:2',NULL),(406,1,'2018-02-28 17:04:56','初始化任务成功:2',NULL),(407,1,'2018-02-28 17:04:58','初始化任务成功:2',NULL),(408,1,'2018-03-02 09:15:28','初始化任务成功:2',NULL),(409,1,'2018-03-02 09:15:30','初始化任务成功:2',NULL),(410,1,'2018-03-02 09:15:52','初始化任务成功:2',NULL),(411,1,'2018-03-02 09:15:54','初始化任务成功:2',NULL),(412,1,'2018-03-02 09:32:17','初始化任务成功:2',NULL),(413,1,'2018-03-02 09:32:19','初始化任务成功:2',NULL),(414,1,'2018-03-02 09:34:55','初始化任务成功:2',NULL),(415,1,'2018-03-02 09:34:57','初始化任务成功:2',NULL),(416,1,'2018-03-02 09:37:43','初始化任务成功:2',NULL),(417,1,'2018-03-02 09:37:45','初始化任务成功:2',NULL),(418,1,'2018-03-02 09:50:05','初始化任务成功:2',NULL),(419,1,'2018-03-02 09:50:07','初始化任务成功:2',NULL),(420,1,'2018-03-02 10:25:18','初始化任务成功:2',NULL),(421,1,'2018-03-02 10:25:21','初始化任务成功:2',NULL),(422,1,'2018-03-02 10:25:38','初始化任务成功:2',NULL),(423,1,'2018-03-02 10:25:40','初始化任务成功:2',NULL),(424,1,'2018-03-02 10:27:07','初始化任务成功:2',NULL),(425,1,'2018-03-02 10:27:09','初始化任务成功:2',NULL),(426,1,'2018-03-02 10:27:37','初始化任务成功:2',NULL),(427,1,'2018-03-02 10:27:39','初始化任务成功:2',NULL),(428,1,'2018-03-02 10:28:06','初始化任务成功:2',NULL),(429,1,'2018-03-02 10:28:08','初始化任务成功:2',NULL),(430,1,'2018-03-02 10:31:36','初始化任务成功:2',NULL),(431,1,'2018-03-02 10:31:38','初始化任务成功:2',NULL),(432,1,'2018-03-02 14:13:32','初始化任务成功:2',NULL),(433,1,'2018-03-02 14:13:34','初始化任务成功:2',NULL),(434,1,'2018-03-02 14:13:51','初始化任务成功:2',NULL),(435,1,'2018-03-02 14:13:54','初始化任务成功:2',NULL),(436,1,'2018-03-02 14:21:46','初始化任务成功:2',NULL),(437,1,'2018-03-02 14:21:48','初始化任务成功:2',NULL),(438,1,'2018-03-02 14:22:15','初始化任务成功:2',NULL),(439,1,'2018-03-02 14:22:17','初始化任务成功:2',NULL),(440,1,'2018-03-02 14:23:25','初始化任务成功:2',NULL),(441,1,'2018-03-02 14:23:27','初始化任务成功:2',NULL),(442,1,'2018-03-02 14:23:56','初始化任务成功:2',NULL),(443,1,'2018-03-02 14:24:00','初始化任务成功:2',NULL),(444,1,'2018-03-02 14:26:19','初始化任务成功:2',NULL),(445,1,'2018-03-02 14:26:21','初始化任务成功:2',NULL),(446,1,'2018-03-02 14:26:38','初始化任务成功:2',NULL),(447,1,'2018-03-02 14:26:40','初始化任务成功:2',NULL),(448,1,'2018-03-02 14:35:21','初始化任务成功:2',NULL),(449,1,'2018-03-02 14:35:23','初始化任务成功:2',NULL),(450,1,'2018-03-02 14:42:34','初始化任务成功:2',NULL),(451,1,'2018-03-02 14:42:36','初始化任务成功:2',NULL),(452,1,'2018-03-02 14:43:13','初始化任务成功:2',NULL),(453,1,'2018-03-02 14:43:15','初始化任务成功:2',NULL),(454,1,'2018-03-02 14:51:26','初始化任务成功:2',NULL),(455,1,'2018-03-02 14:51:28','初始化任务成功:2',NULL),(456,1,'2018-03-02 15:14:12','初始化任务成功:2',NULL),(457,1,'2018-03-02 15:14:15','初始化任务成功:2',NULL),(458,1,'2018-03-02 15:14:31','初始化任务成功:2',NULL),(459,1,'2018-03-02 15:14:33','初始化任务成功:2',NULL),(460,1,'2018-03-02 15:17:21','初始化任务成功:2',NULL),(461,1,'2018-03-02 15:17:23','初始化任务成功:2',NULL),(462,1,'2018-03-02 15:21:04','初始化任务成功:2',NULL),(463,1,'2018-03-02 15:21:06','初始化任务成功:2',NULL),(464,1,'2018-03-02 15:22:33','初始化任务成功:2',NULL),(465,1,'2018-03-02 15:22:35','初始化任务成功:2',NULL),(466,1,'2018-03-02 15:30:18','初始化任务成功:2',NULL),(467,1,'2018-03-02 15:30:21','初始化任务成功:2',NULL),(468,1,'2018-03-02 15:32:30','初始化任务成功:2',NULL),(469,1,'2018-03-02 15:32:33','初始化任务成功:2',NULL),(470,1,'2018-03-02 15:32:50','初始化任务成功:2',NULL),(471,1,'2018-03-02 15:32:52','初始化任务成功:2',NULL),(472,1,'2018-03-02 15:35:52','初始化任务成功:2',NULL),(473,1,'2018-03-02 15:35:54','初始化任务成功:2',NULL),(474,1,'2018-03-02 15:36:21','初始化任务成功:2',NULL),(475,1,'2018-03-02 15:36:23','初始化任务成功:2',NULL),(476,1,'2018-03-02 15:45:44','初始化任务成功:2',NULL),(477,1,'2018-03-02 15:45:46','初始化任务成功:2',NULL),(478,1,'2018-03-02 15:46:44','初始化任务成功:2',NULL),(479,1,'2018-03-02 15:46:47','初始化任务成功:2',NULL),(480,1,'2018-03-02 16:33:23','初始化任务成功:2',NULL),(481,1,'2018-03-02 16:33:26','初始化任务成功:2',NULL),(482,1,'2018-03-02 16:33:43','初始化任务成功:2',NULL),(483,1,'2018-03-02 16:33:45','初始化任务成功:2',NULL),(484,1,'2018-03-02 16:47:42','初始化任务成功:2',NULL),(485,1,'2018-03-02 16:47:44','初始化任务成功:2',NULL),(486,1,'2018-03-02 16:48:33','初始化任务成功:2',NULL),(487,1,'2018-03-02 16:48:35','初始化任务成功:2',NULL),(488,1,'2018-03-02 16:54:53','初始化任务成功:2',NULL),(489,1,'2018-03-02 16:54:56','初始化任务成功:2',NULL),(490,1,'2018-03-02 16:55:15','初始化任务成功:2',NULL),(491,1,'2018-03-02 16:55:17','初始化任务成功:2',NULL),(492,1,'2018-03-05 10:42:46','初始化任务成功:2',NULL),(493,1,'2018-03-05 10:42:48','初始化任务成功:2',NULL),(494,1,'2018-03-05 10:43:02','初始化任务成功:2',NULL),(495,1,'2018-03-05 10:43:04','初始化任务成功:2',NULL),(496,1,'2018-03-05 15:13:25','初始化任务成功:2',NULL),(497,1,'2018-03-05 15:13:26','初始化任务成功:2',NULL),(498,1,'2018-03-06 09:48:40','初始化任务成功:2',NULL),(499,1,'2018-03-06 09:48:42','初始化任务成功:2',NULL),(500,1,'2018-03-06 09:48:58','初始化任务成功:2',NULL),(501,1,'2018-03-06 09:48:59','初始化任务成功:2',NULL),(502,1,'2018-03-06 10:59:02','初始化任务成功:2',NULL),(503,1,'2018-03-06 10:59:04','初始化任务成功:2',NULL),(504,1,'2018-03-06 10:59:27','初始化任务成功:2',NULL),(505,1,'2018-03-06 10:59:29','初始化任务成功:2',NULL),(506,1,'2018-03-06 11:00:03','初始化任务成功:2',NULL),(507,1,'2018-03-06 11:00:05','初始化任务成功:2',NULL),(508,1,'2018-03-06 11:01:29','初始化任务成功:2',NULL),(509,1,'2018-03-06 11:01:31','初始化任务成功:2',NULL),(510,1,'2018-03-06 11:05:06','初始化任务成功:2',NULL),(511,1,'2018-03-06 13:30:23','初始化任务成功:2',NULL),(512,1,'2018-03-06 13:30:25','初始化任务成功:2',NULL),(513,1,'2018-03-06 13:30:44','初始化任务成功:2',NULL),(514,1,'2018-03-06 13:30:46','初始化任务成功:2',NULL),(515,1,'2018-03-06 13:37:10','初始化任务成功:2',NULL),(516,1,'2018-03-06 13:37:12','初始化任务成功:2',NULL),(517,1,'2018-03-06 13:54:08','初始化任务成功:2',NULL),(518,1,'2018-03-06 13:54:11','初始化任务成功:2',NULL),(519,1,'2018-03-06 14:11:47','初始化任务成功:2',NULL),(520,1,'2018-03-06 14:11:49','初始化任务成功:2',NULL),(521,1,'2018-03-06 14:13:20','初始化任务成功:2',NULL),(522,1,'2018-03-06 14:13:23','初始化任务成功:2',NULL),(523,1,'2018-03-06 14:13:42','初始化任务成功:2',NULL),(524,1,'2018-03-06 14:13:45','初始化任务成功:2',NULL),(525,1,'2018-03-06 14:15:13','初始化任务成功:2',NULL),(526,1,'2018-03-06 14:15:16','初始化任务成功:2',NULL),(527,1,'2018-03-06 14:25:00','初始化任务成功:2',NULL),(528,1,'2018-03-06 14:25:02','初始化任务成功:2',NULL),(529,1,'2018-03-06 14:25:30','初始化任务成功:2',NULL),(530,1,'2018-03-06 14:25:33','初始化任务成功:2',NULL),(531,1,'2018-03-06 14:27:13','初始化任务成功:2',NULL),(532,1,'2018-03-06 14:27:15','初始化任务成功:2',NULL),(533,1,'2018-03-06 14:32:14','初始化任务成功:2',NULL),(534,1,'2018-03-06 14:32:17','初始化任务成功:2',NULL),(535,1,'2018-03-06 14:32:35','初始化任务成功:2',NULL),(536,1,'2018-03-06 14:32:37','初始化任务成功:2',NULL),(537,1,'2018-03-06 14:36:58','初始化任务成功:2',NULL),(538,1,'2018-03-06 14:37:01','初始化任务成功:2',NULL),(539,1,'2018-03-06 14:45:11','初始化任务成功:2',NULL),(540,1,'2018-03-06 14:45:14','初始化任务成功:2',NULL),(541,1,'2018-03-06 14:45:53','初始化任务成功:2',NULL),(542,1,'2018-03-06 14:45:55','初始化任务成功:2',NULL),(543,1,'2018-03-06 14:46:24','初始化任务成功:2',NULL),(544,1,'2018-03-06 14:46:26','初始化任务成功:2',NULL),(545,1,'2018-03-06 15:00:24','初始化任务成功:2',NULL),(546,1,'2018-03-06 15:00:26','初始化任务成功:2',NULL),(547,1,'2018-03-06 15:00:44','初始化任务成功:2',NULL),(548,1,'2018-03-06 15:00:46','初始化任务成功:2',NULL),(549,1,'2018-03-06 15:09:28','初始化任务成功:2',NULL),(550,1,'2018-03-06 15:09:31','初始化任务成功:2',NULL),(551,1,'2018-03-06 17:18:47','初始化任务成功:2',NULL),(552,1,'2018-03-06 17:18:50','初始化任务成功:2',NULL),(553,1,'2018-03-06 17:19:11','初始化任务成功:2',NULL),(554,1,'2018-03-06 17:19:14','初始化任务成功:2',NULL),(555,1,'2018-03-06 18:02:03','初始化任务成功:2',NULL),(556,1,'2018-03-06 18:02:06','初始化任务成功:2',NULL),(557,1,'2018-03-06 18:02:07','初始化任务成功:2',NULL),(558,1,'2018-03-06 18:02:08','初始化任务成功:2',NULL),(559,1,'2018-03-06 18:08:38','初始化任务成功:2',NULL),(560,1,'2018-03-06 18:08:40','初始化任务成功:2',NULL),(561,1,'2018-03-06 18:09:19','初始化任务成功:2',NULL),(562,1,'2018-03-06 18:09:21','初始化任务成功:2',NULL),(563,1,'2018-03-07 10:20:49','初始化任务成功:2',NULL),(564,1,'2018-03-07 10:20:51','初始化任务成功:2',NULL),(565,1,'2018-03-07 10:21:09','初始化任务成功:2',NULL),(566,1,'2018-03-07 10:21:11','初始化任务成功:2',NULL),(567,1,'2018-03-07 10:21:12','初始化任务成功:2',NULL),(568,1,'2018-03-07 10:21:13','初始化任务成功:2',NULL),(569,1,'2018-03-07 10:21:14','初始化任务成功:2',NULL),(570,1,'2018-03-07 10:21:15','初始化任务成功:2',NULL),(571,1,'2018-03-07 10:21:16','初始化任务成功:2',NULL),(572,1,'2018-03-07 10:21:17','初始化任务成功:2',NULL),(573,1,'2018-03-07 10:22:52','初始化任务成功:2',NULL),(574,1,'2018-03-07 10:22:55','初始化任务成功:2',NULL),(575,1,'2018-03-07 10:23:14','初始化任务成功:2',NULL),(576,1,'2018-03-07 10:23:16','初始化任务成功:2',NULL),(577,1,'2018-03-07 10:33:18','初始化任务成功:2',NULL),(578,1,'2018-03-07 10:33:20','初始化任务成功:2',NULL),(579,1,'2018-03-07 10:55:00','初始化任务成功:2',NULL),(580,1,'2018-03-07 10:55:02','初始化任务成功:2',NULL),(581,1,'2018-03-07 10:55:04','初始化任务成功:2',NULL),(582,1,'2018-03-07 10:55:05','初始化任务成功:2',NULL),(583,1,'2018-03-07 10:58:13','初始化任务成功:2',NULL),(584,1,'2018-03-07 10:58:15','初始化任务成功:2',NULL),(585,1,'2018-03-07 10:58:29','初始化任务成功:2',NULL),(586,1,'2018-03-07 10:58:31','初始化任务成功:2',NULL),(587,1,'2018-03-07 11:12:21','初始化任务成功:2',NULL),(588,1,'2018-03-07 11:12:23','初始化任务成功:2',NULL),(589,1,'2018-03-07 11:12:37','初始化任务成功:2',NULL),(590,1,'2018-03-07 11:12:39','初始化任务成功:2',NULL),(591,1,'2018-03-07 15:04:02','初始化任务成功:2',NULL),(592,1,'2018-03-07 15:04:03','初始化任务成功:2',NULL),(593,1,'2018-03-07 15:04:27','初始化任务成功:2',NULL),(594,1,'2018-03-07 15:04:28','初始化任务成功:2',NULL),(595,1,'2018-03-07 15:23:59','初始化任务成功:2',NULL),(596,1,'2018-03-07 15:24:01','初始化任务成功:2',NULL),(597,1,'2018-03-07 15:25:25','初始化任务成功:2',NULL),(598,1,'2018-03-07 15:25:26','初始化任务成功:2',NULL),(599,1,'2018-03-07 16:23:18','初始化任务成功:2',NULL),(600,1,'2018-03-07 16:23:20','初始化任务成功:2',NULL),(601,1,'2018-03-07 16:23:39','初始化任务成功:2',NULL),(602,1,'2018-03-07 16:23:41','初始化任务成功:2',NULL),(603,1,'2018-03-07 16:58:15','初始化任务成功:2',NULL),(604,1,'2018-03-07 16:58:17','初始化任务成功:2',NULL),(605,1,'2018-03-07 17:05:39','初始化任务成功:2',NULL),(606,1,'2018-03-07 17:05:42','初始化任务成功:2',NULL),(607,1,'2018-03-07 17:07:13','初始化任务成功:2',NULL),(608,1,'2018-03-07 17:07:16','初始化任务成功:2',NULL),(609,1,'2018-03-07 17:08:36','初始化任务成功:2',NULL),(610,1,'2018-03-07 17:08:39','初始化任务成功:2',NULL),(611,1,'2018-03-07 17:17:14','初始化任务成功:2',NULL),(612,1,'2018-03-07 17:17:16','初始化任务成功:2',NULL),(613,1,'2018-03-07 17:17:32','初始化任务成功:2',NULL),(614,1,'2018-03-07 17:17:34','初始化任务成功:2',NULL),(615,1,'2018-03-07 17:18:20','初始化任务成功:2',NULL),(616,1,'2018-03-07 17:18:22','初始化任务成功:2',NULL),(617,1,'2018-03-07 17:22:38','初始化任务成功:2',NULL),(618,1,'2018-03-07 17:22:40','初始化任务成功:2',NULL),(619,1,'2018-03-07 17:23:01','初始化任务成功:2',NULL),(620,1,'2018-03-07 17:23:03','初始化任务成功:2',NULL),(621,1,'2018-03-07 17:26:34','初始化任务成功:2',NULL),(622,1,'2018-03-07 17:26:37','初始化任务成功:2',NULL),(623,1,'2018-03-07 17:27:26','初始化任务成功:2',NULL),(624,1,'2018-03-07 17:27:29','初始化任务成功:2',NULL),(625,1,'2018-03-07 17:30:00','初始化任务成功:2',NULL),(626,1,'2018-03-07 17:30:02','初始化任务成功:2',NULL),(627,1,'2018-03-07 17:31:26','初始化任务成功:2',NULL),(628,1,'2018-03-07 17:31:29','初始化任务成功:2',NULL),(629,1,'2018-03-07 17:42:13','初始化任务成功:2',NULL),(630,1,'2018-03-07 17:42:36','初始化任务成功:2',NULL),(631,1,'2018-03-07 17:43:45','初始化任务成功:2',NULL),(632,1,'2018-03-07 17:43:48','初始化任务成功:2',NULL),(633,1,'2018-03-07 17:44:08','初始化任务成功:2',NULL),(634,1,'2018-03-07 17:44:11','初始化任务成功:2',NULL),(635,1,'2018-03-07 17:45:11','初始化任务成功:2',NULL),(636,1,'2018-03-07 17:45:14','初始化任务成功:2',NULL),(637,1,'2018-03-07 17:59:00','初始化任务成功:2',NULL),(638,1,'2018-03-07 17:59:02','初始化任务成功:2',NULL),(639,1,'2018-03-07 17:59:34','初始化任务成功:2',NULL),(640,1,'2018-03-07 17:59:37','初始化任务成功:2',NULL),(641,1,'2018-03-07 18:04:29','初始化任务成功:2',NULL),(642,1,'2018-03-07 18:04:32','初始化任务成功:2',NULL),(643,1,'2018-03-07 18:08:54','初始化任务成功:2',NULL),(644,1,'2018-03-07 18:10:25','初始化任务成功:2',NULL),(645,1,'2018-03-07 18:10:28','初始化任务成功:2',NULL),(646,1,'2018-03-07 18:10:49','初始化任务成功:2',NULL),(647,1,'2018-03-07 18:10:51','初始化任务成功:2',NULL),(648,1,'2018-03-07 18:35:54','初始化任务成功:2',NULL),(649,1,'2018-03-07 18:35:57','初始化任务成功:2',NULL),(650,1,'2018-03-07 18:36:30','初始化任务成功:2',NULL),(651,1,'2018-03-07 18:36:33','初始化任务成功:2',NULL),(652,1,'2018-03-07 18:42:26','初始化任务成功:2',NULL),(653,1,'2018-03-07 18:42:29','初始化任务成功:2',NULL),(654,1,'2018-03-07 18:45:44','初始化任务成功:2',NULL),(655,1,'2018-03-07 18:45:46','初始化任务成功:2',NULL),(656,1,'2018-03-07 18:50:44','初始化任务成功:2',NULL),(657,1,'2018-03-07 18:50:47','初始化任务成功:2',NULL),(658,1,'2018-03-07 18:51:09','初始化任务成功:2',NULL),(659,1,'2018-03-07 18:51:12','初始化任务成功:2',NULL),(660,1,'2018-03-07 18:53:36','初始化任务成功:2',NULL),(661,1,'2018-03-07 18:53:40','初始化任务成功:2',NULL),(662,1,'2018-03-07 18:54:13','初始化任务成功:2',NULL),(663,1,'2018-03-07 18:54:16','初始化任务成功:2',NULL),(664,1,'2018-03-07 18:55:48','初始化任务成功:2',NULL),(665,1,'2018-03-07 18:55:51','初始化任务成功:2',NULL),(666,1,'2018-03-07 18:58:17','初始化任务成功:2',NULL),(667,1,'2018-03-07 18:58:20','初始化任务成功:2',NULL),(668,1,'2018-03-07 18:59:06','初始化任务成功:2',NULL),(669,1,'2018-03-07 18:59:10','初始化任务成功:2',NULL),(670,1,'2018-03-07 18:59:18','初始化任务成功:2',NULL),(671,1,'2018-03-07 19:04:07','初始化任务成功:2',NULL),(672,1,'2018-03-07 19:04:10','初始化任务成功:2',NULL),(673,1,'2018-03-07 19:04:30','初始化任务成功:2',NULL),(674,1,'2018-03-07 19:04:32','初始化任务成功:2',NULL),(675,1,'2018-03-07 19:05:00','初始化任务成功:2',NULL),(676,1,'2018-03-07 19:05:02','初始化任务成功:2',NULL),(677,1,'2018-03-08 10:27:53','初始化任务成功:2',NULL),(678,1,'2018-03-08 10:27:54','初始化任务成功:2',NULL),(679,1,'2018-03-08 10:37:15','初始化任务成功:2',NULL),(680,1,'2018-03-08 10:37:17','初始化任务成功:2',NULL),(681,1,'2018-03-08 10:37:37','初始化任务成功:2',NULL),(682,1,'2018-03-08 10:37:39','初始化任务成功:2',NULL),(683,1,'2018-03-08 10:46:12','初始化任务成功:2',NULL),(684,1,'2018-03-08 10:46:14','初始化任务成功:2',NULL),(685,1,'2018-03-08 10:46:44','初始化任务成功:2',NULL),(686,1,'2018-03-08 10:46:46','初始化任务成功:2',NULL),(687,1,'2018-03-08 10:48:05','初始化任务成功:2',NULL),(688,1,'2018-03-08 10:48:07','初始化任务成功:2',NULL),(689,1,'2018-03-08 10:49:17','初始化任务成功:2',NULL),(690,1,'2018-03-08 10:49:19','初始化任务成功:2',NULL),(691,1,'2018-03-08 11:58:14','初始化任务成功:2',NULL),(692,1,'2018-03-08 11:58:16','初始化任务成功:2',NULL),(693,1,'2018-03-08 11:58:33','初始化任务成功:2',NULL),(694,1,'2018-03-08 11:58:35','初始化任务成功:2',NULL),(695,1,'2018-03-08 13:34:50','初始化任务成功:2',NULL),(696,1,'2018-03-08 13:34:52','初始化任务成功:2',NULL),(697,1,'2018-03-08 13:35:07','初始化任务成功:2',NULL),(698,1,'2018-03-08 13:35:08','初始化任务成功:2',NULL),(699,1,'2018-03-08 14:44:47','初始化任务成功:2',NULL),(700,1,'2018-03-08 14:44:49','初始化任务成功:2',NULL),(701,1,'2018-03-08 14:45:45','初始化任务成功:2',NULL),(702,1,'2018-03-08 14:45:48','初始化任务成功:2',NULL),(703,1,'2018-03-08 14:46:06','初始化任务成功:2',NULL),(704,1,'2018-03-08 14:46:08','初始化任务成功:2',NULL),(705,NULL,'2018-03-08 14:49:31','启动任务成功',NULL),(706,1,'2018-03-08 14:59:24','初始化任务成功:2',NULL),(707,2,'2018-03-08 14:59:24','启动任务成功',NULL),(708,2,'2018-03-08 14:59:24','初始化任务成功:天机360',NULL),(709,1,'2018-03-08 14:59:26','初始化任务成功:2',NULL),(710,2,'2018-03-08 14:59:26','更新任务执行时间成功',NULL),(711,2,'2018-03-08 14:59:26','初始化任务成功:天机360',NULL),(712,1,'2018-03-08 15:01:18','初始化任务成功:2',NULL),(713,2,'2018-03-08 15:01:18','启动任务成功',NULL),(714,2,'2018-03-08 15:01:18','初始化任务成功:天机360',NULL),(715,1,'2018-03-08 15:01:48','初始化任务成功:2',NULL),(716,2,'2018-03-08 15:01:48','启动任务成功',NULL),(717,2,'2018-03-08 15:01:48','初始化任务成功:天机360',NULL),(718,1,'2018-03-08 15:01:51','初始化任务成功:2',NULL),(719,2,'2018-03-08 15:01:51','更新任务执行时间成功',NULL),(720,2,'2018-03-08 15:01:51','初始化任务成功:天机360',NULL),(721,1,'2018-03-08 15:02:12','初始化任务成功:2',NULL),(722,2,'2018-03-08 15:02:12','启动任务成功',NULL),(723,2,'2018-03-08 15:02:12','初始化任务成功:天机360',NULL),(724,1,'2018-03-08 15:02:14','初始化任务成功:2',NULL),(725,2,'2018-03-08 15:02:14','更新任务执行时间成功',NULL),(726,2,'2018-03-08 15:02:14','初始化任务成功:天机360',NULL),(727,2,'2018-03-08 15:02:49','更新执行时间，原执行时间0 0/5 * * * ?;现执行时间:0 0/1 * * * ?',NULL),(728,2,'2018-03-08 15:02:49','更新执行时间成功，现执行时间：0 0/1 * * * ?',NULL),(729,1,'2018-03-08 15:03:43','初始化任务成功:2',NULL),(730,2,'2018-03-08 15:03:43','启动任务成功',NULL),(731,2,'2018-03-08 15:03:43','初始化任务成功:天机360',NULL),(732,1,'2018-03-08 15:03:45','初始化任务成功:2',NULL),(733,2,'2018-03-08 15:03:45','更新任务执行时间成功',NULL),(734,2,'2018-03-08 15:03:45','初始化任务成功:天机360',NULL),(735,1,'2018-03-08 15:04:22','初始化任务成功:2',NULL),(736,2,'2018-03-08 15:04:22','启动任务成功',NULL),(737,2,'2018-03-08 15:04:22','初始化任务成功:天机360',NULL),(738,1,'2018-03-08 15:04:25','初始化任务成功:2',NULL),(739,2,'2018-03-08 15:04:25','更新任务执行时间成功',NULL),(740,2,'2018-03-08 15:04:25','初始化任务成功:天机360',NULL),(741,1,'2018-03-08 16:07:20','初始化任务成功:2',NULL),(742,2,'2018-03-08 16:07:20','启动任务成功',NULL),(743,2,'2018-03-08 16:07:20','初始化任务成功:天机360',NULL),(744,1,'2018-03-08 16:07:23','初始化任务成功:2',NULL),(745,2,'2018-03-08 16:07:23','更新任务执行时间成功',NULL),(746,2,'2018-03-08 16:07:23','初始化任务成功:天机360',NULL),(747,1,'2018-03-08 16:07:57','初始化任务成功:2',NULL),(748,2,'2018-03-08 16:07:57','启动任务成功',NULL),(749,2,'2018-03-08 16:07:57','初始化任务成功:天机360',NULL),(750,1,'2018-03-08 16:08:01','初始化任务成功:2',NULL),(751,2,'2018-03-08 16:08:01','更新任务执行时间成功',NULL),(752,2,'2018-03-08 16:08:01','初始化任务成功:天机360',NULL),(753,2,'2018-03-08 16:08:51','更新执行时间，原执行时间0 0/1 * * * ?;现执行时间:0 0 1 * * ?',NULL),(754,2,'2018-03-08 16:08:51','更新执行时间成功，现执行时间：0 0 1 * * ?',NULL),(755,2,'2018-03-08 16:09:35','删除任务成功',NULL),(756,2,'2018-03-08 16:09:35','启动任务成功',NULL),(757,2,'2018-03-08 16:11:04','删除任务成功',NULL),(758,2,'2018-03-08 16:11:04','启动任务成功',NULL),(759,2,'2018-03-08 16:11:12','删除任务成功',NULL),(760,2,'2018-03-08 16:11:12','启动任务成功',NULL),(761,2,'2018-03-08 16:16:47','立即执行任务成功',NULL),(762,2,'2018-03-08 16:17:20','立即执行任务成功',NULL),(763,1,'2018-03-08 16:21:34','初始化任务成功:2',NULL),(764,2,'2018-03-08 16:21:34','启动任务成功',NULL),(765,2,'2018-03-08 16:21:34','初始化任务成功:天机360',NULL),(766,1,'2018-03-08 16:21:38','初始化任务成功:2',NULL),(767,2,'2018-03-08 16:21:38','更新任务执行时间成功',NULL),(768,2,'2018-03-08 16:21:38','初始化任务成功:天机360',NULL),(769,1,'2018-03-08 16:22:09','初始化任务成功:2',NULL),(770,2,'2018-03-08 16:22:10','启动任务成功',NULL),(771,2,'2018-03-08 16:22:10','初始化任务成功:天机360',NULL),(772,1,'2018-03-08 16:22:14','初始化任务成功:2',NULL),(773,2,'2018-03-08 16:22:14','更新任务执行时间成功',NULL),(774,2,'2018-03-08 16:22:14','初始化任务成功:天机360',NULL),(775,2,'2018-03-08 16:23:17','立即执行任务成功',NULL),(776,1,'2018-03-08 16:22:39','初始化任务成功:2',NULL),(777,2,'2018-03-08 16:22:39','启动任务成功',NULL),(778,2,'2018-03-08 16:22:39','初始化任务成功:天机360',NULL),(779,1,'2018-03-08 16:22:42','初始化任务成功:2',NULL),(780,2,'2018-03-08 16:22:42','更新任务执行时间成功',NULL),(781,2,'2018-03-08 16:22:42','初始化任务成功:天机360',NULL),(782,1,'2018-03-08 16:22:59','初始化任务成功:2',NULL),(783,2,'2018-03-08 16:22:59','启动任务成功',NULL),(784,2,'2018-03-08 16:22:59','初始化任务成功:天机360',NULL),(785,1,'2018-03-08 16:23:01','初始化任务成功:2',NULL),(786,2,'2018-03-08 16:23:01','更新任务执行时间成功',NULL),(787,2,'2018-03-08 16:23:01','初始化任务成功:天机360',NULL),(788,1,'2018-03-08 16:30:11','初始化任务成功:2',NULL),(789,2,'2018-03-08 16:30:11','启动任务成功',NULL),(790,2,'2018-03-08 16:30:11','初始化任务成功:天机360',NULL),(791,1,'2018-03-08 16:30:13','初始化任务成功:2',NULL),(792,2,'2018-03-08 16:30:13','更新任务执行时间成功',NULL),(793,2,'2018-03-08 16:30:13','初始化任务成功:天机360',NULL),(794,2,'2018-03-08 16:31:11','立即执行任务成功',NULL),(795,1,'2018-03-08 16:34:31','初始化任务成功:2',NULL),(796,2,'2018-03-08 16:34:31','启动任务成功',NULL),(797,2,'2018-03-08 16:34:31','初始化任务成功:天机360',NULL),(798,1,'2018-03-08 16:34:33','初始化任务成功:2',NULL),(799,2,'2018-03-08 16:34:33','更新任务执行时间成功',NULL),(800,2,'2018-03-08 16:34:33','初始化任务成功:天机360',NULL),(801,1,'2018-03-08 16:34:51','初始化任务成功:2',NULL),(802,2,'2018-03-08 16:34:51','启动任务成功',NULL),(803,2,'2018-03-08 16:34:51','初始化任务成功:天机360',NULL),(804,1,'2018-03-08 16:34:53','初始化任务成功:2',NULL),(805,2,'2018-03-08 16:34:53','更新任务执行时间成功',NULL),(806,2,'2018-03-08 16:34:53','初始化任务成功:天机360',NULL),(807,2,'2018-03-08 16:36:24','更新执行时间，原执行时间0 0 1 * * ?;现执行时间:0 0/1 * * * ?',NULL),(808,2,'2018-03-08 16:36:24','更新执行时间成功，现执行时间：0 0/1 * * * ?',NULL),(809,1,'2018-03-08 16:41:36','初始化任务成功:2',NULL),(810,2,'2018-03-08 16:41:36','启动任务成功',NULL),(811,2,'2018-03-08 16:41:36','初始化任务成功:天机360',NULL),(812,1,'2018-03-08 16:41:38','初始化任务成功:2',NULL),(813,2,'2018-03-08 16:41:38','更新任务执行时间成功',NULL),(814,2,'2018-03-08 16:41:38','初始化任务成功:天机360',NULL),(815,1,'2018-03-08 16:41:55','初始化任务成功:2',NULL),(816,2,'2018-03-08 16:41:55','启动任务成功',NULL),(817,2,'2018-03-08 16:41:55','初始化任务成功:天机360',NULL),(818,1,'2018-03-08 16:41:57','初始化任务成功:2',NULL),(819,2,'2018-03-08 16:41:57','更新任务执行时间成功',NULL),(820,2,'2018-03-08 16:41:57','初始化任务成功:天机360',NULL),(821,1,'2018-03-08 16:49:39','初始化任务成功:2',NULL),(822,2,'2018-03-08 16:49:39','启动任务成功',NULL),(823,2,'2018-03-08 16:49:39','初始化任务成功:天机360',NULL),(824,1,'2018-03-08 16:49:41','初始化任务成功:2',NULL),(825,2,'2018-03-08 16:49:41','更新任务执行时间成功',NULL),(826,2,'2018-03-08 16:49:41','初始化任务成功:天机360',NULL),(827,1,'2018-03-08 16:49:55','初始化任务成功:2',NULL),(828,2,'2018-03-08 16:49:55','启动任务成功',NULL),(829,2,'2018-03-08 16:49:55','初始化任务成功:天机360',NULL),(830,1,'2018-03-08 16:49:57','初始化任务成功:2',NULL),(831,2,'2018-03-08 16:49:57','更新任务执行时间成功',NULL),(832,2,'2018-03-08 16:49:57','初始化任务成功:天机360',NULL),(833,1,'2018-03-08 16:59:49','初始化任务成功:2',NULL),(834,2,'2018-03-08 16:59:49','启动任务成功',NULL),(835,2,'2018-03-08 16:59:49','初始化任务成功:天机360',NULL),(836,1,'2018-03-08 16:59:52','初始化任务成功:2',NULL),(837,2,'2018-03-08 16:59:52','更新任务执行时间成功',NULL),(838,2,'2018-03-08 16:59:52','初始化任务成功:天机360',NULL),(839,1,'2018-03-08 17:00:12','初始化任务成功:2',NULL),(840,2,'2018-03-08 17:00:12','启动任务成功',NULL),(841,2,'2018-03-08 17:00:12','初始化任务成功:天机360',NULL),(842,1,'2018-03-08 17:00:15','初始化任务成功:2',NULL),(843,2,'2018-03-08 17:00:15','更新任务执行时间成功',NULL),(844,2,'2018-03-08 17:00:15','初始化任务成功:天机360',NULL),(845,1,'2018-03-08 17:03:03','初始化任务成功:2',NULL),(846,2,'2018-03-08 17:03:03','启动任务成功',NULL),(847,2,'2018-03-08 17:03:03','初始化任务成功:天机360',NULL),(848,1,'2018-03-08 17:03:05','初始化任务成功:2',NULL),(849,2,'2018-03-08 17:03:05','更新任务执行时间成功',NULL),(850,2,'2018-03-08 17:03:05','初始化任务成功:天机360',NULL),(851,1,'2018-03-08 17:03:25','初始化任务成功:2',NULL),(852,2,'2018-03-08 17:03:25','启动任务成功',NULL),(853,2,'2018-03-08 17:03:25','初始化任务成功:天机360',NULL),(854,1,'2018-03-08 17:03:28','初始化任务成功:2',NULL),(855,2,'2018-03-08 17:03:28','更新任务执行时间成功',NULL),(856,2,'2018-03-08 17:03:28','初始化任务成功:天机360',NULL),(857,1,'2018-03-08 17:07:47','初始化任务成功:2',NULL),(858,2,'2018-03-08 17:07:47','启动任务成功',NULL),(859,2,'2018-03-08 17:07:47','初始化任务成功:天机360',NULL),(860,1,'2018-03-08 17:07:50','初始化任务成功:2',NULL),(861,2,'2018-03-08 17:07:50','更新任务执行时间成功',NULL),(862,2,'2018-03-08 17:07:50','初始化任务成功:天机360',NULL),(863,1,'2018-03-08 17:08:11','初始化任务成功:2',NULL),(864,2,'2018-03-08 17:08:11','启动任务成功',NULL),(865,2,'2018-03-08 17:08:11','初始化任务成功:天机360',NULL),(866,1,'2018-03-08 17:08:14','初始化任务成功:2',NULL),(867,2,'2018-03-08 17:08:14','更新任务执行时间成功',NULL),(868,2,'2018-03-08 17:08:14','初始化任务成功:天机360',NULL),(869,1,'2018-03-08 17:14:00','初始化任务成功:2',NULL),(870,2,'2018-03-08 17:14:00','启动任务成功',NULL),(871,2,'2018-03-08 17:14:00','初始化任务成功:天机360',NULL),(872,1,'2018-03-08 17:14:03','初始化任务成功:2',NULL),(873,2,'2018-03-08 17:14:03','更新任务执行时间成功',NULL),(874,2,'2018-03-08 17:14:03','初始化任务成功:天机360',NULL),(875,1,'2018-03-08 17:14:24','初始化任务成功:2',NULL),(876,2,'2018-03-08 17:14:24','启动任务成功',NULL),(877,2,'2018-03-08 17:14:24','初始化任务成功:天机360',NULL),(878,1,'2018-03-08 17:14:26','初始化任务成功:2',NULL),(879,2,'2018-03-08 17:14:26','更新任务执行时间成功',NULL),(880,2,'2018-03-08 17:14:26','初始化任务成功:天机360',NULL),(881,1,'2018-03-09 09:15:04','初始化任务成功:2',NULL),(882,2,'2018-03-09 09:15:04','启动任务成功',NULL),(883,2,'2018-03-09 09:15:04','初始化任务成功:天机360',NULL),(884,1,'2018-03-09 09:15:05','初始化任务成功:2',NULL),(885,2,'2018-03-09 09:15:05','更新任务执行时间成功',NULL),(886,2,'2018-03-09 09:15:05','初始化任务成功:天机360',NULL),(887,1,'2018-03-09 09:15:20','初始化任务成功:2',NULL),(888,2,'2018-03-09 09:15:20','启动任务成功',NULL),(889,2,'2018-03-09 09:15:20','初始化任务成功:天机360',NULL),(890,1,'2018-03-09 09:15:21','初始化任务成功:2',NULL),(891,2,'2018-03-09 09:15:21','更新任务执行时间成功',NULL),(892,2,'2018-03-09 09:15:21','初始化任务成功:天机360',NULL),(893,2,'2018-03-09 09:16:21','更新执行时间，原执行时间0 0/1 * * * ?;现执行时间:0 0/5 * * * ?',NULL),(894,2,'2018-03-09 09:16:21','更新执行时间成功，现执行时间：0 0/5 * * * ?',NULL),(895,1,'2018-03-09 09:30:13','初始化任务成功:2',NULL),(896,2,'2018-03-09 09:30:13','启动任务成功',NULL),(897,2,'2018-03-09 09:30:13','初始化任务成功:天机360',NULL),(898,1,'2018-03-09 09:30:15','初始化任务成功:2',NULL),(899,2,'2018-03-09 09:30:15','更新任务执行时间成功',NULL),(900,2,'2018-03-09 09:30:15','初始化任务成功:天机360',NULL),(901,1,'2018-03-09 09:30:29','初始化任务成功:2',NULL),(902,2,'2018-03-09 09:30:29','启动任务成功',NULL),(903,2,'2018-03-09 09:30:30','初始化任务成功:天机360',NULL),(904,1,'2018-03-09 09:30:31','初始化任务成功:2',NULL),(905,2,'2018-03-09 09:30:31','更新任务执行时间成功',NULL),(906,2,'2018-03-09 09:30:31','初始化任务成功:天机360',NULL),(907,1,'2018-03-09 10:08:13','初始化任务成功:2',NULL),(908,2,'2018-03-09 10:08:13','启动任务成功',NULL),(909,2,'2018-03-09 10:08:13','初始化任务成功:天机360',NULL),(910,1,'2018-03-09 10:08:15','初始化任务成功:2',NULL),(911,2,'2018-03-09 10:08:15','更新任务执行时间成功',NULL),(912,2,'2018-03-09 10:08:15','初始化任务成功:天机360',NULL),(913,1,'2018-03-09 10:08:30','初始化任务成功:2',NULL),(914,2,'2018-03-09 10:08:30','启动任务成功',NULL),(915,2,'2018-03-09 10:08:30','初始化任务成功:天机360',NULL),(916,1,'2018-03-09 10:08:32','初始化任务成功:2',NULL),(917,2,'2018-03-09 10:08:32','更新任务执行时间成功',NULL),(918,2,'2018-03-09 10:08:32','初始化任务成功:天机360',NULL),(919,1,'2018-03-09 10:26:11','初始化任务成功:2',NULL),(920,2,'2018-03-09 10:26:11','启动任务成功',NULL),(921,2,'2018-03-09 10:26:11','初始化任务成功:天机360',NULL),(922,1,'2018-03-09 10:26:13','初始化任务成功:2',NULL),(923,2,'2018-03-09 10:26:13','更新任务执行时间成功',NULL),(924,2,'2018-03-09 10:26:13','初始化任务成功:天机360',NULL),(925,1,'2018-03-09 10:26:28','初始化任务成功:2',NULL),(926,2,'2018-03-09 10:26:28','启动任务成功',NULL),(927,2,'2018-03-09 10:26:28','初始化任务成功:天机360',NULL),(928,1,'2018-03-09 10:26:30','初始化任务成功:2',NULL),(929,2,'2018-03-09 10:26:30','更新任务执行时间成功',NULL),(930,2,'2018-03-09 10:26:30','初始化任务成功:天机360',NULL),(931,1,'2018-03-09 13:39:17','初始化任务成功:2',NULL),(932,2,'2018-03-09 13:39:17','启动任务成功',NULL),(933,2,'2018-03-09 13:39:17','初始化任务成功:天机360',NULL),(934,1,'2018-03-09 13:39:20','初始化任务成功:2',NULL),(935,2,'2018-03-09 13:39:20','更新任务执行时间成功',NULL),(936,2,'2018-03-09 13:39:20','初始化任务成功:天机360',NULL),(937,1,'2018-03-09 13:39:38','初始化任务成功:2',NULL),(938,2,'2018-03-09 13:39:38','启动任务成功',NULL),(939,2,'2018-03-09 13:39:38','初始化任务成功:天机360',NULL),(940,1,'2018-03-09 13:39:41','初始化任务成功:2',NULL),(941,2,'2018-03-09 13:39:41','更新任务执行时间成功',NULL),(942,2,'2018-03-09 13:39:41','初始化任务成功:天机360',NULL),(943,1,'2018-03-09 17:18:35','初始化任务成功:2',NULL),(944,2,'2018-03-09 17:18:35','启动任务成功',NULL),(945,2,'2018-03-09 17:18:35','初始化任务成功:天机360',NULL),(946,1,'2018-03-09 17:18:38','初始化任务成功:2',NULL),(947,2,'2018-03-09 17:18:38','更新任务执行时间成功',NULL),(948,2,'2018-03-09 17:18:38','初始化任务成功:天机360',NULL),(949,1,'2018-03-09 17:18:59','初始化任务成功:2',NULL),(950,2,'2018-03-09 17:18:59','启动任务成功',NULL),(951,2,'2018-03-09 17:18:59','初始化任务成功:天机360',NULL),(952,1,'2018-03-09 17:19:02','初始化任务成功:2',NULL),(953,2,'2018-03-09 17:19:02','更新任务执行时间成功',NULL),(954,2,'2018-03-09 17:19:02','初始化任务成功:天机360',NULL),(955,1,'2018-03-09 17:23:33','初始化任务成功:2',NULL),(956,2,'2018-03-09 17:23:33','启动任务成功',NULL),(957,2,'2018-03-09 17:23:33','初始化任务成功:天机360',NULL),(958,1,'2018-03-09 17:23:35','初始化任务成功:2',NULL),(959,2,'2018-03-09 17:23:35','更新任务执行时间成功',NULL),(960,2,'2018-03-09 17:23:35','初始化任务成功:天机360',NULL),(961,1,'2018-03-09 17:23:52','初始化任务成功:2',NULL),(962,2,'2018-03-09 17:23:52','启动任务成功',NULL),(963,2,'2018-03-09 17:23:52','初始化任务成功:天机360',NULL),(964,1,'2018-03-09 17:23:54','初始化任务成功:2',NULL),(965,2,'2018-03-09 17:23:54','更新任务执行时间成功',NULL),(966,2,'2018-03-09 17:23:54','初始化任务成功:天机360',NULL),(967,1,'2018-03-22 16:53:26','初始化任务成功:2',NULL),(968,2,'2018-03-22 16:53:26','启动任务成功',NULL),(969,2,'2018-03-22 16:53:26','初始化任务成功:天机360',NULL),(970,1,'2018-03-22 16:53:28','初始化任务成功:2',NULL),(971,2,'2018-03-22 16:53:29','更新任务执行时间成功',NULL),(972,2,'2018-03-22 16:53:29','初始化任务成功:天机360',NULL),(973,1,'2018-03-22 16:53:47','初始化任务成功:2',NULL),(974,2,'2018-03-22 16:53:47','启动任务成功',NULL),(975,2,'2018-03-22 16:53:47','初始化任务成功:天机360',NULL),(976,1,'2018-03-22 16:53:49','初始化任务成功:2',NULL),(977,2,'2018-03-22 16:53:49','更新任务执行时间成功',NULL),(978,2,'2018-03-22 16:53:49','初始化任务成功:天机360',NULL),(979,1,'2018-03-22 17:01:46','初始化任务成功:2',NULL),(980,2,'2018-03-22 17:01:46','启动任务成功',NULL),(981,2,'2018-03-22 17:01:46','初始化任务成功:天机360',NULL),(982,1,'2018-03-22 17:01:48','初始化任务成功:2',NULL),(983,2,'2018-03-22 17:01:48','更新任务执行时间成功',NULL),(984,2,'2018-03-22 17:01:48','初始化任务成功:天机360',NULL),(985,1,'2018-03-22 17:02:06','初始化任务成功:2',NULL),(986,2,'2018-03-22 17:02:06','启动任务成功',NULL),(987,2,'2018-03-22 17:02:06','初始化任务成功:天机360',NULL),(988,1,'2018-03-22 17:02:09','初始化任务成功:2',NULL),(989,2,'2018-03-22 17:02:09','更新任务执行时间成功',NULL),(990,2,'2018-03-22 17:02:09','初始化任务成功:天机360',NULL),(991,1,'2018-03-22 17:28:12','初始化任务成功:2',NULL),(992,2,'2018-03-22 17:28:12','启动任务成功',NULL),(993,2,'2018-03-22 17:28:12','初始化任务成功:天机360',NULL),(994,1,'2018-03-22 17:28:14','初始化任务成功:2',NULL),(995,2,'2018-03-22 17:28:14','更新任务执行时间成功',NULL),(996,2,'2018-03-22 17:28:14','初始化任务成功:天机360',NULL),(997,1,'2018-03-22 17:28:33','初始化任务成功:2',NULL),(998,2,'2018-03-22 17:28:33','启动任务成功',NULL),(999,2,'2018-03-22 17:28:33','初始化任务成功:天机360',NULL),(1000,1,'2018-03-22 17:28:36','初始化任务成功:2',NULL),(1001,2,'2018-03-22 17:28:36','更新任务执行时间成功',NULL),(1002,2,'2018-03-22 17:28:36','初始化任务成功:天机360',NULL),(1003,1,'2018-03-22 17:37:44','初始化任务成功:2',NULL),(1004,2,'2018-03-22 17:37:44','启动任务成功',NULL),(1005,2,'2018-03-22 17:37:44','初始化任务成功:天机360',NULL),(1006,1,'2018-03-22 17:37:46','初始化任务成功:2',NULL),(1007,2,'2018-03-22 17:37:46','更新任务执行时间成功',NULL),(1008,2,'2018-03-22 17:37:46','初始化任务成功:天机360',NULL),(1009,1,'2018-03-22 17:38:04','初始化任务成功:2',NULL),(1010,2,'2018-03-22 17:38:04','启动任务成功',NULL),(1011,2,'2018-03-22 17:38:04','初始化任务成功:天机360',NULL),(1012,1,'2018-03-22 17:38:07','初始化任务成功:2',NULL),(1013,2,'2018-03-22 17:38:07','更新任务执行时间成功',NULL),(1014,2,'2018-03-22 17:38:07','初始化任务成功:天机360',NULL),(1015,1,'2018-03-22 17:54:24','初始化任务成功:2',NULL),(1016,2,'2018-03-22 17:54:24','启动任务成功',NULL),(1017,2,'2018-03-22 17:54:24','初始化任务成功:天机360',NULL),(1018,1,'2018-03-22 17:54:27','初始化任务成功:2',NULL),(1019,2,'2018-03-22 17:54:27','更新任务执行时间成功',NULL),(1020,2,'2018-03-22 17:54:27','初始化任务成功:天机360',NULL),(1021,1,'2018-03-22 17:54:45','初始化任务成功:2',NULL),(1022,2,'2018-03-22 17:54:45','启动任务成功',NULL),(1023,2,'2018-03-22 17:54:45','初始化任务成功:天机360',NULL),(1024,1,'2018-03-22 17:54:48','初始化任务成功:2',NULL),(1025,2,'2018-03-22 17:54:48','更新任务执行时间成功',NULL),(1026,2,'2018-03-22 17:54:48','初始化任务成功:天机360',NULL),(1027,1,'2018-03-22 18:01:18','初始化任务成功:2',NULL),(1028,2,'2018-03-22 18:01:18','启动任务成功',NULL),(1029,2,'2018-03-22 18:01:18','初始化任务成功:天机360',NULL),(1030,1,'2018-03-22 18:01:21','初始化任务成功:2',NULL),(1031,2,'2018-03-22 18:01:21','更新任务执行时间成功',NULL),(1032,2,'2018-03-22 18:01:21','初始化任务成功:天机360',NULL),(1033,1,'2018-03-22 18:02:35','初始化任务成功:2',NULL),(1034,2,'2018-03-22 18:02:35','启动任务成功',NULL),(1035,2,'2018-03-22 18:02:35','初始化任务成功:天机360',NULL),(1036,1,'2018-03-22 18:02:37','初始化任务成功:2',NULL),(1037,2,'2018-03-22 18:02:37','更新任务执行时间成功',NULL),(1038,2,'2018-03-22 18:02:37','初始化任务成功:天机360',NULL),(1039,1,'2018-03-22 18:02:56','初始化任务成功:2',NULL),(1040,2,'2018-03-22 18:02:56','启动任务成功',NULL),(1041,2,'2018-03-22 18:02:56','初始化任务成功:天机360',NULL),(1042,1,'2018-03-22 18:02:58','初始化任务成功:2',NULL),(1043,2,'2018-03-22 18:02:58','更新任务执行时间成功',NULL),(1044,2,'2018-03-22 18:02:58','初始化任务成功:天机360',NULL),(1045,1,'2018-03-22 18:12:51','初始化任务成功:2',NULL),(1046,2,'2018-03-22 18:12:51','启动任务成功',NULL),(1047,2,'2018-03-22 18:12:51','初始化任务成功:天机360',NULL),(1048,1,'2018-03-22 18:12:53','初始化任务成功:2',NULL),(1049,2,'2018-03-22 18:12:53','更新任务执行时间成功',NULL),(1050,2,'2018-03-22 18:12:53','初始化任务成功:天机360',NULL),(1051,1,'2018-03-22 18:14:11','初始化任务成功:2',NULL),(1052,2,'2018-03-22 18:14:11','启动任务成功',NULL),(1053,2,'2018-03-22 18:14:11','初始化任务成功:天机360',NULL),(1054,1,'2018-03-22 18:14:15','初始化任务成功:2',NULL),(1055,2,'2018-03-22 18:14:15','更新任务执行时间成功',NULL),(1056,2,'2018-03-22 18:14:15','初始化任务成功:天机360',NULL),(1057,1,'2018-03-22 18:14:42','初始化任务成功:2',NULL),(1058,2,'2018-03-22 18:14:42','启动任务成功',NULL),(1059,2,'2018-03-22 18:14:42','初始化任务成功:天机360',NULL),(1060,1,'2018-03-22 18:14:44','初始化任务成功:2',NULL),(1061,2,'2018-03-22 18:14:44','更新任务执行时间成功',NULL),(1062,2,'2018-03-22 18:14:44','初始化任务成功:天机360',NULL),(1063,1,'2018-03-22 18:28:38','初始化任务成功:2',NULL),(1064,2,'2018-03-22 18:28:38','启动任务成功',NULL),(1065,2,'2018-03-22 18:28:38','初始化任务成功:天机360',NULL),(1066,1,'2018-03-22 18:28:40','初始化任务成功:2',NULL),(1067,2,'2018-03-22 18:28:40','更新任务执行时间成功',NULL),(1068,2,'2018-03-22 18:28:40','初始化任务成功:天机360',NULL),(1069,1,'2018-03-22 18:28:58','初始化任务成功:2',NULL),(1070,2,'2018-03-22 18:28:58','启动任务成功',NULL),(1071,2,'2018-03-22 18:28:58','初始化任务成功:天机360',NULL),(1072,1,'2018-03-22 18:29:00','初始化任务成功:2',NULL),(1073,2,'2018-03-22 18:29:00','更新任务执行时间成功',NULL),(1074,2,'2018-03-22 18:29:00','初始化任务成功:天机360',NULL),(1075,1,'2018-03-22 18:41:45','初始化任务成功:2',NULL),(1076,2,'2018-03-22 18:41:45','启动任务成功',NULL),(1077,2,'2018-03-22 18:41:45','初始化任务成功:天机360',NULL),(1078,1,'2018-03-22 18:41:48','初始化任务成功:2',NULL),(1079,2,'2018-03-22 18:41:48','更新任务执行时间成功',NULL),(1080,2,'2018-03-22 18:41:48','初始化任务成功:天机360',NULL),(1081,1,'2018-03-22 18:42:06','初始化任务成功:2',NULL),(1082,2,'2018-03-22 18:42:06','启动任务成功',NULL),(1083,2,'2018-03-22 18:42:06','初始化任务成功:天机360',NULL),(1084,1,'2018-03-22 18:42:09','初始化任务成功:2',NULL),(1085,2,'2018-03-22 18:42:09','更新任务执行时间成功',NULL),(1086,2,'2018-03-22 18:42:09','初始化任务成功:天机360',NULL),(1087,1,'2018-03-22 18:44:38','初始化任务成功:2',NULL),(1088,2,'2018-03-22 18:44:39','启动任务成功',NULL),(1089,2,'2018-03-22 18:44:39','初始化任务成功:天机360',NULL),(1090,1,'2018-03-22 18:44:41','初始化任务成功:2',NULL),(1091,2,'2018-03-22 18:44:41','更新任务执行时间成功',NULL),(1092,2,'2018-03-22 18:44:41','初始化任务成功:天机360',NULL),(1093,1,'2018-03-23 09:13:18','初始化任务成功:2',NULL),(1094,2,'2018-03-23 09:13:18','启动任务成功',NULL),(1095,2,'2018-03-23 09:13:18','初始化任务成功:天机360',NULL),(1096,1,'2018-03-23 09:13:21','初始化任务成功:2',NULL),(1097,2,'2018-03-23 09:13:21','更新任务执行时间成功',NULL),(1098,2,'2018-03-23 09:13:21','初始化任务成功:天机360',NULL),(1099,1,'2018-03-23 09:13:38','初始化任务成功:2',NULL),(1100,2,'2018-03-23 09:13:38','启动任务成功',NULL),(1101,2,'2018-03-23 09:13:38','初始化任务成功:天机360',NULL),(1102,1,'2018-03-23 09:13:40','初始化任务成功:2',NULL),(1103,2,'2018-03-23 09:13:40','更新任务执行时间成功',NULL),(1104,2,'2018-03-23 09:13:40','初始化任务成功:天机360',NULL),(1105,1,'2018-03-23 09:15:38','初始化任务成功:2',NULL),(1106,2,'2018-03-23 09:15:38','启动任务成功',NULL),(1107,2,'2018-03-23 09:15:38','初始化任务成功:天机360',NULL),(1108,1,'2018-03-23 09:15:40','初始化任务成功:2',NULL),(1109,2,'2018-03-23 09:15:40','更新任务执行时间成功',NULL),(1110,2,'2018-03-23 09:15:40','初始化任务成功:天机360',NULL),(1111,1,'2018-03-23 09:15:57','初始化任务成功:2',NULL),(1112,2,'2018-03-23 09:15:57','启动任务成功',NULL),(1113,2,'2018-03-23 09:15:57','初始化任务成功:天机360',NULL),(1114,1,'2018-03-23 09:15:59','初始化任务成功:2',NULL),(1115,2,'2018-03-23 09:15:59','更新任务执行时间成功',NULL),(1116,2,'2018-03-23 09:15:59','初始化任务成功:天机360',NULL),(1117,1,'2018-03-23 09:24:18','初始化任务成功:2',NULL),(1118,2,'2018-03-23 09:24:18','启动任务成功',NULL),(1119,2,'2018-03-23 09:24:18','初始化任务成功:天机360',NULL),(1120,1,'2018-03-23 09:24:20','初始化任务成功:2',NULL),(1121,2,'2018-03-23 09:24:20','更新任务执行时间成功',NULL),(1122,2,'2018-03-23 09:24:20','初始化任务成功:天机360',NULL),(1123,1,'2018-03-23 09:24:37','初始化任务成功:2',NULL),(1124,2,'2018-03-23 09:24:37','启动任务成功',NULL),(1125,2,'2018-03-23 09:24:37','初始化任务成功:天机360',NULL),(1126,1,'2018-03-23 09:24:40','初始化任务成功:2',NULL),(1127,2,'2018-03-23 09:24:40','更新任务执行时间成功',NULL),(1128,2,'2018-03-23 09:24:40','初始化任务成功:天机360',NULL),(1129,1,'2018-03-23 09:44:59','初始化任务成功:2',NULL),(1130,2,'2018-03-23 09:44:59','启动任务成功',NULL),(1131,2,'2018-03-23 09:44:59','初始化任务成功:天机360',NULL),(1132,1,'2018-03-23 09:45:02','初始化任务成功:2',NULL),(1133,2,'2018-03-23 09:45:02','更新任务执行时间成功',NULL),(1134,2,'2018-03-23 09:45:02','初始化任务成功:天机360',NULL),(1135,1,'2018-03-23 09:45:19','初始化任务成功:2',NULL),(1136,2,'2018-03-23 09:45:19','启动任务成功',NULL),(1137,2,'2018-03-23 09:45:19','初始化任务成功:天机360',NULL),(1138,1,'2018-03-23 09:45:22','初始化任务成功:2',NULL),(1139,2,'2018-03-23 09:45:22','更新任务执行时间成功',NULL),(1140,2,'2018-03-23 09:45:22','初始化任务成功:天机360',NULL),(1141,1,'2018-03-23 10:03:42','初始化任务成功:2',NULL),(1142,2,'2018-03-23 10:03:42','启动任务成功',NULL),(1143,2,'2018-03-23 10:03:42','初始化任务成功:天机360',NULL),(1144,1,'2018-03-23 10:03:44','初始化任务成功:2',NULL),(1145,2,'2018-03-23 10:03:44','更新任务执行时间成功',NULL),(1146,2,'2018-03-23 10:03:44','初始化任务成功:天机360',NULL),(1147,1,'2018-03-23 10:04:01','初始化任务成功:2',NULL),(1148,2,'2018-03-23 10:04:01','启动任务成功',NULL),(1149,2,'2018-03-23 10:04:01','初始化任务成功:天机360',NULL),(1150,1,'2018-03-23 10:04:03','初始化任务成功:2',NULL),(1151,2,'2018-03-23 10:04:03','更新任务执行时间成功',NULL),(1152,2,'2018-03-23 10:04:03','初始化任务成功:天机360',NULL),(1153,1,'2018-03-23 10:53:31','初始化任务成功:2',NULL),(1154,2,'2018-03-23 10:53:31','启动任务成功',NULL),(1155,2,'2018-03-23 10:53:31','初始化任务成功:天机360',NULL),(1156,1,'2018-03-23 10:53:33','初始化任务成功:2',NULL),(1157,2,'2018-03-23 10:53:33','更新任务执行时间成功',NULL),(1158,2,'2018-03-23 10:53:33','初始化任务成功:天机360',NULL),(1159,1,'2018-03-23 10:53:50','初始化任务成功:2',NULL),(1160,2,'2018-03-23 10:53:50','启动任务成功',NULL),(1161,2,'2018-03-23 10:53:50','初始化任务成功:天机360',NULL),(1162,1,'2018-03-23 10:53:53','初始化任务成功:2',NULL),(1163,2,'2018-03-23 10:53:53','更新任务执行时间成功',NULL),(1164,2,'2018-03-23 10:53:53','初始化任务成功:天机360',NULL),(1165,1,'2018-03-23 10:59:55','初始化任务成功:2',NULL),(1166,2,'2018-03-23 10:59:55','启动任务成功',NULL),(1167,2,'2018-03-23 10:59:55','初始化任务成功:天机360',NULL),(1168,1,'2018-03-23 10:59:57','初始化任务成功:2',NULL),(1169,2,'2018-03-23 10:59:57','更新任务执行时间成功',NULL),(1170,2,'2018-03-23 10:59:57','初始化任务成功:天机360',NULL),(1171,1,'2018-03-23 11:00:24','初始化任务成功:2',NULL),(1172,2,'2018-03-23 11:00:24','启动任务成功',NULL),(1173,2,'2018-03-23 11:00:24','初始化任务成功:天机360',NULL),(1174,1,'2018-03-23 11:00:26','初始化任务成功:2',NULL),(1175,2,'2018-03-23 11:00:26','更新任务执行时间成功',NULL),(1176,2,'2018-03-23 11:00:26','初始化任务成功:天机360',NULL),(1177,1,'2018-04-23 17:52:57','初始化任务成功:2',NULL),(1178,2,'2018-04-23 17:52:57','启动任务成功',NULL),(1179,2,'2018-04-23 17:52:57','初始化任务成功:天机360',NULL),(1180,1,'2018-04-23 17:53:02','初始化任务成功:2',NULL),(1181,2,'2018-04-23 17:53:02','更新任务执行时间成功',NULL),(1182,2,'2018-04-23 17:53:02','初始化任务成功:天机360',NULL),(1183,1,'2018-04-23 18:23:18','初始化任务成功:2',NULL),(1184,2,'2018-04-23 18:23:18','启动任务成功',NULL),(1185,2,'2018-04-23 18:23:18','初始化任务成功:天机360',NULL),(1186,1,'2018-04-23 18:23:20','初始化任务成功:2',NULL),(1187,2,'2018-04-23 18:23:20','更新任务执行时间成功',NULL),(1188,2,'2018-04-23 18:23:20','初始化任务成功:天机360',NULL),(1189,1,'2018-04-24 09:04:14','初始化任务成功:2',NULL),(1190,2,'2018-04-24 09:04:14','启动任务成功',NULL),(1191,2,'2018-04-24 09:04:14','初始化任务成功:天机360',NULL),(1192,1,'2018-04-24 09:04:16','初始化任务成功:2',NULL),(1193,2,'2018-04-24 09:04:16','更新任务执行时间成功',NULL),(1194,2,'2018-04-24 09:04:16','初始化任务成功:天机360',NULL),(1195,1,'2018-04-24 09:12:51','初始化任务成功:2',NULL),(1196,2,'2018-04-24 09:12:51','启动任务成功',NULL),(1197,2,'2018-04-24 09:12:51','初始化任务成功:天机360',NULL),(1198,1,'2018-04-24 09:12:53','初始化任务成功:2',NULL),(1199,2,'2018-04-24 09:12:53','更新任务执行时间成功',NULL),(1200,2,'2018-04-24 09:12:53','初始化任务成功:天机360',NULL),(1201,1,'2018-04-24 09:13:09','初始化任务成功:2',NULL),(1202,2,'2018-04-24 09:13:09','启动任务成功',NULL),(1203,2,'2018-04-24 09:13:09','初始化任务成功:天机360',NULL),(1204,1,'2018-04-24 09:13:11','初始化任务成功:2',NULL),(1205,2,'2018-04-24 09:13:11','更新任务执行时间成功',NULL),(1206,2,'2018-04-24 09:13:11','初始化任务成功:天机360',NULL),(1207,1,'2018-04-24 10:44:18','初始化任务成功:2',NULL),(1208,2,'2018-04-24 10:44:18','启动任务成功',NULL),(1209,2,'2018-04-24 10:44:18','初始化任务成功:天机360',NULL),(1210,1,'2018-04-24 10:44:21','初始化任务成功:2',NULL),(1211,2,'2018-04-24 10:44:21','更新任务执行时间成功',NULL),(1212,2,'2018-04-24 10:44:21','初始化任务成功:天机360',NULL),(1213,1,'2018-04-24 10:44:36','初始化任务成功:2',NULL),(1214,2,'2018-04-24 10:44:36','启动任务成功',NULL),(1215,2,'2018-04-24 10:44:36','初始化任务成功:天机360',NULL),(1216,1,'2018-04-24 10:44:38','初始化任务成功:2',NULL),(1217,2,'2018-04-24 10:44:38','更新任务执行时间成功',NULL),(1218,2,'2018-04-24 10:44:38','初始化任务成功:天机360',NULL),(1219,1,'2018-04-24 11:37:47','初始化任务成功:2',NULL),(1220,2,'2018-04-24 11:37:47','启动任务成功',NULL),(1221,2,'2018-04-24 11:37:47','初始化任务成功:天机360',NULL),(1222,1,'2018-04-24 11:37:49','初始化任务成功:2',NULL),(1223,2,'2018-04-24 11:37:50','更新任务执行时间成功',NULL),(1224,2,'2018-04-24 11:37:50','初始化任务成功:天机360',NULL),(1225,1,'2018-04-24 11:38:06','初始化任务成功:2',NULL),(1226,2,'2018-04-24 11:38:06','启动任务成功',NULL),(1227,2,'2018-04-24 11:38:06','初始化任务成功:天机360',NULL),(1228,1,'2018-04-24 11:38:08','初始化任务成功:2',NULL),(1229,2,'2018-04-24 11:38:08','更新任务执行时间成功',NULL),(1230,2,'2018-04-24 11:38:08','初始化任务成功:天机360',NULL),(1231,1,'2018-04-24 11:44:25','初始化任务成功:2',NULL),(1232,2,'2018-04-24 11:44:25','启动任务成功',NULL),(1233,2,'2018-04-24 11:44:25','初始化任务成功:天机360',NULL),(1234,1,'2018-04-24 11:44:27','初始化任务成功:2',NULL),(1235,2,'2018-04-24 11:44:27','更新任务执行时间成功',NULL),(1236,2,'2018-04-24 11:44:27','初始化任务成功:天机360',NULL),(1237,1,'2018-04-24 11:44:43','初始化任务成功:2',NULL),(1238,2,'2018-04-24 11:44:43','启动任务成功',NULL),(1239,2,'2018-04-24 11:44:43','初始化任务成功:天机360',NULL),(1240,1,'2018-04-24 11:44:44','初始化任务成功:2',NULL),(1241,2,'2018-04-24 11:44:44','更新任务执行时间成功',NULL),(1242,2,'2018-04-24 11:44:44','初始化任务成功:天机360',NULL),(1243,1,'2018-04-24 11:53:22','初始化任务成功:2',NULL),(1244,2,'2018-04-24 11:53:22','启动任务成功',NULL),(1245,2,'2018-04-24 11:53:22','初始化任务成功:天机360',NULL),(1246,1,'2018-04-24 11:53:24','初始化任务成功:2',NULL),(1247,2,'2018-04-24 11:53:24','更新任务执行时间成功',NULL),(1248,2,'2018-04-24 11:53:24','初始化任务成功:天机360',NULL),(1249,1,'2018-04-24 11:53:40','初始化任务成功:2',NULL),(1250,2,'2018-04-24 11:53:40','启动任务成功',NULL),(1251,2,'2018-04-24 11:53:40','初始化任务成功:天机360',NULL),(1252,1,'2018-04-24 11:53:42','初始化任务成功:2',NULL),(1253,2,'2018-04-24 11:53:42','更新任务执行时间成功',NULL),(1254,2,'2018-04-24 11:53:42','初始化任务成功:天机360',NULL),(1255,1,'2018-04-24 12:43:44','初始化任务成功:2',NULL),(1256,2,'2018-04-24 12:43:44','启动任务成功',NULL),(1257,2,'2018-04-24 12:43:44','初始化任务成功:天机360',NULL),(1258,1,'2018-04-24 12:43:46','初始化任务成功:2',NULL),(1259,2,'2018-04-24 12:43:46','更新任务执行时间成功',NULL),(1260,2,'2018-04-24 12:43:46','初始化任务成功:天机360',NULL),(1261,1,'2018-04-24 12:44:04','初始化任务成功:2',NULL),(1262,2,'2018-04-24 12:44:04','启动任务成功',NULL),(1263,2,'2018-04-24 12:44:04','初始化任务成功:天机360',NULL),(1264,1,'2018-04-24 12:44:06','初始化任务成功:2',NULL),(1265,2,'2018-04-24 12:44:06','更新任务执行时间成功',NULL),(1266,2,'2018-04-24 12:44:06','初始化任务成功:天机360',NULL),(1267,1,'2018-04-24 13:28:08','初始化任务成功:2',NULL),(1268,2,'2018-04-24 13:28:09','启动任务成功',NULL),(1269,2,'2018-04-24 13:28:09','初始化任务成功:天机360',NULL),(1270,1,'2018-04-24 13:28:10','初始化任务成功:2',NULL),(1271,2,'2018-04-24 13:28:10','更新任务执行时间成功',NULL),(1272,2,'2018-04-24 13:28:10','初始化任务成功:天机360',NULL),(1273,1,'2018-04-24 13:28:26','初始化任务成功:2',NULL),(1274,2,'2018-04-24 13:28:26','启动任务成功',NULL),(1275,2,'2018-04-24 13:28:26','初始化任务成功:天机360',NULL),(1276,1,'2018-04-24 13:28:28','初始化任务成功:2',NULL),(1277,2,'2018-04-24 13:28:28','更新任务执行时间成功',NULL),(1278,2,'2018-04-24 13:28:28','初始化任务成功:天机360',NULL),(1279,1,'2018-04-24 15:06:48','初始化任务成功:2',NULL),(1280,2,'2018-04-24 15:06:48','启动任务成功',NULL),(1281,2,'2018-04-24 15:06:48','初始化任务成功:天机360',NULL),(1282,1,'2018-04-24 15:06:50','初始化任务成功:2',NULL),(1283,2,'2018-04-24 15:06:50','更新任务执行时间成功',NULL),(1284,2,'2018-04-24 15:06:50','初始化任务成功:天机360',NULL),(1285,1,'2018-04-24 15:07:06','初始化任务成功:2',NULL),(1286,2,'2018-04-24 15:07:07','启动任务成功',NULL),(1287,2,'2018-04-24 15:07:07','初始化任务成功:天机360',NULL),(1288,1,'2018-04-24 15:07:08','初始化任务成功:2',NULL),(1289,2,'2018-04-24 15:07:08','更新任务执行时间成功',NULL),(1290,2,'2018-04-24 15:07:08','初始化任务成功:天机360',NULL),(1291,1,'2018-04-24 15:36:15','初始化任务成功:2',NULL),(1292,2,'2018-04-24 15:36:15','启动任务成功',NULL),(1293,2,'2018-04-24 15:36:15','初始化任务成功:天机360',NULL),(1294,1,'2018-04-24 15:36:17','初始化任务成功:2',NULL),(1295,2,'2018-04-24 15:36:17','更新任务执行时间成功',NULL),(1296,2,'2018-04-24 15:36:17','初始化任务成功:天机360',NULL),(1297,1,'2018-04-24 15:36:33','初始化任务成功:2',NULL),(1298,2,'2018-04-24 15:36:33','启动任务成功',NULL),(1299,2,'2018-04-24 15:36:33','初始化任务成功:天机360',NULL),(1300,1,'2018-04-24 15:36:34','初始化任务成功:2',NULL),(1301,2,'2018-04-24 15:36:34','更新任务执行时间成功',NULL),(1302,2,'2018-04-24 15:36:34','初始化任务成功:天机360',NULL),(1303,1,'2018-04-24 16:00:44','初始化任务成功:2',NULL),(1304,2,'2018-04-24 16:00:44','启动任务成功',NULL),(1305,2,'2018-04-24 16:00:44','初始化任务成功:天机360',NULL),(1306,1,'2018-04-24 16:00:46','初始化任务成功:2',NULL),(1307,2,'2018-04-24 16:00:46','更新任务执行时间成功',NULL),(1308,2,'2018-04-24 16:00:46','初始化任务成功:天机360',NULL),(1309,1,'2018-04-24 16:01:02','初始化任务成功:2',NULL),(1310,2,'2018-04-24 16:01:02','启动任务成功',NULL),(1311,2,'2018-04-24 16:01:02','初始化任务成功:天机360',NULL),(1312,1,'2018-04-24 16:01:04','初始化任务成功:2',NULL),(1313,2,'2018-04-24 16:01:04','更新任务执行时间成功',NULL),(1314,2,'2018-04-24 16:01:04','初始化任务成功:天机360',NULL),(1315,1,'2018-04-24 16:23:54','初始化任务成功:2',NULL),(1316,2,'2018-04-24 16:23:54','启动任务成功',NULL),(1317,2,'2018-04-24 16:23:54','初始化任务成功:天机360',NULL),(1318,1,'2018-04-24 16:23:56','初始化任务成功:2',NULL),(1319,2,'2018-04-24 16:23:56','更新任务执行时间成功',NULL),(1320,2,'2018-04-24 16:23:56','初始化任务成功:天机360',NULL),(1321,1,'2018-04-24 16:24:12','初始化任务成功:2',NULL),(1322,2,'2018-04-24 16:24:12','启动任务成功',NULL),(1323,2,'2018-04-24 16:24:12','初始化任务成功:天机360',NULL),(1324,1,'2018-04-24 16:24:14','初始化任务成功:2',NULL),(1325,2,'2018-04-24 16:24:14','更新任务执行时间成功',NULL),(1326,2,'2018-04-24 16:24:14','初始化任务成功:天机360',NULL),(1327,1,'2018-04-24 16:50:10','初始化任务成功:2',NULL),(1328,2,'2018-04-24 16:50:10','启动任务成功',NULL),(1329,2,'2018-04-24 16:50:10','初始化任务成功:天机360',NULL),(1330,1,'2018-04-24 16:50:12','初始化任务成功:2',NULL),(1331,2,'2018-04-24 16:50:12','更新任务执行时间成功',NULL),(1332,2,'2018-04-24 16:50:12','初始化任务成功:天机360',NULL),(1333,1,'2018-04-24 16:50:27','初始化任务成功:2',NULL),(1334,2,'2018-04-24 16:50:27','启动任务成功',NULL),(1335,2,'2018-04-24 16:50:27','初始化任务成功:天机360',NULL),(1336,1,'2018-04-24 16:50:29','初始化任务成功:2',NULL),(1337,2,'2018-04-24 16:50:29','更新任务执行时间成功',NULL),(1338,2,'2018-04-24 16:50:29','初始化任务成功:天机360',NULL),(1339,1,'2018-04-24 16:57:41','初始化任务成功:2',NULL),(1340,2,'2018-04-24 16:57:41','启动任务成功',NULL),(1341,2,'2018-04-24 16:57:41','初始化任务成功:天机360',NULL),(1342,1,'2018-04-24 16:57:43','初始化任务成功:2',NULL),(1343,2,'2018-04-24 16:57:43','更新任务执行时间成功',NULL),(1344,2,'2018-04-24 16:57:43','初始化任务成功:天机360',NULL),(1345,1,'2018-04-24 16:57:59','初始化任务成功:2',NULL),(1346,2,'2018-04-24 16:57:59','启动任务成功',NULL),(1347,2,'2018-04-24 16:57:59','初始化任务成功:天机360',NULL),(1348,1,'2018-04-24 16:58:01','初始化任务成功:2',NULL),(1349,2,'2018-04-24 16:58:01','更新任务执行时间成功',NULL),(1350,2,'2018-04-24 16:58:01','初始化任务成功:天机360',NULL),(1351,1,'2018-04-24 17:24:33','初始化任务成功:2',NULL),(1352,2,'2018-04-24 17:24:33','启动任务成功',NULL),(1353,2,'2018-04-24 17:24:33','初始化任务成功:天机360',NULL),(1354,1,'2018-04-24 17:24:35','初始化任务成功:2',NULL),(1355,2,'2018-04-24 17:24:35','更新任务执行时间成功',NULL),(1356,2,'2018-04-24 17:24:35','初始化任务成功:天机360',NULL),(1357,1,'2018-04-24 17:24:52','初始化任务成功:2',NULL),(1358,2,'2018-04-24 17:24:52','启动任务成功',NULL),(1359,2,'2018-04-24 17:24:52','初始化任务成功:天机360',NULL),(1360,1,'2018-04-24 17:24:54','初始化任务成功:2',NULL),(1361,2,'2018-04-24 17:24:54','更新任务执行时间成功',NULL),(1362,2,'2018-04-24 17:24:54','初始化任务成功:天机360',NULL),(1363,1,'2018-04-24 17:47:41','初始化任务成功:2',NULL),(1364,2,'2018-04-24 17:47:41','启动任务成功',NULL),(1365,2,'2018-04-24 17:47:41','初始化任务成功:天机360',NULL),(1366,1,'2018-04-24 17:47:43','初始化任务成功:2',NULL),(1367,2,'2018-04-24 17:47:43','更新任务执行时间成功',NULL),(1368,2,'2018-04-24 17:47:43','初始化任务成功:天机360',NULL),(1369,1,'2018-04-24 17:47:58','初始化任务成功:2',NULL),(1370,2,'2018-04-24 17:47:58','启动任务成功',NULL),(1371,2,'2018-04-24 17:47:58','初始化任务成功:天机360',NULL),(1372,1,'2018-04-24 17:48:00','初始化任务成功:2',NULL),(1373,2,'2018-04-24 17:48:00','更新任务执行时间成功',NULL),(1374,2,'2018-04-24 17:48:00','初始化任务成功:天机360',NULL),(1375,1,'2018-04-24 17:53:01','初始化任务成功:2',NULL),(1376,2,'2018-04-24 17:53:01','启动任务成功',NULL),(1377,2,'2018-04-24 17:53:01','初始化任务成功:天机360',NULL),(1378,1,'2018-04-24 17:53:03','初始化任务成功:2',NULL),(1379,2,'2018-04-24 17:53:03','更新任务执行时间成功',NULL),(1380,2,'2018-04-24 17:53:03','初始化任务成功:天机360',NULL),(1381,1,'2018-04-24 17:53:20','初始化任务成功:2',NULL),(1382,2,'2018-04-24 17:53:20','启动任务成功',NULL),(1383,2,'2018-04-24 17:53:20','初始化任务成功:天机360',NULL),(1384,1,'2018-04-24 17:53:22','初始化任务成功:2',NULL),(1385,2,'2018-04-24 17:53:22','更新任务执行时间成功',NULL),(1386,2,'2018-04-24 17:53:22','初始化任务成功:天机360',NULL),(1387,1,'2018-04-24 18:03:52','初始化任务成功:2',NULL),(1388,2,'2018-04-24 18:03:52','启动任务成功',NULL),(1389,2,'2018-04-24 18:03:52','初始化任务成功:天机360',NULL),(1390,1,'2018-04-24 18:03:54','初始化任务成功:2',NULL),(1391,2,'2018-04-24 18:03:54','更新任务执行时间成功',NULL),(1392,2,'2018-04-24 18:03:54','初始化任务成功:天机360',NULL),(1393,1,'2018-04-24 18:04:10','初始化任务成功:2',NULL),(1394,2,'2018-04-24 18:04:10','启动任务成功',NULL),(1395,2,'2018-04-24 18:04:10','初始化任务成功:天机360',NULL),(1396,1,'2018-04-24 18:04:11','初始化任务成功:2',NULL),(1397,2,'2018-04-24 18:04:11','更新任务执行时间成功',NULL),(1398,2,'2018-04-24 18:04:11','初始化任务成功:天机360',NULL),(1399,1,'2018-04-24 18:07:09','初始化任务成功:2',NULL),(1400,2,'2018-04-24 18:07:09','启动任务成功',NULL),(1401,2,'2018-04-24 18:07:09','初始化任务成功:天机360',NULL),(1402,1,'2018-04-24 18:07:11','初始化任务成功:2',NULL),(1403,2,'2018-04-24 18:07:11','更新任务执行时间成功',NULL),(1404,2,'2018-04-24 18:07:11','初始化任务成功:天机360',NULL),(1405,1,'2018-04-24 18:07:26','初始化任务成功:2',NULL),(1406,2,'2018-04-24 18:07:26','启动任务成功',NULL),(1407,2,'2018-04-24 18:07:26','初始化任务成功:天机360',NULL),(1408,1,'2018-04-24 18:07:28','初始化任务成功:2',NULL),(1409,2,'2018-04-24 18:07:28','更新任务执行时间成功',NULL),(1410,2,'2018-04-24 18:07:28','初始化任务成功:天机360',NULL),(1411,1,'2018-04-25 11:27:48','初始化任务成功:2',NULL),(1412,2,'2018-04-25 11:27:49','启动任务成功',NULL),(1413,2,'2018-04-25 11:27:49','初始化任务成功:天机360',NULL),(1414,1,'2018-04-25 11:27:50','初始化任务成功:2',NULL),(1415,2,'2018-04-25 11:27:50','更新任务执行时间成功',NULL),(1416,2,'2018-04-25 11:27:50','初始化任务成功:天机360',NULL),(1417,1,'2018-04-25 11:43:18','初始化任务成功:2',NULL),(1418,2,'2018-04-25 11:43:18','启动任务成功',NULL),(1419,2,'2018-04-25 11:43:18','初始化任务成功:天机360',NULL),(1420,1,'2018-04-25 11:43:20','初始化任务成功:2',NULL),(1421,2,'2018-04-25 11:43:20','更新任务执行时间成功',NULL),(1422,2,'2018-04-25 11:43:20','初始化任务成功:天机360',NULL),(1423,1,'2018-04-25 11:53:50','初始化任务成功:2',NULL),(1424,2,'2018-04-25 11:53:50','启动任务成功',NULL),(1425,2,'2018-04-25 11:53:50','初始化任务成功:天机360',NULL),(1426,1,'2018-04-25 11:53:52','初始化任务成功:2',NULL),(1427,2,'2018-04-25 11:53:52','更新任务执行时间成功',NULL),(1428,2,'2018-04-25 11:53:52','初始化任务成功:天机360',NULL),(1429,1,'2018-04-25 11:56:45','初始化任务成功:2',NULL),(1430,2,'2018-04-25 11:56:45','启动任务成功',NULL),(1431,2,'2018-04-25 11:56:45','初始化任务成功:天机360',NULL),(1432,1,'2018-04-25 11:56:47','初始化任务成功:2',NULL),(1433,2,'2018-04-25 11:56:47','更新任务执行时间成功',NULL),(1434,2,'2018-04-25 11:56:47','初始化任务成功:天机360',NULL),(1435,1,'2018-04-25 13:31:27','初始化任务成功:2',NULL),(1436,2,'2018-04-25 13:31:27','启动任务成功',NULL),(1437,2,'2018-04-25 13:31:27','初始化任务成功:天机360',NULL),(1438,1,'2018-04-25 13:31:28','初始化任务成功:2',NULL),(1439,2,'2018-04-25 13:31:28','更新任务执行时间成功',NULL),(1440,2,'2018-04-25 13:31:28','初始化任务成功:天机360',NULL),(1441,1,'2018-04-25 13:34:13','初始化任务成功:2',NULL),(1442,2,'2018-04-25 13:34:13','启动任务成功',NULL),(1443,2,'2018-04-25 13:34:13','初始化任务成功:天机360',NULL),(1444,1,'2018-04-25 13:34:15','初始化任务成功:2',NULL),(1445,2,'2018-04-25 13:34:15','更新任务执行时间成功',NULL),(1446,2,'2018-04-25 13:34:15','初始化任务成功:天机360',NULL),(1447,1,'2018-04-25 13:51:59','初始化任务成功:2',NULL),(1448,2,'2018-04-25 13:51:59','启动任务成功',NULL),(1449,2,'2018-04-25 13:51:59','初始化任务成功:天机360',NULL),(1450,1,'2018-04-25 13:52:01','初始化任务成功:2',NULL),(1451,2,'2018-04-25 13:52:01','更新任务执行时间成功',NULL),(1452,2,'2018-04-25 13:52:01','初始化任务成功:天机360',NULL),(1453,1,'2018-04-25 13:55:11','初始化任务成功:2',NULL),(1454,2,'2018-04-25 13:55:11','启动任务成功',NULL),(1455,2,'2018-04-25 13:55:11','初始化任务成功:天机360',NULL),(1456,1,'2018-04-25 13:55:13','初始化任务成功:2',NULL),(1457,2,'2018-04-25 13:55:13','更新任务执行时间成功',NULL),(1458,2,'2018-04-25 13:55:13','初始化任务成功:天机360',NULL),(1459,1,'2018-04-25 13:57:05','初始化任务成功:2',NULL),(1460,2,'2018-04-25 13:57:05','启动任务成功',NULL),(1461,2,'2018-04-25 13:57:05','初始化任务成功:天机360',NULL),(1462,1,'2018-04-25 13:57:07','初始化任务成功:2',NULL),(1463,2,'2018-04-25 13:57:07','更新任务执行时间成功',NULL),(1464,2,'2018-04-25 13:57:07','初始化任务成功:天机360',NULL),(1465,1,'2018-04-25 14:06:18','初始化任务成功:2',NULL),(1466,2,'2018-04-25 14:06:18','启动任务成功',NULL),(1467,2,'2018-04-25 14:06:18','初始化任务成功:天机360',NULL),(1468,1,'2018-04-25 14:06:20','初始化任务成功:2',NULL),(1469,2,'2018-04-25 14:06:20','更新任务执行时间成功',NULL),(1470,2,'2018-04-25 14:06:20','初始化任务成功:天机360',NULL),(1471,1,'2018-04-25 14:08:14','初始化任务成功:2',NULL),(1472,2,'2018-04-25 14:08:14','启动任务成功',NULL),(1473,2,'2018-04-25 14:08:14','初始化任务成功:天机360',NULL),(1474,1,'2018-04-25 14:08:16','初始化任务成功:2',NULL),(1475,2,'2018-04-25 14:08:16','更新任务执行时间成功',NULL),(1476,2,'2018-04-25 14:08:16','初始化任务成功:天机360',NULL),(1477,1,'2018-04-25 14:40:38','初始化任务成功:2',NULL),(1478,2,'2018-04-25 14:40:38','启动任务成功',NULL),(1479,2,'2018-04-25 14:40:38','初始化任务成功:天机360',NULL),(1480,1,'2018-04-25 14:40:41','初始化任务成功:2',NULL),(1481,2,'2018-04-25 14:40:41','更新任务执行时间成功',NULL),(1482,2,'2018-04-25 14:40:41','初始化任务成功:天机360',NULL),(1483,1,'2018-04-25 14:48:50','初始化任务成功:2',NULL),(1484,2,'2018-04-25 14:48:50','启动任务成功',NULL),(1485,2,'2018-04-25 14:48:50','初始化任务成功:天机360',NULL),(1486,1,'2018-04-25 14:48:52','初始化任务成功:2',NULL),(1487,2,'2018-04-25 14:48:52','更新任务执行时间成功',NULL),(1488,2,'2018-04-25 14:48:52','初始化任务成功:天机360',NULL);
/*!40000 ALTER TABLE `schedule_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `syslog`
--

DROP TABLE IF EXISTS `syslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `syslog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(255) DEFAULT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `opt_content` varchar(2048) DEFAULT NULL,
  `client_ip` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=380 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `syslog`
--

LOCK TABLES `syslog` WRITE;
/*!40000 ALTER TABLE `syslog` DISABLE KEYS */;
INSERT INTO `syslog` VALUES (304,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=222&','0:0:0:0:0:0:0:1','2017-02-20 14:56:03'),(305,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=223&','0:0:0:0:0:0:0:1','2017-02-20 14:56:07'),(306,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=224&','0:0:0:0:0:0:0:1','2017-02-20 14:56:10'),(307,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=221&','0:0:0:0:0:0:0:1','2017-02-20 14:56:15'),(308,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.RoleServiceImpl,[方法]:deleteRoleById,[参数]:id=2&','0:0:0:0:0:0:0:1','2017-02-20 14:56:23'),(309,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.RoleServiceImpl,[方法]:deleteRoleById,[参数]:id=7&','0:0:0:0:0:0:0:1','2017-02-20 14:56:26'),(310,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.RoleServiceImpl,[方法]:deleteRoleById,[参数]:id=8&','0:0:0:0:0:0:0:1','2017-02-20 14:56:28'),(311,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:deleteUserById,[参数]:id=13&','0:0:0:0:0:0:0:1','2017-02-20 14:56:33'),(312,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:deleteUserById,[参数]:id=14&','0:0:0:0:0:0:0:1','2017-02-20 14:56:37'),(313,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:deleteUserById,[参数]:id=15&','0:0:0:0:0:0:0:1','2017-02-20 14:56:46'),(314,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.OrganizationServiceImpl,[方法]:deleteOrganizationById,[参数]:id=3&','0:0:0:0:0:0:0:1','2017-02-20 14:56:53'),(315,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.OrganizationServiceImpl,[方法]:deleteOrganizationById,[参数]:id=6&','0:0:0:0:0:0:0:1','2017-02-20 14:56:56'),(316,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.OrganizationServiceImpl,[方法]:deleteOrganizationById,[参数]:id=5&','0:0:0:0:0:0:0:1','2017-02-20 14:56:59'),(317,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.OrganizationServiceImpl,[方法]:addOrganization,[参数]:icon=icon-company&address=&name=分公司&seq=1&pid=&code=02&','0:0:0:0:0:0:0:1','2017-02-20 15:13:52'),(318,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.OrganizationServiceImpl,[方法]:addOrganization,[参数]:icon=icon-company&address=&name=供应商&seq=2&pid=&code=03&','0:0:0:0:0:0:0:1','2017-02-20 15:14:20'),(319,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.RoleServiceImpl,[方法]:addRole,[参数]:status=0&description=供应商申请人&name=供应商申请人&seq=1&','0:0:0:0:0:0:0:1','2017-02-20 15:16:05'),(320,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.RoleServiceImpl,[方法]:addRole,[参数]:status=0&description=供应商财务&name=供应商财务&seq=2&','0:0:0:0:0:0:0:1','2017-02-20 15:16:25'),(321,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.RoleServiceImpl,[方法]:addRole,[参数]:status=0&description=分公司审核&name=分公司审核&seq=3&','0:0:0:0:0:0:0:1','2017-02-20 15:17:02'),(322,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.RoleServiceImpl,[方法]:addRole,[参数]:status=0&description=总部审核&name=总部审核&seq=4&','0:0:0:0:0:0:0:1','2017-02-20 15:17:23'),(323,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.RoleServiceImpl,[方法]:addRole,[参数]:status=0&description=总部财务&name=总部财务&seq=5&','0:0:0:0:0:0:0:1','2017-02-20 15:17:36'),(324,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.RoleServiceImpl,[方法]:addRole,[参数]:status=0&description=总部产品\r\n&name=总部产品&seq=6&','0:0:0:0:0:0:0:1','2017-02-20 15:17:52'),(325,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:addUser,[参数]:loginname=甲&phone=23123123&sex=0&status=0&age=23&name=甲&usertype=1&organizationId=8&password=123456&roleIds=9&','0:0:0:0:0:0:0:1','2017-02-20 15:22:24'),(326,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:addUser,[参数]:loginname=乙&phone=1231313&sex=0&status=0&age=23&name=乙&usertype=1&organizationId=8&password=123456&roleIds=10&','0:0:0:0:0:0:0:1','2017-02-20 15:22:53'),(327,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:addUser,[参数]:loginname=丙&phone=21312431&sex=1&status=0&age=23&name=丙&usertype=1&organizationId=7&password=123456&roleIds=11&','0:0:0:0:0:0:0:1','2017-02-20 15:23:21'),(328,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:addUser,[参数]:loginname=丁&phone=234242424&sex=1&status=0&age=23&name=丁&usertype=1&organizationId=1&password=123456&roleIds=12&','0:0:0:0:0:0:0:1','2017-02-20 15:23:50'),(329,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:addUser,[参数]:loginname=戊&phone=254325252&sex=0&status=0&age=23&name=戊&usertype=1&organizationId=1&password=123456&roleIds=13&','0:0:0:0:0:0:0:1','2017-02-20 15:24:11'),(330,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:addUser,[参数]:loginname=己&phone=12313&sex=0&status=0&age=23&name=己&usertype=1&organizationId=1&password=123456&roleIds=14&','0:0:0:0:0:0:0:1','2017-02-20 15:24:40'),(331,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=icon-company&status=0&name=车贷业务&seq=0&pid=&resourcetype=0&url=&','0:0:0:0:0:0:0:1','2017-02-20 15:25:06'),(332,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=icon-folder&status=0&name=供应商管理&seq=0&pid=227&resourcetype=0&url=&','0:0:0:0:0:0:0:1','2017-02-20 15:25:49'),(333,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=icon-folder&status=0&name=业务管理&seq=1&pid=227&resourcetype=0&url=&','0:0:0:0:0:0:0:1','2017-02-20 15:28:51'),(334,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=icon-add&status=0&name=添加&seq=0&pid=228&resourcetype=1&url=/supplier/add&','0:0:0:0:0:0:0:1','2017-02-20 17:10:14'),(335,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=icon-edit&status=0&name=编辑&seq=0&pid=228&resourcetype=1&url=/supplier/edit&','0:0:0:0:0:0:0:1','2017-02-20 17:10:55'),(336,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=icon-del&status=0&name=删除&seq=0&pid=228&resourcetype=1&url=/supplier/delete&','0:0:0:0:0:0:0:1','2017-02-20 17:11:31'),(337,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=232&','0:0:0:0:0:0:0:1','2017-02-20 17:19:45'),(340,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:addUser,[参数]:loginname=admin2&phone=2342352346&sex=0&status=0&age=23&name=admin2&usertype=0&organizationId=1&password=123456&roleIds=1&','0:0:0:0:0:0:0:1','2017-02-20 17:31:03'),(341,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=icon-add&status=0&name=添加银行账户&seq=0&pid=228&resourcetype=1&url=/supplier/addBank&','0:0:0:0:0:0:0:1','2017-02-22 18:09:18'),(342,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=icon-edit&status=0&name=编辑&seq=0&pid=228&resourcetype=1&url=/supplier/editBank&','0:0:0:0:0:0:0:1','2017-02-23 09:20:44'),(343,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=233&','0:0:0:0:0:0:0:1','2017-02-23 15:11:17'),(344,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=234&','0:0:0:0:0:0:0:1','2017-02-23 15:11:24'),(345,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=231&','0:0:0:0:0:0:0:1','2017-02-23 15:14:00'),(346,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=icon-edit&status=0&name=添加&seq=0&pid=228&resourcetype=0&url=/cooperate/edit&','0:0:0:0:0:0:0:1','2017-02-23 15:42:29'),(347,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=inco-edit&status=0&name=添加联系人&seq=0&pid=228&resourcetype=1&url=/cooperate/editLinkman&','0:0:0:0:0:0:0:1','2017-02-23 18:08:16'),(348,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=icon-add&status=0&name=添加联系人&seq=0&pid=228&resourcetype=1&url=/cooperate/addLinkman&','0:0:0:0:0:0:0:1','2017-02-23 18:09:06'),(349,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=icon-del&status=0&name=删除联系人&seq=0&pid=228&resourcetype=0&url=/cooperate/deleteLinkman&','0:0:0:0:0:0:0:1','2017-02-23 18:11:13'),(350,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=icon-add&status=0&name=添加联系人&seq=0&pid=228&resourcetype=1&url=/cooperate/addLinkman&','0:0:0:0:0:0:0:1','2017-02-24 09:16:50'),(351,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=240&','0:0:0:0:0:0:0:1','2017-02-24 09:17:12'),(352,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=inco-company&status=0&name=银行账户管理&seq=0&pid=227&resourcetype=0&url=/bank/manager&','0:0:0:0:0:0:0:1','2017-02-24 11:26:17'),(353,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=icon-add&status=0&name=添加银行账户&seq=0&pid=228&resourcetype=1&url=/cooperate/addBank&','0:0:0:0:0:0:0:1','2017-02-24 17:13:10'),(354,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:addResource,[参数]:icon=icon-del&status=0&name=删除银行账户&seq=0&pid=228&resourcetype=1&url=/cooparter/deleteBank&','0:0:0:0:0:0:0:1','2017-02-24 17:22:51'),(355,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=241&','0:0:0:0:0:0:0:1','2017-02-27 09:57:34'),(356,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=244&','0:0:0:0:0:0:0:1','2017-02-27 11:28:33'),(357,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.OrganizationServiceImpl,[方法]:deleteOrganizationById,[参数]:id=8&','0:0:0:0:0:0:0:1','2017-03-03 17:11:18'),(358,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.OrganizationServiceImpl,[方法]:deleteOrganizationById,[参数]:id=12&','0:0:0:0:0:0:0:1','2017-03-06 12:55:55'),(359,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.OrganizationServiceImpl,[方法]:deleteOrganizationById,[参数]:id=13&','0:0:0:0:0:0:0:1','2017-03-06 13:36:06'),(360,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:deleteUserById,[参数]:id=29&','0:0:0:0:0:0:0:1','2017-03-08 15:34:30'),(361,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=235&','0:0:0:0:0:0:0:1','2017-03-09 10:11:31'),(362,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.OrganizationServiceImpl,[方法]:deleteOrganizationById,[参数]:id=11&','0:0:0:0:0:0:0:1','2017-03-09 14:48:57'),(363,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=253&','0:0:0:0:0:0:0:1','2017-03-13 10:58:24'),(364,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=255&','0:0:0:0:0:0:0:1','2017-03-13 11:56:06'),(365,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:deleteUserById,[参数]:id=30&','0:0:0:0:0:0:0:1','2017-03-14 16:17:25'),(366,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:deleteUserById,[参数]:id=31&','0:0:0:0:0:0:0:1','2017-03-14 16:17:29'),(367,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:deleteUserById,[参数]:id=32&','0:0:0:0:0:0:0:1','2017-03-14 16:17:32'),(368,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:deleteUserById,[参数]:id=33&','0:0:0:0:0:0:0:1','2017-03-14 16:17:36'),(369,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=261&','0:0:0:0:0:0:0:1','2017-03-21 16:05:21'),(370,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:deleteUserById,[参数]:id=66&','192.168.1.158','2017-04-07 09:46:14'),(371,'guanli','guanli','[类名]:com.mrbt.yeston.admin.service.impl.OrganizationServiceImpl,[方法]:deleteOrganizationById,[参数]:id=19&','192.168.1.158','2017-04-07 10:14:21'),(372,'guanli','guanli','[类名]:com.mrbt.yeston.admin.service.impl.OrganizationServiceImpl,[方法]:deleteOrganizationById,[参数]:id=18&','192.168.1.158','2017-04-07 10:14:26'),(373,'guanli','guanli','[类名]:com.mrbt.yeston.admin.service.impl.OrganizationServiceImpl,[方法]:deleteOrganizationById,[参数]:id=17&','192.168.1.158','2017-04-07 10:14:29'),(374,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:deleteUserById,[参数]:id=68&','192.168.1.158','2017-04-07 10:31:27'),(375,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:deleteUserById,[参数]:id=70&','192.168.1.158','2017-04-07 15:37:59'),(376,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:deleteUserById,[参数]:id=83&','192.168.1.158','2017-04-10 16:05:55'),(377,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:deleteUserById,[参数]:id=87&','192.168.1.158','2017-04-11 11:28:21'),(378,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.UserServiceImpl,[方法]:deleteUserById,[参数]:id=88&','192.168.1.158','2017-04-11 11:35:16'),(379,'admin','admin','[类名]:com.mrbt.yeston.admin.service.impl.ResourceServiceImpl,[方法]:deleteResourceById,[参数]:id=267&','0:0:0:0:0:0:0:1','2018-02-27 11:28:38');
/*!40000 ALTER TABLE `syslog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_job`
--

DROP TABLE IF EXISTS `task_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_job` (
  `job_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `job_name` varchar(255) DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(255) DEFAULT NULL COMMENT '任务分组',
  `cron_Expression` varchar(255) DEFAULT NULL COMMENT 'cron表达式',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `bean_class` varchar(255) DEFAULT NULL COMMENT '任务执行时调用哪个类的方法 包名+类名',
  `is_concurrent` varchar(255) DEFAULT NULL COMMENT '任务是否有状态',
  `spring_id` varchar(255) DEFAULT NULL COMMENT 'spring bean',
  `method_name` varchar(255) DEFAULT NULL COMMENT '任务调用的方法名',
  `job_status` varchar(60) DEFAULT NULL COMMENT '任务状态 0-停止 1启动',
  `job_url` varchar(255) DEFAULT NULL COMMENT 'job所对应的controller url',
  `job_db` int(11) DEFAULT NULL COMMENT 'job所需数据库 0-admin 1-web',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_job`
--

LOCK TABLES `task_job` WRITE;
/*!40000 ALTER TABLE `task_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `loginname` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0：男，1：女',
  `age` tinyint(2) DEFAULT NULL,
  `usertype` tinyint(2) NOT NULL DEFAULT '0' COMMENT '用户类型，0：管理员，1：用户，2：供应商',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0：正常，1：失效',
  `organization_id` int(11) NOT NULL,
  `createdate` datetime NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `finger_print` blob,
  `finger_print2` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COMMENT='用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admin','e10adc3949ba59abbe56e057f20f883e',0,25,0,0,1,'2015-12-06 13:14:05','18707173376','APh/Acgq43NcwEE3CatxcLwUVZLY6KcLUV6KcnAzMoBVhqA7l2QOMC/vuSQEah4pPtfcnruG6EjNAzCDKkUm9GkMoInH6zoq1Ql8BVJxY0CjsLEIC6Rhqz+wfC/FgHgG7KvAA7INDjGG836O39iF+6Kl2alER6L+erJvqsPaob1RQOfZN1fvcxZX4r6b8j492K5MCtwfCpMlmiduTSnpqlaQiTIT/vbiiyIZHFMWBhrla+zxo/XvykFuSwUGQiMYXSSTekudEavkQHdThd30QE6j08X3g5B1kgJx+P063O4ciWMtRbEahpQXbww4Ne2CG3mPLFpY6qfkTebXP4V0e0nD8+4uJHmEO/hPhF5OJtu4oorqLQCR8CqyCqVU80X5OOzYSfghcjVzYxU/DISm47PTUB6SJBC/eOzRKiawXwHdIWPzGg2dMoO55ggmDiZIUM4aHZXRuEFdv71k3oaYTE9YDy1YQWQaKfo6kasRBUazctqMqIK0PQcGNKwf8AasHR6KkzZWcq6hWx0XUtXpxoKE5fx6faAjDgoUbwD4fgHIKuNzXMBBNwmrcbBFFVWS9Nmrf+c6k44JfanD0+wt82ZDvGiD8OSzKLEV1zPKpZtHar84rrZmfNPHbB2YGFK7DpRGujmBz+EiMjevcNUwdsGVsG1gTnlDRoiGGF/jlVJ3vxiqcfaCwuRr4hia7mxIGs+/5mWgxQlMfl+uytOJVpS0oTFq1Krd3O4/aBsc449Q/f0Lr/xhJTLq+PcBlxFvnRBoczGvrwwyvH73Wuh5a8WwKjrrxyQ7BEaFNRmpwu4pTn0Cl6PqmV4XO2ZpLZ2fwq1F7thRmMk2gOmyQQqpUxh+IgCelURTaB/r2oQH3smd6Oseh18bzBbaDbS32WR2BZ0g7juXN4vE7a7BXQ/IgIb3AV7b0NWVf13kypWISWqDt3xxwhaFDSby0PzwHMtbavsjnD6CvuYdLLSXWrxBBS2TdKUQzqIyvSVetzym94U7Eeij8VqhB4m7YveILkzJjVPokGVMNCrSnKv5zStN9uSgxfLcthV/DJ6Xuj05bwD4fgHIKuNzXMBBNwmrcbBFFVWS9Nmrf+c6k44JfanD0+wt82ZDvGiD8OSzKLEV1zPKpZtHar84rrZmfNPHbB2YGFK7DpRGujmBz+EiMjevcNUwdsGVsG1gTnlDRoiGGF/jlVJ3vxiqcfaCwuRr4hia7mxIGs+/5mWgxQlMfl+uytOJVpS0oTFq1Krd3O4/aBsc449Q/f0Lr/xhJTLq+PcBlxFvnRBoczGvrwwyvH73Wuh5a8WwKjrrxyQ7BEaFNRmpwu4pTn0Cl6PqmV4XO2ZpLZ2fwq1F7thRmMk2gOmyQQqpUxh+IgCelURTaB/r2oQH3smd6Oseh18bzBbaDbS32WR2BZ0g7juXN4vE7a7BXQ/IgIb3AV7b0NWVf13kypWISWqDt3xxwhaFDSby0PzwHMtbavsjnD6CvuYdLLSXWrxBBS2TdKUQzqIyvSVetzym94U7Eeij8VqhB4m7YveILkzJjVPokGVMNCrSnKv5zStN9uSgxfLcthV/DJ6Xuj05bwDofgHIKuNzXMBBNwmrcTCxFFWSsY/M4Vb1FyjzCDpSEq+tEIV8+yespvcwwxSVQJW7V3HZA37xbiFA3DsqPAJ5U5AHDBF37/mDgCYz4wgBWH42ndkIsTj+jiFuhns9ojbP3hv3fZe0R6XhAvr3l+OFAnyyPkq+Ya/JybXikVFwKjGGo1pew9jMSrwr2RZm4UodosqTrBE4O97e1h4OZOJou7W1pbDW3IMlkHf3Op5UcgARSO4uw5SebyLRgjCb1/QHZp0aCEA3JVBTWTRhkJtlVegkg3L//4G8dxAQXFolrhvH7i4x9VcoEKC9wXRRScKLcj2pH8sapwgSSgP6GMIB/xpoOrBEV5L9a6cijbtRrGSCcIXRyF3fEIztrtmUCaa29abjKboUaodLAksGqdSKeS4/yau63eHPdp7J6g5ZOSFKdnzUq/IWbIipJWInORBKm1iISGlFlDUR2p3iH8gHIt6pHgO7r4QHdyzDQfAui8Fr04qgLpHn47SeHMetaga5bwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','APh+Acgq43NcwEE3CatxcLUUVZJcrScLUVrSa+FanhM045PfmB6LKILXqOfvSihXfL0a+ktAiW+YFahHQD5N+5rnho477NMFM7PCM0geFhdtoLX2fZS458HgXmB8mrsAhFiRPfgbjKO6Ic+qUesVt2ImBrAjb322UxWU4+wLL9B76LzD5XxNu5CIW7n2XNGEpL1KIYLWfO/I/n6E23SJ2ffQPoyhLX2ffR3x3lBdYNnJOp+zy/TXwqYqOIl682jX9JCFY1mCh64utq2UU7jpfv28mzJA05nzfDDcc5lP4MHLdExoR03Si+61pkobsbWFUhoK/7zTojBS1QMeAQkdgYPVjHpTtcJBFSJovvzkkPzUJpajWZyk/g8MRk3YmO7iMZglDnqAjBT7YpyNyeZJJCHCwcC1C6YdMMiry5LcY/k0eiFc7MqqljaKO2lgzXZFBfe4CQMfTMdc+V6Ra20GASx5iWr4XY8WN6TEU0zt2eMJqA9v9AzVUA7grWLYwqLIIHTo8uvEwrG1d/9S+GgvbCcNHl+FoouLVGtvAPh+Acgq43NcwEE3CatxcLUUVZJcrShXfL0a+ktAiW+YFahHQD5N+5rnho477NMFM7PCM0geFhdtoLX2fZS458HgXmB8mrsAhFiRPfgbjKO6Ic+qUesVt2ImBrAjb322UxWU4+wLL9B76LzD5XxNu5CIW7n2XNGEpL1KIYLWfO/I/n6E23SJ2ffQPoyhLX2ffR3x3lBdYNnJOp+zy/TXwqYqOIl682jX9JCFY1mCh64utq2UU7jpfv28mzJA05nzfDDcc5lP4MHLdExoR03Si+61pkobsbWFUhoK/7zTojBS1QMeAQkdgYPVjHpTtcJBFSJovvzkkPzUJpajWZyk/g8MRk3YmO7iMZglDnqAjBT7YpyNyeZJJCHCwcC1C6YdMMiry5LcY/k0eiFc7MqqljaKO2lgzXZFBfe4CQMfTMdc+V6Ra20GASx5iWr4XY8WN6TEU0zt2eMJqA9v9AzVUA7grWLYwqLIIHTo8uvEwrG1d/9S+GgvbCcNHl+FoouLVGtvAPiAAcgq43NcwEE3Catx8KYUVZLchTPO96+Jr6zk3mAVUfxtrC2nDOmXA8qKtOx5GReWScb4vZlWUhRTdojIDOuGcnXPb3YLLGE+RRrUpj5NCdDOEPxJOBra0RgV4PybmbYUuh4ngTJS86Cn4Lj+fT6WGtZxBf1RdFDK8Y68wMGJwBQEm8+8aSzYEWq00gLnL8Wd28de+ypI87v5OjIA5JqxBvuyU0FrE3JqRo2OCGDSeVm0/8x6eSdHBQIYGvBQitWoI2XJ4J72bUC3uhJGXV9k/XwLmY9QgRwl29jMrgYMLYQ/lxWTUYXqXifGMWHV+dPZbU+ShWGGH9gtKvS1kU0i4nZO6kdTuNyTebyG+KPl2lil7rF32F2A3eYYWFhtLrYY59855k8EI6L8mD4Ql/jll58QyVXjK7lfmiHH9O9rZjqsN1FIbk7CUxNce/cmpg8zFmMwEUpYOjYRA/nNl5bYGH+wuseW7SY0tiW57+AvkHzXumco+lqyi7DYjLnD12ooFG8A6H4ByCrjc1zAQTcJq3GwSRVVkoi4/e9LgIL5LxA8I/9nzq1cYijIpH1c8T/6OaFRdgtXP1qeX0YM34CYC9/zB+NTxAL920s7ZHkWKAwUlvAQtzVa+XantilSRhdPMFf+CD0OkC9dswwU3K9IdKj3jOx89nV1k7o7FvJGfuwWYYEHmeiOZCSuQFG6nCMZ3oPLVwQvdd8R+h5806WDI+/SQy52vrgCYXqZBrR4TI2DF4jeqqzDL1NV8Kzs0mqYVvxuK1fkfWBwgq8CLXbTWoCXYWWAcNFENbjUS5H7bUahHO6GtFLDJ9ZqQiae2fv1TLAlMj5Z67aUglwj/5QRU0Ok2F9njZ1uL5M7lbYoIJfXpj9aX7kaxCc++qrAfKQytzD9CXvOl3Q217nx4Wbm3FQC5pnmo4nY7zsSTr6hUfSHc1QGR6q79dvMqME57nyBHxN+i9vYKVj9xsW4xXdbedRVxVjVNIAyUXw0EfGOCpaQoHgMAkFQ7xT2SwWyE4bLstV9O28AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(67,'guanli','管理','c4ca4238a0b923820dcc509a6f75849b',1,18,0,0,1,'2017-04-07 09:46:57','',NULL,NULL),(69,'chp','产品','c4ca4238a0b923820dcc509a6f75849b',0,18,1,0,1,'2017-04-07 10:32:35','',NULL,NULL),(71,'qdshq','青岛','c4ca4238a0b923820dcc509a6f75849b',0,23,2,0,21,'2017-04-07 15:18:41','',NULL,NULL),(72,'qdcw','青岛1','c4ca4238a0b923820dcc509a6f75849b',0,12,2,0,21,'2017-04-07 15:39:09','',NULL,NULL),(73,'cw','财务','c4ca4238a0b923820dcc509a6f75849b',1,19,1,0,1,'2017-04-10 14:25:56','',NULL,NULL),(74,'shh','审核','c4ca4238a0b923820dcc509a6f75849b',0,20,1,0,1,'2017-04-10 14:26:37','',NULL,NULL),(75,'qdfgs','青岛分公司','c4ca4238a0b923820dcc509a6f75849b',0,20,1,0,7,'2017-04-10 14:36:14','',NULL,NULL),(76,'ly','李洋','c4ca4238a0b923820dcc509a6f75849b',0,23,2,0,23,'2017-04-10 14:37:51','',NULL,NULL),(77,'bj','北京分公司','c4ca4238a0b923820dcc509a6f75849b',0,23,1,0,10,'2017-04-10 14:39:21','',NULL,NULL),(78,'bjshq','北京','c4ca4238a0b923820dcc509a6f75849b',0,23,1,0,22,'2017-04-10 14:41:16','',NULL,NULL),(79,'bjcw','北京1','c4ca4238a0b923820dcc509a6f75849b',0,25,1,0,22,'2017-04-10 14:42:13','',NULL,NULL),(80,'hzhshq','杭州','d41d8cd98f00b204e9800998ecf8427e',0,NULL,1,0,20,'2017-04-10 14:43:02','',NULL,NULL),(81,'hzhcw','杭州1','c4ca4238a0b923820dcc509a6f75849b',0,NULL,1,0,20,'2017-04-10 14:43:30','',NULL,NULL),(82,'hzhfgs','杭州分公司','c4ca4238a0b923820dcc509a6f75849b',0,NULL,1,0,9,'2017-04-10 14:44:19','',NULL,NULL),(84,'qdfgs1','青岛分公司','c4ca4238a0b923820dcc509a6f75849b',0,NULL,1,0,7,'2017-04-10 15:27:10','',NULL,NULL),(85,'bjfgs1','北京分公司','c4ca4238a0b923820dcc509a6f75849b',0,NULL,1,0,10,'2017-04-10 15:27:46','',NULL,NULL),(86,'hzhfgs1','杭州分公司','c4ca4238a0b923820dcc509a6f75849b',0,NULL,1,0,9,'2017-04-10 15:28:29','',NULL,NULL),(89,'quanbu','quanbu','e10adc3949ba59abbe56e057f20f883e',0,NULL,1,0,22,'2017-04-11 11:36:24','',NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(19) NOT NULL,
  `role_id` bigint(19) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=233 DEFAULT CHARSET=utf8 COMMENT='用户角色';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (60,1,1),(65,16,9),(66,17,10),(67,18,11),(68,19,12),(69,20,13),(70,21,14),(77,28,1),(80,24,1),(86,34,9),(87,35,10),(88,36,11),(89,37,12),(90,38,13),(91,39,14),(94,40,12),(95,41,10),(96,42,11),(97,43,9),(98,44,11),(99,45,10),(101,46,9),(102,47,10),(103,48,11),(104,49,12),(106,51,14),(107,52,11),(108,53,10),(110,50,13),(111,54,9),(112,55,11),(113,56,11),(114,57,13),(115,58,14),(116,59,9),(117,60,10),(118,61,14),(119,62,13),(120,63,12),(121,64,11),(122,65,11),(173,69,14),(174,71,9),(175,72,10),(176,73,13),(177,74,12),(178,75,11),(179,76,9),(180,76,10),(189,77,11),(190,78,9),(191,79,10),(193,81,10),(194,82,11),(197,80,9),(206,84,11),(208,85,11),(209,86,11),(230,89,9),(231,89,10),(232,67,15);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yt_bank_account_type`
--

DROP TABLE IF EXISTS `yt_bank_account_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_bank_account_type` (
  `id` int(11) NOT NULL,
  `bat_name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yt_bank_account_type`
--

LOCK TABLES `yt_bank_account_type` WRITE;
/*!40000 ALTER TABLE `yt_bank_account_type` DISABLE KEYS */;
INSERT INTO `yt_bank_account_type` VALUES (1,'合作机构账户'),(2,'垫付款账户'),(3,'借款账户'),(4,'保证金账户'),(5,'其他账户');
/*!40000 ALTER TABLE `yt_bank_account_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yt_bank_info`
--

DROP TABLE IF EXISTS `yt_bank_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_bank_info` (
  `id` varchar(64) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0:未启用，1:已启用，2:已作废',
  `type` int(11) NOT NULL COMMENT '账户类型，yt_bank_account_type.id',
  `cooperative_id` varchar(64) DEFAULT NULL COMMENT '合作机构公司id,yt_supplier_main.id',
  `bank_account` varchar(30) NOT NULL COMMENT '银行账户',
  `bank_account_name` varchar(50) DEFAULT NULL COMMENT '账户姓名',
  `bank` varchar(30) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL COMMENT '开户行',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '作废时间',
  PRIMARY KEY (`id`),
  KEY `fk_sup` (`cooperative_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='银行账号数据，如果type为合作机构公司账户，supplier_id不能为空，并且一个合作济公公司装潢只能有一个启用账户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yt_bank_info`
--

LOCK TABLES `yt_bank_info` WRITE;
/*!40000 ALTER TABLE `yt_bank_info` DISABLE KEYS */;
INSERT INTO `yt_bank_info` VALUES ('0b91b1d03cf54d7eaaf026de54ce1927',1,2,'','11015201778006','众和胜（天津）资产管理有限公司','平安银行','平安银行天津东马路支行','2017-04-07 16:46:21',NULL),('1b9c77ba98604d85922197d12db3f489',2,4,'','200200409200031104','北京睿博盈通网络科技有限公司','工商银行','中国工商银行广安门范家胡同支行','2017-04-07 14:03:39','2017-04-07 14:32:20'),('253296ada4fd4958a21bb9995425a233',2,1,'6e42fc32bedc40e58ff93d8f005d9e1d','222222222222222222222222','青岛梓杉','飒沓','阿萨的','2017-04-07 16:57:55','2017-04-07 16:57:59'),('3bba333ea5f74fbfa32c0f52c2439e48',1,1,'8e22e7f3ddc4479b8124c958aed65483','91140154800009035','中嵩众筹（北京）资本管理有限公司','浦发银行','浦发银行北京西直门支行','2017-04-10 10:12:09',NULL),('434260e50fc94349aeff7ebd0dee70e9',2,1,'6e42fc32bedc40e58ff93d8f005d9e1d','211113123124123121451232132','青岛梓杉','阿萨德阿萨德撒的发送发水电费 飒沓f','发士大夫阿萨德富士达富士达发阿斯蒂芬阿萨德','2017-04-07 16:59:54','2017-04-10 10:04:23'),('5b56ce96a72d4b1e9e032acd52380faf',1,1,'6e42fc32bedc40e58ff93d8f005d9e1d','698336542','青岛梓杉汇金资产管理有限公司','民生银行','中国民生银行股份有限公司青岛分行','2017-04-10 10:09:52',NULL),('7b113ce882ee4c05aa0efd72eb71fa7b',2,2,'','11015201778006','众和胜（天津）资产管理有限公司','平安银行','平安银行天津东马路支行','2017-04-07 11:21:32','2017-04-07 14:37:21'),('813df0e3368c49cf9a7d012e638a7ab9',1,4,'','0200200409200031094','北京睿博盈通网络科技有限公司','工商银行','中国工商银行广安门范家胡同支行','2017-04-10 10:24:25',NULL),('8ad9c5cef3114c4b9c96aa49aed40449',2,1,'6e42fc32bedc40e58ff93d8f005d9e1d','222222222222222222222','青岛梓杉','阿萨德','阿萨的','2017-04-07 16:55:26','2017-04-07 16:57:57'),('8cace899e1234eb4935d86cffe5001e9',2,5,'','12050161540000000000','众和胜（天津）资产管理有限公司','建设银行','中国建设银行股份有限公司天津富裕支行','2017-04-07 11:24:21','2017-04-07 14:37:31'),('98b40157ec094c109aacbd75a4004995',1,5,'','12050161540000000150','众和胜（天津）资产管理有限公司','建设银行','中国建设银行股份有限公司天津富裕支行','2017-04-10 10:22:31',NULL),('a8bdf428c31046328328faa6ac442d73',2,1,'6e42fc32bedc40e58ff93d8f005d9e1d','adda','青岛梓杉','dadad','adad','2017-04-07 16:50:17','2017-04-07 16:59:39'),('ab4ac3eb58ad4003bc9641ff74236be6',2,3,'','123222222222222229504','123','123','123','2017-04-07 14:36:50','2017-04-07 14:41:26'),('ac2251029efa4b15a0e6aac88dbf0da7',1,1,'6e42fc32bedc40e58ff93d8f005d9e1d','802250200494967','青岛梓杉汇金资产管理有限公司','青岛银行','青岛银行股份有限公司东海西路第一支行','2017-04-10 10:09:03',NULL),('bb55ed421ae44dd39e6a9df51b0cfb27',2,1,'6e42fc32bedc40e58ff93d8f005d9e1d','1231321313','青岛梓杉','adadq1','adadad','2017-04-07 15:06:54','2017-04-10 10:04:33'),('cc3eef60a5dd4cbc8726ad8650f79348',2,4,'','200200409200031104','北京睿博盈通网络科技有限公司','工商银行','中国工商银行广安门范家胡同支行','2017-04-07 11:30:53','2017-04-10 10:23:37'),('d2a3102e611a445a8c6ea8a996ea4ead',1,1,'933d8db230464113b87c62ac2e277662','6214860101865018','李洋','招商银行','招商银行股份有限公司北京方庄支行','2017-04-07 11:09:21',NULL),('d46ff34bf3a1438a841d0a51a9baab35',2,1,'6e42fc32bedc40e58ff93d8f005d9e1d','698336542','青岛梓杉汇金资产管理有限公司','民生银行','中国民生银行青岛分行营业部','2017-04-07 11:07:01','2017-04-07 14:32:37'),('d8f4f11e4cd5428eb01308d61a800e46',2,1,'6e42fc32bedc40e58ff93d8f005d9e1d','sff','青岛梓杉','sff','sfsf','2017-04-07 14:41:39','2017-04-07 14:41:42'),('dfe6c8bdf5334e32afe57b999ef3ed27',1,3,'','110914458510301','北京睿博盈通网络科技有限公司','招商银行','招商银行北京分行东四环支行','2017-04-07 11:27:40',NULL),('e73c33a1f1de49d99f7ca0d7ec1719a1',2,4,'','200200409200031104','北京睿博盈通网络科技有限公司','工商银行','中国工商银行广安门范家胡同支行','2017-04-07 11:29:30','2017-04-07 11:30:05'),('e83832287b9c4125833549ad6b6e03b7',2,1,'8e22e7f3ddc4479b8124c958aed65483','91140154800009040','中嵩众筹（北京）资本管理有限公司','浦发银行','浦发银行北京西直门支行','2017-04-07 11:04:20','2017-04-10 10:11:21'),('ec429701a6fc4042b4e8b917038d089c',1,1,'f262087810754d6bbee5bad43b67adcf','201000113764652','杭州海俊实业有限公司','农村商业银行','杭州联合农村商业银行股份有限公司四季青支行','2017-04-07 11:13:44',NULL);
/*!40000 ALTER TABLE `yt_bank_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yt_business_assort`
--

DROP TABLE IF EXISTS `yt_business_assort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_business_assort` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assort_name` varchar(45) DEFAULT NULL COMMENT '分类名称',
  `assort_bewrite` varchar(512) DEFAULT NULL COMMENT '分类描述',
  `assort_module` varchar(45) DEFAULT NULL COMMENT '业务模块，通过该字段判断调用的页面',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='业务分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yt_business_assort`
--

LOCK TABLES `yt_business_assort` WRITE;
/*!40000 ALTER TABLE `yt_business_assort` DISABLE KEYS */;
INSERT INTO `yt_business_assort` VALUES (1,'车贷业务','车贷宝业务模块','yt_car_loan');
/*!40000 ALTER TABLE `yt_business_assort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yt_car_loan`
--

DROP TABLE IF EXISTS `yt_car_loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_car_loan` (
  `id` varchar(64) NOT NULL COMMENT 'UUID',
  `plate_number` varchar(64) DEFAULT NULL COMMENT '车牌号',
  `vehicle_ownership` int(11) DEFAULT NULL COMMENT '车辆所属，1-个人，2-公司，？',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '车主姓名',
  `whether_operation` int(11) DEFAULT NULL COMMENT '是否营运，0否，1是',
  `vehicle_type` varchar(128) DEFAULT NULL COMMENT '车辆型号',
  `vehicle_life` int(11) DEFAULT NULL COMMENT '车辆年限，不足一个月按照整月处理 ？',
  `kilometers` double DEFAULT NULL COMMENT '行驶公里数',
  `loan_amount` double DEFAULT NULL COMMENT '借款金额',
  `loan_term` int(45) DEFAULT NULL COMMENT '借款期限 ?',
  `single_double_charge` int(11) DEFAULT NULL COMMENT '单押/双押   1：单押，2：双押',
  `dollars_number` int(11) DEFAULT NULL COMMENT '一抵押/二抵押    1一抵押，2二抵押',
  `one_dollars_name` varchar(45) DEFAULT NULL COMMENT '如果抵押为二抵，需要备注填写一抵押人，上一抵押人',
  `repayment_method` int(11) DEFAULT '1' COMMENT '还款方式，1：转账',
  `rate` double DEFAULT NULL COMMENT '利率',
  `document_type` int(11) DEFAULT NULL COMMENT '证件类型，1身份证，2，营业执照',
  `travel_book` text COMMENT '行驶本',
  `idcard_license` text COMMENT '身份证或营业执照',
  `vehicle_evaluation_report` text COMMENT '车辆评估报告',
  `loan_agreement` text COMMENT '委托借款协议',
  `vehicle_certificate` text COMMENT '机动车登记证',
  `vehicle_tax_certificate` text COMMENT '车辆购置完税证明',
  `vehical_invoice` text COMMENT '车辆发票',
  `vehical_photo` text COMMENT '车辆照片',
  `loan_contract` text COMMENT '借款合同',
  `iou` text COMMENT '借条',
  `capital_requirement` text COMMENT '资金需求表',
  `policy` text COMMENT '保单',
  `vehicle_inventory` text COMMENT '机动车封存清单',
  `status` int(11) DEFAULT '1' COMMENT '审核状态',
  `cooperate_id` varchar(64) DEFAULT NULL COMMENT '供应商id ',
  `user_id` int(11) DEFAULT NULL COMMENT '申请人用户ID',
  `est_rep_amount` double DEFAULT NULL COMMENT '预计还款金额',
  `act_rep_amount` double DEFAULT NULL COMMENT '实际还款金额',
  `loan_time` datetime DEFAULT NULL COMMENT '借款时间',
  `business_type` int(255) DEFAULT '0' COMMENT '业务类型',
  `product_id` int(11) DEFAULT NULL COMMENT '产品id',
  `start_time` datetime DEFAULT NULL COMMENT '发起时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='车贷宝业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yt_car_loan`
--

LOCK TABLES `yt_car_loan` WRITE;
/*!40000 ALTER TABLE `yt_car_loan` DISABLE KEYS */;
INSERT INTO `yt_car_loan` VALUES ('BJYF_001_BJSHQ_1491962116927','津123',1,'13',0,'123',123,123,123123.01,12311,1,1,'',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'8e22e7f3ddc4479b8124c958aed65483',78,164650.88,164650.88,NULL,0,NULL,NULL),('BJYF_001_BJSHQ_1491962355830','沪1231',1,'1212',0,'123321',123,321,122,12,1,1,NULL,1,123,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9,'8e22e7f3ddc4479b8124c958aed65483',78,126.93,126.93,'2017-04-12 10:05:44',0,910,'2017-04-12 10:00:32'),('BJYF_001_BJSHQ_1491962869885','京NX5M56',1,'杨素珍',0,'宝马X5M',4,30000,400000,60,2,1,NULL,1,12,NULL,'http://192.168.1.88/ytCarLoan/8e22e7f3ddc4479b8124c958aed65483/travelBook/f4646adc084a45f591d667c2d355a0c5.jpg','http://192.168.1.88/ytCarLoan/8e22e7f3ddc4479b8124c958aed65483/idcardLicense/ef6f744cfb0744169962a4dceea8dde3.jpg,http://192.168.1.88/ytCarLoan/8e22e7f3ddc4479b8124c958aed65483/idcardLicense/9dfe9b7e65b443b5a70a9a93046c5598.jpg','http://192.168.1.88/ytCarLoan/8e22e7f3ddc4479b8124c958aed65483/vehicleEvaluationReport/42bd70ecbdc44ad0a03c8434f425fe0e.jpg,http://192.168.1.88/ytCarLoan/8e22e7f3ddc4479b8124c958aed65483/vehicleEvaluationReport/b3ba00d7f8a246cd9dc8e492cc6ade5a.jpg','http://192.168.1.88/ytCarLoan/8e22e7f3ddc4479b8124c958aed65483/loanAgreement/be84b822d4e94707b14e8f125da3dfe5.jpg,http://192.168.1.88/ytCarLoan/8e22e7f3ddc4479b8124c958aed65483/loanAgreement/adf352570d7f4d0bbeb0033062f1e86e.jpg','http://192.168.1.88/ytCarLoan/8e22e7f3ddc4479b8124c958aed65483/vehicleCertificate/2fe0331cd24d425b9cda5e0ebfc3dba5.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,24,'8e22e7f3ddc4479b8124c958aed65483',78,407890.41,407890.41,'2017-04-12 10:30:03',0,NULL,'2017-04-12 10:17:48'),('QDFGS_001_QDSHQ_1491807556058','鲁B7QJ99',1,'李彬',0,'别克.君威',5,30000,110000,30,1,1,NULL,1,12,NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/travelBook/26c008b2323f4111ba96555a143e7f4c.jpg','http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/idcardLicense/d9aa4df9665f469f94b3c8a9071f9216.jpg','http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/vehicleEvaluationReport/4397798c65b242aaba2a990e77176a47.jpg','http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/loanAgreement/aa014504039e4e14bc98f35e71faf930.jpg,http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/loanAgreement/054cc4478d58467cbcc7cab3947a5a2b.jpg','http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/vehicleCertificate/d14fe593d96845c1b9689c58abec635c.jpg',NULL,NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/vehicalPhoto/b7aee5d3136742ee9e65c5f38cce95e4.jpg',NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/iou/7cb3ef6d86dc4bfbbac76f29ec2ef25a.jpg',NULL,NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/vehicleInventory/fbaf85fe18734d01b0b2f32b4b0ea722.jpg',4,'6e42fc32bedc40e58ff93d8f005d9e1d',71,111084.93,111084.93,NULL,0,NULL,'2017-04-10 14:59:38'),('QDFGS_001_QDSHQ_1491809618480','鲁BK68J9',1,'陈洪海',0,'现代途胜',5,32000,110000,90,1,1,NULL,1,12,NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/travelBook/fc5d6092e40d4eb3b8cb215035895f42.jpg','http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/idcardLicense/71deb17731c545639620737aefac6f11.jpg,http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/idcardLicense/4f4327e8f4f04e6db024f503f1a96027.jpg','http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/vehicleEvaluationReport/c42bd1ac2d5945a28997dd0d2b9de0b6.jpg,http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/vehicleEvaluationReport/551520e887b84a17accc8628ac1afe3d.jpg','http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/loanAgreement/42e0991804844e6192ce92428743ef7a.jpg,http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/loanAgreement/166e755037f04fc893ad9d8f2e231c33.jpg','http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/vehicleCertificate/d3ef87a969ab43a3b5010e7e8e9c7c94.jpg','http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/vehicleTaxCertificate/ce853ddd54084c1585a7823427d676be.jpg',NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/vehicalPhoto/730b0c72cae34d6a9f3c41e1dd7b3b3e.jpg',NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/iou/f5f4bacffb8d4800b45086eeb35385d3.jpg','http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/capitalRequirement/66a66af411f7440981b8be7f0ff922ca.jpg',NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/vehicleInventory/c156c355bd5d47db87f53279d287acf5.jpg',24,'6e42fc32bedc40e58ff93d8f005d9e1d',71,113254.79,113254.79,'2017-04-10 15:58:08',0,908,'2017-04-10 15:47:35'),('QDFGS_001_QDSHQ_1491873753448','京鲁QNU910',1,'曹青',0,'英菲尼迪QX70',37,4,330000,90,1,1,'',1,7,NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/travelBook/5011da6f1b2744ca839d23fb6962040b.jpg','http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/idcardLicense/1ac5ef27b18c4d1e9ba15fa7f4674f6b.jpg',NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/loanAgreement/b4e4b146fe2b4dcba61d5bfab78de9ed.jpg',NULL,NULL,NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/vehicalPhoto/652ac9c3f38643968a61bcacb2b48fc0.jpg',NULL,NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/capitalRequirement/89479006c1c24420add80e95a88d7d32.jpg',NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/vehicleInventory/9b6cf269646a4b97ba79df771f0f28aa.jpg',24,'6e42fc32bedc40e58ff93d8f005d9e1d',71,339764.38,339764.38,'2017-04-11 10:27:31',0,909,'2017-04-11 09:42:30'),('QDFGS_001_QDSHQ_1491967333785','津asdad',1,'23213',0,'dad',123,2131,1231,2,1,1,NULL,1,13,NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/travelBook/710261327b3e4ae4af78f2f3565dd436.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'6e42fc32bedc40e58ff93d8f005d9e1d',71,1231.88,1231.88,NULL,0,NULL,NULL),('QDFGS_001_QDSHQ_1492055918019','鲁B773CC',1,'娄珏',0,'奔驰C180K',2,30000,80000,90,1,1,NULL,1,12,NULL,'http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/travelBook/cb242ca2ab1649b5aef814f10d6a6198.jpg','http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/idcardLicense/fb15906e76e2498ca6f54150645cefcb.jpg','http://192.168.1.88/ytCarLoan/6e42fc32bedc40e58ff93d8f005d9e1d/vehicleEvaluationReport/abc5e847de904473b5b85035b7cc37e6.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5,'6e42fc32bedc40e58ff93d8f005d9e1d',71,82367.12,82367.12,NULL,0,NULL,'2017-04-13 12:06:59');
/*!40000 ALTER TABLE `yt_car_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yt_car_loan_log`
--

DROP TABLE IF EXISTS `yt_car_loan_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_car_loan_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT NULL COMMENT '操作状态',
  `oper_info` varchar(512) DEFAULT NULL COMMENT '记录信息',
  `oper_time` date DEFAULT NULL COMMENT '操作时间',
  `oper_user_id` int(11) DEFAULT NULL COMMENT '操作人ID',
  `car_loan_id` varchar(64) DEFAULT NULL COMMENT '对应的车贷宝业务表ID',
  `voucher` varchar(512) DEFAULT NULL COMMENT '相关凭证，图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COMMENT='车贷宝操作记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yt_car_loan_log`
--

LOCK TABLES `yt_car_loan_log` WRITE;
/*!40000 ALTER TABLE `yt_car_loan_log` DISABLE KEYS */;
INSERT INTO `yt_car_loan_log` VALUES (1,1,'新添贷款记录','2017-04-10',71,'QDFGS_001_QDSHQ_1491807556058',NULL),(2,2,'发起流程','2017-04-10',71,'QDFGS_001_QDSHQ_1491807556058',NULL),(3,3,'申请人确认申请','2017-04-10',71,'QDFGS_001_QDSHQ_1491807556058',NULL),(4,25,'初审','2017-04-10',75,'QDFGS_001_QDSHQ_1491807556058',NULL),(5,1,'上传了vehicleInventory图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491807556058',NULL),(6,1,'上传了iou图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491807556058',NULL),(7,1,'上传了vehicalPhoto图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491807556058',NULL),(8,1,'上传了vehicleCertificate图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491807556058',NULL),(9,1,'上传了loanAgreement图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491807556058',NULL),(10,1,'上传了vehicleEvaluationReport图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491807556058',NULL),(11,1,'上传了idcardLicense图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491807556058',NULL),(12,1,'上传了travelBook图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491807556058',NULL),(13,3,'申请人确认申请','2017-04-10',71,'QDFGS_001_QDSHQ_1491807556058',NULL),(14,4,'初审','2017-04-10',75,'QDFGS_001_QDSHQ_1491807556058',NULL),(15,1,'新添贷款记录','2017-04-10',71,'QDFGS_001_QDSHQ_1491809618480',NULL),(16,1,'上传了vehicleInventory图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491809618480',NULL),(17,1,'上传了capitalRequirement图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491809618480',NULL),(18,1,'上传了iou图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491809618480',NULL),(19,1,'上传了vehicalPhoto图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491809618480',NULL),(20,1,'上传了vehicleTaxCertificate图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491809618480',NULL),(21,1,'上传了vehicleCertificate图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491809618480',NULL),(22,1,'上传了loanAgreement图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491809618480',NULL),(23,1,'上传了vehicleEvaluationReport图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491809618480',NULL),(24,1,'上传了idcardLicense图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491809618480',NULL),(25,1,'上传了travelBook图片','2017-04-10',71,'QDFGS_001_QDSHQ_1491809618480',NULL),(26,2,'发起流程','2017-04-10',71,'QDFGS_001_QDSHQ_1491809618480',NULL),(27,3,'申请人确认申请','2017-04-10',71,'QDFGS_001_QDSHQ_1491809618480',NULL),(28,4,'初审','2017-04-10',84,'QDFGS_001_QDSHQ_1491809618480',NULL),(29,5,'复审','2017-04-10',75,'QDFGS_001_QDSHQ_1491809618480',NULL),(30,6,'终审','2017-04-10',74,'QDFGS_001_QDSHQ_1491809618480',NULL),(31,7,'垫付账户放款','2017-04-10',73,'QDFGS_001_QDSHQ_1491809618480','http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/众和胜付款梓彬汇金（现代途胜）垫付款11.30.jpeg'),(32,8,'验收垫付款','2017-04-10',72,'QDFGS_001_QDSHQ_1491809618480','http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金收款众合胜（现代途胜）垫付款11.30.png'),(33,8,'发布了产品，id为：908','2017-04-10',69,'QDFGS_001_QDSHQ_1491809618480',NULL),(34,9,'是否发布产品','2017-04-10',69,'QDFGS_001_QDSHQ_1491809618480',NULL),(35,10,'募集完成','2017-04-10',69,'QDFGS_001_QDSHQ_1491809618480',NULL),(36,11,'借款账户放款','2017-04-10',73,'QDFGS_001_QDSHQ_1491809618480','http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/盈通付款梓杉汇金（现代途胜）借款12.6.jpeg'),(37,12,'供应商收款','2017-04-10',72,'QDFGS_001_QDSHQ_1491809618480','http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金付款众和胜（途胜）回款12.6.png'),(38,13,'归还垫付款','2017-04-10',72,'QDFGS_001_QDSHQ_1491809618480','http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金付款众和胜（途胜）回款12.6.png'),(39,14,'总部回收垫付款','2017-04-10',73,'QDFGS_001_QDSHQ_1491809618480','http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/众合胜收款梓杉汇金（现代途胜）垫付款12.6.jpeg'),(40,15,'保证金申请','2017-04-10',73,'QDFGS_001_QDSHQ_1491809618480',NULL),(41,16,'缴纳保证金','2017-04-10',72,'QDFGS_001_QDSHQ_1491809618480','http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金付款盈通（途胜、标志）保证金12.6.png'),(42,17,'保证金收款','2017-04-10',73,'QDFGS_001_QDSHQ_1491809618480','http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/盈通收款梓杉汇金（现代途胜、标志508）保证金12.6.jpeg'),(43,18,'是否催款','2017-04-10',1,'QDFGS_001_QDSHQ_1491809618480',NULL),(44,19,'总部催款','2017-04-10',73,'QDFGS_001_QDSHQ_1491809618480',NULL),(45,20,'供应商还款','2017-04-10',72,'QDFGS_001_QDSHQ_1491809618480','http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金还款睿博盈通本息22440.6元2.28.png,http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金还款众合胜本金8.8w2.28.png,http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/梓杉汇金还款众合胜利息2814.19元2.28.png'),(46,21,'总部确认收款','2017-04-10',73,'QDFGS_001_QDSHQ_1491809618480',NULL),(47,22,'退还保证金','2017-04-10',73,'QDFGS_001_QDSHQ_1491809618480','http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/盈通付款中嵩（贵士、保时捷）保证金2.28.jpeg'),(48,23,'供应商回收保证金','2017-04-10',72,'QDFGS_001_QDSHQ_1491809618480','http://192.168.1.88/ytCarLoan/QDFGS_001_QDSHQ_1491809618480/evidence/睿博盈通退梓杉汇金保证金（别克君越）5500元2.28.png'),(49,24,'完成','2017-04-10',67,'QDFGS_001_QDSHQ_1491809618480',NULL),(50,1,'新添贷款记录','2017-04-11',71,'QDFGS_001_QDSHQ_1491873753448',NULL),(51,1,'上传了loanAgreement图片','2017-04-11',71,'QDFGS_001_QDSHQ_1491873753448',NULL),(52,1,'上传了vehicalPhoto图片','2017-04-11',71,'QDFGS_001_QDSHQ_1491873753448',NULL),(53,1,'上传了capitalRequirement图片','2017-04-11',71,'QDFGS_001_QDSHQ_1491873753448',NULL),(54,1,'上传了vehicleInventory图片','2017-04-11',71,'QDFGS_001_QDSHQ_1491873753448',NULL),(55,1,'上传了travelBook图片','2017-04-11',71,'QDFGS_001_QDSHQ_1491873753448',NULL),(56,1,'上传了idcardLicense图片','2017-04-11',71,'QDFGS_001_QDSHQ_1491873753448',NULL),(57,1,'编辑贷款记录','2017-04-11',71,'QDFGS_001_QDSHQ_1491873753448',NULL),(58,2,'发起流程','2017-04-11',71,'QDFGS_001_QDSHQ_1491873753448',NULL),(59,3,'申请人确认申请','2017-04-11',71,'QDFGS_001_QDSHQ_1491873753448',NULL),(60,4,'初审','2017-04-11',75,'QDFGS_001_QDSHQ_1491873753448',NULL),(61,5,'复审','2017-04-11',84,'QDFGS_001_QDSHQ_1491873753448',NULL),(62,6,'终审','2017-04-11',74,'QDFGS_001_QDSHQ_1491873753448',NULL),(63,7,'垫付账户放款','2017-04-11',73,'QDFGS_001_QDSHQ_1491873753448',NULL),(64,8,'验收垫付款','2017-04-11',72,'QDFGS_001_QDSHQ_1491873753448',NULL),(65,8,'发布了产品，id为：909','2017-04-11',69,'QDFGS_001_QDSHQ_1491873753448',NULL),(66,9,'是否发布产品','2017-04-11',69,'QDFGS_001_QDSHQ_1491873753448',NULL),(67,10,'募集完成','2017-04-11',69,'QDFGS_001_QDSHQ_1491873753448',NULL),(68,11,'借款账户放款','2017-04-11',73,'QDFGS_001_QDSHQ_1491873753448',NULL),(69,12,'供应商收款','2017-04-11',72,'QDFGS_001_QDSHQ_1491873753448',NULL),(70,13,'归还垫付款','2017-04-11',72,'QDFGS_001_QDSHQ_1491873753448',NULL),(71,14,'总部回收垫付款','2017-04-11',73,'QDFGS_001_QDSHQ_1491873753448',NULL),(72,15,'保证金申请','2017-04-11',73,'QDFGS_001_QDSHQ_1491873753448',NULL),(73,16,'缴纳保证金','2017-04-11',72,'QDFGS_001_QDSHQ_1491873753448',NULL),(74,17,'保证金收款','2017-04-11',73,'QDFGS_001_QDSHQ_1491873753448',NULL),(75,18,'是否催款','2017-04-11',1,'QDFGS_001_QDSHQ_1491873753448',NULL),(76,19,'总部催款','2017-04-11',73,'QDFGS_001_QDSHQ_1491873753448',NULL),(77,20,'供应商还款','2017-04-11',72,'QDFGS_001_QDSHQ_1491873753448',NULL),(78,21,'总部确认收款','2017-04-11',73,'QDFGS_001_QDSHQ_1491873753448',NULL),(79,22,'退还保证金','2017-04-11',73,'QDFGS_001_QDSHQ_1491873753448',NULL),(80,23,'供应商回收保证金','2017-04-11',72,'QDFGS_001_QDSHQ_1491873753448',NULL),(81,1,'新添贷款记录','2017-04-12',78,'BJYF_001_BJSHQ_1491962116927',NULL),(82,1,'编辑贷款记录','2017-04-12',78,'BJYF_001_BJSHQ_1491962116927',NULL),(83,1,'新添贷款记录','2017-04-12',78,'BJYF_001_BJSHQ_1491962355830',NULL),(84,2,'发起流程','2017-04-12',78,'BJYF_001_BJSHQ_1491962355830',NULL),(85,3,'申请人确认申请','2017-04-12',78,'BJYF_001_BJSHQ_1491962355830',NULL),(86,4,'初审','2017-04-12',85,'BJYF_001_BJSHQ_1491962355830',NULL),(87,5,'复审','2017-04-12',77,'BJYF_001_BJSHQ_1491962355830',NULL),(88,6,'终审','2017-04-12',74,'BJYF_001_BJSHQ_1491962355830',NULL),(89,7,'垫付账户放款','2017-04-12',73,'BJYF_001_BJSHQ_1491962355830',NULL),(90,8,'验收垫付款','2017-04-12',79,'BJYF_001_BJSHQ_1491962355830',NULL),(91,1,'新添贷款记录','2017-04-12',78,'BJYF_001_BJSHQ_1491962869885',NULL),(92,1,'上传了travelBook图片','2017-04-12',78,'BJYF_001_BJSHQ_1491962869885',NULL),(93,1,'上传了idcardLicense图片','2017-04-12',78,'BJYF_001_BJSHQ_1491962869885',NULL),(94,1,'上传了vehicleEvaluationReport图片','2017-04-12',78,'BJYF_001_BJSHQ_1491962869885',NULL),(95,1,'上传了loanAgreement图片','2017-04-12',78,'BJYF_001_BJSHQ_1491962869885',NULL),(96,1,'上传了vehicleCertificate图片','2017-04-12',78,'BJYF_001_BJSHQ_1491962869885',NULL),(97,8,'发布了产品，id为：910','2017-04-12',69,'BJYF_001_BJSHQ_1491962355830',NULL),(98,9,'是否发布产品','2017-04-12',69,'BJYF_001_BJSHQ_1491962355830',NULL),(99,2,'发起流程','2017-04-12',78,'BJYF_001_BJSHQ_1491962869885',NULL),(100,3,'申请人确认申请','2017-04-12',78,'BJYF_001_BJSHQ_1491962869885',NULL),(101,4,'初审','2017-04-12',77,'BJYF_001_BJSHQ_1491962869885',NULL),(102,5,'复审','2017-04-12',85,'BJYF_001_BJSHQ_1491962869885',NULL),(103,6,'终审','2017-04-12',74,'BJYF_001_BJSHQ_1491962869885',NULL),(104,7,'垫付账户放款','2017-04-12',73,'BJYF_001_BJSHQ_1491962869885','http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/1.jpg'),(105,8,'验收垫付款','2017-04-12',79,'BJYF_001_BJSHQ_1491962869885','http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/9.jpg'),(106,8,'是否发布产品','2017-04-12',69,'BJYF_001_BJSHQ_1491962869885',NULL),(107,15,'保证金申请','2017-04-12',73,'BJYF_001_BJSHQ_1491962869885',NULL),(108,16,'缴纳保证金','2017-04-12',79,'BJYF_001_BJSHQ_1491962869885','http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/7.jpg'),(109,17,'保证金收款','2017-04-12',73,'BJYF_001_BJSHQ_1491962869885','http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/6.jpg'),(110,18,'是否催款','2017-04-12',1,'BJYF_001_BJSHQ_1491962869885',NULL),(111,19,'总部催款','2017-04-12',73,'BJYF_001_BJSHQ_1491962869885',NULL),(112,20,'供应商还款','2017-04-12',79,'BJYF_001_BJSHQ_1491962869885','http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/8.jpg'),(113,21,'总部确认收款','2017-04-12',73,'BJYF_001_BJSHQ_1491962869885','http://192.168.1.88/ytCarLoan/BJYF_001_BJSHQ_1491962869885/evidence/7.jpg'),(114,22,'退还保证金','2017-04-12',73,'BJYF_001_BJSHQ_1491962869885',NULL),(115,23,'供应商回收保证金','2017-04-12',79,'BJYF_001_BJSHQ_1491962869885',NULL),(116,24,'完成','2017-04-12',1,'QDFGS_001_QDSHQ_1491873753448',NULL),(117,24,'完成','2017-04-12',1,'BJYF_001_BJSHQ_1491962869885',NULL),(118,1,'新添贷款记录','2017-04-12',71,'QDFGS_001_QDSHQ_1491967333785',NULL),(119,1,'上传了travelBook图片','2017-04-12',71,'QDFGS_001_QDSHQ_1491967333785',NULL),(120,1,'上传了travelBook图片','2017-04-12',71,'QDFGS_001_QDSHQ_1491967333785',NULL),(121,1,'上传了travelBook图片','2017-04-12',71,'QDFGS_001_QDSHQ_1491967333785',NULL),(122,1,'上传了travelBook图片','2017-04-12',71,'QDFGS_001_QDSHQ_1491967333785',NULL),(123,1,'新添贷款记录','2017-04-13',71,'QDFGS_001_QDSHQ_1492055918019',NULL),(124,1,'上传了travelBook图片','2017-04-13',71,'QDFGS_001_QDSHQ_1492055918019',NULL),(125,1,'上传了idcardLicense图片','2017-04-13',71,'QDFGS_001_QDSHQ_1492055918019',NULL),(126,1,'上传了vehicleEvaluationReport图片','2017-04-13',71,'QDFGS_001_QDSHQ_1492055918019',NULL),(127,2,'发起流程','2017-04-13',71,'QDFGS_001_QDSHQ_1492055918019',NULL),(128,3,'申请人确认申请','2017-04-13',71,'QDFGS_001_QDSHQ_1492055918019',NULL),(129,4,'初审','2017-04-13',84,'QDFGS_001_QDSHQ_1492055918019',NULL),(130,5,'复审','2017-04-13',75,'QDFGS_001_QDSHQ_1492055918019',NULL);
/*!40000 ALTER TABLE `yt_car_loan_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yt_cooperative_contact`
--

DROP TABLE IF EXISTS `yt_cooperative_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_cooperative_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `linkman` varchar(45) DEFAULT NULL COMMENT '联系类型，公司或联系人姓名',
  `fixed_telphone` varchar(45) DEFAULT NULL COMMENT '固定电话',
  `mobile_phone` varchar(45) DEFAULT NULL COMMENT '手机号',
  `fax_phone` varchar(45) DEFAULT NULL COMMENT '传真',
  `address` varchar(45) DEFAULT NULL COMMENT '地址',
  `email` varchar(45) DEFAULT NULL COMMENT 'email',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modi_time` datetime DEFAULT NULL COMMENT '修改时间',
  `status` int(11) DEFAULT '1' COMMENT '状态，0删除，1正常',
  `cooperative_id` varchar(64) DEFAULT NULL COMMENT '合作机构公司ID,yt_supplier_main.id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='合作机构公司联系方式，数据可以添加、逻辑删除，不能修改';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yt_cooperative_contact`
--

LOCK TABLES `yt_cooperative_contact` WRITE;
/*!40000 ALTER TABLE `yt_cooperative_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `yt_cooperative_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yt_cooperative_main`
--

DROP TABLE IF EXISTS `yt_cooperative_main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_cooperative_main` (
  `id` varchar(64) NOT NULL,
  `name` varchar(100) DEFAULT NULL COMMENT '供应商名称',
  `region_name` varchar(100) DEFAULT NULL COMMENT '地域名称',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `modi_time` datetime DEFAULT NULL COMMENT '修改时间',
  `status` int(11) DEFAULT '0' COMMENT '状态，0：未启用，1：已启用，2:已过期',
  `main_id` varchar(64) DEFAULT NULL COMMENT '原数据ID',
  `dept_id` int(11) DEFAULT NULL COMMENT '部门id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='合作机构公司信息，新增加的数据状态为未启用，启用后，要修改数据，要求将原数据复制成一条新数据，main_id为原数据ID，状态为已过期，之后再原数据上进行修改';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yt_cooperative_main`
--

LOCK TABLES `yt_cooperative_main` WRITE;
/*!40000 ALTER TABLE `yt_cooperative_main` DISABLE KEYS */;
INSERT INTO `yt_cooperative_main` VALUES ('6e42fc32bedc40e58ff93d8f005d9e1d','青岛梓杉','青岛','2017-04-07 10:54:20',NULL,1,NULL,21),('8e22e7f3ddc4479b8124c958aed65483','北京中嵩','北京','2017-04-07 10:54:11',NULL,1,NULL,22),('933d8db230464113b87c62ac2e277662','李洋','北京','2017-04-07 10:54:56',NULL,1,NULL,23),('f262087810754d6bbee5bad43b67adcf','杭州海俊','杭州','2017-04-07 10:54:46',NULL,1,NULL,20);
/*!40000 ALTER TABLE `yt_cooperative_main` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yt_money_flow`
--

DROP TABLE IF EXISTS `yt_money_flow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_money_flow` (
  `id` varchar(64) NOT NULL,
  `car_loan_id` varchar(64) DEFAULT NULL COMMENT '业务id',
  `task_name` varchar(30) DEFAULT NULL,
  `u_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `from_account` varchar(30) DEFAULT NULL COMMENT '放款账户',
  `from_account_name` varchar(30) DEFAULT NULL COMMENT '放款账户名称',
  `from_account_bank_name` varchar(30) DEFAULT NULL COMMENT '放款账户开户行',
  `to_account` varchar(30) DEFAULT NULL COMMENT '收款账户',
  `to_account_name` varchar(30) DEFAULT NULL COMMENT '收款账户名称',
  `to_account_bank_name` varchar(30) DEFAULT NULL COMMENT '收款账户开户行',
  `money` double DEFAULT NULL COMMENT '金额',
  `add_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yt_money_flow`
--

LOCK TABLES `yt_money_flow` WRITE;
/*!40000 ALTER TABLE `yt_money_flow` DISABLE KEYS */;
INSERT INTO `yt_money_flow` VALUES ('1e2cfd625db540d08bf5c61f63e7a032','BJYF_001_BJSHQ_1491962355830','垫付账户放款',73,'0200200409200031094','北京睿博盈通网络科技有限公司','工商银行','91140154800009035','中嵩众筹（北京）资本管理有限公司','浦发银行',12312,'2017-04-12 10:04:41'),('2522717db7864417a1f37cfed3930944','QDFGS_001_QDSHQ_1491873753448','退还保证金',73,'0200200409200031094','北京睿博盈通网络科技有限公司','工商银行','698336542','青岛梓杉汇金资产管理有限公司','民生银行',16500,'2017-04-11 11:51:07'),('2bc610a162a04d6b8aef4b3bf23a3443','QDFGS_001_QDSHQ_1491873753448','缴纳保证金',72,'698336542','青岛梓杉汇金资产管理有限公司','民生银行','0200200409200031094','北京睿博盈通网络科技有限公司','工商银行',16500,'2017-04-11 11:29:29'),('2f271a911db54275b01407c428776ec2','QDFGS_001_QDSHQ_1491809618480','借款账户放款',73,'110914458510301','北京睿博盈通网络科技有限公司','招商银行','698336542','青岛梓杉汇金资产管理有限公司','民生银行',22000,'2017-04-10 16:27:32'),('3931b7a74a0a416e99e03c94ef59787e','BJYF_001_BJSHQ_1491962869885','垫付账户放款',73,'11015201778006','众和胜（天津）资产管理有限公司','平安银行','91140154800009035','中嵩众筹（北京）资本管理有限公司','浦发银行',400000,'2017-04-12 10:27:38'),('399e0b89313f463ea25458977053016e','BJYF_001_BJSHQ_1491962869885','退还保证金',73,'0200200409200031094','北京睿博盈通网络科技有限公司','工商银行','91140154800009035','中嵩众筹（北京）资本管理有限公司','浦发银行',20000,'2017-04-12 10:50:04'),('5a5e8b743fb445c3a8e7b9d49c5c1eb7','QDFGS_001_QDSHQ_1491873753448','供应商还款',72,'698336542','青岛梓杉汇金资产管理有限公司','民生银行','110914458510301','北京睿博盈通网络科技有限公司','招商银行',12234.74,'2017-04-11 11:50:06'),('65982dd7e36741bc860f53d6b0652dd7','BJYF_001_BJSHQ_1491962869885','缴纳保证金',79,'91140154800009035','中嵩众筹（北京）资本管理有限公司','浦发银行','0200200409200031094','北京睿博盈通网络科技有限公司','工商银行',20000,'2017-04-12 10:37:29'),('766cd43427024ad2bce6280ef1ec2715','QDFGS_001_QDSHQ_1491873753448','借款账户放款',73,'110914458510301','北京睿博盈通网络科技有限公司','招商银行','698336542','青岛梓杉汇金资产管理有限公司','民生银行',12000,'2017-04-11 10:50:29'),('93850d23a7a847cabd313ae5653966e4','BJYF_001_BJSHQ_1491962869885','供应商还款',79,'91140154800009035','中嵩众筹（北京）资本管理有限公司','浦发银行','11015201778006','众和胜（天津）资产管理有限公司','平安银行',410000,'2017-04-12 10:46:15'),('9dd479852d5c4136bad78793be180332','QDFGS_001_QDSHQ_1491873753448','供应商还款',72,'698336542','青岛梓杉汇金资产管理有限公司','民生银行','11015201778006','众和胜（天津）资产管理有限公司','平安银行',318000,'2017-04-11 11:50:06'),('a678bc4d1bed49658e520460992326be','QDFGS_001_QDSHQ_1491873753448','垫付账户放款',73,'11015201778006','众和胜（天津）资产管理有限公司','平安银行','698336542','青岛梓杉汇金资产管理有限公司','民生银行',330000,'2017-04-11 10:23:12'),('ae92ef63461b417e9e0f5c2d15f9f188','QDFGS_001_QDSHQ_1491873753448','供应商还款',72,'698336542','青岛梓杉汇金资产管理有限公司','民生银行','12050161540000000150','众和胜（天津）资产管理有限公司','建设银行',9529.64,'2017-04-11 11:50:06'),('c30c66ca08f84af0a2a133cc0686d875','QDFGS_001_QDSHQ_1491809618480','供应商还款',72,'698336542','青岛梓杉汇金资产管理有限公司','民生银行','12050161540000000150','众和胜（天津）资产管理有限公司','建设银行',2814.19,'2017-04-10 17:37:53'),('d299043c85bb47479df02f8315a3c521','QDFGS_001_QDSHQ_1491809618480','归还垫付款',72,'698336542','青岛梓杉汇金资产管理有限公司','民生银行','11015201778006','众和胜（天津）资产管理有限公司','平安银行',22000,'2017-04-10 16:33:16'),('d7f7d9e9d5c94c4cb77fef319ae52c86','QDFGS_001_QDSHQ_1491873753448','归还垫付款',72,'698336542','青岛梓杉汇金资产管理有限公司','民生银行','11015201778006','众和胜（天津）资产管理有限公司','平安银行',12000,'2017-04-11 11:27:07'),('d9e62e4c24dd43388c5dbd699c0c9210','QDFGS_001_QDSHQ_1491809618480','退还保证金',73,'0200200409200031094','北京睿博盈通网络科技有限公司','工商银行','698336542','青岛梓杉汇金资产管理有限公司','民生银行',5500,'2017-04-10 17:46:19'),('dd46adf7cc3344e69f7edf3c3f9877ff','QDFGS_001_QDSHQ_1491809618480','供应商还款',72,'698336542','青岛梓杉汇金资产管理有限公司','民生银行','110914458510301','北京睿博盈通网络科技有限公司','招商银行',22440.6,'2017-04-10 17:37:53'),('f28cc73a951941d7aadc5f00acf85093','QDFGS_001_QDSHQ_1491809618480','垫付账户放款',73,'11015201778006','众和胜（天津）资产管理有限公司','平安银行','698336542','青岛梓杉汇金资产管理有限公司','民生银行',110000,'2017-04-10 15:55:49'),('f39e262573fd45adbe6cbcb64ed79de9','QDFGS_001_QDSHQ_1491809618480','缴纳保证金',72,'698336542','青岛梓杉汇金资产管理有限公司','民生银行','0200200409200031094','北京睿博盈通网络科技有限公司','工商银行',5500,'2017-04-10 16:37:04'),('f6a5181fd51146c69189c8e4c3e400a7','QDFGS_001_QDSHQ_1491809618480','供应商还款',72,'698336542','青岛梓杉汇金资产管理有限公司','民生银行','11015201778006','众和胜（天津）资产管理有限公司','平安银行',88000,'2017-04-10 17:37:53');
/*!40000 ALTER TABLE `yt_money_flow` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-15 10:48:56
