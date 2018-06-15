package com.mrbt.yeston.service.impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import com.mrbt.yeston.admin.commons.exception.ServiceException;
import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.service.CooperateService;
import com.mrbt.yeston.web.mapper.YtBankAccountTypeMapper;
import com.mrbt.yeston.web.mapper.YtBankInfoMapper;
import com.mrbt.yeston.web.mapper.YtCooperativeContactMapper;
import com.mrbt.yeston.web.mapper.YtCooperativeMainMapper;
import com.mrbt.yeston.web.model.YtBankAccountType;
import com.mrbt.yeston.web.model.YtBankAccountTypeExample;
import com.mrbt.yeston.web.model.YtBankInfo;
import com.mrbt.yeston.web.model.YtBankInfoExample;
import com.mrbt.yeston.web.model.YtCooperativeContact;
import com.mrbt.yeston.web.model.YtCooperativeContactExample;
import com.mrbt.yeston.web.model.YtCooperativeMain;
import com.mrbt.yeston.web.model.YtCooperativeMainExample;
import com.mrbt.yeston.web.model.YtCooperativeMainExample.Criteria;
import com.mrbt.yeston.web.utils.Common;

/**
 * @author 罗鑫
 * @Date 2017年2月20日
 * @version 1.0
 */
@Service
public class CooperateServiceImpl implements CooperateService {
	
	@Autowired
	private YtCooperativeMainMapper ytCooperativeMainMapper; 
	@Autowired
	private YtCooperativeContactMapper ytCooperativeContactMapper;
	@Autowired
	private YtBankInfoMapper ytBankInfoMapper;
	@Autowired
	private YtBankAccountTypeMapper ytBankAccountTypeMapper;
	
	@Override
	public PageInfo<YtCooperativeMain> findDataGrid(Integer page, Integer rows, String supplierName,
			String regionName) {
		PageInfo<YtCooperativeMain> pageInfo = new PageInfo<>(page, rows);
		YtCooperativeMainExample example = new YtCooperativeMainExample();
		example.setPageNo(page);
		example.setPageSize(rows);
		Criteria criteria = example.createCriteria().andStatusNotEqualTo(2);
		if(StringUtils.isNotBlank(supplierName))
			criteria.andNameLike("%" + supplierName + "%");
		if(StringUtils.isNotBlank(regionName))
			criteria.andRegionNameEqualTo(regionName);
		pageInfo.setTotal(ytCooperativeMainMapper.countByExample(example));
		pageInfo.setRows(ytCooperativeMainMapper.selectByExample(example));
		return pageInfo;
	}

	@Override
	public void addCooperative(YtCooperativeMain cooperative) {
		YtCooperativeMainExample example = new YtCooperativeMainExample();
		example.createCriteria().andNameEqualTo(cooperative.getName());
		List<YtCooperativeMain> list = ytCooperativeMainMapper.selectByExample(example);
		if(list != null && list.size() > 0){
			throw new ServiceException("合作机构已存在");
		}
		cooperative.setId(Common.getUUID());
		cooperative.setCreateTime(new Date());
		ytCooperativeMainMapper.insertSelective(cooperative);
		
	}

	@Override
	public void start(String id) {
		YtCooperativeMain main = new YtCooperativeMain();
		main.setId(id);
		main.setStatus(1);
		ytCooperativeMainMapper.updateByPrimaryKeySelective(main);
	}

	@Override
	public YtCooperativeMain findById(String id) {
		return ytCooperativeMainMapper.selectByPrimaryKey(id);
	}


	@Override
	public PageInfo<YtCooperativeContact> findLinkmanGrid(Integer page, Integer rows, String cooperateId) {
		PageInfo<YtCooperativeContact> pageInfo = new PageInfo<>(page, rows);
		YtCooperativeContactExample example = new YtCooperativeContactExample();
		example.setPageNo(page);
		example.setPageSize(rows);
		example.createCriteria().andCooperativeIdEqualTo(cooperateId).andStatusEqualTo(1);
		pageInfo.setTotal(ytCooperativeContactMapper.countByExample(example));
		pageInfo.setRows(ytCooperativeContactMapper.selectByExample(example));
		return pageInfo;
	}

