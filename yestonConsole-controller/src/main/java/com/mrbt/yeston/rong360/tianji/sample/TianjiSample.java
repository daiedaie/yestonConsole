package com.mrbt.yeston.rong360.tianji.sample;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mrbt.yeston.admin.commons.base.BaseController;
import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.rong360.tianji.mongo.AgentrBlack;
import com.mrbt.yeston.rong360.tianji.mongo.BaiduBlack;
import com.mrbt.yeston.rong360.tianji.mongo.BairongIcredit;
import com.mrbt.yeston.rong360.tianji.mongo.FaceplusGetrandomnumber;
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
import com.mrbt.yeston.rong360.tianji.utils.RSAUtils;
import com.mrbt.yeston.rong360.tianji.utils.RequestMethod;
import com.mrbt.yeston.rong360.tianji.utils.RequestUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "tianji360")
public class TianjiSample extends BaseController {

	@Autowired
	private MongoTemplate mongoTemplate;

	public static String appId = "1000339";// 需要使用方替换
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public static void main(String[] args) throws Exception {
		OpenapiClient sample = new OpenapiClient();
		sample.setAppId(TianjiSample.appId); // TODO 设置Appid
		sample.setPrivateKey(RSAUtils.getPrivateKey()); // TODO
														// 设置机构私钥，需要使用方替换private_key.pem文件
		sample.setIsTestEnv(true); // TODO
									// 设置为请求测试环境，默认为线上环境（false），需要使用方替换，也可不替换
		sample.setPrintLog(true); // 是否打印关键日志，默认为false，需要使用方替换，也可不替换
		// generateLogid()代表利用UUID随机生成一个id，传入String类型可用自己的id
		sample.setLogid(RequestUtil.generateLogid());

		sample.setMethod("tianji.api.rong360.sdk");
		sample.setField("name", "苏轶博");
		sample.setField("idNumber", "61012219910518401X");
		sample.setField("phone", "15991989578");

		JSONObject ret = sample.execute();
		System.out.println(ret.toString());
	}
	
