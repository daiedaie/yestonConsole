package com.mrbt.yeston.web.utils;

import java.beans.PropertyDescriptor;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.PropertyUtilsBean;

import com.mysql.fabric.xmlrpc.Client;

/**
 * 公用工具类
 * 
 * @author yjq
 *
 */
public class Common {
	
	/**
	 * 获取uuid
	 * @return
	 */
	public static String getUUID(){
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	/**
	 * 读取配置文件
	 * 
	 * @param fileName
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public static String getPropertyVal(String fileName, String key) throws Exception {
		Common c = new Common();
		String classPath = c.getPath();
		Properties pps = new Properties();
		pps.load(new FileInputStream(classPath + fileName));
		String strValue = pps.getProperty(key);
		return strValue;
	}

	public static String getStaticProperty(String fileName, String key) {
		try {
			// Common c=new Common();
			// String classPath = c.getPath();
			Properties pps = new Properties();
			pps.load(new InputStreamReader(Client.class.getClassLoader().getResourceAsStream(fileName), "UTF-8"));
			// pps.load(new FileInputStream(classPath + fileName));
			String strValue = pps.getProperty(key);
			return strValue;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取路径
	 * 
	 * @return
	 */
	public String getPath() {
		return this.getClass().getResource("/").getPath();
	}

	/**
	 * 获取一个类(包括父类) 所有的属性的值
	 * 
	 * @param obj
	 * @return {title=welcome!, description=欢迎来到你的保！,
	 *         url=http://test.lingmoney.cn/}
	 * @throws Exception
	 * @author yjq
	 */
	public static <T> Map<String, Object> getField(T obj) throws Exception {
		Map<String, Object> resMap = new HashMap<String, Object>();
		//
		Class<?> clazz = obj.getClass();
		Field[] field = clazz.getDeclaredFields();
		List<Field> fieldList = new ArrayList<Field>(Arrays.asList(field));
		if (!clazz.getSuperclass().getName().equals("java.lang.Object")) {
			// 获取父类
			Class<?> fatherClazz = clazz.getSuperclass();
			Field[] fatherField = fatherClazz.getDeclaredFields();
			List<Field> fFieldList = Arrays.asList(fatherField);
			// 有父类
			fieldList.addAll(fFieldList);
		}

		// 遍历
		for (int i = 0; i < fieldList.size(); i++) {
			String fieldName = fieldList.get(i).getName();
			String newName = fieldName.replaceFirst(fieldName.substring(0, 1), fieldName.substring(0, 1).toUpperCase());
			String fieldMethod = "get" + newName;
			Method m = clazz.getMethod(fieldMethod);
			Object value = m.invoke(obj);
			// resMap.put(fieldName, value)
			if (value != null) {
				if (!value.getClass().getName().equals("java.lang.String")) {
					Map<String, Object> sonResMap = new HashMap<String, Object>();
					sonResMap = Common.getField(value);
					resMap.put(fieldName, sonResMap);
				} else {
					resMap.put(fieldName, value);
				}
			}

		}
		return resMap;
	}

	/**
	 * 日期加天数 返回新日期
	 * 
	 * @param d
	 * @param day
	 * @return
	 * @throws ParseException
	 */
	public static Date addDate(Date d, long day) throws ParseException {
		long time = d.getTime();
		day = day * 24 * 60 * 60 * 1000;
		time += day;
		return new Date(time);
	}

	/**
	 * 随机生成 num位数字字符数组
	 * 
	 * @param num
	 * @return
	 */
	public static char[] generateRandomArray(int num) {
		String chars = "0123456789";
		char[] rands = new char[num];
		for (int i = 0; i < num; i++) {
			int rand = (int) (Math.random() * 10);
			rands[i] = chars.charAt(rand);
		}
		return rands;
	}
	
	/**
	 * 获取字母和数字的随机串
	 * @param num 位数
	 * @return
	 */
	public static String generateRandomCharArray(int num) {
		String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		String res = "";
		for (int i = 0; i < num; i++) {
			Random rd = new Random();
			res += chars.charAt(rd.nextInt(chars.length() - 1));
		}
		return res;
	}
	
	/**
	 * 获取ip
	 * @param request
	 * @return
	 */
	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	/**
	 * 实体类转换成map
	 * @param obj
	 * @return
	 */
	public static Map<String, Object> beanToMap(Object obj) {
		Map<String, Object> params = new HashMap<String, Object>(0);
		try {
			PropertyUtilsBean propertyUtilsBean = new PropertyUtilsBean();
			PropertyDescriptor[] descriptors = propertyUtilsBean.getPropertyDescriptors(obj);
			for (int i = 0; i < descriptors.length; i++) {
				String name = descriptors[i].getName();
				if (!"class".equals(name)) {
					params.put(name, propertyUtilsBean.getNestedProperty(obj, name));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return params;
	}
	
}
