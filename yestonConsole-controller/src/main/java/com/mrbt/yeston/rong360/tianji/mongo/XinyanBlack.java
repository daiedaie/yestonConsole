package com.mrbt.yeston.rong360.tianji.mongo;

import java.io.Serializable;

import org.springframework.data.mongodb.core.mapping.Document;

/** 
 * @author  suyibo 
 * @date 创建时间：2018年2月24日
 */
@Document(collection = "tianji_xinyan_black_mongo")
public class XinyanBlack implements Serializable {
	/**
	 * 数据id
	 */
	private String id;
	/**
	 * 接口名
	 */
	private String method;
	/**
	 * 接口名
	 */
	private String methodName;
	/**
	 * 用户姓名
	 */
	private String name;
	/**
	 * 身份证号
	 */
	private String idNumber;
	/**
	 * 电话
	 */
	private String phone;
	/**
	 * 查询结果码，0：建议拉黑
	 */
	private String code;
	/**
	 * 查询结果描述
	 */
	private String desc;
	/**
	 * 最大逾期金额
	 */
	private String maxOverdueAmt;
	/**
	 * 最长逾期天数，区间，格式：dd-dd
	 */
	private String maxOverdueDays;
	/**
	 * 最近预期时间，格式：yyyy-MM
	 */
	private String latestOverdueTime;
	/**
	 * 当前逾期机构数
	 */
	private String currentlyOverdue;
	/**
	 * 当前履约机构数
	 */
	private String currentlyPerformance;
	/**
	 * 异常还款机构数
	 */
	private String accExc;
	/**
	 * 睡眠机构数
	 */
	private String accSleep;
	/**
	 * 创建时间
	 */
	private String createDate;
	/**
	 * DataInfo数据id
	 */
	private String dataInfoId;

	/**
	 * This field was generated by MyBatis Generator. This field corresponds to
	 * the database table syn_user_data
	 *
	 * @mbg.generated
	 */
	private static final long serialVersionUID = 1L;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getMethodName() {
		return methodName;
	}

	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getMaxOverdueAmt() {
		return maxOverdueAmt;
	}

	public void setMaxOverdueAmt(String maxOverdueAmt) {
		this.maxOverdueAmt = maxOverdueAmt;
	}

	public String getMaxOverdueDays() {
		return maxOverdueDays;
	}

	public void setMaxOverdueDays(String maxOverdueDays) {
		this.maxOverdueDays = maxOverdueDays;
	}

	public String getLatestOverdueTime() {
		return latestOverdueTime;
	}

	public void setLatestOverdueTime(String latestOverdueTime) {
		this.latestOverdueTime = latestOverdueTime;
	}

	public String getCurrentlyOverdue() {
		return currentlyOverdue;
	}

	public void setCurrentlyOverdue(String currentlyOverdue) {
		this.currentlyOverdue = currentlyOverdue;
	}

	public String getCurrentlyPerformance() {
		return currentlyPerformance;
	}

	public void setCurrentlyPerformance(String currentlyPerformance) {
		this.currentlyPerformance = currentlyPerformance;
	}

	public String getAccExc() {
		return accExc;
	}

	public void setAccExc(String accExc) {
		this.accExc = accExc;
	}

	public String getAccSleep() {
		return accSleep;
	}

	public void setAccSleep(String accSleep) {
		this.accSleep = accSleep;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getDataInfoId() {
		return dataInfoId;
	}

	public void setDataInfoId(String dataInfoId) {
		this.dataInfoId = dataInfoId;
	}

}
