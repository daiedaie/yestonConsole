/**
 * 
 */
package com.mrbt.yeston.web.echo.util;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;


/**
 * Json 工具
 * @author Hoary(hoary_huang@foxmail.com)
 * @since 2016-4-14
 */
public class JsonUtil {

	/**
	 * new Gson();
	 * new GsonBuilder().disableHtmlEscaping().serializeNulls().create();
	 * new GsonBuilder().disableHtmlEscaping().create();
	 */
	private static Gson gson = new Gson();
	/**
	 * json to object
	 * @param <T>
	 */
	public static <T> Object json2Object( String json, Class<T> clazz ){
		return gson.fromJson(json, clazz);
	}

	/**
	 * object to json
	 */
	public static String object2Json( Object obj ){
		return gson.toJson(obj);
	}
	
	
	public static String getNodeValue(String json, String nodeName){
		return JSONObject.parseObject(json).getString(nodeName);
	}
	

}
