package com.mrbt.yeston.business.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.repository.ProcessDefinition;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.mrbt.yeston.admin.commons.base.BaseController;
import com.mrbt.yeston.admin.commons.exception.ServiceException;
import com.mrbt.yeston.admin.commons.shiro.ShiroUser;
import com.mrbt.yeston.service.PersonalTaskService;
import com.mrbt.yeston.web.utils.Common;

import net.sf.json.JSONObject;

/**
 * 个人任务管理
 * @author 罗鑫
 * Date 2017年3月13日
 */
@Controller
@RequestMapping("personalTask")
public class PersonalTaskController extends BaseController{

	@Autowired
	private PersonalTaskService personalTaskService;
	
	/**
	 * 获取转账银行账户列表
	 */
	@RequestMapping("toBankInfoList")
	public @ResponseBody Object toBankInfoList(String carLoanId,String taskName){
		try {
			return personalTaskService.findToBankInfoList(carLoanId,taskName);
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 获取到账银行账户列表
	 */
	@RequestMapping("fromBankInfoList")
	public @ResponseBody Object fromBankInfoList(String carLoanId,String taskName){
		try {
			return personalTaskService.findFromBankInfoList(carLoanId,taskName);
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 发布产品
	 */
	@RequestMapping("publishProduct")
	public @ResponseBody Object publishProduct(String businessType,String productName,Double raiseMoney,
			Double fixedYield,String fixedDays,String carLoanId){
		PostMethod postMethod = null;
		try {
			HttpClient client = new HttpClient();
			String url = Common.getPropertyVal("publishProductInterface.properties", "publishUrl");
			
			client.getParams().setConnectionManagerTimeout(5000);
			client.getParams().setSoTimeout(3000);
			
			postMethod = new PostMethod(url);
			postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, "UTF-8");
			//3.设置请求参数
			postMethod.setParameter("businessType", businessType);
			postMethod.setParameter("productName", productName);
			postMethod.setParameter("raiseMoney", String.valueOf(raiseMoney));
			postMethod.setParameter("fixedYield", String.valueOf(fixedYield / 100));
			postMethod.setParameter("fixedDays", fixedDays);

			int code = client.executeMethod(postMethod);
			if(code == 500){
				throw new RuntimeException();
			}
			
			//5. 获取结果
			String result = postMethod.getResponseBodyAsString();
			JSONObject jsonObject = JSONObject.fromObject(result);
			if(jsonObject.getString("code").equals("500")){
				throw new RuntimeException();
			}
			ShiroUser user = (ShiroUser)SecurityUtils.getSubject().getPrincipal();
			personalTaskService.setProductId(carLoanId,jsonObject.getString("productId"),user.getId());
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		} finally{
			if(postMethod != null) postMethod.releaseConnection();
		}
	}
		
	
	/**
	 * 发布产品页面
	 */
	@RequestMapping("publishProductPage")
	public String publishProductPage(String taskId,Model model){
		model.addAttribute("carLoan", personalTaskService.findDataDetailByTaskId(taskId));
		return "/task/publishProduct";
	}
	
	/**
	 * 首页顶部加载任务
	 */
	@RequestMapping("loadTask")
	public @ResponseBody Object loadTask(){
		try {
			ShiroUser user = (ShiroUser)SecurityUtils.getSubject().getPrincipal();
			return personalTaskService.loadTask(user.getId());
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 办理任务
	 * @param taskId
	 * @param model
	 * @return
	 */
	@RequestMapping("transactTask")
	public @ResponseBody Object transactTask(String taskId,String carLoanId,String commentMsg,String outcome,
			HttpServletRequest request,String[] fromAccount,String[] toAccount,String[] money){
		try {
			ShiroUser user = (ShiroUser)SecurityUtils.getSubject().getPrincipal();
			//保存资金流向
			if(fromAccount != null && toAccount != null && money != null){
				personalTaskService.saveMoneyFlow(fromAccount,toAccount,money,user.getId().intValue(),carLoanId,taskId);
			}
			
			// 办理任务
			Map<String, List<MultipartFile>> map = ((MultipartRequest) request).getMultiFileMap();
			personalTaskService.transactTask(taskId,carLoanId,commentMsg,user.getId(),outcome,map);
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	@RequestMapping("taskPage")
	public String taskPage(String taskId,Model model){
		// 查询订单
		model.addAttribute("carLoanDetail", personalTaskService.findDataDetailByTaskId(taskId));
		// 查询按钮
		model.addAttribute("outcomeList", personalTaskService.findOutcomeListByTaskId(taskId));
		// 查询审批信息
		model.addAttribute("commentList", personalTaskService.findCommentListByTaskId(taskId));
		// 任务信息
		model.addAttribute("task", personalTaskService.findTaskById(taskId));
		return "/task/taskForm";
	}
	
	@RequestMapping("currentImg")
	public String currentImg(String taskId,Model model){
		ProcessDefinition pd = personalTaskService.findProcessDefinitionByTaskId(taskId);
		model.addAttribute("deploymentId", pd.getDeploymentId());
		model.addAttribute("imageName", pd.getDiagramResourceName());
		model.addAttribute("coordinate", personalTaskService.findCoordinate(taskId));
		return "/task/image";
	}
	
	@RequestMapping("dataGrid")
	public @ResponseBody Object dataGrid(Integer page,Integer rows){
		try {
			ShiroUser user = (ShiroUser)SecurityUtils.getSubject().getPrincipal();
			return personalTaskService.findDataGrid(page,rows,user.getId());
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	@RequestMapping("manager")
	public String manager(){
		return "/task/taskManager";
	}
}
