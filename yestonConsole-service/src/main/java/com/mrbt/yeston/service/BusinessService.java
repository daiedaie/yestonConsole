package com.mrbt.yeston.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.web.model.YtCarLoan;
import com.mrbt.yeston.web.model.YtMoneyFlow;
import com.mrbt.yeston.web.vo.ApplyUser;
import com.mrbt.yeston.web.vo.CommentVo;
import com.mrbt.yeston.web.vo.DataStatus;
import com.mrbt.yeston.web.vo.DeptTree;
import com.mrbt.yeston.web.vo.YtCarLoanInfoVo;
import com.mrbt.yeston.web.vo.YtCartLoanInfoSearchVo;
import com.mrbt.yeston.web.vo.ZipFileBean;

/**
 * @author 罗鑫
 * Date 2017年3月6日
 */
public interface BusinessService {

	/**
	 * 查询贷款记录
	 * @param page
	 * @param rows
	 * @param searchVo 
	 * @param roleList 
	 * @return
	 */
	PageInfo<YtCarLoanInfoVo> findDataGrid(Integer page, Integer rows, YtCartLoanInfoSearchVo searchVo, Integer deptId);

	/**
	 * 创建车贷信息
	 * @param ytCarLoan
	 * @param userId 
	 * @param user 
	 */
	void addCarLoanInfo(YtCarLoan ytCarLoan, Integer userId);

	/**
	 * 状态列表
	 * @return
	 */
	List<DataStatus> statusList();

	/**
	 * 申请人列表
	 * @return
	 */
	List<ApplyUser> userList();

	/**
	 * 部门列表
	 * @return
	 */
	List<DeptTree> deptList();

	/**
	 * 上传资料
	 * @param carLoanId
	 * @param uId 
	 * @param map
	 * @throws Exception 
	 */
	void uploadFile(String carLoanId, Map<String, List<MultipartFile>> mapList, Long uId) throws Exception;

	YtCarLoan findDataDetailById(String id);

	Boolean checkUser(Integer deptId);

	/**
	 * 编辑
	 * @param ytCarLoan
	 * @param uId 
	 */
	void editCarLoanInfo(YtCarLoan ytCarLoan, Long uId);

	/**
	 * 发起申请
	 * @param carLoanId
	 * @param id
	 */
	void startApply(String carLoanId, Long userId);

	/**
	 * 完成订单
	 * @param carLoanId
	 * @param id
	 */
	void complete(String carLoanId, Long id);

	/**
	 * 历史审批
	 * @param carLoanId
	 * @param page
	 * @param rows
	 * @return
	 */
	PageInfo<CommentVo> hisComment(String carLoanId);

	PageInfo<YtMoneyFlow> findMoneyFlow(Integer page, Integer rows, String carLoanId);

	List<ZipFileBean> downloadFile(String carLoanId) throws Exception;

	String findTaskId(String carLoanId);

}