	@RequestMapping("tianji360Manager")
	public String manager(HttpServletRequest request, HttpServletResponse response) {
		return "/tianji360/tianji360Manager";
	}

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
	@RequestMapping(value = "/saveRong360BaseData")
	public @ResponseBody Object saveRong360BaseData(String methods, String name, String idNumber, String phone,
			String bankCard, String video, HttpServletRequest request, HttpServletResponse response) {
		List<DataInfo> dataInfoList = new ArrayList<>();
		Integer pageNumber = Integer.valueOf(request.getParameter("page"));
		Integer pageSize = Integer.valueOf(request.getParameter("rows"));

		PageInfo<DataInfo> pageInfo = new PageInfo<>(pageNumber, pageSize);
		try {
			if (StringUtils.isNotEmpty(methods)) {
				String[] methodList = methods.split(",");
				DataInfo dataInfo = new DataInfo();
				dataInfo.setName(name);
				String str = "";
				for (int i = 0; i < methodList.length; i++) {
					switch (methodList[i]) {
					case "tianji.api.rong360.sdk": // 融360抓取服务
						break;
					case "tianji.api.baidu.blacklist": // 黑名单-百度
						str += RequestMethod.ResultName.BLACK_BAIDU.getName() + ",";
						break;
					case "tianji.api.agentr.blacklist": // 黑名单-机构R
						str += RequestMethod.ResultName.BLACK_R.getName() + ",";
						break;
					case "tianji.api.xinyan.blacklist": // 黑名单-新颜征信
						str += RequestMethod.ResultName.BLACK_XINYANZHENGXIN.getName() + ",";
						break;
					case "tianji.api.fahai.lawblacklist": // 灰名单-法海法律
						str += RequestMethod.ResultName.GREY_FAHAIFALV.getName() + ",";
						break;
					case "tianji.api.fahai.blacklistdetail": // 灰名单-法海涉诉详情
						str += RequestMethod.ResultName.GREY_SHESUINFO.getName() + ",";
						break;
					case "tianji.api.fahai.keywordsearch": // 灰名单-法海法律（企业相关）
						str += RequestMethod.ResultName.GREY_FAHAIFALV_QIYE.getName() + ",";
						break;
					case "tianji.api.faceplus.getrandomnumber": // FACE++-获取随机数-H5
						str += RequestMethod.ResultName.FACEPLUS_GETRANDOMNUMBER.getName() + ",";
						break;
					case "tianji.api.faceplus.validatevideo": // FACE++-自拍视频的活体验证-H5
						break;
					case "tianji.api.kaola.bankcard4item": // 身份验证-考拉征信
						str += RequestMethod.ResultName.IDENTITY_VERIFICATION_KAOLA.getName() + ",";
						break;
					case "tianji.api.pengyuan.mobilecheck3item": // 身份验证-机构c
						str += RequestMethod.ResultName.IDENTITY_VERIFICATION_C.getName() + ",";
						break;
					case "tianji.api.jiao.phonestatus": // 身份查询-机构k手机状态
						str += RequestMethod.ResultName.IDENTITY_FIND_PHONE.getName() + ",";
						break;
					case "tianji.api.jiao.phonenetworklength": // 身份查询-机构k手机号码在网时长
						str += RequestMethod.ResultName.IDENTITY_FIND_PHONE_NUMBER.getName() + ",";
						break;
					case "tianji.api.jiao.phoneconsumption": // 身份查询-机构k手机消费档次
						str += RequestMethod.ResultName.IDENTITY_FIND_PHONE_XIAOFEI.getName() + ",";
						break;
					case "tianji.api.bairong.icredit": // 外部信用报告-百融
						str += RequestMethod.ResultName.BAIRONG_ICREDIT.getName() + ",";
						break;
					case "tianji.api.jiguang.policy": // 反欺诈报告-极光
						str += RequestMethod.ResultName.JIGUANG_POLICY.getName() + ",";
						break;
					case "tianji.api.umeng.score": // 特色报告-友盟+
						str += RequestMethod.ResultName.UMENG_SCORE.getName() + ",";
						break;

					default:
						break;
					}

				}
				dataInfo.setMethod(methods);
				dataInfo.setMethodName(str.substring(0, str.length() - 1));
				dataInfo.setPhone(phone);
				dataInfo.setIdNumber(idNumber);
				dataInfo.setBankCard(bankCard);
				dataInfo.setVideo(video);
				dataInfo.setStatus(0);
				dataInfo.setCreateDate(sdf.format(new Date()));
				mongoTemplate.insert(dataInfo);
			}
			dataInfoList = mongoTemplate.find(new Query().with(new Sort(new Order(Direction.DESC, "createDate")))
					.skip(pageInfo.getFrom()).limit(pageInfo.getSize()),
					DataInfo.class);
			pageInfo.setCode(200);
			pageInfo.setTotal(mongoTemplate.findAll(DataInfo.class).size());
			pageInfo.setRows(dataInfoList);
		} catch (Exception e) {
			pageInfo.setCode(201);
			pageInfo.setMsg("系统异常！");
			pageInfo.setRows(dataInfoList);
		}
		return pageInfo;
	}



