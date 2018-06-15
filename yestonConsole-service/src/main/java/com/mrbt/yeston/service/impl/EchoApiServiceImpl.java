package com.mrbt.yeston.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.service.EchoApiService;
import com.mrbt.yeston.web.echo.DO.MortgagorData;
import com.mrbt.yeston.web.echo.DO.MortgagorDataVo;
import com.mrbt.yeston.web.echo.DO.PersonalCreditHistory;
import com.mrbt.yeston.web.echo.DO.PersonalCreditHistory2;
import com.mrbt.yeston.web.echo.DO.PersonalInfo;
import com.mrbt.yeston.web.echo.DO.RiskRecord;
import com.mrbt.yeston.web.echo.util.ApiRestTemplate;
import com.mrbt.yeston.web.utils.DateUtils;

import net.sf.ehcache.config.Configuration.Monitoring;

@Service
public class EchoApiServiceImpl implements EchoApiService {

	@Autowired
	private MongoTemplate mongoTemplate;

	@Override
	public JSONObject queryPersionalInfo(String name, String idNo, String queryReason) {
		
		JSONObject data = new JSONObject();

		final JSONObject params = new JSONObject();

		params.put("name", name);
		params.put("idNo", idNo);
		params.put("queryReason", queryReason);

		try {
			data = ApiRestTemplate.sendRecv("101", params);
//			data = JSONObject.parseObject("{\"message\":\"success\",\"tx\":\"102\",\"data\":{\"riskResults\":[],\"zcCreditScore\":\"450\",\"queryStatistics\":{\"timesByOtherOrg\":10,\"otherOrgCount\":10,\"timesByCurrentOrg\":0},\"contractBreakRate\":\"40.00%\",\"queryHistory\":[{\"orgType\":\"P2P\",\"time\":\"2017-06-22\",\"orgName\":\"其他机构3\",\"queryReason\":\"10\"},{\"orgType\":\"P2P\",\"time\":\"2017-06-13\",\"orgName\":\"其他机构5\",\"queryReason\":\"10\"},{\"orgType\":\"P2P\",\"time\":\"2017-06-12\",\"orgName\":\"其他机构7\",\"queryReason\":\"10\"},{\"orgType\":\"非持牌消金-小额现金贷\",\"time\":\"2017-06-06\",\"orgName\":\"其他机构2\",\"queryReason\":\"10\"},{\"orgType\":\"非持牌消金-消费分期\",\"time\":\"2017-05-26\",\"orgName\":\"其他机构1\",\"queryReason\":\"10\"},{\"orgType\":\"非持牌消金\",\"time\":\"2017-04-19\",\"orgName\":\"其他机构10\",\"queryReason\":\"10\"},{\"orgType\":\"P2P\",\"time\":\"2017-04-19\",\"orgName\":\"其他机构6\",\"queryReason\":\"10\"},{\"orgType\":\"P2P\",\"time\":\"2017-04-10\",\"orgName\":\"其他机构9\",\"queryReason\":\"10\"},{\"orgType\":\"P2P\",\"time\":\"2017-03-31\",\"orgName\":\"其他机构8\",\"queryReason\":\"10\"},{\"orgType\":\"非持牌消金-小额现金贷\",\"time\":\"2017-03-30\",\"orgName\":\"其他机构4\",\"queryReason\":\"10\"}],\"flowId\":\"088b8ed8e80245ce944251bad39158ff\",\"loanRecords\":[{\"periods\":\"1\",\"loanAmount\":\"(0,1000]\",\"overdueM3\":\"\",\"overdueM6\":\"\",\"orgName\":\"86\",\"loanStatusCode\":\"\",\"overdueStatus\":\"\",\"overdueTotal\":\"\",\"name\":\"朱培培\",\"certNo\":\"320305198905040963\",\"loanDate\":\"201610\",\"overdueAmount\":\"\",\"approvalStatusCode\":\"203\",\"loanTypeCode\":\"21\"},{\"periods\":\"1\",\"loanAmount\":\"(0,1000]\",\"overdueM3\":\"\",\"overdueM6\":\"\",\"orgName\":\"86\",\"loanStatusCode\":\"\",\"overdueStatus\":\"\",\"overdueTotal\":\"\",\"name\":\"朱培培\",\"certNo\":\"320305198905040963\",\"loanDate\":\"201608\",\"overdueAmount\":\"\",\"approvalStatusCode\":\"204\",\"loanTypeCode\":\"21\"},{\"periods\":\"1\",\"loanAmount\":\"(0,1000]\",\"overdueM3\":\"\",\"overdueM6\":\"\",\"orgName\":\"86\",\"loanStatusCode\":\"\",\"overdueStatus\":\"\",\"overdueTotal\":\"\",\"name\":\"朱培培\",\"certNo\":\"320305198905040963\",\"loanDate\":\"201605\",\"overdueAmount\":\"\",\"approvalStatusCode\":\"203\",\"loanTypeCode\":\"21\"},{\"periods\":\"1\",\"loanAmount\":\"(0,1000]\",\"overdueM3\":\"\",\"overdueM6\":\"\",\"orgName\":\"86\",\"loanStatusCode\":\"\",\"overdueStatus\":\"\",\"overdueTotal\":\"\",\"name\":\"朱培培\",\"certNo\":\"320305198905040963\",\"loanDate\":\"201604\",\"overdueAmount\":\"\",\"approvalStatusCode\":\"203\",\"loanTypeCode\":\"21\"},{\"periods\":\"1\",\"loanAmount\":\"(0,1000]\",\"overdueM3\":\"\",\"overdueM6\":\"\",\"orgName\":\"86\",\"loanStatusCode\":\"\",\"overdueStatus\":\"\",\"overdueTotal\":\"\",\"name\":\"朱培培\",\"certNo\":\"320305198905040963\",\"loanDate\":\"201604\",\"overdueAmount\":\"\",\"approvalStatusCode\":\"204\",\"loanTypeCode\":\"21\"}]},\"errorCode\":0}");
			
			//保存查询的信息    {"errorCode":"4009","message":"用户调用参数不正确"}
			if(!data.getString("errorCode").equals("4009")){
				Criteria cri = Criteria.where("persional_name").is(name).and("id_no").is(idNo);
				List<PersonalInfo> resList = mongoTemplate.find(new Query(cri), PersonalInfo.class);
				if (resList == null || resList.size() == 0) {
					PersonalInfo pi = new PersonalInfo();
					pi.setId_no(idNo);
					pi.setPersional_name(name);
					pi.setCreate_time(DateUtils.getDateTimeStr());
					pi.setLast_query_time(DateUtils.getDateTimeStr());
					pi.setShare(0);
					mongoTemplate.save(pi);
				}else{
					Update update = Update.update("last_query_time", DateUtils.getDateTimeStr());
					mongoTemplate.updateMulti(new Query(cri), update, PersonalInfo.class);
				}
				
				//保存查询历史数据
				PersonalCreditHistory pch = new PersonalCreditHistory();
				pch.setPersonal_name(name);
				pch.setId_no(idNo);
				pch.setQuery_time(DateUtils.getDateTimeStr());
				pch.setErrorCode(data.getString("errorCode"));
				pch.setMessage(data.getString("message"));
				pch.setData_info(data.toString());
				pch.setSource_code(1);
				pch.setSource_info("阿福共享平台");
				
				if(data.getString("errorCode").equals("0")){
					pch.setTx(data.getString("tx"));
					
					JSONObject info = data.getJSONObject("data");
					
					pch.setFlow_id(info.getString("flowId"));
					pch.setZcCreditScore(info.getString("zcCreditScore"));
					pch.setContractBreakRate(info.getString("contractBreakRate"));
					pch.setQueryStatistics(info.getString("queryStatistics"));
					pch.setQueryHistory(info.getString("queryHistory"));
					
					//写入借款记录表
					insertMortgagorData(info.getString("loanRecords"), info.getString("riskResults"), name, idNo);
				}
				
				mongoTemplate.save(pch);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	
	/**
	 * 实时查询数据，写入借款人记录
	 * @param idNo 
	 * @param name 
	 * @param string
	 * @param string2
	 */
	private void insertMortgagorData(String loanRecords, String riskResults, String name, String idNo) {
		
		//用身份证+姓名查询借款记录
		Criteria criQ = Criteria.where("certNo").is(idNo).and("name").is(name);
		List<MortgagorData> queryMortg = mongoTemplate.find(new Query(criQ), MortgagorData.class);

		//用身份证号+姓名+借款日期做KEY写入到MAP中，用于不写入重复数据
		Map<String, Object> resMap = new HashMap<String, Object>();
		for (int i = 0; i < queryMortg.size(); i++) {
			MortgagorData md = queryMortg.get(i);
			resMap.put(md.getCertNo() + md.getName() + md.getLoanDate(), "");
		}
		
		JSONArray jsona = JSONObject.parseArray(loanRecords);
		List<MortgagorData> mortList = new ArrayList<MortgagorData>();
		for (int i = 0; i < jsona.size(); i++) {
			JSONObject json = jsona.getJSONObject(i);
			
			String key = json.getString("certNo") + json.getString("name") + json.getString("loanDate");
			if(resMap.containsKey(key)){
				continue;
			}
			
			MortgagorData md = new MortgagorData();
			
			md.setApprovalStatusCode(json.getString("approvalStatusCode"));
			md.setCertNo(json.getString("certNo"));
			md.setDataCome(1);
			md.setLoanAmount(json.getString("loanAmount"));
			md.setLoanDate(json.getString("loanDate"));
			md.setLoanStatusCode(json.getString("loanStatusCode"));
			md.setLoanTypeCode(json.getString("loanTypeCode"));
			md.setName(json.getString("name"));
			md.setOverdueAmount(json.getString("overdueAmount"));
			md.setOverdueM3(json.getString("overdueM3"));
			md.setOverdueM6(json.getString("overdueM6"));
			md.setOverdueStatus(json.getString("overdueStatus"));
			md.setOverdueTotal(json.getString("overdueTotal"));
			md.setPeriods(json.getInteger("periods"));
			md.setDataCome(1);
			mortList.add(md);
		}
		mongoTemplate.insertAll(mortList);
		
		//写入风险项记录
		//用身份证+姓名查询借款记录
		Criteria crir = Criteria.where("certNo").is(idNo).and("name").is(name);
		List<RiskRecord> queryRisk = mongoTemplate.find(new Query(crir), RiskRecord.class);
		
		//用身份证号+姓名+借款日期做KEY写入到MAP中，用于不写入重复数据
		Map<String, Object> resMapr = new HashMap<String, Object>();
		for (int i = 0; i < resMapr.size(); i++) {
			RiskRecord risk = queryRisk.get(i);
			resMapr.put(risk.getCertNo() + risk.getName() + risk.getRiskDetail(), "");
		}
		
		JSONArray jsonar = JSONObject.parseArray(riskResults);
		List<RiskRecord> riskList = new ArrayList<RiskRecord>();
		for (int i = 0; i < jsonar.size(); i++) {
			JSONObject json = jsonar.getJSONObject(i);
			
			String key = json.getString("certNo") + json.getString("name") + json.getString("riskDetail");
			if(resMapr.containsKey(key)){
				continue;
			}
			
			RiskRecord risk = new RiskRecord();
			risk.setName(name);
			risk.setCertNo(idNo);
			risk.setRiskDetail(json.getString("riskDetail"));
			risk.setRiskItemTypeCode(json.getString("riskItemTypeCode"));
			risk.setRiskItemValue(json.getString("riskItemValue"));
			risk.setRiskTime(json.getString("riskTime"));
			risk.setDataCome(1);
			riskList.add(risk);
		}
		mongoTemplate.insertAll(riskList);
	}

	public static String formatDuring(final long mss) {
		final long days = mss / (1000 * 60 * 60 * 24);
		final long hours = (mss % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60);
		final long minutes = (mss % (1000 * 60 * 60)) / (1000 * 60);
		final long seconds = (mss % (1000 * 60)) / 1000;
		return days + " days " + hours + " hours " + minutes + " minutes " + seconds + " seconds ";
	}

	@Override
	public JSONObject shareUploadIdNo(String idNo) {
		JSONObject data = new JSONObject();
		try {
			final JSONObject params = new JSONObject();
			final ArrayList<String> jsona = new ArrayList<String>();
			
			String[] idNos = idNo.split(",");
			for (int i = 0; i < idNos.length; i++) {
				jsona.add(idNos[i]);
				params.put("idNos", jsona);
			}
			
			Criteria cri = Criteria.where("id_no").in(jsona);
				
			List<PersonalInfo> resList = mongoTemplate.find(new Query(cri), PersonalInfo.class);
			for (int i = 0; i < resList.size(); i++) {
				PersonalInfo resPi = resList.get(i);
				if(resPi.getShare() == 1){
					data.put("code", 303);
					data.put("msg", "有已分享的数据");
					return data;
				}
			}

			data = ApiRestTemplate.sendRecv("301", params);
			
			if(data.get("errorCode").equals(0)){
				mongoTemplate.updateMulti(new Query(cri), new Update().set("share", 1), PersonalInfo.class);
				data.put("code", 200);
				data.put("msg", "分享到平台成功");
			}
//			uploadResData(data);
		} catch (final Exception e) {
			e.printStackTrace();
			data.put("code", 500);
			data.put("msg", "服务器错误");
		}
		return data;
	}
	
	public static void uploadResData(JSONObject data) {
		System.out.println("业务类型编号:" + data.getString("tx"));
		System.out.println("错误码:" + data.getString("errorCode"));
		System.out.println("错误信息:" + data.getString("message"));
		
		JSONObject dataJson = data.getJSONObject("data");
		
		System.out.println("总上传的证件号码数:" + dataJson.getString("totalUploadCount"));
		System.out.println("实际上传的号码数:" + dataJson.getString("uploadedIdNoCount"));
		System.out.println("无效的证件号码数:" + dataJson.getString("invalidIdNoCount"));
		System.out.println("无效的证件号:" + dataJson.getString("invalidIdNos"));
		System.out.println("已存在的证件号码数:" + dataJson.getString("existingIdNoCount"));
		System.out.println("已存在的证件号码:" + dataJson.getString("existingIdNos"));
		System.out.println("获取的积分:" + dataJson.getString("pointsGot"));
	}

	@Override
	public Object findDataGrid(Integer page, Integer rows, String name, String idNo) {
		PageInfo<PersonalInfo> pageInfo = new PageInfo<>(page, rows);
		
		Query query = new Query();
		if(name != null && !name.equals("")){
			query.addCriteria(Criteria.where("persional_name").is(name));
		}
		
		if(idNo != null && !idNo.equals("")){
			query.addCriteria(Criteria.where("id_no").is(idNo));
		}
		
		query.with(new Sort(Direction.DESC, "create_time"));
		query.skip(pageInfo.getFrom());
		query.limit(pageInfo.getSize());

		long total = mongoTemplate.count(query, PersonalInfo.class);
		List<PersonalInfo> perInfoList = mongoTemplate.find(query, PersonalInfo.class);

		pageInfo.setTotal((int) total);
		pageInfo.setRows(perInfoList);

		return pageInfo;
	}

	@Override
	public JSONObject queryHistory(String idNo) {
		JSONObject resJson = new JSONObject();
		
		Criteria cri1 = Criteria.where("id_no").is(idNo);
		Query query1 = new Query(cri1);
		query1.with(new Sort(Direction.DESC, "query_time"));
		List<PersonalCreditHistory2> pchList = mongoTemplate.find(query1, PersonalCreditHistory2.class);
		
		resJson.put("personalCreditHistory", pchList);
		
		Criteria cri2 = Criteria.where("certNo").is(idNo);
		Query query2 = new Query(cri2);
		query2.with(new Sort(Direction.DESC, "loanDate"));
		List<MortgagorData> mortList = mongoTemplate.find(query2, MortgagorData.class);
		resJson.put("mortgagorData", mortList);
		
		List<RiskRecord> riskList = mongoTemplate.find(query2, RiskRecord.class);
		resJson.put("riskList", riskList);
		
		return resJson;
	}

	@Override
	public JSONObject echomComeQuery(JSONObject resjson) {
		JSONObject resJson = new JSONObject();
		
		//解密请求数据
		JSONObject desJson = ApiRestTemplate.descEchoComeData(resjson);
		JSONObject dataJson = desJson.getJSONObject("data");
		String idNo = dataJson.getString("idNo");
		String name = dataJson.getString("name");
		
		//通过姓名和身份证号查询数据
		Criteria cri = Criteria.where("certNo").is(idNo).and("name").is(name).and("dataCome").is(0);
		Query query = new Query(cri);
		
		List<MortgagorData> mortList = mongoTemplate.find(query, MortgagorData.class);
		
		//定义返回json的data部分
		JSONObject resDJson = new JSONObject();
		
		if(mortList != null && mortList.size() >0){
			JSONArray loanRecords = new JSONArray();
			JSONArray riskResults = new JSONArray();
			for (int i = 0; i < mortList.size(); i++) {
				MortgagorData md = mortList.get(i);
				JSONObject lr = new JSONObject();
				lr.put("name", md.getName());
				lr.put("certNo", md.getCertNo());
				lr.put("loanDate", md.getLoanDate());
				lr.put("periods", md.getPeriods());
				lr.put("loanAmount", md.getLoanAmount());
				lr.put("approvalStatusCode", md.getApprovalStatusCode());
				lr.put("loanStatusCode", md.getLoanStatusCode());
				lr.put("loanTypeCode", md.getLoanTypeCode());
				lr.put("overdueAmount", md.getOverdueAmount());
				lr.put("overdueStatus", md.getOverdueStatus());
				lr.put("overdueTotal", md.getOverdueTotal());
				lr.put("overdueM3", md.getOverdueM3());
				lr.put("overdueM6", md.getOverdueM6());
				
				loanRecords.add(lr);
			}
			
			//查询风险项
			List<RiskRecord> riskList = mongoTemplate.find(query, RiskRecord.class);
			for (int i = 0; i < riskList.size(); i++) {
				RiskRecord risk = riskList.get(i);
				JSONObject rr = new JSONObject();
				
				rr.put("riskItemTypeCode", risk.getRiskItemTypeCode());
				rr.put("riskItemValue", risk.getRiskItemValue());
				rr.put("riskDetail", risk.getRiskDetail());
				rr.put("riskTime", risk.getRiskTime());
				riskResults.add(rr);
			}
			
			resDJson.put("loanRecords", loanRecords);
			resDJson.put("riskResults", riskResults);
			resJson.put("errorCode", "0000");
			resJson.put("message", "查询成功");
		}else{
			//组成响应数据
			JSONArray loanRecords = new JSONArray();
			JSONArray riskResults = new JSONArray();
			resDJson.put("loanRecords", loanRecords);
			resDJson.put("riskResults", riskResults);
			resJson.put("errorCode", "0001");
			resJson.put("message", "查询成功无数据");
		}
		
		JSONObject params = new JSONObject();
		params.put("tx", "202");
		params.put("version", "v3");
		params.put("data", resDJson);
		
		//加密params数据
		String encParams = ApiRestTemplate.encResEchoData(params); 
		resJson.put("params", encParams);
		return resJson;
	}

	@Override
	public JSONObject saveAppendMortgagor(MortgagorDataVo mortDataVo) {
		JSONObject json = new JSONObject();
		
		//用身份证号，借款时间，期数，查询数据
		Criteria cri2 = Criteria.where("certNo").is(mortDataVo.getCertNo()).and("loanDate").is(mortDataVo.getLoanDate()).and("periods").is(mortDataVo.getPeriods());
		long mdCount = mongoTemplate.count(new Query(cri2), MortgagorData.class);
		
		if(mdCount > 0){
			json.put("code", 300);
			json.put("msg", "借款记录已经存在");
			return json;
		}
		
		Criteria criRisk = Criteria.where("certNo").is(mortDataVo.getCertNo()).and("riskDetail").is(mortDataVo.getRiskDetail());
		long riskCount = mongoTemplate.count(new Query(criRisk), RiskRecord.class);
		if(riskCount > 0){
			json.put("code", 300);
			json.put("msg", "风险记录已经存在");
			return json;
		}
		
		//拒贷一定有风险，有风险不一定是拒贷
		if(mortDataVo.getApprovalStatusCode().equals("203")){
			if(mortDataVo.getRiskDetail() == null || mortDataVo.getRiskDetail().equals("")){
				json.put("code", 300);
				json.put("msg", "拒贷必须填写风险原因");
				return json;
			}
		}
		
		try {
			//添加借款记录
			
			MortgagorData md = new MortgagorData();
			md.setOverdueStatus(mortDataVo.getOverdueStatus());
			md.setApprovalStatusCode(mortDataVo.getApprovalStatusCode());
			md.setCertNo(mortDataVo.getCertNo());
			md.setDataCome(0);
			md.setLoanAmount(mortDataVo.getLoanAmount());
			md.setLoanDate(mortDataVo.getLoanDate());
			md.setLoanStatusCode(mortDataVo.getLoanStatusCode());
			md.setLoanTypeCode(mortDataVo.getLoanTypeCode());
			md.setName(mortDataVo.getName());
			md.setOverdueAmount(mortDataVo.getOverdueAmount());
			md.setOverdueM3(mortDataVo.getOverdueM3());
			md.setOverdueM6(mortDataVo.getOverdueM6());
			md.setOverdueTotal(mortDataVo.getOverdueTotal());
			md.setPeriods(mortDataVo.getPeriods());
			
			mongoTemplate.save(md);
			
			//添加风险记录
			if(mortDataVo.getRiskDetail() != null && !mortDataVo.getRiskDetail().equals("")){
				RiskRecord risk = new RiskRecord();
				risk.setCertNo(mortDataVo.getCertNo());
				risk.setDataCome(0);
				risk.setName(mortDataVo.getName());
				risk.setRiskDetail(mortDataVo.getRiskDetail());
				risk.setRiskItemTypeCode(mortDataVo.getRiskItemTypeCode());
				risk.setRiskItemValue(mortDataVo.getRiskItemValue());
				risk.setRiskTime(mortDataVo.getRiskTime());
				mongoTemplate.save(risk);
			}
			
			//借款人记录,如果借款人信息不存在，添加借款人信息
			Criteria cri1 = Criteria.where("id_no").is(mortDataVo.getCertNo()).and("persional_name").is(mortDataVo.getName());
			System.out.println(new Query(cri1));
			long count = mongoTemplate.count(new Query(cri1), PersonalInfo.class);
			if(count == 0){
				PersonalInfo pi = new PersonalInfo();
				pi.setId_no(mortDataVo.getCertNo());
				pi.setPersional_name(mortDataVo.getName());
				pi.setCreate_time(DateUtils.getDateTimeStr());
				pi.setLast_query_time(DateUtils.getDateTimeStr());
				pi.setShare(0);
				mongoTemplate.save(pi);
			}
			
			json.put("code", 200);
			json.put("msg", "数据添加完成");
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			json.put("code", 500);
			json.put("msg", "服务器错误");
			return json;
		}
	}
}
