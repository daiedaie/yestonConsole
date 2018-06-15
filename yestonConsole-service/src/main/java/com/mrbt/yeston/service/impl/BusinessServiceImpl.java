package com.mrbt.yeston.service.impl;

import java.awt.Color;
import java.awt.Font;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mrbt.yeston.admin.commons.exception.ServiceException;
import com.mrbt.yeston.admin.commons.utils.FtpUtils;
import com.mrbt.yeston.admin.commons.utils.PageInfo;
import com.mrbt.yeston.service.BusinessService;
import com.mrbt.yeston.web.mapper.PersonTaskMapper;
import com.mrbt.yeston.web.mapper.YtCarLoanCustomMapper;
import com.mrbt.yeston.web.mapper.YtCarLoanLogMapper;
import com.mrbt.yeston.web.mapper.YtCarLoanMapper;
import com.mrbt.yeston.web.mapper.YtCooperativeMainMapper;
import com.mrbt.yeston.web.mapper.YtMoneyFlowMapper;
import com.mrbt.yeston.web.model.YtCarLoan;
import com.mrbt.yeston.web.model.YtCarLoanExample;
import com.mrbt.yeston.web.model.YtCarLoanLog;
import com.mrbt.yeston.web.model.YtCooperativeMain;
import com.mrbt.yeston.web.model.YtCooperativeMainExample;
import com.mrbt.yeston.web.model.YtMoneyFlow;
import com.mrbt.yeston.web.model.YtMoneyFlowExample;
import com.mrbt.yeston.web.utils.Common;
import com.mrbt.yeston.web.utils.PingyinUtils;
import com.mrbt.yeston.web.utils.WaterMarkHelper;
import com.mrbt.yeston.web.utils.WaterMarkHelper.WaterMarkConfigure;
import com.mrbt.yeston.web.vo.ApplyUser;
import com.mrbt.yeston.web.vo.CommentVo;
import com.mrbt.yeston.web.vo.DataStatus;
import com.mrbt.yeston.web.vo.DeptTree;
import com.mrbt.yeston.web.vo.DeptVo;
import com.mrbt.yeston.web.vo.YtCarLoanInfoVo;
import com.mrbt.yeston.web.vo.YtCartLoanInfoSearchVo;
import com.mrbt.yeston.web.vo.ZipFileBean;

/**
 * @author 罗鑫
 * Date 2017年3月6日
 */
@Service
public class BusinessServiceImpl implements BusinessService{
	
	@Autowired
	private FtpUtils ftpUtils;
	@Autowired
	private YtCarLoanMapper ytCarLoanMapper;
	@Autowired
	private YtCarLoanCustomMapper ytCarLoanCustomMapper;
	@Autowired
	private YtCooperativeMainMapper ytCooperativeMainMapper;
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	private YtCarLoanLogMapper ytCarLoanLogMapper;
	@Autowired
	private HistoryService historyService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private PersonTaskMapper personTaskMapper;
	@Autowired
	private YtMoneyFlowMapper ytMoneyFlowMapper;

