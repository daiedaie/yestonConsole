package com.mrbt.yeston.service;

import java.util.List;

import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.web.model.YtBankAccountType;
import com.mrbt.yeston.web.model.YtBankInfo;
import com.mrbt.yeston.web.model.YtCooperativeContact;
import com.mrbt.yeston.web.model.YtCooperativeMain;

/**
 * 供应商管理
 * @author 罗鑫
 * @Date 2017年2月20日
 * @version 1.0
 */
public interface CooperateService {

	/**
	 * 查询列表
	 * @return
	 */
	PageInfo<YtCooperativeMain> findDataGrid(Integer page, Integer rows, String supplierName, String regionName);

	/**
	 * 添加合作机构
	 * @param cooperative
	 */
	void addCooperative(YtCooperativeMain cooperative);

	/**
	 * 启用
	 * @param id
	 */
	void start(String id);

	/**
	 * 根据id查
	 * @param id
	 * @return
	 */
	YtCooperativeMain findById(String id);

	/**
	 * 查询联系人列表
	 * @param page
	 * @param rows
	 * @param cooperateId 
	 * @return
	 */
	PageInfo<YtCooperativeContact> findLinkmanGrid(Integer page, Integer rows, String cooperateId);

	/**
	 * 添加联系人
	 * @param contact
	 * @param cooperateId
	 */
	void addLinkman(YtCooperativeContact contact, String cooperateId);

	/**
	 * 删除联系人
	 * @param id
	 */
	void delLinkman(Integer id);

	/**
	 * 查询联系人
	 * @param id
	 * @return
	 */
	YtCooperativeContact findLinkmanById(Integer id);

	/**
	 * 编辑联系人
	 * @param contact
	 */
	void editLinkman(YtCooperativeContact contact);

	/**
	 * 银行账户信息
	 * @param page
	 * @param rows
	 * @param cooperativeId 
	 * @return
	 */
	PageInfo<YtBankInfo> findBankGrid(Integer page, Integer rows, String cooperativeId);

	/**
	 * 删除银行卡
	 * @param id
	 */
	void delBank(String id);

	/**
	 * 添加银行账户
	 * @param info
	 * @param cooperateId
	 */
	void addBank(YtBankInfo info, String cooperateId);
	
	/**
	 * 启用银行账户
	 * @param id
	 */
	void startBank(String id);

	/**
	 * 公共账户
	 * @param rows 
	 * @param page 
	 * @return
	 */
	PageInfo<YtBankInfo> commonBankGrid(Integer page, Integer rows);

	/**
	 * 银行账户类型
	 * @return
	 */
	List<YtBankAccountType> getBankType();

	YtCooperativeMain findCooperateById(String cooperateId);

	YtBankInfo findBankInfoById(String id);

	void editBank(YtBankInfo bankInfo);

}
