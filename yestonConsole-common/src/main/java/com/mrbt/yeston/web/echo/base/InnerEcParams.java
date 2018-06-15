/**
 * 
 */
package com.mrbt.yeston.web.echo.base;

import com.alibaba.fastjson.JSONObject;

/**
 * @description params里边的具体内容
 * @author Hoary (hoary_huang@foxmail.com)
 * @since 2016年4月29日
 */
public class InnerEcParams {
	
	/**
	 * 事务类型
	 */
	private String tx;
	
	/**
	 * 内容
	 */
	private String data;
	
	public InnerEcParams() {
	}
	
	public InnerEcParams( String data ) {
		this.data = data;
	}
	
	public String getJson(){
		final JSONObject jo = new JSONObject();
		jo.put("tx", tx);
		jo.put("data", JSONObject.parseObject(data));
		
		final String json = jo.toJSONString();
		
		return json;
	}
	
	public InnerEcParams( String tx,String data ) {
		this.tx = tx;
		this.data = data;
	}

	public String getTx() {
		return tx;
	}

	public void setTx(String tx) {
		this.tx = tx;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
}