	@Override
	public PageInfo<YtCarLoanInfoVo> findDataGrid(Integer page, Integer rows, YtCartLoanInfoSearchVo searchVo, Integer deptId) {
		PageInfo<YtCarLoanInfoVo> pageInfo = new PageInfo<>(page, rows);
		Map<String, Object> condition = new HashMap<>();
		DeptVo deptVo = ytCarLoanCustomMapper.findDeptById(deptId);
		Object notCooperate = new Object();// 不是供应商不查出为发起状态的记录
		if(deptVo.getPid() != null){// 子级部门
			condition.put("deptId", deptId);
		}else if(deptVo.getId() != 1){// 一级部门除了总部
			condition.put("notCooperate", notCooperate);
			Integer id = deptVo.getId();
			List<DeptVo> deptList = ytCarLoanCustomMapper.findDeptByPid(id);
			if(deptList != null && deptList.size() > 0){
				List<Integer> deptIds = new ArrayList<>();
				for (DeptVo dept : deptList) {
					deptIds.add(dept.getId());
				}
				condition.put("deptIds", deptIds);
			}
		}else{// 总部
			condition.put("notCooperate", notCooperate);
		}
		if(searchVo != null){
			if(StringUtils.isNoneBlank(searchVo.getPlateNumber())){// 车牌号
				condition.put("plateNumber", searchVo.getPlateNumber());
			}
			if(StringUtils.isNoneBlank(searchVo.getVehicleType())){// 车辆型号
				condition.put("vehicleType", searchVo.getVehicleType());
			}
			if(StringUtils.isNoneBlank(searchVo.getOwnerName())){// 车主姓名
				condition.put("ownerName", searchVo.getOwnerName());
			}
			if(StringUtils.isNoneBlank(searchVo.getDeptId())){// 部门
				condition.put("deptId", searchVo.getDeptId());
			}
			if(searchVo.getUserId() != null){// 申请人
				condition.put("userId", searchVo.getUserId());
			}
			if(searchVo.getStartTime() != null){// 最早申请时间
				condition.put("startTime", searchVo.getStartTime());
			}
			if(searchVo.getEndTime() != null){// 最晚申请时间
				condition.put("endTime", searchVo.getEndTime());
			}
			if(searchVo.getLoanAmountMin() != null){// 最小借款金额
				condition.put("loanAmountMin", searchVo.getLoanAmountMin());
			}
			if(searchVo.getLoanAmountMax() != null){// 最大借款金额
				condition.put("loanAmountMax", searchVo.getLoanAmountMax());
			}
			if(searchVo.getLoanTernMin() != null){// 最小借款期限
				condition.put("loanTernMin", searchVo.getLoanTernMin());
			}
			if(searchVo.getLoanTernMax() != null){// 最大借款期限
				condition.put("loanTernMax", searchVo.getLoanTernMax());
			}
			if(searchVo.getStatus() != null){// 状态
				condition.put("status", searchVo.getStatus());
			}
		}
		pageInfo.setCondition(condition);
		pageInfo.setRows(ytCarLoanCustomMapper.findBycondition(pageInfo));
		pageInfo.setTotal(ytCarLoanCustomMapper.countBycondition(pageInfo));
		return pageInfo;
	}

	@Override
	public void addCarLoanInfo(YtCarLoan ytCarLoan,Integer userId) {
		
		// 判断车牌号
		String plateNumber = ytCarLoan.getPlateNumber();
		YtCarLoanExample example = new YtCarLoanExample();
		example.createCriteria().andPlateNumberEqualTo(plateNumber).andStatusNotEqualTo(24);
		List<YtCarLoan> list = ytCarLoanMapper.selectByExample(example);
		if(list != null && list.size() > 0){
			throw new ServiceException("当前车辆还有未完成的业务");
		}
		
		// 生成id
		// 1.查询供应商所在部门的上级部门
		String pDeptName = ytCarLoanCustomMapper.findPDeptNameByUserId(userId);
		// 2.查询供应商所在部门be编号
		String deptNumber = ytCarLoanCustomMapper.findDeptNumberByUserId(userId);
		// 3.查询用户登录名
		String uName = ytCarLoanCustomMapper.findUserNameById(userId);
		
		String carLoanId = PingyinUtils.converterToFirstSpell(pDeptName).toUpperCase() 
				+ "_" + deptNumber + "_" + uName.toUpperCase() + "_" + System.currentTimeMillis();
		
		ytCarLoan.setId(carLoanId);
		ytCarLoan.setUserId(userId.intValue());
		// 查询供应商id
		String cooperateId = ytCarLoanCustomMapper.findCooperateIdByDeptId(userId);
		ytCarLoan.setCooperateId(cooperateId);
		ytCarLoanMapper.insertSelective(ytCarLoan);
		
		// 插入日志
		YtCarLoanLog record = new YtCarLoanLog();
		record.setCarLoanId(carLoanId);
		record.setOperInfo("新添贷款记录");
		record.setOperTime(new Date());
		record.setOperUserId(userId);
		record.setStatus(1);
		ytCarLoanLogMapper.insertSelective(record);
	}

