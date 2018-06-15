package com.mrbt.yeston.admin.commons.utils;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.mrbt.yeston.admin.commons.scan.SpringUtils;
import com.mrbt.yeston.web.model.ScheduleJob;

public class TaskUtils {
	
	private static final Logger LOGGER = LogManager.getLogger(TaskUtils.class);

	/**
	 * 通过反射调用scheduleJob中定义的方法
	 * 
	 * @param scheduleJob
	 */
	public static void invokMethod(ScheduleJob scheduleJob) {
		Object object = null;
		Class<?> clazz = null;
		if (StringUtils.isNotBlank(scheduleJob.getSpringId())) {
			object = SpringUtils.getBean(scheduleJob.getSpringId());
		} else if (StringUtils.isNotBlank(scheduleJob.getBeanClass())) {
			try {
				clazz = Class.forName(scheduleJob.getBeanClass());
				object = clazz.newInstance();
			} catch (Exception e) {
				LOGGER.error(e.getMessage(), e);
				e.printStackTrace();
				return;
			}
		}
		if (object == null) {
			LOGGER.error("---task [" + scheduleJob.getJobGroup()+"."+scheduleJob.getJobName() + "] has failed to start.Please check the configuration.---");
			return;
		}
		clazz = object.getClass();
		Method method = null;
		try {
			method = clazz.getDeclaredMethod(scheduleJob.getMethodName());
		} catch (NoSuchMethodException e) {
			LOGGER.error("---task [" + scheduleJob.getJobGroup()+"."+scheduleJob.getJobName() + "]  has failed to start. The method's name is wrong.---");
			return;
		} catch (SecurityException e) {
			LOGGER.error(e.getMessage(), e);
			e.printStackTrace();
			return;
		}
		if (method != null) {
			try {
				method.invoke(object);
			} catch (IllegalAccessException e) {
				LOGGER.error(e.getMessage(), e);
				e.printStackTrace();
				return;
			} catch (IllegalArgumentException e) {
				LOGGER.error(e.getMessage(), e);
				e.printStackTrace();
				return;
			} catch (InvocationTargetException e) {
				LOGGER.error(e.getMessage(), e);
				e.printStackTrace();
				return;
			}
		}
		System.out.println("---task [" + scheduleJob.getJobGroup()+"."+scheduleJob.getJobName() + "]  is has been excuted.---");
	}
}
