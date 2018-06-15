package com.mrbt.yeston.service;

import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.web.model.ScheduleJob;
import com.mrbt.yeston.web.model.ScheduleJobExample;

/**
 *@author syb
 *@date 2017年5月17日 上午10:31:53
 *@version 1.0
 *@description 定时任务
 **/
public interface ScheduleService {

	/**
	 * 根据JOBID获取任务
	 * @param jobId
	 * @return
	 */
	ScheduleJob getTaskById(Integer jobId);

	/**
	 * 获取全部任务
	 * @param example
	 * @return
	 */
	PageInfo getAllTask(ScheduleJobExample example);

	/**
	 * 添加任务
	 * @param scheduleJob
	 * @return
	 */
	PageInfo addTask(ScheduleJob scheduleJob);

	/**
	 * 修改任务状态
	 * @param jobId
	 * @param cmd
	 */
	PageInfo changeStatus(Integer jobId, Integer status);

	/**
	 * 修改执行时间
	 * @param jobId
	 * @param cron
	 */
	PageInfo updateCron(Integer jobId, String cron);

	/**
	 * 立即执行
	 * @param jobId
	 */
	PageInfo executeJobNow(Integer jobId);

	/**
	 * 暂停任务
	 * @param jobId
	 */
	PageInfo pauseJob(Integer jobId);

	/**
	 * 恢复任务
	 * @param jobId
	 */
	PageInfo resumeJob(Integer jobId);

	/**
	 * 保存操作日志
	 * @param jobId
	 * @param description
	 * @param errorLog
	 */
	void saveScheduleLog(Integer jobId, String description, String errorLog);

	/**
	 * 编辑任务
	 * 
	 * @param scheduleJob
	 * @return
	 */
	PageInfo editSchedule(ScheduleJob scheduleJob);

	/***
	 * 删除任务
	 * 
	 * @param jobId
	 * @return
	 */
	PageInfo removeSchedule(Integer jobId);
}
