package com.mrbt.yeston.echoTest;

import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.configuration.ConfigurationException;

import com.alibaba.fastjson.JSONObject;
import com.mrbt.yeston.web.echo.base.ApiQueryClient;
import com.mrbt.yeston.web.echo.util.ApiRestTemplate;

public class UploadIdNoClient extends ApiQueryClient{

	/**
	 * @param args
	 * @throws ConfigurationException
	 */
	public static void main(final String[] args) throws ConfigurationException {
		
		try {
			System.out.println("["+df.format(new Date())+"]给echo上传身份证了~~~upload cert------------upcert");
			JSONObject data = null;
			final JSONObject params = new JSONObject();
			final ArrayList<String> idNos = new ArrayList<String>();
			
			idNos.add("511123199206150322");
			params.put("idNos", idNos);
			
			data = ApiRestTemplate.sendRecv("301", params);
			
			System.out.println(data);
		} catch (final Exception e) {
			e.printStackTrace(); 
		}
		
		System.out.println("["+df.format(new Date())+"]上传身份证号结束~~~~~~~~");
	}

}
