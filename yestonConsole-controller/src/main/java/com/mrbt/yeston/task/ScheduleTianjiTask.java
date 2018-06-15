package com.mrbt.yeston.task;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Component;

import com.mrbt.yeston.rong360.tianji.mongo.AgentrBlack;
import com.mrbt.yeston.rong360.tianji.mongo.BaiduBlack;
import com.mrbt.yeston.rong360.tianji.mongo.BairongIcredit;
import com.mrbt.yeston.rong360.tianji.mongo.FaceplusGetrandomnumber;
import com.mrbt.yeston.rong360.tianji.mongo.FaceplusValidatevideo;
import com.mrbt.yeston.rong360.tianji.mongo.FahaiDetailBlack;
import com.mrbt.yeston.rong360.tianji.mongo.FahaiKeywordSearch;
import com.mrbt.yeston.rong360.tianji.mongo.FahaiLawBlack;
import com.mrbt.yeston.rong360.tianji.mongo.JiaoPhoneConsumption;
import com.mrbt.yeston.rong360.tianji.mongo.JiaoPhoneNetWorkLength;
import com.mrbt.yeston.rong360.tianji.mongo.JiaoPhoneStatus;
import com.mrbt.yeston.rong360.tianji.mongo.JiguangPolicy;
import com.mrbt.yeston.rong360.tianji.mongo.KaolaBankcard;
import com.mrbt.yeston.rong360.tianji.mongo.PengyuanMobilecheck;
import com.mrbt.yeston.rong360.tianji.mongo.UmengScore;
import com.mrbt.yeston.rong360.tianji.mongo.XinyanBlack;
import com.mrbt.yeston.rong360.tianji.sample.DataInfo;
import com.mrbt.yeston.rong360.tianji.sample.OpenapiClient;
import com.mrbt.yeston.rong360.tianji.sample.TianjiSample;
import com.mrbt.yeston.rong360.tianji.utils.RSAUtils;
import com.mrbt.yeston.rong360.tianji.utils.RequestMethod;
import com.mrbt.yeston.rong360.tianji.utils.RequestUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/** 
 * @author  suyibo 
 * @date 创建时间：2018年3月8日
 */
@Component("scheduleTianjiTask")
public class ScheduleTianjiTask {

	@Autowired
	private MongoTemplate mongoTemplate;

	public static String appId = "1000339";// 需要使用方替换
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

