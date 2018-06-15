package com.mrbt.yeston.echoTest;

import java.util.Date;

import org.apache.commons.configuration.ConfigurationException;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.JsonObject;
import com.mrbt.yeston.web.echo.base.ApiQueryClient;
import com.mrbt.yeston.web.echo.util.ApiRestTemplate;
import com.mrbt.yeston.web.utils.JsonFormatTool;

/**
 * 
 * @author Derek Zhu
 *
 */
public class EchoQueryApiClient extends ApiQueryClient {

	/**
	 * @param args
	 * @throws ConfigurationException
	 */
	public static void main(final String[] args) throws ConfigurationException {

		try {
			JSONObject data = new JSONObject();

			final JSONObject params = new JSONObject();

			final String name = "朱培培";
			final String idNo = "320305198905040963";
			params.put("name", name);
			params.put("idNo", idNo);
			params.put("queryReason", "10");
			
			data = ApiRestTemplate.sendRecv("101", params);
//			data = JSONObject.parseObject("{\"message\":\"success\",\"tx\":\"102\",\"data\":{\"riskResults\":[],\"zcCreditScore\":\"450\",\"queryStatistics\":{\"timesByOtherOrg\":10,\"otherOrgCount\":10,\"timesByCurrentOrg\":0},\"contractBreakRate\":\"40.00%\",\"queryHistory\":[{\"orgType\":\"P2P\",\"time\":\"2017-06-22\",\"orgName\":\"其他机构3\",\"queryReason\":\"10\"},{\"orgType\":\"P2P\",\"time\":\"2017-06-13\",\"orgName\":\"其他机构5\",\"queryReason\":\"10\"},{\"orgType\":\"P2P\",\"time\":\"2017-06-12\",\"orgName\":\"其他机构7\",\"queryReason\":\"10\"},{\"orgType\":\"非持牌消金-小额现金贷\",\"time\":\"2017-06-06\",\"orgName\":\"其他机构2\",\"queryReason\":\"10\"},{\"orgType\":\"非持牌消金-消费分期\",\"time\":\"2017-05-26\",\"orgName\":\"其他机构1\",\"queryReason\":\"10\"},{\"orgType\":\"非持牌消金\",\"time\":\"2017-04-19\",\"orgName\":\"其他机构10\",\"queryReason\":\"10\"},{\"orgType\":\"P2P\",\"time\":\"2017-04-19\",\"orgName\":\"其他机构6\",\"queryReason\":\"10\"},{\"orgType\":\"P2P\",\"time\":\"2017-04-10\",\"orgName\":\"其他机构9\",\"queryReason\":\"10\"},{\"orgType\":\"P2P\",\"time\":\"2017-03-31\",\"orgName\":\"其他机构8\",\"queryReason\":\"10\"},{\"orgType\":\"非持牌消金-小额现金贷\",\"time\":\"2017-03-30\",\"orgName\":\"其他机构4\",\"queryReason\":\"10\"}],\"flowId\":\"088b8ed8e80245ce944251bad39158ff\",\"loanRecords\":[{\"periods\":\"1\",\"loanAmount\":\"(0,1000]\",\"overdueM3\":\"\",\"overdueM6\":\"\",\"orgName\":\"86\",\"loanStatusCode\":\"\",\"overdueStatus\":\"\",\"overdueTotal\":\"\",\"name\":\"朱培培\",\"certNo\":\"320305198905040963\",\"loanDate\":\"201610\",\"overdueAmount\":\"\",\"approvalStatusCode\":\"203\",\"loanTypeCode\":\"21\"},{\"periods\":\"1\",\"loanAmount\":\"(0,1000]\",\"overdueM3\":\"\",\"overdueM6\":\"\",\"orgName\":\"86\",\"loanStatusCode\":\"\",\"overdueStatus\":\"\",\"overdueTotal\":\"\",\"name\":\"朱培培\",\"certNo\":\"320305198905040963\",\"loanDate\":\"201608\",\"overdueAmount\":\"\",\"approvalStatusCode\":\"204\",\"loanTypeCode\":\"21\"},{\"periods\":\"1\",\"loanAmount\":\"(0,1000]\",\"overdueM3\":\"\",\"overdueM6\":\"\",\"orgName\":\"86\",\"loanStatusCode\":\"\",\"overdueStatus\":\"\",\"overdueTotal\":\"\",\"name\":\"朱培培\",\"certNo\":\"320305198905040963\",\"loanDate\":\"201605\",\"overdueAmount\":\"\",\"approvalStatusCode\":\"203\",\"loanTypeCode\":\"21\"},{\"periods\":\"1\",\"loanAmount\":\"(0,1000]\",\"overdueM3\":\"\",\"overdueM6\":\"\",\"orgName\":\"86\",\"loanStatusCode\":\"\",\"overdueStatus\":\"\",\"overdueTotal\":\"\",\"name\":\"朱培培\",\"certNo\":\"320305198905040963\",\"loanDate\":\"201604\",\"overdueAmount\":\"\",\"approvalStatusCode\":\"203\",\"loanTypeCode\":\"21\"},{\"periods\":\"1\",\"loanAmount\":\"(0,1000]\",\"overdueM3\":\"\",\"overdueM6\":\"\",\"orgName\":\"86\",\"loanStatusCode\":\"\",\"overdueStatus\":\"\",\"overdueTotal\":\"\",\"name\":\"朱培培\",\"certNo\":\"320305198905040963\",\"loanDate\":\"201604\",\"overdueAmount\":\"\",\"approvalStatusCode\":\"204\",\"loanTypeCode\":\"21\"}]},\"errorCode\":0}");
			System.out.println(data);
			showData(data);
			
		} catch (final Exception e) {
			e.printStackTrace(); 
		}
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




	public static String formatDuring(final long mss) {
		final long days = mss / (1000 * 60 * 60 * 24);
		final long hours = (mss % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60);
		final long minutes = (mss % (1000 * 60 * 60)) / (1000 * 60);
		final long seconds = (mss % (1000 * 60)) / 1000;
		return days + " days " + hours + " hours " + minutes + " minutes " + seconds + " seconds ";
	}
}