	@Override
	public List<DataStatus> statusList() {
		return ytCarLoanCustomMapper.findStatusList();
	}

	@Override
	public List<ApplyUser> userList() {
		return ytCarLoanCustomMapper.findUserList();
	}

	@Override
	public List<DeptTree> deptList() {
		List<DeptTree> list = ytCarLoanCustomMapper.findDeptList();
		if(list != null && list.size() > 0){
			for (int i = 0; i < list.size(); i++) {
				if(list.get(i).getParentId() != null){
					for (int j = 0; j < list.size(); j++) {
						if(list.get(i).getParentId() == list.get(j).getId()){
							list.get(j).getChildren().add(list.get(i));
						}
					}
					list.remove(i);
					i--;
				}
			}
		}
		return list;
	}

	@Override
	public void uploadFile(String carLoanId, Map<String, List<MultipartFile>> mapList, Long uId) throws Exception{
		YtCarLoan carLoan = ytCarLoanMapper.selectByPrimaryKey(carLoanId);
		List<String> urlList = new ArrayList<>();
		// 水印
		WaterMarkHelper helper = new WaterMarkHelper();
		WaterMarkConfigure configure = helper.new WaterMarkConfigure();
		configure.setFont(new Font("黑体", Font.ITALIC, 200));
		configure.setWaterMarkContent("领钱儿");
		configure.setMarkContentColor(new Color(232, 71, 9));
		configure.setDegree(null);
		configure.setAlpha(0.3f);
		
		String name = null;
		for (Entry<String, List<MultipartFile>> set : mapList.entrySet()) {
			List<MultipartFile> pics = set.getValue();
			for (MultipartFile pic : pics) {
				if(pic.getSize() == 0){
					throw new ServiceException("请选择有效的图片");
				}
				if(name == null){
					name = pic.getName();
				}
				// 添加水印
				InputStream stream = helper.getMarkedInputstream(pic.getInputStream(), configure);
				
				String filename = Common.getUUID() + ".jpg";
				String savePath = "/ytCarLoan/" + carLoan.getCooperateId() + "/" + name;
				try {
					ftpUtils.upload(stream, savePath , filename);
				} catch (Exception e) {
					ftpUtils.upload(stream, savePath , filename);
				}
				String url = ftpUtils.getUrl() + "ytCarLoan/" + carLoan.getCooperateId() + "/" + name + "/" + filename;
				urlList.add(url);
			}
		}
		Field field = carLoan.getClass().getDeclaredField(name);
		field.setAccessible(true);
		StringBuilder returnUrl = new StringBuilder();
		if(urlList.size() > 0){
			for (int i = 0; i < urlList.size(); i++) {
				returnUrl.append(urlList.get(i));
				if(i < urlList.size() - 1){
					returnUrl.append(",");
				}
			}
		}
		field.set(carLoan, returnUrl.toString());
		ytCarLoanMapper.updateByPrimaryKeySelective(carLoan);
		
		// 记录日志
		YtCarLoanLog record = new YtCarLoanLog();
		record.setCarLoanId(carLoan.getId());
		record.setOperInfo("上传了" + name + "图片");
		record.setOperTime(new Date());
		record.setOperUserId(uId.intValue());
		record.setStatus(1);
		ytCarLoanLogMapper.insertSelective(record);
	}

	@Override
	public YtCarLoan findDataDetailById(String id) {
		return ytCarLoanMapper.selectByPrimaryKey(id);
	}

