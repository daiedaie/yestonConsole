package com.mrbt.yeston.rong360.tianji.utils;

import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

import com.mrbt.yeston.rong360.tianji.client.ClientManager;
import com.mrbt.yeston.rong360.tianji.client.RongClient;

import net.sf.json.JSONObject;

/**
 * 请求工具类
 * 
 * @author 融360-天机
 * 
 */
public class RequestUtil<K, V> {

	/**
	 * request请求
	 * 
	 * @param method
	 *            方法
	 * @param params
	 *            系统参数
	 * @param bizData
	 *            业务参数
	 * @param appId
	 *            appId
	 * @param privateKey
	 *            私钥
	 * @param isTestEnv
	 *            是否使用测试环境
	 * @return String 响应字符串
	 * @throws Exception
	 *             异常
	 */
	public static String request(String method, Map<String, String> params, Map<String, String> bizData, String appId,
			String privateKey, boolean isTestEnv, String logid, boolean isPrintLog) throws Exception {
		if (StringUtils.isEmpty(method) || bizData.isEmpty()) {
			throw new IllegalArgumentException("参数错误！method和biz_data不能为空！");
		}
		if (!isValidMethod(method)) {
			throw new IllegalArgumentException("参数method格式错误！");
		}
		if (logid == null || logid.isEmpty()) {
			throw new IllegalArgumentException("参数logid不能为空");
		}
		checkNull(params);
		checkNull(bizData);
		params.put("method", method);
		params.put("biz_data", JSONObject.fromObject(bizData).toString());
		RongClient client = ClientManager.createClient(appId, privateKey, isTestEnv, logid, isPrintLog, method);
		return client.execute(params);
	}

	/**
	 * 检测是否是合法方法
	 * 
	 * @param method
	 *            方法字符串
	 * @return boolean 是否是合法方法
	 */
	private static boolean isValidMethod(String method) {
		String pattern = "\\w+\\.\\w+\\.(\\w+.)?\\w+\\.\\w+";
		return Pattern.matches(pattern, method);
	}

	/**
	 * 检测参数是否为空
	 * 
	 * @param params
	 *            参数
	 */
	private static void checkNull(Map<String, String> params) {
		for (Map.Entry<String, String> entry : params.entrySet()) {
			if (entry.getValue() == null) {
				throw new NullPointerException("参数" + entry.getKey() + "不能为空！");
			}
		}
	}

	public static String generateLogid() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

}
