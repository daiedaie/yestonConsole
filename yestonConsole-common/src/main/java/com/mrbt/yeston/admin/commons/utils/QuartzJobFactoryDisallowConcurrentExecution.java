package com.mrbt.yeston.admin.commons.utils;

import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.mrbt.yeston.web.model.ScheduleJob;

/**
 * 
 * @Description: 若一个方法一次执行不完，下次轮转时则等待该方法执行完后才执行下一次操作
 * @author 
 * @date 2016.12
 */
@DisallowConcurrentExecution
public class QuartzJobFactoryDisallowConcurrentExecution implements Job {

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		ScheduleJob scheduleJob = (ScheduleJob) context.getMergedJobDataMap().get("scheduleJob");
		TaskUtils.invokMethod(scheduleJob);
	}
}