	@Override
	public Boolean checkUser(Integer deptId) {
		YtCooperativeMainExample example = new YtCooperativeMainExample();
		example.createCriteria().andDeptIdEqualTo(deptId).andStatusEqualTo(1);
		List<YtCooperativeMain> list = ytCooperativeMainMapper.selectByExample(example);
		if(list != null && list.size() > 0){
			return true;
		}
		return false;
	}

	@Override
	public void editCarLoanInfo(YtCarLoan ytCarLoan, Long uId) {
		if(ytCarLoan.getDollarsNumber() == 1){
			ytCarLoan.setOneDollarsName("");
		}
		ytCarLoanMapper.updateByPrimaryKeySelective(ytCarLoan);
		
		YtCarLoanLog record = new YtCarLoanLog();
		record.setCarLoanId(ytCarLoan.getId());
		record.setOperInfo("编辑贷款记录");
		record.setOperTime(new Date());
		record.setOperUserId(uId.intValue());
		record.setStatus(1);
		ytCarLoanLogMapper.insertSelective(record);
	}

	@Override
	public void startApply(String carLoanId, Long userId) {
		Map<String, Object> variables = new HashMap<String,Object>();
		variables.put("inputUser", userId);//表示惟一用户
		
		runtimeService.startProcessInstanceByKey("YtCarLoan",carLoanId,variables);
		
		// 修改状态
		YtCarLoan ytCarLoan = new YtCarLoan();
		Date d = new Date();
		ytCarLoan.setId(carLoanId);
		ytCarLoan.setStatus(2);
		ytCarLoan.setStartTime(d);
		ytCarLoanMapper.updateByPrimaryKeySelective(ytCarLoan);
		
		// 记录日志
		YtCarLoanLog record = new YtCarLoanLog();
		record.setCarLoanId(ytCarLoan.getId());
		record.setOperInfo("发起流程");
		record.setOperTime(d);
		record.setOperUserId(userId.intValue());
		record.setStatus(2);
		ytCarLoanLogMapper.insertSelective(record);
	}

	@Override
	public void complete(String carLoanId, Long id) {
		// 修改状态
		YtCarLoan ytCarLoan = new YtCarLoan();
		ytCarLoan.setId(carLoanId);
		ytCarLoan.setStatus(24);
		ytCarLoanMapper.updateByPrimaryKeySelective(ytCarLoan);
		
		// 记录日志
		YtCarLoanLog record = new YtCarLoanLog();
		record.setCarLoanId(ytCarLoan.getId());
		record.setOperInfo("完成");
		record.setOperTime(new Date());
		record.setOperUserId(id.intValue());
		record.setStatus(24);
		ytCarLoanLogMapper.insertSelective(record);
	}

