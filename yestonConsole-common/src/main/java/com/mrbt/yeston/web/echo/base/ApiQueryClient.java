package com.mrbt.yeston.web.echo.base;

import java.text.SimpleDateFormat;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;

/**
 * @description
 * @author Hoary (hoary_huang@foxmail.com)
 * @since 2016年8月10日
 */
public class ApiQueryClient {
	protected static final SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss SSS");
	private static PropertiesConfiguration config;
	protected static String user = null;
	protected static String passwd = null;
	protected static String apiUrl = null;
	protected static String hisUrl = null;
	static{
		try {
			config = new PropertiesConfiguration("prop.properties");
			user = config.getString("userId");
			passwd = config.getString("password");
			apiUrl = config.getString("apiUrlForEchoQuery");
			hisUrl = config.getString("apiUrlForEchoHistory");
		} catch (final ConfigurationException e) {
			e.printStackTrace();
		}
	}
}