	/**
	 * 获取查询数据
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	public void getMarkedInputstream() {
		// 获取dataInfo中状态为0的数据，进行360查询
		List<DataInfo> dataInfoList = mongoTemplate.find(new Query(Criteria.where("status").is(0)), DataInfo.class);
		if (!dataInfoList.isEmpty()) {
			for (DataInfo dataInfo : dataInfoList) {
				String methods = dataInfo.getMethod();
				if (StringUtils.isNotEmpty(methods)) {
					String[] method = methods.split(",");
					for (int i = 0; i < method.length; i++) {
						switch (method[i]) {
						case "tianji.api.rong360.sdk": // 融360抓取服务
							rong360SDK(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;
						case "tianji.api.baidu.blacklist": // 黑名单-百度
							baiduBlacklist(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;
						case "tianji.api.agentr.blacklist": // 黑名单-机构R
							agentrBlacklist(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;
						case "tianji.api.xinyan.blacklist": // 黑名单-新颜征信
							xinyanBlacklist(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;
						case "tianji.api.fahai.lawblacklist": // 灰名单-法海法律
							fahaiLawblacklist(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;
						case "tianji.api.fahai.blacklistdetail": // 灰名单-法海涉诉详情
							fahaiBlacklistdetail(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;
						case "tianji.api.fahai.keywordsearch": // 灰名单-法海法律（企业相关）
							fahaiKeywordsearch(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;
						case "tianji.api.faceplus.getrandomnumber": // FACE++-获取随机数-H5
							faceplusGetrandomnumber(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;
						case "tianji.api.faceplus.validatevideo": // FACE++-自拍视频的活体验证-H5
							faceplusValidatevideo(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone(), dataInfo.getVideo());
							break;
						case "tianji.api.kaola.bankcard4item": // 身份验证-考拉征信
							kaolaBankcard4item(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone(), dataInfo.getBankCard());
							break;
						case "tianji.api.pengyuan.mobilecheck3item": // 身份验证-机构c
							pengyuanMobilecheck3item(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;
						case "tianji.api.jiao.phonestatus": // 身份查询-机构k手机状态
							jiaoPhonestatus(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;
						case "tianji.api.jiao.phonenetworklength": // 身份查询-机构k手机号码在网时长
							jiaoPhonenetworklength(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;
						case "tianji.api.jiao.phoneconsumption": // 身份查询-机构k手机消费档次
							jiaoPhoneconsumption(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;
						case "tianji.api.bairong.icredit": // 外部信用报告-百融
							bairongIcredit(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;
						case "tianji.api.jiguang.policy": // 反欺诈报告-极光
							jiguangPolicy(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;
						case "tianji.api.umeng.score": // 特色报告-友盟+
							umengScore(dataInfo.getId(),method[i], dataInfo.getName(), dataInfo.getIdNumber(), dataInfo.getPhone());
							break;

						default:
							break;
						}
					}
				}
				mongoTemplate.upsert(new Query(Criteria.where("id").is(dataInfo.getId())),
						new Update().set("status", 1), DataInfo.class);
			}
		}

	}

	/**
	 * FACE++-自拍视频的活体验证-H5
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	private void faceplusValidatevideo(String id, String method, String name, String idNumber, String phone,
			String video) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<FaceplusValidatevideo> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), FaceplusValidatevideo.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();

			sample.setMethod(method);
			// 获取token_random_number参数
			List<FaceplusGetrandomnumber> faceplusGetrandomnumberList = mongoTemplate.find(new Query(
					Criteria.where("method").is("tianji.api.faceplus.getrandomnumber").and("idNumber").is(idNumber)),
					FaceplusGetrandomnumber.class);
			if (!faceplusGetrandomnumberList.isEmpty()) {
				sample.setField("token_random_number", faceplusGetrandomnumberList.get(0).getRandomNumber());
				try {
					JSONObject ret = sample.execute();
					if (ret.getInt("error") == 200) {
						JSONObject jsonObject = ret.getJSONObject("tianji_api_faceplus_validatevideo_response");
						if (!jsonObject.isEmpty()) {
							FaceplusValidatevideo faceplusValidatevideo = new FaceplusValidatevideo();
							faceplusValidatevideo.setName(name);
							faceplusValidatevideo.setIdNumber(idNumber);
							faceplusValidatevideo.setPhone(phone);
							faceplusValidatevideo.setMethod(method);
							faceplusValidatevideo.setVideo(video);
							faceplusValidatevideo
									.setMethodName(RequestMethod.ResultName.FACEPLUS_VALIDATEVIDEO.getName());
							faceplusValidatevideo.setImageBest(jsonObject.getString("image_best"));
							faceplusValidatevideo.setCreateDate(sdf.format(new Date()));
							faceplusValidatevideo.setDataInfoId(id);
							mongoTemplate.insert(faceplusValidatevideo);
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 * FACE++-获取随机数-H5
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	private void faceplusGetrandomnumber(String id, String method, String name, String idNumber, String phone) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<FaceplusGetrandomnumber> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), FaceplusGetrandomnumber.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();

			sample.setMethod(method);
			sample.setField("biz_data", "获取随机数");
			try {
				JSONObject ret = sample.execute();
				if (ret.getInt("error") == 200) {
					JSONObject jsonObject = ret.getJSONObject("tianji_api_faceplus_getrandomnumber_response");
					if (!jsonObject.isEmpty() && !jsonObject.getString("message").equals("测试暂时无数据")) {

						FaceplusGetrandomnumber faceplusGetrandomnumber = new FaceplusGetrandomnumber();
						faceplusGetrandomnumber.setName(name);
						faceplusGetrandomnumber.setIdNumber(idNumber);
						faceplusGetrandomnumber.setPhone(phone);
						faceplusGetrandomnumber.setMethod(method);
						faceplusGetrandomnumber
								.setMethodName(RequestMethod.ResultName.FACEPLUS_GETRANDOMNUMBER.getName());
						faceplusGetrandomnumber.setRandomNumber(jsonObject.getString("random_number"));
						faceplusGetrandomnumber.setCreateDate(sdf.format(new Date()));
						faceplusGetrandomnumber.setDataInfoId(id);
						mongoTemplate.insert(faceplusGetrandomnumber);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * 特色报告-友盟+
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	private void umengScore(String id, String method, String name, String idNumber, String phone) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<UmengScore> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), UmengScore.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();

			sample.setMethod(method);
			sample.setField("phone", phone);
			try {
				JSONObject ret = sample.execute();
				if (ret.getInt("error") == 200) {
					JSONObject jsonObject = ret.getJSONObject("tianji_api_umeng_score_response");
					if (!jsonObject.isEmpty() && !jsonObject.getString("message").equals("测试暂时无数据")) {

						UmengScore umengScore = new UmengScore();
						umengScore.setName(name);
						umengScore.setIdNumber(idNumber);
						umengScore.setPhone(phone);
						umengScore.setMethod(method);
						umengScore.setMethodName(RequestMethod.ResultName.UMENG_SCORE.getName());
						umengScore.setDevicePrice(jsonObject.getJSONObject("tags").getString("device_price"));
						umengScore.setCreditScore(jsonObject.getJSONObject("tags").getString("credit_score"));
						umengScore.setIdScore(jsonObject.getJSONObject("tags").getString("id_score"));
						umengScore.setDeviceBrand(jsonObject.getJSONObject("tags").getString("device_brand"));
						umengScore.setInterestScore(jsonObject.getJSONObject("tags").getString("interest_score"));
						umengScore.setLocationScore(jsonObject.getJSONObject("tags").getString("location_score"));
						umengScore.setDeviceRank(jsonObject.getJSONObject("tags").getString("device_rank"));
						umengScore.setDeviceOs(jsonObject.getJSONObject("tags").getString("device_os"));
						umengScore.setDeviceScore(jsonObject.getJSONObject("tags").getString("device_score"));
						umengScore.setAppScore(jsonObject.getJSONObject("tags").getString("app_score"));
						umengScore.setCreateDate(sdf.format(new Date()));
						umengScore.setDataInfoId(id);
						mongoTemplate.insert(umengScore);

					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * 反欺诈报告-极光
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	private void jiguangPolicy(String id, String method, String name, String idNumber, String phone) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<JiguangPolicy> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), JiguangPolicy.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();

			sample.setMethod(method);
			sample.setField("phone", phone);
			try {
				JSONObject ret = sample.execute();
				if (ret.getInt("error") == 200) {
					JSONObject jsonObject = ret.getJSONObject("tianji_api_jiguang_policy_response");
					if (!jsonObject.isEmpty()) {

						JiguangPolicy jiguangPolicy = new JiguangPolicy();
						jiguangPolicy.setName(name);
						jiguangPolicy.setIdNumber(idNumber);
						jiguangPolicy.setPhone(phone);
						jiguangPolicy.setMethod(method);
						jiguangPolicy.setMethodName(RequestMethod.ResultName.JIGUANG_POLICY.getName());
						jiguangPolicy.setCPL_AGE_LEVEL(jsonObject.getJSONObject("data").getString("CPL_AGE_LEVEL"));
						jiguangPolicy.setCPL_SEX_LEVEL(jsonObject.getJSONObject("data").getString("CPL_SEX_LEVEL"));
						jiguangPolicy
								.setCPL_DEVICE_LEVEL(jsonObject.getJSONObject("data").getString("CPL_DEVICE_LEVEL"));
						jiguangPolicy.setCPL_CPS_LEVEL(jsonObject.getJSONObject("data").getString("CPL_CPS_LEVEL"));
						jiguangPolicy.setSOM_RNI_RSI(jsonObject.getJSONObject("data").getString("SOM_RNI_RSI"));
						jiguangPolicy.setFIM_NF_BCI2(jsonObject.getJSONObject("data").getString("FIM_NF_BCI2"));
						jiguangPolicy.setFIM_NF_BCI3(jsonObject.getJSONObject("data").getString("FIM_NF_BCI3"));
						jiguangPolicy.setFIM_NF_BPI(jsonObject.getJSONObject("data").getString("FIM_NF_BPI"));
						jiguangPolicy.setFIM_NF_BFI(jsonObject.getJSONObject("data").getString("FIM_NF_BFI"));
						jiguangPolicy.setFIM_NF_BSI(jsonObject.getJSONObject("data").getString("FIM_NF_BSI"));
						jiguangPolicy.setFIM_CC_BSI1(jsonObject.getJSONObject("data").getString("FIM_CC_BSI1"));
						jiguangPolicy.setFIM_CC_BSI2(jsonObject.getJSONObject("data").getString("FIM_CC_BSI2"));
						jiguangPolicy.setFIM_CC_BSI3(jsonObject.getJSONObject("data").getString("FIM_CC_BSI3"));
						jiguangPolicy.setFIM_CC_BFI(jsonObject.getJSONObject("data").getString("FIM_CC_BFI"));
						jiguangPolicy.setFIM_PAY_BPI(jsonObject.getJSONObject("data").getString("FIM_PAY_BPI"));
						jiguangPolicy.setFIM_PAY_BFI(jsonObject.getJSONObject("data").getString("FIM_PAY_BFI"));
						jiguangPolicy.setGBM_TM_BSI(jsonObject.getJSONObject("data").getString("GBM_TM_BSI"));
						jiguangPolicy.setGBM_LH_BFI(jsonObject.getJSONObject("data").getString("GBM_LH_BFI"));
						jiguangPolicy.setGBM_SBH_HSI(jsonObject.getJSONObject("data").getString("GBM_SBH_HSI"));
						jiguangPolicy.setGBM_CBH_HSI(jsonObject.getJSONObject("data").getString("GBM_CBH_HSI"));
						jiguangPolicy.setCreateDate(sdf.format(new Date()));
						jiguangPolicy.setDataInfoId(id);
						mongoTemplate.insert(jiguangPolicy);

					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * 外部信用报告-百融
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	private void bairongIcredit(String id, String method, String name, String idNumber, String phone) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<BairongIcredit> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), BairongIcredit.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();

			sample.setMethod(method);
			sample.setField("name", name);
			sample.setField("idNumber", idNumber);
			sample.setField("phone", phone);
			try {
				JSONObject ret = sample.execute();
				if (ret.getInt("error") == 200) {
					JSONObject jsonObject = ret.getJSONObject("tianji_api_bairong_icredit_response");
					if (!jsonObject.isEmpty()) {

						BairongIcredit bairongIcredit = new BairongIcredit();
						bairongIcredit.setName(name);
						bairongIcredit.setIdNumber(idNumber);
						bairongIcredit.setPhone(phone);
						bairongIcredit.setMethod(method);
						bairongIcredit.setMethodName(RequestMethod.ResultName.BAIRONG_ICREDIT.getName());
						bairongIcredit.setFlagScore(jsonObject.getString("flag_score"));
						bairongIcredit.setBrcreditpoint(jsonObject.getString("brcreditpoint"));
						bairongIcredit.setCreateDate(sdf.format(new Date()));
						bairongIcredit.setDataInfoId(id);
						mongoTemplate.insert(bairongIcredit);

					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * 身份查询-机构k手机消费档次
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	private void jiaoPhoneconsumption(String id, String method, String name, String idNumber, String phone) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<JiaoPhoneConsumption> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), JiaoPhoneConsumption.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();

			sample.setMethod(method);
			sample.setField("name", name);
			sample.setField("idNumber", idNumber);
			sample.setField("phone", phone);
			try {
				JSONObject ret = sample.execute();
				if (ret.getInt("error") == 200) {
					JSONArray jsonArray = ret.getJSONArray("tianji_api_jiao_phoneconsumption_response");
					if (!jsonArray.isEmpty()) {

						for (int i = 0; i < jsonArray.size(); i++) {
							JSONObject jsonObject = (JSONObject) jsonArray.get(i);
							JiaoPhoneConsumption jiaoPhoneConsumption = new JiaoPhoneConsumption();
							jiaoPhoneConsumption.setName(name);
							jiaoPhoneConsumption.setIdNumber(idNumber);
							jiaoPhoneConsumption.setPhone(phone);
							jiaoPhoneConsumption.setMethod(method);
							jiaoPhoneConsumption
									.setMethodName(RequestMethod.ResultName.IDENTITY_FIND_PHONE_XIAOFEI.getName());
							jiaoPhoneConsumption.setCheckStatus(jsonObject.getString("checkStatus"));
							jiaoPhoneConsumption.setMessage(jsonObject.getString("message"));
							jiaoPhoneConsumption.setProvince(jsonObject.getJSONObject("checkResult")
									.getJSONObject("ISPNUM").getString("province"));
							jiaoPhoneConsumption.setCity(
									jsonObject.getJSONObject("checkResult").getJSONObject("ISPNUM").getString("city"));
							jiaoPhoneConsumption.setIsp(
									jsonObject.getJSONObject("checkResult").getJSONObject("ISPNUM").getString("isp"));
							jiaoPhoneConsumption.setCode(
									((JSONObject) jsonObject.getJSONObject("checkResult").getJSONArray("RSL").get(0))
											.getJSONObject("RS").getString("code"));
							jiaoPhoneConsumption.setDesc(
									((JSONObject) jsonObject.getJSONObject("checkResult").getJSONArray("RSL").get(0))
											.getJSONObject("RS").getString("desc"));
							jiaoPhoneConsumption.setCreateDate(sdf.format(new Date()));
							jiaoPhoneConsumption.setDataInfoId(id);
							mongoTemplate.insert(jiaoPhoneConsumption);
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 身份查询-机构k手机号码在网时长
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	private void jiaoPhonenetworklength(String id, String method, String name, String idNumber, String phone) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<JiaoPhoneNetWorkLength> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), JiaoPhoneNetWorkLength.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();

			sample.setMethod(method);
			sample.setField("name", name);
			sample.setField("idNumber", idNumber);
			sample.setField("phone", phone);
			try {
				JSONObject ret = sample.execute();
				if (ret.getInt("error") == 200) {
					JSONObject jsonObject = ret.getJSONObject("tianji_api_jiao_phonenetworklength_response");
					if (!jsonObject.isEmpty()) {

						JiaoPhoneNetWorkLength jiaoPhoneNetWorkLength = new JiaoPhoneNetWorkLength();
						jiaoPhoneNetWorkLength.setName(name);
						jiaoPhoneNetWorkLength.setIdNumber(idNumber);
						jiaoPhoneNetWorkLength.setPhone(phone);
						jiaoPhoneNetWorkLength.setMethod(method);
						jiaoPhoneNetWorkLength
								.setMethodName(RequestMethod.ResultName.IDENTITY_FIND_PHONE_NUMBER.getName());
						jiaoPhoneNetWorkLength.setProvince(jsonObject.getJSONObject("ISPNUM").getString("province"));
						jiaoPhoneNetWorkLength.setCity(jsonObject.getJSONObject("ISPNUM").getString("city"));
						jiaoPhoneNetWorkLength.setIsp(jsonObject.getJSONObject("ISPNUM").getString("isp"));
						jiaoPhoneNetWorkLength.setDesc(((JSONObject) jsonObject.getJSONArray("RSL").get(0))
								.getJSONObject("RS").getString("desc"));
						jiaoPhoneNetWorkLength.setCreateDate(sdf.format(new Date()));
						jiaoPhoneNetWorkLength.setDataInfoId(id);
						mongoTemplate.insert(jiaoPhoneNetWorkLength);

					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 身份查询-机构k手机状态
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	private void jiaoPhonestatus(String id, String method, String name, String idNumber, String phone) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<JiaoPhoneStatus> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), JiaoPhoneStatus.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();

			sample.setMethod(method);
			sample.setField("name", name);
			sample.setField("idNumber", idNumber);
			sample.setField("phone", phone);
			try {
				JSONObject ret = sample.execute();
				if (ret.getInt("error") == 200) {
					JSONArray jsonArray = ret.getJSONArray("tianji_api_jiao_phonestatus_response");
					if (!jsonArray.isEmpty()) {

						for (int i = 0; i < jsonArray.size(); i++) {
							JSONObject jsonObject = (JSONObject) jsonArray.get(i);
							JiaoPhoneStatus jiaoPhoneStatus = new JiaoPhoneStatus();
							jiaoPhoneStatus.setName(name);
							jiaoPhoneStatus.setIdNumber(idNumber);
							jiaoPhoneStatus.setPhone(phone);
							jiaoPhoneStatus.setMethod(method);
							jiaoPhoneStatus.setMethodName(RequestMethod.ResultName.IDENTITY_FIND_PHONE.getName());
							jiaoPhoneStatus.setCheckStatus(jsonObject.getString("checkStatus"));
							jiaoPhoneStatus.setMessage(jsonObject.getString("message"));
							jiaoPhoneStatus.setProvince(jsonObject.getJSONObject("checkResult").getJSONObject("ISPNUM")
									.getString("province"));
							jiaoPhoneStatus.setCity(
									jsonObject.getJSONObject("checkResult").getJSONObject("ISPNUM").getString("city"));
							jiaoPhoneStatus.setIsp(
									jsonObject.getJSONObject("checkResult").getJSONObject("ISPNUM").getString("isp"));
							jiaoPhoneStatus.setDesc(
									((JSONObject) jsonObject.getJSONObject("checkResult").getJSONArray("RSL").get(0))
											.getJSONObject("RS").getString("desc"));
							jiaoPhoneStatus.setCreateDate(sdf.format(new Date()));
							jiaoPhoneStatus.setDataInfoId(id);
							mongoTemplate.insert(jiaoPhoneStatus);
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * 身份验证-机构c
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	private void pengyuanMobilecheck3item(String id, String method, String name, String idNumber, String phone) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<PengyuanMobilecheck> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), PengyuanMobilecheck.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();

			sample.setMethod(method);
			sample.setField("name", name);
			sample.setField("idNumber", idNumber);
			sample.setField("phone", phone);
			try {
				JSONObject ret = sample.execute();
				if (ret.getInt("error") == 200) {
					JSONObject jsonObject = ret.getJSONObject("tianji_api_agentc_mobilecheck3item_response");
					if (!jsonObject.isEmpty()) {
						JSONArray jsonList = jsonObject.getJSONArray("checkResult");
						if (!jsonList.isEmpty()) {

							for (int j = 0; j < jsonList.size(); j++) {
								PengyuanMobilecheck pengyuanMobilecheck = new PengyuanMobilecheck();
								pengyuanMobilecheck.setName(name);
								pengyuanMobilecheck.setIdNumber(idNumber);
								pengyuanMobilecheck.setPhone(phone);
								pengyuanMobilecheck.setMethod(method);
								pengyuanMobilecheck
										.setMethodName(RequestMethod.ResultName.IDENTITY_VERIFICATION_C.getName());
								pengyuanMobilecheck.setCheckStatus(
										jsonObject.getJSONObject("tianji_api_agentc_mobilecheck3item_response")
												.getString("checkStatus"));
								pengyuanMobilecheck.setMessage(
										jsonObject.getJSONObject("tianji_api_agentc_mobilecheck3item_response")
												.getString("message"));
								pengyuanMobilecheck
										.setNameCheckResult(jsonList.getJSONObject(j).getString("nameCheckResult"));
								pengyuanMobilecheck.setDocumentNoCheckResult(
										jsonList.getJSONObject(j).getString("documentNoCheckResult"));
								pengyuanMobilecheck
										.setPhoneCheckResult(jsonList.getJSONObject(j).getString("phoneCheckResult"));
								pengyuanMobilecheck.setAreaInfo(jsonList.getJSONObject(j).getString("areaInfo"));
								pengyuanMobilecheck.setOperator(jsonList.getJSONObject(j).getString("operator"));
								pengyuanMobilecheck.setCreateDate(sdf.format(new Date()));
								pengyuanMobilecheck.setDataInfoId(id);
								mongoTemplate.insert(pengyuanMobilecheck);
							}
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 身份验证-考拉征信
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	private void kaolaBankcard4item(String id, String method, String name, String idNumber, String phone,
			String bankCard) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<KaolaBankcard> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), KaolaBankcard.class);
		if (findList.isEmpty()) {
			if (StringUtils.isNotEmpty(bankCard)) {
				OpenapiClient sample = getOpenapiClient();

				sample.setMethod(method);
				sample.setField("name", name);
				sample.setField("idNumber", idNumber);
				sample.setField("phone", phone);
				sample.setField("bankCard", bankCard);
				try {
					JSONObject ret = sample.execute();
					if (ret.getInt("error") == 200) {
						JSONArray jsonArray = ret.getJSONArray("tianji_api_kaola_bankcard4item_response");
						if (!jsonArray.isEmpty()) {

							for (int i = 0; i < jsonArray.size(); i++) {
								JSONObject jsonObject = (JSONObject) jsonArray.get(i);
								KaolaBankcard kaolaBankcard = new KaolaBankcard();
								kaolaBankcard.setName(name);
								kaolaBankcard.setIdNumber(idNumber);
								kaolaBankcard.setPhone(phone);
								kaolaBankcard.setMethod(method);
								kaolaBankcard
										.setMethodName(RequestMethod.ResultName.IDENTITY_VERIFICATION_KAOLA.getName());
								kaolaBankcard.setBankCard(bankCard);
								kaolaBankcard.setCheckStatus(jsonObject.getString("checkStatus"));
								kaolaBankcard.setMessage(jsonObject.getString("message"));
								kaolaBankcard.setCreateDate(sdf.format(new Date()));
								kaolaBankcard.setDataInfoId(id);
								mongoTemplate.insert(kaolaBankcard);
							}
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

	}

	/**
	 * 灰名单-法海法律（企业相关）
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	private void fahaiKeywordsearch(String id, String method, String name, String idNumber, String phone) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<FahaiKeywordSearch> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), FahaiKeywordSearch.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();

			sample.setMethod(method);
			sample.setField("name", name);
			try {
				JSONObject ret = sample.execute();
				if (ret.getInt("error") == 200) {
					JSONObject jsonObject = ret.getJSONObject("tianji_api_fahai_keywordsearch_response");
					if (!jsonObject.isEmpty()) {

						FahaiKeywordSearch fahaiKeywordSearch = new FahaiKeywordSearch();
						fahaiKeywordSearch.setName(name);
						fahaiKeywordSearch.setIdNumber(idNumber);
						fahaiKeywordSearch.setPhone(phone);
						fahaiKeywordSearch.setMethod(method);
						fahaiKeywordSearch.setMethodName(RequestMethod.ResultName.GREY_FAHAIFALV_QIYE.getName());
						fahaiKeywordSearch.setType(jsonObject.getString("type"));
						fahaiKeywordSearch.setDesc(jsonObject.getString("desc"));
						fahaiKeywordSearch.setDate(jsonObject.getString("date"));
						fahaiKeywordSearch.setCreateDate(sdf.format(new Date()));
						fahaiKeywordSearch.setDataInfoId(id);
						mongoTemplate.insert(fahaiKeywordSearch);

					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 灰名单-法海涉诉详情
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	private void fahaiBlacklistdetail(String id, String method, String name, String idNumber, String phone) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<FahaiDetailBlack> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), FahaiDetailBlack.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();
			// 获取keyId
			List<FahaiLawBlack> fahaiLawBlackList = mongoTemplate.find(
					new Query(
							Criteria.where("method").is("tianji.api.fahai.lawblacklist").and("idNumber").is(idNumber)),
					FahaiLawBlack.class);
			if (!fahaiLawBlackList.isEmpty()) {
				for (FahaiLawBlack fahaiLawBlack : fahaiLawBlackList) {
					sample.setMethod(method);
					sample.setField("keyId", fahaiLawBlack.getKeyId());
					try {
						JSONObject ret = sample.execute();
						if (ret.getInt("error") == 200) {
							JSONArray jsonArray = ret.getJSONArray("tianji_api_fahai_blacklistdetail_response");
							if (!jsonArray.isEmpty()) {

								for (int i = 0; i < jsonArray.size(); i++) {
									JSONObject jsonObject = (JSONObject) jsonArray.get(i);
									FahaiDetailBlack fahaiDetailBlack = new FahaiDetailBlack();
									fahaiDetailBlack.setName(name);
									fahaiDetailBlack.setIdNumber(idNumber);
									fahaiDetailBlack.setPhone(phone);
									fahaiDetailBlack.setMethod(method);
									fahaiDetailBlack.setMethodName(RequestMethod.ResultName.GREY_SHESUINFO.getName());
									fahaiDetailBlack.setType(jsonObject.getString("type"));
									fahaiDetailBlack.setDesc(jsonObject.getString("desc"));
									fahaiDetailBlack.setCreateDate(sdf.format(new Date()));
									fahaiDetailBlack.setDataInfoId(id);
									mongoTemplate.insert(fahaiDetailBlack);
								}
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}

	}

	/**
	 * 灰名单-法海法律
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	private void fahaiLawblacklist(String id, String method, String name, String idNumber, String phone) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<FahaiLawBlack> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), FahaiLawBlack.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();

			sample.setMethod(method);
			sample.setField("name", name);
			sample.setField("idNumber", idNumber);
			try {
				JSONObject ret = sample.execute();
				if (ret.getInt("error") == 200) {
					JSONArray jsonArray = ret.getJSONArray("tianji_api_fahai_lawblacklist_response");
					if (!jsonArray.isEmpty()) {

						for (int i = 0; i < jsonArray.size(); i++) {
							JSONObject jsonObject = (JSONObject) jsonArray.get(i);
							FahaiLawBlack fahaiLawBlack = new FahaiLawBlack();
							fahaiLawBlack.setName(name);
							fahaiLawBlack.setIdNumber(idNumber);
							fahaiLawBlack.setPhone(phone);
							fahaiLawBlack.setMethod(method);
							fahaiLawBlack.setMethodName(RequestMethod.ResultName.GREY_FAHAIFALV.getName());
							fahaiLawBlack.setType(jsonObject.getString("type"));
							fahaiLawBlack.setDesc(jsonObject.getString("desc"));
							fahaiLawBlack.setDate(jsonObject.getString("date"));
							fahaiLawBlack.setKeyId(jsonObject.getJSONObject("originalRet").getString("keyId"));
							fahaiLawBlack.setCreateDate(sdf.format(new Date()));
							fahaiLawBlack.setDataInfoId(id);
							mongoTemplate.insert(fahaiLawBlack);
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 黑名单-新颜征信
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 */
	private void xinyanBlacklist(String id, String method, String name, String idNumber, String phone) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<XinyanBlack> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), XinyanBlack.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();

			sample.setMethod(method);
			sample.setField("name", name);
			sample.setField("idNumber", idNumber);
			try {
				JSONObject ret = sample.execute();
				if (ret.getInt("error") == 200) {
					JSONObject jsonObject = ret.getJSONObject("tianji_api_xinyan_blacklist_response");
					if (!jsonObject.isEmpty()) {

						XinyanBlack xinyanBlack = new XinyanBlack();
						xinyanBlack.setName(name);
						xinyanBlack.setIdNumber(idNumber);
						xinyanBlack.setPhone(phone);
						xinyanBlack.setMethod(method);
						xinyanBlack.setMethodName(RequestMethod.ResultName.BLACK_XINYANZHENGXIN.getName());
						xinyanBlack.setCode(jsonObject.getString("code"));
						xinyanBlack.setDesc(jsonObject.getString("desc"));
						xinyanBlack.setMaxOverdueAmt(
								jsonObject.getJSONObject("result_detail").getString("max_overdue_amt"));
						xinyanBlack.setMaxOverdueDays(
								jsonObject.getJSONObject("result_detail").getString("max_overdue_days"));
						xinyanBlack.setLatestOverdueTime(
								jsonObject.getJSONObject("result_detail").getString("latest_overdue_time"));
						xinyanBlack.setCurrentlyOverdue(
								jsonObject.getJSONObject("result_detail").getString("currently_overdue"));
						xinyanBlack.setCurrentlyPerformance(
								jsonObject.getJSONObject("result_detail").getString("currently_performance"));
						xinyanBlack.setAccExc(jsonObject.getJSONObject("result_detail").getString("acc_exc"));
						xinyanBlack.setAccSleep(jsonObject.getJSONObject("result_detail").getString("acc_sleep"));
						xinyanBlack.setCreateDate(sdf.format(new Date()));
						xinyanBlack.setDataInfoId(id);
						mongoTemplate.insert(xinyanBlack);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 黑名单-机构R
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 * @return
	 */
	private void agentrBlacklist(String id, String method, String name, String idNumber, String phone) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<AgentrBlack> findList = mongoTemplate
				.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00").lte(nowTime + " 23:59:59")
						.and("method").is("method").and("idNumber").is(idNumber)), AgentrBlack.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();

			sample.setMethod(method);
			sample.setField("name", name);
			sample.setField("idNumber", idNumber);
			sample.setField("phone", phone);

			try {
				JSONObject ret = sample.execute();
				if (ret.getInt("error") == 200) {
					JSONArray jsonArray = ret.getJSONArray("tianji_api_agentr_blacklist_response");
					if (!jsonArray.isEmpty()) {

						for (int i = 0; i < jsonArray.size(); i++) {
							JSONObject jsonObject = (JSONObject) jsonArray.get(i);
							AgentrBlack agentrBlack = new AgentrBlack();
							agentrBlack.setName(name);
							agentrBlack.setIdNumber(idNumber);
							agentrBlack.setPhone(phone);
							agentrBlack.setMethod(method);
							agentrBlack.setMethodName(RequestMethod.ResultName.BLACK_R.getName());
							agentrBlack.setFeature1(jsonObject.getString("feature1"));
							agentrBlack.setFeature2(jsonObject.getString("feature2"));
							agentrBlack.setFeature3(jsonObject.getString("feature3"));
							agentrBlack.setFeature4(jsonObject.getString("feature4"));
							agentrBlack.setFeature5(jsonObject.getString("feature5"));
							agentrBlack.setCreateDate(sdf.format(new Date()));
							agentrBlack.setDataInfoId(id);
							mongoTemplate.insert(agentrBlack);
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 黑名单-百度
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 * @return
	 */
	private void baiduBlacklist(String id, String method, String name, String idNumber, String phone) {
		String nowTime = sf.format(new Date());
		// 同一用户当日内不可重复查询
		List<BaiduBlack> findList = mongoTemplate.find(new Query(Criteria.where("createDate").gte(nowTime + " 00:00:00")
				.lte(nowTime + " 23:59:59")
				.and("method").is("method").and("idNumber").is(idNumber)), BaiduBlack.class);
		if (findList.isEmpty()) {
			OpenapiClient sample = getOpenapiClient();

			sample.setMethod(method);
			sample.setField("name", name);
			sample.setField("idNumber", idNumber);
			sample.setField("phone", phone);
			try {
				JSONObject ret = sample.execute();
				if (ret.getInt("error") == 200) {
					JSONObject jsonObject = ret.getJSONObject("tianji_api_baidu_blacklist_response");
					if (!jsonObject.isEmpty()) {

						BaiduBlack baiduBlack = new BaiduBlack();
						baiduBlack.setName(name);
						baiduBlack.setIdNumber(idNumber);
						baiduBlack.setPhone(phone);
						baiduBlack.setMethod(method);
						baiduBlack.setMethodName(RequestMethod.ResultName.BLACK_BAIDU.getName());
						baiduBlack.setType(jsonObject.getString("type"));
						baiduBlack.setDesc(jsonObject.getString("desc"));
						baiduBlack.setBlackReason(jsonObject.getJSONObject("originalRet").getString("blackReason"));
						baiduBlack.setCreateDate(sdf.format(new Date()));
						baiduBlack.setDataInfoId(id);
						mongoTemplate.insert(baiduBlack);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * 封装参数
	 * 
	 * @return 数据返回
	 */
	private static OpenapiClient getOpenapiClient() {
		OpenapiClient sample = new OpenapiClient();

		sample.setAppId(TianjiSample.appId); // TODO 设置Appid
		sample.setPrivateKey(RSAUtils.getPrivateKey()); // TODO
														// 设置机构私钥，需要使用方替换private_key.pem文件
		sample.setIsTestEnv(true); // TODO
									// 设置为请求测试环境，默认为线上环境（false），需要使用方替换，也可不替换
		sample.setPrintLog(true); // 是否打印关键日志，默认为false，需要使用方替换，也可不替换
		// generateLogid()代表利用UUID随机生成一个id，传入String类型可用自己的id
		sample.setLogid(RequestUtil.generateLogid());
		return sample;
	}

	/**
	 * 融360抓取服务
	 * 
	 * @param method
	 *            查询的接口名
	 * @param name
	 *            姓名
	 * @param idNumber
	 *            身份证
	 * @param phone
	 *            电话
	 * @return
	 */
	private void rong360SDK(String id, String method, String name, String idNumber, String phone) {

	}
}