	@Override
	public PageInfo<CommentVo> hisComment(String carLoanId) {
		PageInfo<CommentVo> pageInfo = new PageInfo<>();
		HistoricProcessInstance hpi = historyService.createHistoricProcessInstanceQuery()
				.processInstanceBusinessKey(carLoanId)//使用BusinessKey字段查询
				.singleResult();

		String processInstanceId = hpi.getId();
		
		List<CommentVo> returnList = new ArrayList<>();
		List<Comment> list = taskService.getProcessInstanceComments(processInstanceId);
		if(list != null && list.size() > 0){
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
		
		pageInfo.setRows(returnList);
		return pageInfo;
	}

	@Override
	public PageInfo<YtMoneyFlow> findMoneyFlow(Integer page, Integer rows,String carLoanId) {
		PageInfo<YtMoneyFlow> pageInfo = new PageInfo<>(page, rows);
		YtMoneyFlowExample example = new YtMoneyFlowExample();
		example.setPageNo(page);
		example.setPageSize(rows);
		example.createCriteria().andCarLoanIdEqualTo(carLoanId);
		pageInfo.setRows(ytMoneyFlowMapper.selectByExample(example));
		pageInfo.setTotal(ytMoneyFlowMapper.countByExample(example));
		return pageInfo;
	}

	@Override
	public List<ZipFileBean> downloadFile(String carLoanId) throws Exception {
		YtCarLoan carLoan = ytCarLoanMapper.selectByPrimaryKey(carLoanId);
		List<ZipFileBean> zipFileBeans = new ArrayList<>();
		ZipFileBean zipFileBean = null;
		
		//行驶本
		String travelBook = carLoan.getTravelBook();
		if(travelBook != null){
			String[] split = travelBook.split(",");
			if(split.length == 1){
				String remoteRecourse = split[0].split("http://192.168.1.88/")[1];
				zipFileBean = new ZipFileBean();
				InputStream download = ftpUtils.download("/" + remoteRecourse);
				String chString = Common.getPropertyVal("enToCh.properties", "travelBook");
				zipFileBean.setFilePath(remoteRecourse.replace("travelBook", chString));
				zipFileBean.setInputStream(download);
				zipFileBeans.add(zipFileBean);
			}else{
				for(String s : split){
					String remoteRecourse = s.split("http://192.168.1.88/")[1];
					zipFileBean = new ZipFileBean();
					InputStream download = ftpUtils.download("/" + remoteRecourse);
					String chString = Common.getPropertyVal("enToCh.properties", "travelBook");
					zipFileBean.setFilePath(remoteRecourse.replace("travelBook", chString));
					zipFileBean.setInputStream(download);
					zipFileBeans.add(zipFileBean);
				}
			}
		}
		
		// 身份证  / 营业执照
		String idcardLicense = carLoan.getIdcardLicense();
		if(idcardLicense != null){
			String[] split = idcardLicense.split(",");
			if(split.length == 1){
				String remoteRecourse = split[0].split("http://192.168.1.88/")[1];
				zipFileBean = new ZipFileBean();
				InputStream download = ftpUtils.download("/" + remoteRecourse);
				String chString = Common.getPropertyVal("enToCh.properties", "idcardLicense");
				zipFileBean.setFilePath(remoteRecourse.replace("idcardLicense", chString));
				zipFileBean.setInputStream(download);
				zipFileBeans.add(zipFileBean);
			}else{
				for(String s : split){
					String remoteRecourse = s.split("http://192.168.1.88/")[1];
					zipFileBean = new ZipFileBean();
					InputStream download = ftpUtils.download("/" + remoteRecourse);
					String chString = Common.getPropertyVal("enToCh.properties", "idcardLicense");
					zipFileBean.setFilePath(remoteRecourse.replace("idcardLicense", chString));
					zipFileBean.setInputStream(download);
					zipFileBeans.add(zipFileBean);
				}
			}
		}
		
		// 车辆评估报告
		String vehicleEvaluationReport = carLoan.getVehicleEvaluationReport();
		if(vehicleEvaluationReport != null){
			String[] split = vehicleEvaluationReport.split(",");
			if(split.length == 1){
				String remoteRecourse = split[0].split("http://192.168.1.88/")[1];
				zipFileBean = new ZipFileBean();
				InputStream download = ftpUtils.download("/" + remoteRecourse);
				String chString = Common.getPropertyVal("enToCh.properties", "vehicleEvaluationReport");
				zipFileBean.setFilePath(remoteRecourse.replace("vehicleEvaluationReport", chString));
				zipFileBean.setInputStream(download);
				zipFileBeans.add(zipFileBean);
			}else{
				for(String s : split){
					String remoteRecourse = s.split("http://192.168.1.88/")[1];
					zipFileBean = new ZipFileBean();
					InputStream download = ftpUtils.download("/" + remoteRecourse);
					String chString = Common.getPropertyVal("enToCh.properties", "vehicleEvaluationReport");
					zipFileBean.setFilePath(remoteRecourse.replace("vehicleEvaluationReport", chString));
					zipFileBean.setInputStream(download);
					zipFileBeans.add(zipFileBean);
				}
			}
		}
		
		// 委托借款协议
		String loanAgreement = carLoan.getLoanAgreement();
		if(loanAgreement != null){
			String[] split = loanAgreement.split(",");
			if(split.length == 1){
				String remoteRecourse = split[0].split("http://192.168.1.88/")[1];
				zipFileBean = new ZipFileBean();
				InputStream download = ftpUtils.download("/" + remoteRecourse);
				String chString = Common.getPropertyVal("enToCh.properties", "loanAgreement");
				zipFileBean.setFilePath(remoteRecourse.replace("loanAgreement", chString));
				zipFileBean.setInputStream(download);
				zipFileBeans.add(zipFileBean);
			}else{
				for(String s : split){
					String remoteRecourse = s.split("http://192.168.1.88/")[1];
					zipFileBean = new ZipFileBean();
					InputStream download = ftpUtils.download("/" + remoteRecourse);
					String chString = Common.getPropertyVal("enToCh.properties", "loanAgreement");
					zipFileBean.setFilePath(remoteRecourse.replace("loanAgreement", chString));
					zipFileBean.setInputStream(download);
					zipFileBeans.add(zipFileBean);
				}
			}
		}
		
		// 机动车登记证
		String vehicleCertificate = carLoan.getVehicleCertificate();
		if(vehicleCertificate != null){
			String[] split = vehicleCertificate.split(",");
			if(split.length == 1){
				String remoteRecourse = split[0].split("http://192.168.1.88/")[1];
				zipFileBean = new ZipFileBean();
				InputStream download = ftpUtils.download("/" + remoteRecourse);
				String chString = Common.getPropertyVal("enToCh.properties", "vehicleCertificate");
				zipFileBean.setFilePath(remoteRecourse.replace("vehicleCertificate", chString));
				zipFileBean.setInputStream(download);
				zipFileBeans.add(zipFileBean);
			}else{
				for(String s : split){
					String remoteRecourse = s.split("http://192.168.1.88/")[1];
					zipFileBean = new ZipFileBean();
					InputStream download = ftpUtils.download("/" + remoteRecourse);
					String chString = Common.getPropertyVal("enToCh.properties", "vehicleCertificate");
					zipFileBean.setFilePath(remoteRecourse.replace("vehicleCertificate", chString));
					zipFileBean.setInputStream(download);
					zipFileBeans.add(zipFileBean);
				}
			}
		}
		
		// 车辆购置完税证明
		String vehicleTaxCertificate = carLoan.getVehicleTaxCertificate();
		if(vehicleTaxCertificate != null){
			String[] split = vehicleTaxCertificate.split(",");
			if(split.length == 1){
				String remoteRecourse = split[0].split("http://192.168.1.88/")[1];
				zipFileBean = new ZipFileBean();
				InputStream download = ftpUtils.download("/" + remoteRecourse);
				String chString = Common.getPropertyVal("enToCh.properties", "vehicleTaxCertificate");
				zipFileBean.setFilePath(remoteRecourse.replace("vehicleTaxCertificate", chString));
				zipFileBean.setInputStream(download);
				zipFileBeans.add(zipFileBean);
			}else{
				for(String s : split){
					String remoteRecourse = s.split("http://192.168.1.88/")[1];
					zipFileBean = new ZipFileBean();
					InputStream download = ftpUtils.download("/" + remoteRecourse);
					String chString = Common.getPropertyVal("enToCh.properties", "vehicleTaxCertificate");
					zipFileBean.setFilePath(remoteRecourse.replace("vehicleTaxCertificate", chString));
					zipFileBean.setInputStream(download);
					zipFileBeans.add(zipFileBean);
				}
			}
		}
		
		// 车辆发票
		String vehicalInvoice = carLoan.getVehicalInvoice();
		if(vehicalInvoice != null){
			String[] split = vehicalInvoice.split(",");
			if(split.length == 1){
				String remoteRecourse = split[0].split("http://192.168.1.88/")[1];
				zipFileBean = new ZipFileBean();
				InputStream download = ftpUtils.download("/" + remoteRecourse);
				String chString = Common.getPropertyVal("enToCh.properties", "vehicalInvoice");
				zipFileBean.setFilePath(remoteRecourse.replace("vehicalInvoice", chString));
				zipFileBean.setInputStream(download);
				zipFileBeans.add(zipFileBean);
			}else{
				for(String s : split){
					String remoteRecourse = s.split("http://192.168.1.88/")[1];
					zipFileBean = new ZipFileBean();
					InputStream download = ftpUtils.download("/" + remoteRecourse);
					String chString = Common.getPropertyVal("enToCh.properties", "vehicalInvoice");
					zipFileBean.setFilePath(remoteRecourse.replace("vehicalInvoice", chString));
					zipFileBean.setInputStream(download);
					zipFileBeans.add(zipFileBean);
				}
			}
		}
		
		// 车辆照片
		String vehicalPhoto = carLoan.getVehicalPhoto();
		if(vehicalPhoto != null){
			String[] split = vehicalPhoto.split(",");
			if(split.length == 1){
				String remoteRecourse = split[0].split("http://192.168.1.88/")[1];
				zipFileBean = new ZipFileBean();
				InputStream download = ftpUtils.download("/" + remoteRecourse);
				String chString = Common.getPropertyVal("enToCh.properties", "vehicalPhoto");
				zipFileBean.setFilePath(remoteRecourse.replace("vehicalPhoto", chString));
				zipFileBean.setInputStream(download);
				zipFileBeans.add(zipFileBean);
			}else{
				for(String s : split){
					String remoteRecourse = s.split("http://192.168.1.88/")[1];
					zipFileBean = new ZipFileBean();
					InputStream download = ftpUtils.download("/" + remoteRecourse);
					String chString = Common.getPropertyVal("enToCh.properties", "vehicalPhoto");
					zipFileBean.setFilePath(remoteRecourse.replace("vehicalPhoto", chString));
					zipFileBean.setInputStream(download);
					zipFileBeans.add(zipFileBean);
				}
			}
		}
		
		// 借款合同
		String loanContract = carLoan.getLoanContract();
		if(loanContract != null){
			String[] split = loanContract.split(",");
			if(split.length == 1){
				String remoteRecourse = split[0].split("http://192.168.1.88/")[1];
				zipFileBean = new ZipFileBean();
				InputStream download = ftpUtils.download("/" + remoteRecourse);
				String chString = Common.getPropertyVal("enToCh.properties", "loanContract");
				zipFileBean.setFilePath(remoteRecourse.replace("loanContract", chString));
				zipFileBean.setInputStream(download);
				zipFileBeans.add(zipFileBean);
			}else{
				for(String s : split){
					String remoteRecourse = s.split("http://192.168.1.88/")[1];
					zipFileBean = new ZipFileBean();
					InputStream download = ftpUtils.download("/" + remoteRecourse);
					String chString = Common.getPropertyVal("enToCh.properties", "loanContract");
					zipFileBean.setFilePath(remoteRecourse.replace("loanContract", chString));
					zipFileBean.setInputStream(download);
					zipFileBeans.add(zipFileBean);
				}
			}
		}
		
		// 借条
		String iou = carLoan.getIou();
		if(iou != null){
			String[] split = iou.split(",");
			if(split.length == 1){
				String remoteRecourse = split[0].split("http://192.168.1.88/")[1];
				zipFileBean = new ZipFileBean();
				InputStream download = ftpUtils.download("/" + remoteRecourse);
				String chString = Common.getPropertyVal("enToCh.properties", "iou");
				zipFileBean.setFilePath(remoteRecourse.replace("iou", chString));
				zipFileBean.setInputStream(download);
				zipFileBeans.add(zipFileBean);
			}else{
				for(String s : split){
					String remoteRecourse = s.split("http://192.168.1.88/")[1];
					zipFileBean = new ZipFileBean();
					InputStream download = ftpUtils.download("/" + remoteRecourse);
					String chString = Common.getPropertyVal("enToCh.properties", "iou");
					zipFileBean.setFilePath(remoteRecourse.replace("iou", chString));
					zipFileBean.setInputStream(download);
					zipFileBeans.add(zipFileBean);
				}
			}
		}
		
		// 资金需求表
		String capitalRequirement = carLoan.getCapitalRequirement();
		if(capitalRequirement != null){
			String[] split = capitalRequirement.split(",");
			if(split.length == 1){
				String remoteRecourse = split[0].split("http://192.168.1.88/")[1];
				zipFileBean = new ZipFileBean();
				InputStream download = ftpUtils.download("/" + remoteRecourse);
				String chString = Common.getPropertyVal("enToCh.properties", "capitalRequirement");
				zipFileBean.setFilePath(remoteRecourse.replace("capitalRequirement", chString));
				zipFileBean.setInputStream(download);
				zipFileBeans.add(zipFileBean);
			}else{
				for(String s : split){
					String remoteRecourse = s.split("http://192.168.1.88/")[1];
					zipFileBean = new ZipFileBean();
					InputStream download = ftpUtils.download("/" + remoteRecourse);
					String chString = Common.getPropertyVal("enToCh.properties", "capitalRequirement");
					zipFileBean.setFilePath(remoteRecourse.replace("capitalRequirement", chString));
					zipFileBean.setInputStream(download);
					zipFileBeans.add(zipFileBean);
				}
			}
		}
		
		// 保单
		String policy = carLoan.getPolicy();
		if(policy != null){
			String[] split = policy.split(",");
			if(split.length == 1){
				String remoteRecourse = split[0].split("http://192.168.1.88/")[1];
				zipFileBean = new ZipFileBean();
				InputStream download = ftpUtils.download("/" + remoteRecourse);
				String chString = Common.getPropertyVal("enToCh.properties", "policy");
				zipFileBean.setFilePath(remoteRecourse.replace("policy", chString));
				zipFileBean.setInputStream(download);
				zipFileBeans.add(zipFileBean);
			}else{
				for(String s : split){
					String remoteRecourse = s.split("http://192.168.1.88/")[1];
					zipFileBean = new ZipFileBean();
					InputStream download = ftpUtils.download("/" + remoteRecourse);
					String chString = Common.getPropertyVal("enToCh.properties", "policy");
					zipFileBean.setFilePath(remoteRecourse.replace("policy", chString));
					zipFileBean.setInputStream(download);
					zipFileBeans.add(zipFileBean);
				}
			}
		}
		
		// 机动车封存清单
		String vehicleInventory = carLoan.getVehicleInventory();
		if(vehicleInventory != null){
			String[] split = vehicleInventory.split(",");
			if(split.length == 1){
				String remoteRecourse = split[0].split("http://192.168.1.88/")[1];
				zipFileBean = new ZipFileBean();
				InputStream download = ftpUtils.download("/" + remoteRecourse);
				String chString = Common.getPropertyVal("enToCh.properties", "vehicleInventory");
				zipFileBean.setFilePath(remoteRecourse.replace("vehicleInventory", chString));
				zipFileBean.setInputStream(download);
				zipFileBeans.add(zipFileBean);
			}else{
				for(String s : split){
					String remoteRecourse = s.split("http://192.168.1.88/")[1];
					zipFileBean = new ZipFileBean();
					InputStream download = ftpUtils.download("/" + remoteRecourse);
					String chString = Common.getPropertyVal("enToCh.properties", "vehicleInventory");
					zipFileBean.setFilePath(remoteRecourse.replace("vehicleInventory", chString));
					zipFileBean.setInputStream(download);
					zipFileBeans.add(zipFileBean);
				}
			}
		}
		return zipFileBeans;
	}

	@Override
	public String findTaskId(String carLoanId) {
		Task task = taskService.createTaskQuery()
				.processInstanceBusinessKey(carLoanId)
				.singleResult();
		return task.getId();
	}
	
}