	/**
	 * 获取数据详情
	 * @param id dataInfoId
	 * @return 数据返回
	 */
	@RequestMapping(value = "/getInfoList")
	public @ResponseBody Object getInfoList(String id) {
		PageInfo<?> pageInfo = new PageInfo<>();
		List<List<?>> list = new ArrayList<>();
		// 获取dataInfo对象
		DataInfo dataInfo = mongoTemplate.findOne(new Query(Criteria.where("id").is(id)), DataInfo.class);
		try {
			String[] methodList = dataInfo.getMethod().split(",");
			for (int i = 0; i < methodList.length; i++) {
				switch (methodList[i]) {
				case "tianji.api.rong360.sdk": // 融360抓取服务
					break;
				case "tianji.api.baidu.blacklist": // 黑名单-百度
					List<BaiduBlack> baiduBlackList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							BaiduBlack.class);
					if (!baiduBlackList.isEmpty()) {
						list.add(baiduBlackList);
					}
					break;
				case "tianji.api.agentr.blacklist": // 黑名单-机构R
					List<AgentrBlack> agentrBlackList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							AgentrBlack.class);
					if (!agentrBlackList.isEmpty()) {
						list.add(agentrBlackList);
					}
					break;
				case "tianji.api.xinyan.blacklist": // 黑名单-新颜征信
					List<XinyanBlack> xinyanBlackList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							XinyanBlack.class);
					if (!xinyanBlackList.isEmpty()) {
						list.add(xinyanBlackList);
					}
					break;
				case "tianji.api.fahai.lawblacklist": // 灰名单-法海法律
					List<FahaiLawBlack> fahaiLawBlackList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							FahaiLawBlack.class);
					if (!fahaiLawBlackList.isEmpty()) {
						list.add(fahaiLawBlackList);
					}
					break;
				case "tianji.api.fahai.blacklistdetail": // 灰名单-法海涉诉详情
					List<FahaiDetailBlack> fahaiDetailBlackList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							FahaiDetailBlack.class);
					if (!fahaiDetailBlackList.isEmpty()) {
						list.add(fahaiDetailBlackList);
					}
					break;
				case "tianji.api.fahai.keywordsearch": // 灰名单-法海法律（企业相关）
					List<FahaiKeywordSearch> fahaiKeywordSearchList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							FahaiKeywordSearch.class);
					if (!fahaiKeywordSearchList.isEmpty()) {
						list.add(fahaiKeywordSearchList);
					}
					break;
				case "tianji.api.faceplus.getrandomnumber": // FACE++-获取随机数-H5
					List<FaceplusGetrandomnumber> faceplusGetrandomnumberList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							FaceplusGetrandomnumber.class);
					if (!faceplusGetrandomnumberList.isEmpty()) {
						list.add(faceplusGetrandomnumberList);
					}
					break;
				case "tianji.api.faceplus.validatevideo": // FACE++-自拍视频的活体验证-H5
					break;
				case "tianji.api.kaola.bankcard4item": // 身份验证-考拉征信
					List<KaolaBankcard> KaolaBankcardList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							KaolaBankcard.class);
					if (!KaolaBankcardList.isEmpty()) {
						list.add(KaolaBankcardList);
					}
					break;
				case "tianji.api.pengyuan.mobilecheck3item": // 身份验证-机构c
					List<PengyuanMobilecheck> PengyuanMobilecheckList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							PengyuanMobilecheck.class);
					if (!PengyuanMobilecheckList.isEmpty()) {
						list.add(PengyuanMobilecheckList);
					}
					break;
				case "tianji.api.jiao.phonestatus": // 身份查询-机构k手机状态
					List<JiaoPhoneStatus> jiaoPhoneStatusList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							JiaoPhoneStatus.class);
					if (!jiaoPhoneStatusList.isEmpty()) {
						list.add(jiaoPhoneStatusList);
					}
					break;
				case "tianji.api.jiao.phonenetworklength": // 身份查询-机构k手机号码在网时长
					List<JiaoPhoneNetWorkLength> JiaoPhoneNetWorkLengthList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							JiaoPhoneNetWorkLength.class);
					if (!JiaoPhoneNetWorkLengthList.isEmpty()) {
						list.add(JiaoPhoneNetWorkLengthList);
					}
					break;
				case "tianji.api.jiao.phoneconsumption": // 身份查询-机构k手机消费档次
					List<JiaoPhoneConsumption> jiaoPhoneConsumptionList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							JiaoPhoneConsumption.class);
					if (!jiaoPhoneConsumptionList.isEmpty()) {
						list.add(jiaoPhoneConsumptionList);
					}
					break;
				case "tianji.api.bairong.icredit": // 外部信用报告-百融
					List<BairongIcredit> BairongIcreditList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							BairongIcredit.class);
					if (!BairongIcreditList.isEmpty()) {
						list.add(BairongIcreditList);
					}
					break;
				case "tianji.api.jiguang.policy": // 反欺诈报告-极光
					List<JiguangPolicy> jiguangPolicyList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							JiguangPolicy.class);
					if (!jiguangPolicyList.isEmpty()) {
						list.add(jiguangPolicyList);
					}
					break;
				case "tianji.api.umeng.score": // 特色报告-友盟+
					List<UmengScore> umengScoreList = mongoTemplate.find(
							new Query(Criteria.where("method").is(methodList[i]).and("dataInfoId").is(dataInfo.getId())),
							UmengScore.class);
					if (!umengScoreList.isEmpty()) {
						list.add(umengScoreList);
					}
					break;

				default:
					break;
				}
			}
			pageInfo.setCode(200);
			pageInfo.setObj(list);
		} catch (Exception e) {
			pageInfo.setCode(201);
			pageInfo.setMsg("查询数据异常");
		}
		return pageInfo;
	}
}
