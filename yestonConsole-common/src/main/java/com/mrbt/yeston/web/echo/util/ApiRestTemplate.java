package com.mrbt.yeston.web.echo.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.interfaces.RSAPublicKey;

import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.JsonObject;
import com.mrbt.yeston.admin.commons.utils.DigestUtils;
import com.mrbt.yeston.web.echo.base.InnerEcParams;
import com.mrbt.yeston.web.echo.base.OuterEcFormat;

/**
 * @description
 * @author Hoary (hoary_huang@foxmail.com)
 * @since 2016年5月12日
 */
public class ApiRestTemplate {
	private static final Logger logger = LoggerFactory.getLogger(ApiRestTemplate.class);
	private static RestTemplate sender = new RestTemplate();
	
	static RSAPublicKey rsaPublicKey;
	static String encUserid;
	
	static PropertiesConfiguration config;
	private static String user, passwd, apiUrl, apiUrlHttps;
	static{
		try{
			config = new PropertiesConfiguration("prop.properties");
			user = config.getString("userId");
			passwd = config.getString("password");
			//往Tomcat端发送数据.此处是tomcat端的url
			apiUrl = config.getString("apiUrlForEchoQuery");
			apiUrlHttps = config.getString("apiUrlForEchoQueryHttps");
			
//			rsaPublicKey = RSA_1024_V2.gainRSAPublicKeyFromCrtFile(System.getProperty("user.dir") + "/ZC_PublicKey_V2.crt");
			rsaPublicKey = RSA_1024_V2.gainRSAPublicKeyFromCrtFile(config.getString("crtFilePath"));
			//公钥加密userid
			encUserid = RSA_1024_V2.encodeByPublicKey(rsaPublicKey, user);
			
		}catch(final Exception e){
			e.printStackTrace();
		}
	}
	
	//API -> Center
	public static JSONObject sendRecv(final String tx, final JSONObject data) throws Exception{
		JSONObject json = new JSONObject();
		
		final MultiValueMap<String, String> paraMap = new LinkedMultiValueMap<String, String>();
		final JSONObject innerJson = new JSONObject();
		innerJson.put("tx", tx);
		innerJson.put("data", data);
		
		logger.info("加密前数据："+innerJson.toJSONString());
		final String encParams = URLEncoder.encode(RC4_128_V2.encode(innerJson.toJSONString(), passwd),"UTF-8");

		
		logger.info("待发送加密的UID：encUserid:"+encUserid);
		logger.info("待发送加密的params:"+encParams);
		
		paraMap.add("userid", encUserid ); 
		paraMap.add("params", encParams);
		
		final String res = sender.postForObject(apiUrl, paraMap, String.class);
		if( StringUtils.isBlank(res)){
			logger.error("Return Nothing");
			json.put("errorCode", 301);
			json.put("message", "没有返回任何信息");
			return json;
		}
		logger.info("echo返回raw数据:"+res);
		
		json = handleResponse(res, json);
		
		return json;
		
	}
	
	
	//API -> Center
	public static String sendRecvHttps(final String tx,final JSONObject data) throws Exception{
		final MultiValueMap<String, String> paraMap = new LinkedMultiValueMap<String, String>();
		final JSONObject innerJson = new JSONObject();
		innerJson.put("tx", tx);
		innerJson.put("data", data);
		
		logger.info("加密前数据："+innerJson.toJSONString());

		
		logger.info("待发送的UID:"+user);
		logger.info("待发送的params:"+innerJson.toJSONString());
		
		paraMap.add("userid", user ); 
		final String sign = DigestUtils.md5Hex(user+passwd);
		logger.info("待发送的sign:"+sign);
		paraMap.add("sign", sign);
		paraMap.add("params", innerJson.toJSONString());
		SSLUtil.trustEveryone();
		final String res = sender.postForObject(apiUrlHttps, paraMap, String.class);
		if( StringUtils.isBlank(res)){
			logger.error("Return Nothing");
			return "没有返回任何信息";
		}
		logger.info("echo返回raw数据:"+res);
		
		return res;
		
	}
	/**
	 * @param res
	 * @throws Exception 
	 */
	private static JSONObject handleResponse(final String res, JSONObject json) throws Exception {
		
		final OuterEcFormat rec = (OuterEcFormat) JsonUtil.json2Object(res, OuterEcFormat.class);
		if( rec == null ){
			logger.error("无法识别响应");
			return null;
		}
		
		logger.info("errorCode:"+rec.getErrorCode());
		logger.info("message:"+rec.getMessage());
		logger.info("params:"+rec.getParams());
		
		json.put("errorCode", rec.getErrorCode());
		json.put("message", rec.getMessage());
		
		if( StringUtils.isBlank(rec.getParams())){
			logger.info("！！！！！！！！！！返回数据为空");
			return json;
		}
		
		final String decodeRes = RC4_128_V2.decode(URLDecoder.decode(rec.getParams(), "UTF-8"), passwd);
		
		JSONObject data = JSONObject.parseObject(decodeRes);
		
		logger.info("解密响应："+decodeRes);
		
		json.put("tx", data.get("tx"));
		json.put("data", data.get("data"));
		
		return json;
	}

