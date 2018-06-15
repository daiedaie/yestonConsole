package com.mrbt.yeston.task;

import java.util.Date;
import java.util.List;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import com.mrbt.yeston.web.mapper.YtCarLoanLogMapper;
import com.mrbt.yeston.web.mapper.YtCarLoanMapper;
import com.mrbt.yeston.web.model.YtCarLoan;
import com.mrbt.yeston.web.model.YtCarLoanExample;
import com.mrbt.yeston.web.model.YtCarLoanLog;

@Component
public class ScheduleTask1{
	
	@Autowired
	private YtCarLoanMapper ytCarLoanMapper;
	@Autowired
	private TaskService taskActivitiService;
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	private YtCarLoanLogMapper ytCarLoanLogMapper;

//	@Scheduled(cron = "0 0 0 * * ?")
	private void runTask() {
		YtCarLoanExample example = new YtCarLoanExample();
		example.createCriteria().andStatusEqualTo(17);
		List<YtCarLoan> list = ytCarLoanMapper.selectByExample(example);
		if (list != null && list.size() > 0) {
			for (YtCarLoan ytCarLoan : list) {
				// 借款日期
				Long loanTime = ytCarLoan.getLoanTime().getTime();
				// 现在的时间
				Long currentTime = System.currentTimeMillis();
				// 借款期限
				Integer loanTerm = ytCarLoan.getLoanTerm();
				// 已经过去的天数
				Long passTime = (currentTime - loanTime) / 1000 / 3600 / 24;
				if (passTime >= (loanTerm - 3)) {// 需要催款
					List<Task> taskList = taskActivitiService.createTaskQuery().taskCandidateOrAssigned(String.valueOf(1)).list();
					if (taskList != null && taskList.size() > 0) {
						for (Task task : taskList) {
							// 根据业务id找到任务id
							String processInstanceId = task.getProcessInstanceId();
							ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
									.processInstanceId(processInstanceId).singleResult();
							String businessKey = processInstance.getBusinessKey();

							if (ytCarLoan.getId().equals(businessKey)) {// 找到业务id对应的任务
								// 办理任务
								taskActivitiService.complete(task.getId());

								// 改变状态
								YtCarLoan newYtCarLoan = new YtCarLoan();
								newYtCarLoan.setId(ytCarLoan.getId());
								newYtCarLoan.setStatus(18);
								ytCarLoanMapper.updateByPrimaryKeySelective(newYtCarLoan);

								// 插入日志
								YtCarLoanLog record = new YtCarLoanLog();
								record.setCarLoanId(newYtCarLoan.getId());
								record.setOperInfo(task.getName());
								record.setOperTime(new Date());
								record.setOperUserId(0);
								record.setStatus(18);
								ytCarLoanLogMapper.insertSelective(record);
							}
						}
					}
				}
			}
		}
	}
}
