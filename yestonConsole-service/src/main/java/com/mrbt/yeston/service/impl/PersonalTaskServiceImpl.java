package com.mrbt.yeston.service.impl;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mrbt.yeston.admin.commons.exception.ServiceException;
import com.mrbt.yeston.admin.commons.utils.FtpUtils;
import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.service.PersonalTaskService;
import com.mrbt.yeston.web.mapper.PersonTaskMapper;
import com.mrbt.yeston.web.mapper.YtBankInfoMapper;
import com.mrbt.yeston.web.mapper.YtCarLoanLogMapper;
import com.mrbt.yeston.web.mapper.YtCarLoanMapper;
import com.mrbt.yeston.web.mapper.YtMoneyFlowMapper;
import com.mrbt.yeston.web.model.YtBankInfo;
import com.mrbt.yeston.web.model.YtCarLoan;
import com.mrbt.yeston.web.model.YtCarLoanLog;
import com.mrbt.yeston.web.model.YtMoneyFlow;
import com.mrbt.yeston.web.utils.Common;
import com.mrbt.yeston.web.vo.CommentVo;
import com.mrbt.yeston.web.vo.TaskVo;
import com.mrbt.yeston.web.vo.YtBankInfoVo;

/**
 * @author 罗鑫 Date 2017年3月13日
 */
@Service
public class PersonalTaskServiceImpl implements PersonalTaskService {
	@Autowired
	private TaskService taskActivitiService;
	@Autowired
	private RepositoryService repositoryService;
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	private PersonTaskMapper personTaskMapper;
	@Autowired
	private YtCarLoanMapper ytCarLoanMapper;
	@Autowired
	private YtCarLoanLogMapper ytCarLoanLogMapper;
	@Autowired
	private FtpUtils ftpUtils;
	@Autowired
	private YtMoneyFlowMapper ytMoneyFlowMapper;
	@Autowired
	private YtBankInfoMapper ytBankInfoMapper;

