package com.mrbt.yeston.test;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring-config.xml"})
public class BaseJunit4Test {
	
	@Autowired
	private MongoTemplate mongoTemplate;

	
	@Test // 标明是测试方法
	@Transactional // 标明此方法需使用事务
	@Rollback(false) // 标明使用完此方法后事务不回滚,true时为回滚
	public void insert() {
		System.out.println(mongoTemplate.count(new Query(), "data_syn_wenying_flowdb"));
	}
	
	private static void showData(JSONObject data) {
		System.out.println(data.get("data"));
		System.out.println("错误码:" + data.getString("errorCode"));
		System.out.println("错误信息:" + data.getString("message"));
		System.out.println("业务类型编号:" + data.getString("tx"));
		System.out.println("数据data：" + data.getString("data"));
		
		//data节点位置
		JSONObject info = data.getJSONObject("data");
		System.out.println("-----------------------------------------------------");
		System.out.println("流水号:" + info.getString("flowId"));
		System.out.println("致诚信用分:" + info.getString("zcCreditScore"));
		System.out.println("违约概率:" + info.getString("contractBreakRate"));
		
		System.out.println("-----------------------------------------------------");
		System.out.println("被查询统计:" + info.getString("queryStatistics"));
		JSONObject queryStatistics = info.getJSONObject("queryStatistics");
		System.out.println("其他机构查询次数:" + queryStatistics.getString("timesByOtherOrg"));
		System.out.println("其他查询机构数:" + queryStatistics.getString("otherOrgCount"));
		System.out.println("本机构查询次数:" + queryStatistics.getString("timesByCurrentOrg"));
		
		System.out.println("-----------------------------------------------------");
		System.out.println("被查询历史:" + info.getString("queryHistory"));
		JSONArray queryHistory = info.getJSONArray("queryHistory");
		for (int i = 0; i < queryHistory.size(); i++) {
			JSONObject jsonQh = queryHistory.getJSONObject(i);
			System.out.println("机构代号:" + jsonQh.getString("orgType"));
			System.out.println("查询时间:" + jsonQh.getString("time"));
			System.out.println("机构类型:" + jsonQh.getString("orgName"));
			System.out.println("查询原因:" + jsonQh.getString("queryReason"));
		}
		
		System.out.println("-----------------------------------------------------");
		System.out.println("借款记录历史:" + info.getString("loanRecords"));
		JSONArray loanRecords = info.getJSONArray("loanRecords");
		for (int i = 0; i < loanRecords.size(); i++) {
			JSONObject jsonLr = loanRecords.getJSONObject(i);
			System.out.println("提供数据的机构代号:" + jsonLr.getString("orgName"));
			System.out.println("被查询借款人姓名:" + jsonLr.getString("name"));
			System.out.println("被查询借款人身份证号:" + jsonLr.getString("certNo"));
			System.out.println("借款时间:" + jsonLr.getString("loanDate"));
			System.out.println("期数:" + jsonLr.getString("periods"));
			System.out.println("借款金额:" + jsonLr.getString("loanAmount"));
			System.out.println("审批结果码:" + jsonLr.getString("approvalStatusCode"));
			System.out.println("还款状态码:" + jsonLr.getString("loanStatusCode"));
			System.out.println("借款类型码:" + jsonLr.getString("loanTypeCode"));
			System.out.println("逾期金额:" + jsonLr.getString("overdueAmount"));
			System.out.println("逾期情况:" + jsonLr.getString("overdueStatus"));
			System.out.println("历史逾期总次数:" + jsonLr.getString("overdueTotal"));
			System.out.println("历史逾期M3+次数(不包含M3,包括M6及以上):" + jsonLr.getString("overdueM3"));
			System.out.println("历史逾期M6+次数(不包含M6):" + jsonLr.getString("overdueM6"));
		}
		
		
		System.out.println("-----------------------------------------------------");
		System.out.println("风险项记录:" + info.getString("riskResults"));
		JSONArray riskResults = info.getJSONArray("riskResults");
		for (int i = 0; i < riskResults.size(); i++) {
			JSONObject jsonLr = loanRecords.getJSONObject(i);
			System.out.println("提供数据的机构代号:" + jsonLr.getString("orgName"));
			System.out.println("命中项码:" + jsonLr.getString("riskItemTypeCode"));
			System.out.println("命中内容:" + jsonLr.getString("riskItemValue"));
			System.out.println("风险类型码:" + jsonLr.getString("riskTypeCode"));
			System.out.println("风险明细:" + jsonLr.getString("riskDetail"));
			System.out.println("风险最近时间:" + jsonLr.getString("riskTime"));
		}
	}
	
}
