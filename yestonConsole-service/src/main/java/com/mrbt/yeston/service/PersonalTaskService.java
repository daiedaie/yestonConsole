package com.mrbt.yeston.service;

import java.util.List;
import java.util.Map;

import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.task.Task;
import org.springframework.web.multipart.MultipartFile;

import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.web.model.YtCarLoan;
import com.mrbt.yeston.web.vo.CommentVo;
import com.mrbt.yeston.web.vo.TaskVo;
import com.mrbt.yeston.web.vo.YtBankInfoVo;

/**
 * 个人任务管理
 * @author 罗鑫
 * Date 2017年3月13日
 */
public interface PersonalTaskService {

	PageInfo<TaskVo> findDataGrid(Integer page, Integer rows, Long userId);

	ProcessDefinition findProcessDefinitionByTaskId(String taskId);

	Map<String,Object> findCoordinate(String taskId);

	YtCarLoan findDataDetailByTaskId(String taskId);

	List<String> findOutcomeListByTaskId(String taskId);

	List<CommentVo> findCommentListByTaskId(String taskId);

	void transactTask(String taskId, String carLoanId, String commentMsg, 
			Long uId, String outcome, Map<String, List<MultipartFile>> map) throws Exception;

	int loadTask(Long id);

	void setProductId(String carLoanId, String productId, Long uId);

	Task findTaskById(String taskId);
	
	List<YtBankInfoVo> findFromBankInfoList(String carLoanId, String taskName);

	List<YtBankInfoVo> findToBankInfoList(String carLoanId, String taskName);

	void saveMoneyFlow(String[] fromAccount, String[] toAccount, String[] money, int uId, String carLoanId,
			String taskId);
}