	@Override
	public void transactTask(String taskId, String carLoanId, String commentMsg, Long uId, String outcome,
			Map<String, List<MultipartFile>> map) throws Exception {
		// 任务对象
		Task task = taskActivitiService.createTaskQuery().taskId(taskId).singleResult();
		// 业务对象
		YtCarLoan ytCarLoan = ytCarLoanMapper.selectByPrimaryKey(carLoanId);
		// 流程id
		String processInstanceId = task.getProcessInstanceId();

		List<String> urlList = null;
		StringBuilder returnUrl = null;
		// 1.上传凭证
		out:for (Entry<String, List<MultipartFile>> set : map.entrySet()) {
			List<MultipartFile> pics = set.getValue();
			urlList = new ArrayList<>();
			for (MultipartFile file : pics) {
				if (file.getSize() == 0) {
					break out;
				}
				InputStream stream = file.getInputStream();
				String filename = file.getOriginalFilename();
				String savePath = "/ytCarLoan/" + carLoanId + "/evidence";
				try {
					ftpUtils.upload(stream, savePath, filename);
				} catch (Exception e) {
					ftpUtils.upload(stream, savePath, filename);
				}
				String url = ftpUtils.getUrl() + "ytCarLoan/" + carLoanId + "/evidence/" + filename;
				urlList.add(url);
			}
			returnUrl = new StringBuilder();
			if (urlList.size() > 0) {
				for (int i = 0; i < urlList.size(); i++) {
					returnUrl.append(urlList.get(i));
					if (i < urlList.size() - 1) {
						returnUrl.append(",");
					}
				}
			}
		}

		// 办理任务
		Map<String, Object> variables = new HashMap<String, Object>();
		if (outcome != null && !outcome.equals("完成")) {
			variables.put("outcome", outcome);
		}

		String taskName = task.getName();
		YtCarLoan carLoan = new YtCarLoan();
		carLoan.setId(carLoanId);
		// 查询下一办理人，分公司审核
		List<Integer> branchCheckUser = personTaskMapper.findBranchCheckUserByBusinessKey(carLoanId,uId);
		List<String> branchCheck = new ArrayList<>();
		for (Integer u : branchCheckUser) {
			branchCheck.add(String.valueOf(u));
		}
		// 供应商财务
		List<Integer> cooperateFinanceUser = personTaskMapper.findCooperateFinanceByCooperateId(ytCarLoan.getCooperateId());
		List<String> cooperateFinance = new ArrayList<>();
		for (Integer u : cooperateFinanceUser) {
			cooperateFinance.add(String.valueOf(u));
		}

		// 插入日志
		YtCarLoanLog record = new YtCarLoanLog();
		record.setCarLoanId(carLoanId);
		record.setOperInfo(taskName);
		record.setOperTime(new Date());
		record.setOperUserId(uId.intValue());
		if(returnUrl != null){
			record.setVoucher(returnUrl.toString());
		}

		if (taskName.equals("申请人确认申请")) {
			// 改变业务数据状态
			carLoan.setStatus(3);
			record.setStatus(3);
			// 设置下一办理人
			variables.put("branchCheckUser", branchCheck);
		} else if (taskName.equals("初审")) {
			if (outcome.equals("通过")) {
				carLoan.setStatus(4);
				record.setStatus(4);
				variables.put("branchCheckUser", branchCheck);
			} else if (outcome.equals("驳回")) {
				carLoan.setStatus(25);
				record.setStatus(25);
				variables.put("inputUser", ytCarLoan.getUserId());
			} else if (outcome.equals("拒绝")) {
				carLoan.setStatus(26);
				record.setStatus(26);
			}
		} else if (taskName.equals("复审")) {
			if (outcome.equals("通过")) {
				carLoan.setStatus(5);
				record.setStatus(5);
			} else if (outcome.equals("驳回")) {
				record.setStatus(25);
				carLoan.setStatus(25);
				variables.put("inputUser", ytCarLoan.getUserId());
			} else if (outcome.equals("拒绝")) {
				record.setStatus(26);
				carLoan.setStatus(26);
			}
		} else if (taskName.equals("终审")) {
			if (outcome.equals("通过")) {
				carLoan.setStatus(6);
				record.setStatus(6);
			} else if (outcome.equals("驳回")) {
				record.setStatus(25);
				carLoan.setStatus(25);
				variables.put("inputUser", ytCarLoan.getUserId());
			} else if (outcome.equals("拒绝")) {
				record.setStatus(26);
				carLoan.setStatus(26);
			}
		} else if (taskName.equals("垫付账户放款")) {
			carLoan.setStatus(7);
			record.setStatus(7);
			variables.put("cooperateFinanceUser", cooperateFinance);
		} else if (taskName.equals("验收垫付款")) {
			record.setStatus(8);
			carLoan.setStatus(8);
			carLoan.setLoanTime(new Date());
		} else if (taskName.equals("是否发布产品")) {
			if (outcome.equals("发布")) {
				record.setStatus(9);
				carLoan.setStatus(9);
			} else {
				record.setStatus(8);
				carLoan.setStatus(8);
			}
		} else if (taskName.equals("募集完成")) {
			carLoan.setStatus(10);
			record.setStatus(10);
		} else if (taskName.equals("借款账户放款")) {
			carLoan.setStatus(11);
			record.setStatus(11);
			variables.put("cooperateFinanceUser", cooperateFinance);
		} else if (taskName.equals("供应商收款")) {
			carLoan.setStatus(12);
			record.setStatus(12);
			variables.put("cooperateFinanceUser", cooperateFinance);
		} else if (taskName.equals("归还垫付款")) {
			record.setStatus(13);
			carLoan.setStatus(13);
		} else if (taskName.equals("总部回收垫付款")) {
			record.setStatus(14);
			carLoan.setStatus(14);
		} else if (taskName.equals("保证金申请")) {
			record.setStatus(15);
			carLoan.setStatus(15);
			variables.put("cooperateFinanceUser", cooperateFinance);
		} else if (taskName.equals("缴纳保证金")) {
			record.setStatus(16);
			carLoan.setStatus(16);
		} else if (taskName.equals("保证金收款")) {
			record.setStatus(17);
			carLoan.setStatus(17);
		} else if (taskName.equals("是否催款")) {
			record.setStatus(18);
			carLoan.setStatus(18);
		} else if (taskName.equals("总部催款")) {
			record.setStatus(19);
			carLoan.setStatus(19);
			variables.put("cooperateFinanceUser", cooperateFinance);
		} else if (taskName.equals("供应商还款")) {
			record.setStatus(20);
			carLoan.setStatus(20);
		} else if (taskName.equals("总部确认收款")) {
			record.setStatus(21);
			carLoan.setStatus(21);
		} else if (taskName.equals("退还保证金")) {
			record.setStatus(22);
			carLoan.setStatus(22);
			variables.put("cooperateFinanceUser", cooperateFinance);
		} else if (taskName.equals("供应商回收保证金")) {
			record.setStatus(23);
			carLoan.setStatus(23);
		}

		// 添加批注
		if(returnUrl != null){
			commentMsg = commentMsg + "&&" + returnUrl.toString();
		}
		Authentication.setAuthenticatedUserId(String.valueOf(uId));
		taskActivitiService.addComment(taskId, processInstanceId, commentMsg);
		
		ytCarLoanMapper.updateByPrimaryKeySelective(carLoan);
		ytCarLoanLogMapper.insertSelective(record);
		taskActivitiService.complete(taskId, variables);
	}

