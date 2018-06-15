package com.mrbt.yeston.rong360.tianji.client.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.mrbt.yeston.rong360.tianji.client.RongClient;
import com.mrbt.yeston.rong360.tianji.utils.Base64Utils;
import com.mrbt.yeston.rong360.tianji.utils.CrawlerUtils;
import com.mrbt.yeston.rong360.tianji.utils.HttpTools;
import com.mrbt.yeston.rong360.tianji.utils.RSAUtils;

/**
 * 默认的请求客户端实现
 * @author 融360-天机
 *
 */
public class DefaultRongClient implements RongClient {
	/**
	 * 服务器URL
	 */
    private String serverUrl	= "";
    /**
     * appId
     */
    private String appId		= "";
    /**
     * 版本号
     */
    private String version 		= "1.0.0";
    /**
     * 私钥
     */
    private String privateKey	= "";
    /**
     * 编码格式
     */
    private String charset		= "utf-8";
    /**
     * 字符串格式
     */
    private String format 		= "json";
    /**
     * 加密方法
     */
    private String signType 	= "RSA";
    /**
     * 连接超时时间
     */
    private int connectTimeout 	= 3000;
    /**
     * 响应超时时间
     */
    private int readTimeout    	= 40000;
    /**
     * 是否是测试环境
     */
    private boolean isDebug 	= false;
    /**
     * 是否打印关键日志信息
     */
    private boolean isPrintLog = false;
    
    /**
     * 默认的融客户端构造方法
     * @param serverUrl 服务器URL
     * @param appId appId
     * @param privateKey 私钥
     * @param format 字符串格式
     * @param charset 字符编码
     * @param isDebug 是否是测试环境
     */
    public DefaultRongClient(String serverUrl, String appId, String privateKey, String format,
        String charset, boolean isDebug, boolean isPrintLog) {
        this.serverUrl = serverUrl;
        this.appId = appId;
        this.privateKey = privateKey;
        this.format = format;
        this.isDebug = isDebug;
        this.isPrintLog = isPrintLog;
        this.charset = charset;
        checkParams();
    }
    
    /**
     * 重载父类方法
     * @param params 参数
     * @throws Exception 异常
     */
    @Override
	public String execute(Map<String,String> params) throws Exception {
        if(params==null){
            params = new HashMap<String,String>();
        }
        params.put("app_id", this.appId);
        params.put("version", this.version);
        params.put("sign_type", this.signType);
        params.put("format", this.format);
        params.put("timestamp", String.valueOf(new Date().getTime()));
        //sign处理 RSA加密
        String paramsStr = CrawlerUtils.getSortParams(params);
        printDebugLog("请求的url：" + this.serverUrl);
        printDebugLog("待签名数据：" + paramsStr);
        byte[] bytes = RSAUtils.generateSHA1withRSASigature(paramsStr, privateKey, charset);
        String sign = Base64Utils.encode(bytes);
        printDebugLog("签名后数据：" + sign);
        params.put("sign", sign);
        String result = HttpTools.post(this.serverUrl, params, this.connectTimeout, this.readTimeout);
        printDebugLog("请求返回数据：" + result);
        return result;
    }
    
    /**
     * 打印debug日志
     * @param log 日志字符串
     */
    private void printDebugLog(String log) {
    	if (isPrintLog) {
    		System.out.println("[DEBUG]" + log);
    	}
    }
    
    /**
     * 检验参数是否合法
     */
    private void checkParams() {
    	if (!StringUtils.isNumeric(appId) || (appId.length() != 7 && !appId.equals("123456"))) {
    		throw new IllegalArgumentException("appid格式不合法！");
    	}
    	if (!isValidPrivateKey()) {
    		throw new IllegalArgumentException("私钥格式不合法！");
    	}
    }

    /**
     * 是否是合法的私钥
     * @return boolean 是否是合法的私钥
     */
	private boolean isValidPrivateKey() {
		String[] strs = StringUtils.split(privateKey, "\n");
		for (int index = 0; index < 13; index++) {
			if (index >= strs.length || strs[index].length() != 64) {
				return false;
			}
		}
		if (strs.length < 14 || strs[13].length() != 16) {
			return false;
		}
		return true;
	}
    
}
