package com.mrbt.yeston.echo.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mrbt.yeston.admin.commons.base.BaseController;
import com.mrbt.yeston.admin.commons.exception.ServiceException;
import com.mrbt.yeston.admin.commons.utils.StringOpertion;
import com.mrbt.yeston.service.EchoApiService;
import com.mrbt.yeston.web.echo.DO.MortgagorDataVo;

@Controller
@RequestMapping(value = "echoApi")
public class EchoApiController extends BaseController {

	private static final Logger LOGGER = LogManager.getLogger(EchoApiController.class);

	@Autowired
	private EchoApiService echoApiService;

	
	@RequestMapping("manager")
	public String manager(HttpServletRequest request, HttpServletResponse response) {
		LOGGER.info("打开指纹管理页面");
		return "/echo/echoManager";
	}
	
	@RequestMapping("mortgagorAdd")
	public String mortgagorAdd(HttpServletRequest request, HttpServletResponse response) {
		LOGGER.info("添加借款人信息页面");
		return "/echo/mortgagorAdd";
	}
	
	/**
	 * 业务数据
	 * 
	 * @param page
	 * @param rows
	 * @param searchVo
	 * @return
	 */
	@RequestMapping("dataGrid")
	public @ResponseBody Object dataGrid(Integer page, Integer rows, String name, String idNo) {
		try {
			return echoApiService.findDataGrid(page, rows, name, idNo);
		} catch (Exception e) {
			if (e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}

	/**
	 * 查询个人信用
	 * 
	 * @param name
	 * @param idNo
	 * @param 查询原因
	 * @return
	 */
	@RequestMapping(value = "/query")
	public @ResponseBody Object query(String name, String idNo) {
		LOGGER.info("查询个人信用信息:" + StringOpertion.hideName(name) + "\t" + StringOpertion.hideIdenCard(idNo));

		if (name != null && !name.equals("") && idNo != null && !idNo.equals("")) {
			JSONObject queryInfo = echoApiService.queryPersionalInfo(name, idNo, "10");
			if(queryInfo != null && queryInfo.get("errorCode").equals(0)){
				return renderSuccess(queryInfo);
			}else{
				return renderError(queryInfo.getString("message"));
			}
		} else {
			return renderError("请求参数不完整");
		}

	}
	
	/**
	 * 查询个人信用历史
	 * 
	 * @param name
	 * @param idNo
	 * @param 查询原因
	 * @return
	 */
	@RequestMapping(value = "/queryHistory")
	public @ResponseBody Object queryHistory(String idNo) {
		LOGGER.info("查询个人信用历史查询记录:" + StringOpertion.hideIdenCard(idNo));

		if (idNo != null && !idNo.equals("")) {
			JSONObject queryInfo = echoApiService.queryHistory(idNo);
			if(queryInfo != null && queryInfo.size() > 0){
				return renderSuccess(queryInfo);
			}else{
				return renderError("查询数据为空");
			}
		} else {
			return renderError("请求参数不完整");
		}

	}

	/**
	 * 上传证件号码共享数据请求
	 * 
	 * @param name
	 * @param idNo
	 * @param 查询原因
	 * @return
	 */
	@RequestMapping(value = "/shareIdNo")
	public @ResponseBody Object shareIdNo(String idNo) {
		LOGGER.info("上传证件号码共享数据请求:" + idNo);

		if(idNo != null && !idNo.equals("")){
			JSONObject shareInfo = echoApiService.shareUploadIdNo(idNo);
			if(shareInfo.get("code").equals(200)){
				return renderSuccess(shareInfo);
			}
			return renderError(shareInfo.getString("msg"));
		}else{
			return renderError("上传数据为空");
		}
	}
	
	
	/**
	 * 平台查询机构接口，对外，不要权限验证
	 * @param idNo
	 * @return
	 */
	@RequestMapping(value = "/echoComeQuery")
	public @ResponseBody Object echoComeQuery(String params) {
		LOGGER.info("平台查询机构接口:" + params);
		JSONObject json = new JSONObject();
		try {
			String unescParams = StringEscapeUtils.unescapeHtml4(params);
			JSONObject resjson = JSONObject.parseObject(unescParams);
			json = echoApiService.echomComeQuery(resjson);
		} catch (Exception e) {
			e.printStackTrace();
			json.put("errorCode", "4008");
			json.put("message", "输入的参数据部分格式不正确，需JSON格式");
		}
		return json;
	}
	
	/**
	 * 添加贷款人用户数据，用于与平台测试
	 * @return
	 */
	@RequestMapping(value = "/appendMortgagor")
	public @ResponseBody Object appendMortgagor(HttpServletRequest request, HttpServletResponse response, MortgagorDataVo mortDataVo) {
		LOGGER.info("添加贷款人用户数据");
		
		JSONObject json = echoApiService.saveAppendMortgagor(mortDataVo);
		if(json.get("code").equals(200)){
			return renderSuccess(json.getString("msg"));
		}else{
			return renderError(json.getString("msg"));
		}
	}
}