	@Override
	public PageInfo<TaskVo> findDataGrid(Integer page, Integer rows, Long userId) {
		PageInfo<TaskVo> pageInfo = new PageInfo<>(page, rows);
		TaskQuery query = taskActivitiService.createTaskQuery();
		List<Task> list = null;
		list = query.taskCandidateOrAssigned(String.valueOf(userId))// 指定个人任务查询
				.orderByTaskCreateTime().asc()//
				.listPage((page - 1) * rows, rows);
		List<TaskVo> returnList = new ArrayList<>();
		if (list != null && list.size() > 0) {
			for (Task task : list) {
				TaskVo vo = new TaskVo();
				String processInstanceId = task.getProcessInstanceId();
				ProcessInstance pi = runtimeService.createProcessInstanceQuery()//
						.processInstanceId(processInstanceId)// 使用流程实例ID查询
						.singleResult();
				vo.setYtCarLoanId(pi.getBusinessKey());
				vo.setTaskId(task.getId());
				vo.setTaskName(task.getName());
				vo.setCreateTime(task.getCreateTime());
				vo.setUserName(personTaskMapper.findUserNameById(userId.intValue()));
				returnList.add(vo);
			}
		}
		pageInfo.setRows(returnList);
		pageInfo.setTotal((int) query.count());
		return pageInfo;
	}

	@Override
	public ProcessDefinition findProcessDefinitionByTaskId(String taskId) {
		Task task = taskActivitiService.createTaskQuery()//
				.taskId(taskId)// 使用任务ID查询
				.singleResult();
		// 查询流程定义的对象
		return repositoryService.createProcessDefinitionQuery()// 创建流程定义查询对象，对应表act_re_procdef
				.processDefinitionId(task.getProcessDefinitionId())// 使用流程定义ID查询
				.singleResult();
	}

	@Override
	public Map<String, Object> findCoordinate(String taskId) {
		// 存放坐标
		Map<String, Object> map = new HashMap<String, Object>();
		// 使用任务ID，查询任务对象
		Task task = taskActivitiService.createTaskQuery()//
				.taskId(taskId)// 使用任务ID查询
				.singleResult();
		// 获取流程定义的ID
		String processDefinitionId = task.getProcessDefinitionId();
		// 获取流程定义的实体对象（对应.bpmn文件中的数据）
		ProcessDefinitionEntity processDefinitionEntity = (ProcessDefinitionEntity) repositoryService
				.getProcessDefinition(processDefinitionId);
		// 流程实例ID
		String processInstanceId = task.getProcessInstanceId();
		// 使用流程实例ID，查询正在执行的执行对象表，获取当前活动对应的流程实例对象
		ProcessInstance pi = runtimeService.createProcessInstanceQuery()// 创建流程实例查询
				.processInstanceId(processInstanceId)// 使用流程实例ID查询
				.singleResult();
		// 获取当前活动的ID
		String activityId = pi.getActivityId();
		// 获取当前活动对象
		ActivityImpl activityImpl = processDefinitionEntity.findActivity(activityId);// 活动ID
		// 获取坐标
		map.put("x", activityImpl.getX());
		map.put("y", activityImpl.getY());
		map.put("width", activityImpl.getWidth());
		map.put("height", activityImpl.getHeight());
		return map;

	}

