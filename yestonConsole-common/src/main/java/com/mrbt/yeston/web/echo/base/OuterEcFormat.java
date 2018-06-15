package com.mrbt.yeston.web.echo.base;

import java.io.Serializable;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

/**
 * @description	API数据交换格式
 * @author Hoary (hoary_huang@foxmail.com)
 * @since 2016-04-29
 */
public class OuterEcFormat implements Serializable{
	
	private static final long serialVersionUID = 1949563506237821973L;

	/**
	 * 致诚公钥加密的用户编号
	 */
	//private String userid;
	
	/**
	 * 对称密钥加密的事务类型和通信内容(MUST)
	 */
	private transient InnerEcParams ecParams;
	
	private String params;
	
	/**
	 * 明文的响应状态码
	 */
	private int errorCode;
	
	/**
	 * 明文的响应状态码描述
	 */
	private String message;
	
	public OuterEcFormat() {
		ecParams = new InnerEcParams();
	}
	
	public OuterEcFormat(String data,int errorCode,String message) {
		this(data);
		this.errorCode = errorCode;
		this.message = message;
	}
	
	public OuterEcFormat(int errorCode,String message,String encParams) {
		this.errorCode = errorCode;
		this.message = message;
		this.params = encParams;
	}
	
	/**
	 * 给InnerEcParams对象的data属性赋值
	 * @param data
	 */
	public OuterEcFormat( String data ) {
		if( ecParams != null ){
			ecParams.setData(data);
		}else{
			ecParams = new InnerEcParams(data);
		}
	}
	
	@SuppressWarnings("unchecked")
	public String toJsonString() {
		final Map<String, Object> map = (Map<String,Object>) JSON.parse( params );
		final JSONObject jo = new JSONObject();
		final JSONObject paramJo = new JSONObject(map);
		jo.put("params", paramJo );
		jo.put("errorCode", errorCode);
		jo.put("message", message);
		
		final String json = jo.toJSONString();
		
		return json;
	}
	
	public InnerEcParams getInnerParams(){
		return this.ecParams;
	}
	
	public void setAll(String data,int errorCode,String message){
		if( ecParams != null ){
			ecParams.setData(data);
		}else{
			ecParams = new InnerEcParams(data);
		}
		this.errorCode = errorCode;
		this.message = message;
	}
	
	public void setAll(InnerEcParams params,int errorCode,String message){
		this.ecParams = params;
		this.errorCode = errorCode;
		this.message = message;
	}

	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}

	public int getErrorCode() {
		return errorCode;
	}


	public void setErrorCode(int errorCode) {
		this.errorCode = errorCode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
}
