package com.mrbt.yeston.rong360.tianji.utils;
/** 
 * @author  suyibo 
 * @date 创建时间：2018年2月23日
 */
public class RequestMethod {

	public static enum ResultName {

		/**
		 * 融360抓取服务-运营商
		 */
		RONG360_SDK_YUNYING("tianji.api.rong360.sdk", "融360抓取服务-运营商"),
		/**
		 * 融360抓取服务-京东
		 */
		RONG360_SDK_JD("tianji.api.rong360.sdk", "融360抓取服务-京东"),
		/**
		 * 融360抓取服务-邮箱
		 */
		RONG360_SDK_EMAIL("tianji.api.rong360.sdk", "融360抓取服务-邮箱"),
		/**
		 * 融360抓取服务-网银
		 */
		RONG360_SDK_VISA("tianji.api.rong360.sdk", "融360抓取服务-网银"),
		/**
		 * 融360抓取服务-社保
		 */
		RONG360_SDK_SHEBAO("tianji.api.rong360.sdk", "融360抓取服务-社保"),
		/**
		 * 融360抓取服务-公积金
		 */
		RONG360_SDK_GONGJIJIN("tianji.api.rong360.sdk", "融360抓取服务-公积金"),
		/**
		 * 融360抓取服务-支付宝
		 */
		RONG360_SDK_ZHIFUBAO("tianji.api.rong360.sdk", "融360抓取服务-支付宝"),
		/**
		 * 融360抓取服务-淘宝
		 */
		RONG360_SDK_TAOBAO("tianji.api.rong360.sdk", "融360抓取服务-淘宝"),
		/**
		 * 融360抓取服务-简版征信
		 */
		RONG360_SDK_ZHENGXIN("tianji.api.rong360.sdk", "融360抓取服务-简版征信"),

		/**
		 * 黑名单-百度
		 */
		BLACK_BAIDU("tianji.api.baidu.blacklist", "黑名单-百度"),
		/**
		 * 黑名单-机构R
		 */
		BLACK_R("tianji.api.agentr.blacklist", "黑名单-机构R"),
		/**
		 * 黑名单-新颜征信
		 */
		BLACK_XINYANZHENGXIN("tianji.api.xinyan.blacklist", "黑名单-新颜征信"),

		/**
		 * 灰名单-法海法律
		 */
		GREY_FAHAIFALV("tianji.api.fahai.lawblacklist", "灰名单-法海法律"),
		/**
		 * 灰名单-法海涉诉详情
		 */
		GREY_SHESUINFO("tianji.api.fahai.blacklistdetail", "灰名单-法海涉诉详情"),
		/**
		 * 灰名单-法海法律（企业相关）
		 */
		GREY_FAHAIFALV_QIYE("tianji.api.fahai.keywordsearch", "灰名单-法海法律（企业相关）"),

		/**
		 * FACE++-获取随机数-H5
		 */
		FACEPLUS_GETRANDOMNUMBER("tianji.api.faceplus.getrandomnumber", "FACE++-获取随机数-H5"),
		/**
		 * FACE++-自拍视频的活体验证-H5
		 */
		FACEPLUS_VALIDATEVIDEO("tianji.api.faceplus.validatevideo", "FACE++-自拍视频的活体验证-H5"),

		/**
		 * 身份验证-考拉征信
		 */
		IDENTITY_VERIFICATION_KAOLA("tianji.api.kaola.bankcard4item", "身份验证-考拉征信"),
		/**
		 * 身份验证-机构c
		 */
		IDENTITY_VERIFICATION_C("tianji.api.pengyuan.mobilecheck3item", "身份验证-机构c"),

		/**
		 * 身份查询-机构k手机状态
		 */
		IDENTITY_FIND_PHONE("tianji.api.jiao.phonestatus", "身份查询-机构k手机状态"),
		/**
		 * 身份查询-机构k手机号码在网时长
		 */
		IDENTITY_FIND_PHONE_NUMBER("tianji.api.jiao.phonenetworklength", "身份查询-机构k手机号码在网时长"),
		/**
		 * 身份查询-机构k手机消费档次
		 */
		IDENTITY_FIND_PHONE_XIAOFEI("tianji.api.jiao.phoneconsumption", "身份查询-机构k手机消费档次"),

		/**
		 * 外部信用报告-百融
		 */
		BAIRONG_ICREDIT("tianji.api.bairong.icredit", "外部信用报告-百融"),

		/**
		 * 反欺诈报告-极光
		 */
		JIGUANG_POLICY("tianji.api.jiguang.policy", "反欺诈报告-极光"),
		/**
		 * 特色报告-友盟+
		 */
		UMENG_SCORE("tianji.api.umeng.score", "特色报告-友盟+");

		;

		ResultName(String msg, String name) {
			this.msg = msg;
			this.name = name;
		}

		private final String msg;
		private final String name;

		public String getMsg() {
			return msg;
		}

		public String getName() {
			return name;
		}
	}
}