	@Override
	public YtCarLoan findDataDetailByTaskId(String taskId) {
		// 1：使用任务ID，查询任务对象Task
		Task task = taskActivitiService.createTaskQuery()//
				.taskId(taskId)// 使用任务ID查询
				.singleResult();
		// 2：使用任务对象Task获取流程实例ID
		String processInstanceId = task.getProcessInstanceId();
		// 3：使用流程实例ID，查询正在执行的执行对象表，返回流程实例对象
		ProcessInstance pi = runtimeService.createProcessInstanceQuery()//
				.processInstanceId(processInstanceId)// 使用流程实例ID查询
				.singleResult();
		return ytCarLoanMapper.selectByPrimaryKey(pi.getBusinessKey());
	}

	@Override
	public List<String> findOutcomeListByTaskId(String taskId) {
		// 返回存放连线的名称集合
		List<String> list = new ArrayList<String>();
		// 1:使用任务ID，查询任务对象
		Task task = taskActivitiService.createTaskQuery()//
				.taskId(taskId)// 使用任务ID查询
				.singleResult();
		// 2：获取流程定义ID
		String processDefinitionId = task.getProcessDefinitionId();
		// 3：查询ProcessDefinitionEntiy对象
		ProcessDefinitionEntity processDefinitionEntity = (ProcessDefinitionEntity) repositoryService
				.getProcessDefinition(processDefinitionId);
		// 使用任务对象Task获取流程实例ID
		String processInstanceId = task.getProcessInstanceId();
		// 使用流程实例ID，查询正在执行的执行对象表，返回流程实例对象
		ProcessInstance pi = runtimeService.createProcessInstanceQuery()//
				.processInstanceId(processInstanceId)// 使用流程实例ID查询
				.singleResult();
		// 获取当前活动的id
		String activityId = pi.getActivityId();
		// 4：获取当前的活动
		ActivityImpl activityImpl = processDefinitionEntity.findActivity(activityId);
		// 5：获取当前活动完成之后连线的名称
		List<PvmTransition> pvmList = activityImpl.getOutgoingTransitions();
		if (pvmList != null && pvmList.size() > 0) {
			for (PvmTransition pvm : pvmList) {
				String name = (String) pvm.getProperty("name");
				if (StringUtils.isNotBlank(name)) {
					list.add(name);
				} else {
					list.add("完成");
				}
			}
		}
		return list;
	}

	@Override
	public List<CommentVo> findCommentListByTaskId(String taskId) {
		// 使用当前任务ID，获取当前任务对象
		Task task = taskActivitiService.createTaskQuery()//
				.taskId(taskId)// 使用任务ID查询
				.singleResult();
		// 获取流程实例ID
		String processInstanceId = task.getProcessInstanceId();
		List<Comment> list = taskActivitiService.getProcessInstanceComments(processInstanceId);
		List<CommentVo> returnList = null;
		if (list != null && list.size() > 0) {
			returnList = new ArrayList<>();
			CommentVo vo = null;
			String[] s = null; 
			for (Comment comment : list) {
				vo = new CommentVo();
				s = comment.getFullMessage().split("&&");
				vo.setMessage(s[0]);
				if(s.length > 1){
					vo.setVoucher(s[1]);
				}
				vo.setTime(comment.getTime());
				vo.setUserName(personTaskMapper.findUserNameById(Integer.valueOf(comment.getUserId())));
				returnList.add(vo);
			}
		}
		return returnList;
	}

