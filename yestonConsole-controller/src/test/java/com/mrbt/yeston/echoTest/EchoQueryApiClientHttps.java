package com.mrbt.yeston.echoTest;

import java.util.Date;

import org.apache.commons.configuration.ConfigurationException;

import com.alibaba.fastjson.JSONObject;
import com.mrbt.yeston.web.echo.base.ApiQueryClient;
import com.mrbt.yeston.web.echo.util.ApiRestTemplate;

/**
 * 
 * @author Derek Zhu
 *
 */
public class EchoQueryApiClientHttps extends ApiQueryClient {

	/**
	 * @param args
	 * @throws ConfigurationException
	 */
	public static void main(final String[] args) throws ConfigurationException {

		try {
			String data = null;

			System.out.println("[" + df.format(new Date()) + "]查询程序启动~~~~~~~~");
			final JSONObject params = new JSONObject();

			final String name = "兰江洋";
			final String idNo = "420527198911033893";
			params.put("name", name);
			params.put("idNo", idNo);
			params.put("queryReason", "10");

			final long startTime = System.currentTimeMillis();
			data = ApiRestTemplate.sendRecvHttps("101", params);
			System.out.println(data);
			final long endTime = System.currentTimeMillis();
			System.out.println("Time duration: " + formatDuring(endTime - startTime));
			System.out.println("[" + df.format(new Date()) + "]查询程序结束~~~~~~~~");

		} catch (final Exception e) {
			e.printStackTrace();
		}
	}

	public static String formatDuring(final long mss) {
		final long days = mss / (1000 * 60 * 60 * 24);
		final long hours = (mss % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60);
		final long minutes = (mss % (1000 * 60 * 60)) / (1000 * 60);
		final long seconds = (mss % (1000 * 60)) / 1000;
		return days + " days " + hours + " hours " + minutes + " minutes " + seconds + " seconds ";
	}
}
