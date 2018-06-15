package com.mrbt.yeston.rong360.tianji.client;

import com.mrbt.yeston.rong360.tianji.client.impl.DefaultRongClient;

/**
 * 客户端管理器
 * 
 * @author 融360-天机
 *
 */
public class ClientManager {

	/**
	 * 请求URL
	 */
	private static String url = "";
	/**
	 * 字符串格式
	 */
	private static String format = "json";
	/**
	 * 编码格式
	 */
	private static String charset = "utf-8";

	/**
	 * 创建融客户端
	 * 
	 * @param appId
	 *            appId
	 * @param privateKey
	 *            私钥
	 * @param isTestEnv
	 *            是否是测试环境
	 * @return RongClient 返回一个创建好的融客户端
	 */
	public static RongClient createClient(String appId, String privateKey, boolean isTestEnv, String logid,
			boolean isPrintLog, String method) {
		String getData = "?logid=" + logid + "&orgid=" + appId + "&func=" + method;
		if (isTestEnv) {
			url = "https://openapisandbox.rong360.com/gateway" + getData;
		} else {
			url = "https://openapi.rong360.com/gateway" + getData;
		}
		return new DefaultRongClient(url, appId, privateKey, format, charset, isTestEnv, isPrintLog);
	}

}