	//Org -> Echo 
	public static JSONObject sendRecv( final OuterEcFormat req ) throws Exception{
		JSONObject json = new JSONObject();
		//加密关键内容
		
		final String encParams = URLEncoder.encode(RC4_128_V2.encode(req.getParams(), passwd),"UTF-8");
		req.setParams(encParams);
		final String toSend = JsonUtil.object2Json(req);
		logger.info("发送前："+toSend);
		final String res = sender.postForObject(apiUrl, toSend, String.class);
		logger.info("接收raw:"+res);
		return handleResponse(res, json);
	}

	/**
	 * @param user
	 * @param passwd
	 * @param apiUrl
	 * @param params
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public static String sendAndRecieve(final String user, final String passwd, final String apiUrl, final JSONObject params,final String tx) throws UnsupportedEncodingException {
		
		final MultiValueMap<String, String> paraMap = new LinkedMultiValueMap<String, String>();
		//公钥加密userid
		final RSAPublicKey rsaPublicKey = RSA_1024_V2.gainRSAPublicKeyFromCrtFile(System.getProperty("user.dir")
				+ "/ZC_PublicKey_V2.crt");
		final String encUserid = RSA_1024_V2.encodeByPublicKey(rsaPublicKey, user);

		
		final JSONObject innerJson = new JSONObject();
		innerJson.put("tx", tx);
		innerJson.put("data", params);
		
		
		logger.info("加密前数据："+innerJson.toJSONString());
		final String encParams = URLEncoder.encode(RC4_128_V2.encode(innerJson.toJSONString(), passwd),"UTF-8");
//		logger.info("params加密结果："+encParams);
//		
//		if( encParams != null ){
//			final String decParams = RC4_128_V2.decode(encParams, passwd);
//			logger.info("先自己解密试试:"+decParams);
//		}
		
		logger.info("待发送数据encUserid:"+encUserid);
		logger.info("待发送数据tosendJson:"+encParams);
		
		paraMap.add("userid", encUserid ); 
		paraMap.add("params", encParams);
		
		
		final String res = sender.postForObject(apiUrl, paraMap, String.class);
		if( StringUtils.isBlank(res)){
			logger.error("Return Nothing");
			return "Return Nothing";
		}
		logger.info("echo返回raw数据:"+res);
		
		final OuterEcFormat rec = (OuterEcFormat) JsonUtil.json2Object(res, OuterEcFormat.class);
		if( rec == null ){
			logger.error("无法识别响应，可能不是约定的格式");
			return null;
		}
		
		logger.info("errorCode:"+rec.getErrorCode());
		logger.info("message:"+rec.getMessage());
		logger.info("params:"+rec.getParams());
		if( StringUtils.isBlank(rec.getParams())){
			logger.info("！！！！！！！！！！返回数据为空");
			return null;
		}
		
		final String decodeRes = RC4_128_V2.decode(URLDecoder.decode(rec.getParams(), "UTF-8"), passwd);
		logger.info("解密响应："+decodeRes);
		final String data = JsonUtil.getNodeValue(decodeRes, "data");
		logger.info("data:"+data);
		
		
		
		
		return data;
	}
	public static String echoQueryOrg(final String url,final String rc4Key,final String name, final String idNo) throws UnsupportedEncodingException{
		final JSONObject data = new JSONObject();
		String strParams = "";
		data.put("name", name);
		data.put("idNo", idNo);
		final InnerEcParams inner = new InnerEcParams("201",data.toJSONString());
		logger.debug("defore eccrypt: " + inner.getJson());
		strParams = URLEncoder.encode(RC4_128_V2.encode(inner.getJson(), rc4Key),"UTF-8");

		final MultiValueMap<String, String> paraMap = new LinkedMultiValueMap<String, String>();
		final JSONObject jsonObject = new JSONObject();
		jsonObject.put("params", strParams);
		jsonObject.put("errorCode", "0000");
		jsonObject.put("message", "queryFromEcho");
		paraMap.add("params",  jsonObject.toJSONString());
		SSLUtil.trustEveryone();
		return sender.postForObject(url, paraMap
				, String.class);
	}


	/**
	 * 解密平台访问请求数据
	 * @param resjson
	 * @return
	 */
	public static JSONObject descEchoComeData(JSONObject resjson) {
		try {
			String dataField = URLDecoder.decode(resjson.getString("params"), "utf-8");
			System.out.println(dataField);
			final String decryptResult = RC4_128_V2.decode(dataField, passwd);
			return JSONObject.parseObject(decryptResult);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static String encResEchoData(JSONObject dataJson){
		try {
			return URLEncoder.encode(RC4_128_V2.encode(dataJson.toJSONString(), passwd),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return null;
	}
}
