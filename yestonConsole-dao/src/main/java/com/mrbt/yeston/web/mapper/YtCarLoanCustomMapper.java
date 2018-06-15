package com.mrbt.yeston.web.mapper;

import java.util.List;

import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.web.vo.ApplyUser;
import com.mrbt.yeston.web.vo.DataStatus;
import com.mrbt.yeston.web.vo.DeptTree;
import com.mrbt.yeston.web.vo.DeptVo;
import com.mrbt.yeston.web.vo.YtCarLoanInfoVo;

/**
 * @author 罗鑫
 * Date 2017年3月7日
 */
public interface YtCarLoanCustomMapper {

	List<YtCarLoanInfoVo> findBycondition(PageInfo<YtCarLoanInfoVo> pageInfo);

	int countBycondition(PageInfo<YtCarLoanInfoVo> pageInfo);

	List<DataStatus> findStatusList();

	List<ApplyUser> findUserList();

	String findCooperateIdByDeptId(Integer userId);

	List<DeptTree> findDeptList();

	DeptVo findDeptById(Integer deptId);

	List<DeptVo> findDeptByPid(Integer pid);

	String findUserNameById(Integer userId);

	String findPDeptNameByUserId(Integer userId);

	String findDeptNumberByUserId(Integer userId);

}
