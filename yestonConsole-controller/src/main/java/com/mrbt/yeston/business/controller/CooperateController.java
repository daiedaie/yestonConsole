package com.mrbt.yeston.business.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mrbt.yeston.admin.commons.base.BaseController;
import com.mrbt.yeston.admin.commons.exception.ServiceException;
import com.mrbt.yeston.admin.service.OrganizationService;
import com.mrbt.yeston.service.CooperateService;
import com.mrbt.yeston.web.model.YtBankInfo;
import com.mrbt.yeston.web.model.YtCooperativeContact;
import com.mrbt.yeston.web.model.YtCooperativeMain;

/**
 * 供应商管理
 * @author 罗鑫
 * @Date 2017年2月20日
 * @version 1.0
 */
@Controller
@RequestMapping("/cooperate")
public class CooperateController extends BaseController{

	@Autowired
	private CooperateService cooperateService;
	@Autowired
	private OrganizationService organizationService;
	
	/**
	 * 编辑银行账户
	 */
	@RequestMapping("editBank")
	public @ResponseBody Object editBank(YtBankInfo bankInfo){
		try {
			cooperateService.editBank(bankInfo);
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 编辑银行账户页面
	 */
	@RequestMapping("editBankPage")
	public String editBankPage(String id,Model model){
		model.addAttribute("bankInfo", cooperateService.findBankInfoById(id));
		return "/cooperate/cooperateBankEdit";
	}
	
	/**
	 * 获取部门
	 */
	@RequestMapping("deptList")
	public @ResponseBody Object region(){
		try {
			return organizationService.findRegion();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 银行账户类型getBankType
	 */
	@RequestMapping("getBankType")
	public @ResponseBody Object getBankType(){
		try {
			return cooperateService.getBankType();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 公共账户
	 */
	@RequestMapping("commonBankGrid")
	public @ResponseBody Object commonBankGrid(Integer page,Integer rows){
		try {
			return cooperateService.commonBankGrid(page,rows);
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 启用银行账户
	 */
	@RequestMapping("startBank")
	public @ResponseBody Object startBank(String id){
		try {
			cooperateService.startBank(id);
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 添加银行账户
	 */
	@RequestMapping("addBank")
	public @ResponseBody Object addBank(YtBankInfo info,String cooperateId){
		try {
			cooperateService.addBank(info,cooperateId);
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 添加银行账户页面
	 */
	@RequestMapping("addBankPage")
	public String addBankPage(String cooperateId,Model model){
		if(cooperateId != null){
			model.addAttribute("cooperate", cooperateService.findCooperateById(cooperateId));
		}
		return "/cooperate/cooperateBankAdd";
	}
	
	/**
	 * 删除银行账户
	 */
	@RequestMapping("deleteBank")
	public @ResponseBody Object deleteBank(String id){
		try {
			cooperateService.delBank(id);
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	} 
	
	/**
	 * 银行账户信息
	 */
	@RequestMapping("bankGrid")
	public @ResponseBody Object bankGrid(Integer page,Integer rows,String cooperateId){
		try {
			return cooperateService.findBankGrid(page,rows,cooperateId);
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 编辑联系人
	 */
	@RequestMapping("editLinkman")
	public @ResponseBody Object editLinkman(YtCooperativeContact contact){
		try {
			cooperateService.editLinkman(contact);
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 编辑联系人页面
	 */
	@RequestMapping("editLinkmanPage")
	public String editLinkmanPage(Integer id,Model model){
		model.addAttribute("linkman", cooperateService.findLinkmanById(id));
		return "/cooperate/linkmanEdit";
	}
	
	/**
	 * 删除联系人
	 */
	@RequestMapping("deleteLinkman")
	public @ResponseBody Object deleteLinkman(Integer id){
		try {
			cooperateService.delLinkman(id);
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 添加联系人
	 */
	@RequestMapping("addLinkman")
	public @ResponseBody Object addLinkman(YtCooperativeContact contact,String cooperateId){
		try {
			cooperateService.addLinkman(contact,cooperateId);
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 添加联系人页面
	 */
	@RequestMapping("addLinkmanPage")
	public String addLinkmanPage(String cooperateId,Model model){
		model.addAttribute("cooperateId", cooperateId);
		return "/cooperate/linkmanAdd";
	}
	
	/**
	 * 联系人列表
	 */
	@RequestMapping("linkmanGrid")
	public @ResponseBody Object linkmanGrid(Integer page, Integer rows,String cooperateId){
		try {
			return cooperateService.findLinkmanGrid(page,rows,cooperateId);
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 启用
	 */
	@RequestMapping("start")
	public @ResponseBody Object start(String id){
		try {
			cooperateService.start(id);
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 添加
	 */
	@RequestMapping("add")
	public @ResponseBody Object add(YtCooperativeMain cooperative){
		try {
			cooperateService.addCooperative(cooperative);
			return renderSuccess();
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
	/**
	 * 添加页面
	 */
	@RequestMapping("addPage")
	public String addPage(){
		return "/cooperate/cooperateAdd";
	}
	
	/**
	 * 合作机构管理
	 */
	@RequestMapping("manager")
	public String manager(){
		return "/cooperate/cooperate";
	}
	
	/**
	 * 供应商数据
	 * @return
	 */
	@RequestMapping("dataGrid")
	public @ResponseBody Object dataGrid(Integer page, Integer rows,String supplierName,String regionName){
		try {
			return cooperateService.findDataGrid(page,rows,supplierName,regionName);
		} catch (Exception e) {
			if(e instanceof ServiceException)
				return renderError(e.getMessage());
			e.printStackTrace();
			return renderError("服务器出错");
		}
	}
	
}
