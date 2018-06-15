package com.mrbt.yeston.business.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.io.IOUtils;
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
import com.mrbt.yeston.service.BusinessService;
import com.mrbt.yeston.web.model.YtCarLoan;
import com.mrbt.yeston.web.utils.Common;
import com.mrbt.yeston.web.utils.StringOpertion;
import com.mrbt.yeston.web.vo.ProductInfoVo;
import com.mrbt.yeston.web.vo.TradingVo;
import com.mrbt.yeston.web.vo.YtCartLoanInfoSearchVo;
import com.mrbt.yeston.web.vo.ZipFileBean;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 
 * @author 罗鑫
 * Date 2017年3月6日
 */
@Controller
@RequestMapping("/business")
public class BusinessController extends BaseController{

	@Autowired
	private BusinessService businessService;
	
	/**
	 * 查询任务id
	 */
	@RequestMapping("getTaskId")
	public @ResponseBody Object getTaskId(String carLoanId){
		try {
			return businessService.findTaskId(carLoanId);
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	
	/**
	 * 下载资料
	 */
	@RequestMapping("downloadFile")
	public void downloadFile(String carLoanId,HttpServletResponse response){
		
		String fileName = carLoanId + ".zip";
		response.setContentType("APPLICATION/OCTET-STREAM");  
        response.setHeader("Content-Disposition","attachment; filename="+fileName);
		ServletOutputStream servletOutputStream = null;
		ZipOutputStream out = null;
		try {
			servletOutputStream = response.getOutputStream();
			out = new ZipOutputStream(servletOutputStream);
			List<ZipFileBean> fileList = businessService.downloadFile(carLoanId);
			
			for(ZipFileBean file : fileList){
				out.putNextEntry(new ZipEntry(file.getFilePath()));
				IOUtils.copy(file.getInputStream(), out);
            }
		} catch (Exception e) {
			e.printStackTrace();
			try {
				response.setContentType("text/html;charset=utf-8"); 
				servletOutputStream.write("服务器出错".getBytes());
			} catch (IOException e1) {}
		} finally {
			try {
				out.close();
			} catch (Exception e) {}
		}
	}
	
	/**
	 * 资金流向
	 */
	@RequestMapping("moneyFlowData")
	public @ResponseBody Object moneyFlowData(Integer page,Integer rows,String carLoanId){
		try {
			return businessService.findMoneyFlow(page,rows,carLoanId);
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 获取产品详情
	 */
	@RequestMapping("getProductInfo")
	public void getProductInfo(String id, String businessType,HttpServletResponse response){
		PostMethod postMethod = null;
		response.setContentType("text/html;charet=utf-8");
		JSONObject writerJson = new JSONObject();
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			HttpClient client = new HttpClient();
			String url = Common.getPropertyVal("publishProductInterface.properties", "shwoProductUrl");
			
			client.getParams().setConnectionManagerTimeout(5000);
			client.getParams().setSoTimeout(3000);
			
			postMethod = new PostMethod(url);
			postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, "UTF-8");
			//3.设置请求参数
			postMethod.setParameter("businessType", businessType);
			postMethod.setParameter("productId", id);

			int code = client.executeMethod(postMethod);
			if(code == 500){
				throw new RuntimeException();
			}
			
			//5. 获取结果
			String result = postMethod.getResponseBodyAsString();
			JSONObject readJson = JSONObject.fromObject(result);
			if(readJson.getString("code").equals("500")){
				throw new RuntimeException();
			}
			JSONObject productJson = readJson.getJSONObject("product");
			ProductInfoVo productInfo = (ProductInfoVo) JSONObject.toBean(productJson, ProductInfoVo.class);
			writerJson.put("productInfo", productInfo);
			
			JSONArray tradingJson = readJson.getJSONArray("successTrading");
			@SuppressWarnings("unchecked")
			Collection<TradingVo> trad = JSONArray.toCollection(tradingJson, TradingVo.class);
			for (TradingVo tradingVo : trad) {
				tradingVo.setUsersName(StringOpertion.hideRealName(tradingVo.getUsersName()));
				tradingVo.setUsersTelephone(StringOpertion.hideMoblieNum(tradingVo.getUsersTelephone()));
			}
			writerJson.put("trad", trad);
			
		} catch (Exception e) {
			writerJson.put("code", 500);
			writerJson.put("resMsg", "服务器出错");
			e.printStackTrace();
		}finally {
			if(postMethod != null) postMethod.releaseConnection();
			writerJson.write(writer);
		}
	}
	
	/**
	 * 产品详情页
	 */
	@RequestMapping("showProductPage")
	public String showProductPage(String id, String businessType,Model model){
		model.addAttribute("id", id);
		model.addAttribute("businessType", businessType);
		return "/business/productInfo";
	}
	
	/**
	 * 历史审批
	 */
	@RequestMapping("hisComment")
	public @ResponseBody Object hisComment(String carLoanId){
		try {
			return businessService.hisComment(carLoanId);
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 完成订单
	 */
	@RequestMapping("complete")
	public @ResponseBody Object complete(String carLoanId){
		try {
			ShiroUser user = (ShiroUser)SecurityUtils.getSubject().getPrincipal();
			businessService.complete(carLoanId,user.getId());
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 发起申请
	 */
	@RequestMapping("startApply")
	public @ResponseBody Object startApply(String carLoanId){
		try {
			ShiroUser user = (ShiroUser)SecurityUtils.getSubject().getPrincipal();
			businessService.startApply(carLoanId,user.getId());
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	/**
	 * 数据详情页面
	 */
	@RequestMapping("carLoanDetailPage")
	public String carLoanDetailPage(String id,Model model){
		model.addAttribute("carLoanDetail", businessService.findDataDetailById(id));
		return "/business/carLoanDetailPage";
	}
	
	/**
	 * 编辑
	 */
	@RequestMapping("edit")
	public @ResponseBody Object edit(YtCarLoan ytCarLoan){
		try {
			ShiroUser user = (ShiroUser)SecurityUtils.getSubject().getPrincipal();
			businessService.editCarLoanInfo(ytCarLoan,user.getId());
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 检查用户
	 */
	@RequestMapping("checkUser")
	public @ResponseBody Object checkUser(){
		try {
			ShiroUser user = (ShiroUser)SecurityUtils.getSubject().getPrincipal();
			return businessService.checkUser(user.getDeptId());
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 编辑页面
	 */
	@RequestMapping("editFunPage")
	public String dataDetailPage(String id,Model model){
		model.addAttribute("carLoanDetail", businessService.findDataDetailById(id));
		return "/business/businessEdit";
	}
	
	/**
	 * 上传页面
	 * @param carLoanId
	 * @param model
	 * @return
	 */
	@RequestMapping("uploadPage")
	public String uploadPage(String carLoanId,Model model){
		model.addAttribute("carLoanId", carLoanId);
		return "/business/upload";
	}
	
	/**
	 * 上传资料
	 * @return
	 */
	@RequestMapping("uploadFile")
	public @ResponseBody Object uploadFile(String carLoanId,HttpServletRequest request){
		try {
			Map<String, List<MultipartFile>> map = ((MultipartRequest) request).getMultiFileMap();
			ShiroUser user = (ShiroUser)SecurityUtils.getSubject().getPrincipal();
			businessService.uploadFile(carLoanId,map,user.getId());
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}

	}
	
	/**
	 * 申请人集合
	 */
	@RequestMapping("userList")
	public @ResponseBody Object userList(){
		try {
			return businessService.userList();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 审核状态集合
	 */
	@RequestMapping("statusList")
	public @ResponseBody Object statusList(){
		try {
			return businessService.statusList();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 部门列表
	 */
	@RequestMapping("deptList")
	public @ResponseBody Object deptList(){
		try {
			return businessService.deptList();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 创建贷款申请
	 */
	@RequestMapping("add")
	public @ResponseBody Object add(YtCarLoan ytCarLoan){
		try {
			ShiroUser user = (ShiroUser)SecurityUtils.getSubject().getPrincipal();
			businessService.addCarLoanInfo(ytCarLoan,user.getId().intValue());
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 申请借款页面
	 * @return
	 */
	@RequestMapping("addPage")
	public String addPage(){
		return "/business/businessAdd";
	}
	
	/**
	 * 业务管理页面
	 * @return
	 */
	@RequestMapping("manager")
	public String manager(){
		return "/business/business";
	}
	
	/**
	 * 业务数据
	 * @param page
	 * @param rows
	 * @param searchVo
	 * @return
	 */
	@RequestMapping("dataGrid")
	public @ResponseBody Object dataGrid(Integer page,Integer rows,YtCartLoanInfoSearchVo searchVo){
		try {
			ShiroUser user = (ShiroUser)SecurityUtils.getSubject().getPrincipal();
			return businessService.findDataGrid(page,rows,searchVo,user.getDeptId());
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
}