	@Override
	public void addLinkman(YtCooperativeContact contact, String cooperateId) {
		YtCooperativeContactExample example = new YtCooperativeContactExample();
		example.createCriteria().andLinkmanEqualTo(contact.getLinkman());
		List<YtCooperativeContact> list = ytCooperativeContactMapper.selectByExample(example);
		if(list != null && list.size() > 0){
			throw new ServiceException("联系人已存在");
		}
		contact.setCreateTime(new Date());
		contact.setCooperativeId(cooperateId);
		ytCooperativeContactMapper.insertSelective(contact);
	}

	@Override
	public void delLinkman(Integer id) {
		YtCooperativeContact contact = new YtCooperativeContact();
		contact.setId(id);
		contact.setStatus(0);
		ytCooperativeContactMapper.updateByPrimaryKeySelective(contact);
	}

	@Override
	public YtCooperativeContact findLinkmanById(Integer id) {
		return ytCooperativeContactMapper.selectByPrimaryKey(id);
	}

	@Override
	public void editLinkman(YtCooperativeContact contact) {
		contact.setModiTime(new Date());
		ytCooperativeContactMapper.updateByPrimaryKeySelective(contact);
	}

	@Override
	public PageInfo<YtBankInfo> findBankGrid(Integer page, Integer rows, String cooperativeId) {
		PageInfo<YtBankInfo> pageInfo = new PageInfo<>(page, rows);
		YtBankInfoExample example = new YtBankInfoExample();
		example.setPageNo(page);
		example.setPageSize(rows);
		example.createCriteria().andCooperativeIdEqualTo(cooperativeId).andStatusNotEqualTo(2);
		pageInfo.setTotal(ytBankInfoMapper.countByExample(example));
		pageInfo.setRows(ytBankInfoMapper.selectByExample(example));
		return pageInfo;
	}

	@Override
	public void delBank(String id) {
		YtBankInfo info = new YtBankInfo();
		info.setId(id);
		info.setStatus(2);
		info.setCancelTime(new Date());
		ytBankInfoMapper.updateByPrimaryKeySelective(info);
	}

	@Override
	public void addBank(YtBankInfo info, String cooperateId) {
		try {
			info.setId(Common.getUUID());
			info.setCreateTime(new Date());
			if(info.getType() == null){
				info.setType(1);
			}
			info.setCooperativeId(cooperateId);
			ytBankInfoMapper.insertSelective(info);
		} catch (Exception e) {
			if(e instanceof DataIntegrityViolationException){
				throw new ServiceException("账号过长，请重新输入！");
			}
		}
	}

	@Override
	public void startBank(String id) {
		YtBankInfo info = new YtBankInfo();
		info.setId(id);
		info.setStatus(1);
		ytBankInfoMapper.updateByPrimaryKeySelective(info);
	}

	@Override
	public PageInfo<YtBankInfo> commonBankGrid(Integer page, Integer rows) {
		PageInfo<YtBankInfo> pageInfo = new PageInfo<>(page, rows);
		YtBankInfoExample example = new YtBankInfoExample();
		example.setPageNo(page);
		example.setPageSize(rows);
		example.createCriteria().andTypeNotEqualTo(1).andStatusNotEqualTo(2);
		pageInfo.setTotal(ytBankInfoMapper.countByExample(example));
		List<YtBankInfo> list = ytBankInfoMapper.selectByExample(example);
		if(list != null && list.size() > 0){
			YtBankAccountType type = null;
			for (YtBankInfo info : list) {
				type = ytBankAccountTypeMapper.selectByPrimaryKey(info.getType());
				info.setTypeName(type.getBatName());
			}
		}
		pageInfo.setRows(list);
		return pageInfo;
	}

	@Override
	public List<YtBankAccountType> getBankType() {
		YtBankAccountTypeExample example = new YtBankAccountTypeExample();
		example.createCriteria().andBatNameNotEqualTo("合作机构公司账户");
		return ytBankAccountTypeMapper.selectByExample(example);
	}

	@Override
	public YtCooperativeMain findCooperateById(String cooperateId) {
		return ytCooperativeMainMapper.selectByPrimaryKey(cooperateId);
	}

	@Override
	public YtBankInfo findBankInfoById(String id) {
		return ytBankInfoMapper.selectByPrimaryKey(id);
	}

	@Override
	public void editBank(YtBankInfo bankInfo) {
		ytBankInfoMapper.updateByPrimaryKeySelective(bankInfo);
	}

}
