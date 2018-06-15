package com.mrbt.yeston.rong360.tianji.sample;

import java.util.HashMap;
import java.util.Map;

import com.mrbt.yeston.rong360.tianji.utils.RequestUtil;

import net.sf.json.JSONObject;

/**
 * 客户端实体类
 * 
 * @author wei
 *
 */
public class OpenapiClient {
	/**
	 * appId
	 */
	private String appId;
	/**
	 * 私钥
	 */
	private String privateKey;
	/**
	 * 是否使用测试环境
	 */
	private boolean isTestEnv;
	/**
	 * 方法名
	 */
	private String method;
	/**
	 * 业务参数
	 */
	private Map<String, String> bizData = new HashMap<>();
	/**
	 * 流水号
	 */
	private String logid;
	/**
	 * 是否打印关键日志信息
	 */
	private boolean isPrintLog = false;

	public void setAppId(String appId) {
		this.appId = appId;
	}

	/**
	 * 设置私钥
	 * 
	 * @param privateKey
	 *            私钥
	 */
	public void setPrivateKey(String privateKey) {
		this.privateKey = privateKey;
	}

	/**
	 * 设置是否使用测试环境
	 * 
	 * @param isTestEnv
	 *            是否使用测试环境
	 */
	public void setIsTestEnv(boolean isTestEnv) {
		this.isTestEnv = isTestEnv;
	}

	/**
	 * 设置方法名
	 * 
	 * @param method
	 *            方法名
	 */
	public void setMethod(String method) {
		this.method = method;
	}

	/**
	 * 设置业务参数
	 * 
	 * @param key
	 *            业务参数名
	 * @param value
	 *            业务参数值
	 */
	public void setField(String key, String value) {
		this.bizData.put(key, value);
	}

	public void setLogid(String logid) {
		this.logid = logid;
	}

	public void setPrintLog(boolean isPrintLog) {
		this.isPrintLog = isPrintLog;
	}

	/**
	 * 执行方法访问天机
	 * 
	 * @return JSONObject 返回的json对象
	 * @throws Exception
	 *             异常
	 */
	public JSONObject execute() throws Exception {

		Map<String, String> sysParams = new HashMap<>();
		// sysParams.put("key", "value"); 天机接口可以不传系统参数
		JSONObject ret = this.doOpenApiRequest(this.method, sysParams, this.bizData, this.logid, this.isPrintLog);
		return ret;
	}

	/**
	 * 执行API请求
	 * 
	 * @param method
	 *            方法名
	 * @param params
	 *            系统参数MAP
	 * @param bizData
	 *            业务参数MAP
	 * @return JSONObject 返回的json对象
	 * @throws Exception
	 *             异常
	 */
	private JSONObject doOpenApiRequest(String method, Map<String, String> params, Map<String, String> bizData,
			String logid, boolean isPrintLog) throws Exception {
		String result = RequestUtil.request(method, params, bizData, this.appId, this.privateKey, this.isTestEnv, logid,
				isPrintLog);
		if (result == null || result.length() == 0) {
			throw new Exception("Request tianji api " + method + " returns null");
		}
		JSONObject jsonRet = JSONObject.fromObject(result);
		if (jsonRet == null) {
			throw new Exception("Request tianji api " + method + " got a non-json result");
		}
		return jsonRet;
	}
}