	@Override
	public int loadTask(Long id) {
		return (int) taskActivitiService.createTaskQuery().taskCandidateOrAssigned(String.valueOf(id)).count();
	}

	@Override
	public void setProductId(String carLoanId, String productId, Long uId) {
		YtCarLoan carLoan = new YtCarLoan();
		carLoan.setId(carLoanId);
		carLoan.setProductId(Integer.valueOf(productId));
		ytCarLoanMapper.updateByPrimaryKeySelective(carLoan);
		
		// 记录日志
		YtCarLoanLog record = new YtCarLoanLog();
		record.setCarLoanId(carLoan.getId());
		record.setOperInfo("发布了产品，id为：" + productId);
		record.setOperTime(new Date());
		record.setOperUserId(uId.intValue());
		record.setStatus(8);
		ytCarLoanLogMapper.insertSelective(record);
	}

	@Override
	public Task findTaskById(String taskId) {
		return taskActivitiService.createTaskQuery().taskId(taskId).singleResult();
	}

	@Override
	public List<YtBankInfoVo> findFromBankInfoList(String carLoanId, String taskName) {
		if(taskName.equals("垫付账户放款") || taskName.equals("借款账户放款") || taskName.equals("退还保证金")){
			return personTaskMapper.findBankInfo();
		}else if(taskName.equals("归还垫付款") || taskName.equals("缴纳保证金") || taskName.equals("供应商还款")){
			String coopearateId = personTaskMapper.findCoopearateIdByCarLoanId(carLoanId);
			return personTaskMapper.findBankInfoByCoopearateId(coopearateId);
		}
		return null;
	}

	@Override
	public List<YtBankInfoVo> findToBankInfoList(String carLoanId, String taskName) {
		if(taskName.equals("垫付账户放款") || taskName.equals("借款账户放款") || taskName.equals("退还保证金")){
			String coopearateId = personTaskMapper.findCoopearateIdByCarLoanId(carLoanId);
			return personTaskMapper.findBankInfoByCoopearateId(coopearateId);
		}else if(taskName.equals("归还垫付款") || taskName.equals("缴纳保证金") || taskName.equals("供应商还款")){
			return personTaskMapper.findBankInfo();
		}
		return null;
	}

	@Override
	public void saveMoneyFlow(String[] fromAccount, String[] toAccount, String[] money, int uId, String carLoanId,
			String taskId) {
		if(fromAccount.length == 0 || toAccount.length == 0 || money.length == 0){ 
			throw new ServiceException("请填写资金流向");
		}
		for(int i = 0; i < fromAccount.length; i++){
			if(fromAccount[i].equals("") || toAccount[i].equals("") || money[i].equals("")){
				throw new ServiceException("资金流向填写有误！");
			}
		}
		
		YtMoneyFlow flow = null;
		YtBankInfo fromBank = null;
		YtBankInfo toBank = null;
		
		// 查询任务名称
		Task task = taskActivitiService.createTaskQuery().taskId(taskId).singleResult();
		Date d = new Date();
		
		for(int i = 0; i < fromAccount.length; i++){
			flow = new YtMoneyFlow();
			fromBank = ytBankInfoMapper.selectByPrimaryKey(fromAccount[i]);
			toBank = ytBankInfoMapper.selectByPrimaryKey(toAccount[i]);
			
			// 放款账户
			flow.setFromAccount(fromBank.getBankAccount());
			flow.setFromAccountName(fromBank.getBankAccountName());
			flow.setFromAccountBankName(fromBank.getBank());
			
			// 收款账户
			flow.setToAccount(toBank.getBankAccount());
			flow.setToAccountName(toBank.getBankAccountName());
			flow.setToAccountBankName(toBank.getBank());
			
			flow.setMoney(Double.valueOf(money[i]));
			flow.setTaskName(task.getName());
			flow.setCarLoanId(carLoanId);
			flow.setuId(uId);
			flow.setId(Common.getUUID());
			flow.setAddTime(d);
			ytMoneyFlowMapper.insertSelective(flow);
		}
	}

}
