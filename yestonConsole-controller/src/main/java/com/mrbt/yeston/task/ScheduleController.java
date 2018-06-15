package com.mrbt.yeston.task;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.echo.controller.EchoApiController;
import com.mrbt.yeston.service.ScheduleService;
import com.mrbt.yeston.web.model.ScheduleJob;
import com.mrbt.yeston.web.model.ScheduleJobExample;

/**
 *@author syb
 *@date 2017年5月17日 上午10:29:11
 *@version 1.0
 *@description 定时任务管理
 **/
@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	private static final Logger LOGGER = LogManager.getLogger(EchoApiController.class);
	
	@Autowired
	private ScheduleService scheduleService;
	
	@RequestMapping("manager")
	public String manager(HttpServletRequest request, HttpServletResponse response) {
		LOGGER.info("计划任务管理后台");
		return "/schedule/scheduleList";
	}
	/**
	 * 任务修改
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/editSchedule")
	public @ResponseBody Object editSchedule(ScheduleJob scheduleJob) {
		PageInfo pi = new PageInfo();
		try {
			pi = scheduleService.editSchedule(scheduleJob);
		} catch (Exception e) {
			pi.setCode(500);
			pi.setMsg("系统错误");
			e.printStackTrace();
		}

		return pi;
	}

	/**
	 * 删除任务
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/removeSchedule")
	public @ResponseBody Object removeSchedule(Integer jobId) {
		PageInfo pi = new PageInfo();

		try {
			pi = scheduleService.removeSchedule(jobId);
		} catch (Exception e) {
			pi.setCode(500);
			pi.setMsg("系统错误");
			e.printStackTrace();
		}

		return pi;
	}

	/**
	 * 请求任务添加页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/scheduleAdd", method = RequestMethod.GET)
	public String taskAdd(HttpServletRequest request) {
		return "/schedule/scheduleAdd";
	}

	/**
	 * 请求任务列表
	 * 
	 * @param page
	 * @param rows
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/scheduleList")
	public @ResponseBody Object taskList(HttpServletRequest request, Integer page, Integer rows, Integer jobId,
			String jobStatus, String jobName) {
		PageInfo retObj = null;
		if (page != null && rows != null) {
			retObj = new PageInfo(page, rows);
			ScheduleJobExample example = new ScheduleJobExample();
			example.setLimitStart(retObj.getFrom());
			example.setLimitEnd(retObj.getSize());
			ScheduleJobExample.Criteria cri = example.createCriteria();
			if (jobId != null) {
				cri.andJobIdEqualTo(jobId);
			}
			if (StringUtils.isNotBlank(jobStatus)) {
				cri.andJobStatusEqualTo(NumberUtils.toInt(jobStatus));
			}
			if (StringUtils.isNotBlank(jobName)) {
				cri.andJobNameEqualTo(jobName);
			}
			retObj = scheduleService.getAllTask(example);
			retObj.setCode(200);
		} else {
			retObj = new PageInfo();
			retObj.setCode(1001);
		}

		return retObj;
	}

	/**
	 * 添加任务
	 * 
	 * @param request
	 * @param scheduleJob
	 * @return
	 */
	@RequestMapping(value = "/scheduleAdd", method = RequestMethod.POST)
	@ResponseBody
	public PageInfo addTask(HttpServletRequest request, ScheduleJob scheduleJob) {
		PageInfo pi = new PageInfo();
		try {
			pi = scheduleService.addTask(scheduleJob);
		} catch (Exception e) {
			e.printStackTrace();
			pi.setCode(500);
			pi.setMsg("保存失败");
		}
		return pi;
	}

	@RequestMapping(value = "/changeJobStatus", method = RequestMethod.POST)
	@ResponseBody
	public PageInfo changeJobStatus(HttpServletRequest request, Integer jobId, Integer status) {
		PageInfo pi = new PageInfo();
		try {
			pi = scheduleService.changeStatus(jobId, status);
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
			pi.setCode(500);
			pi.setMsg("任务状态改变失败！");
		}
		return pi;
	}

	/**
	 * 更改任务执行时间
	 * @param request
	 * @param jobId
	 * @param cron
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateCron", method = RequestMethod.POST)
	public PageInfo updateCron(HttpServletRequest request, Integer jobId, String cron) {
		PageInfo pi = new PageInfo();
		try {
			pi = scheduleService.updateCron(jobId, cron);
		} catch (Exception e) {
			pi.setMsg("cron更新失败！");
			pi.setCode(500);
		}
		return pi;
	}

	/**
	 * 立即执行任务
	 * @param id
	 */
	@RequestMapping("/executeJobNow")
	public @ResponseBody Object executeJobNow(Integer jobId, HttpServletResponse response) {
		PageInfo pi = new PageInfo();
		try {
			pi = scheduleService.executeJobNow(jobId);
		} catch (Exception e) {
			e.printStackTrace();
			pi.setCode(500);
			pi.setMsg("系统错误");
			LOGGER.error("立即执行定时任务失败，系统错误。" + e.getMessage());
		}
		return pi;
	}
	
	/**
	 * 暂停任务
	 * @param jobId
	 * @param response
	 */
	@RequestMapping("/pauseJob")
	public @ResponseBody Object pauseJob (HttpServletResponse response, Integer jobId) {
		PageInfo pi = new PageInfo();
		try {
			pi = scheduleService.pauseJob(jobId);
			response.getWriter().write("success");
		} catch (Exception e) {
			e.printStackTrace();
			pi.setCode(500);
			pi.setMsg("系统错误");
			LOGGER.error("暂停计划任务失败,系统错误");
		}
		return pi;
	}
	
	@RequestMapping("/resumeJob")
	public @ResponseBody Object resumeJob (HttpServletResponse response, Integer jobId) {
		PageInfo pi = new PageInfo();
		try {
			pi = scheduleService.resumeJob(jobId);
		} catch (Exception e) {
			e.printStackTrace();
			pi.setCode(500);
			pi.setMsg("系统错误");
			LOGGER.error("系统错误" + e.getMessage());
		}
		return pi;
	}
	
}
