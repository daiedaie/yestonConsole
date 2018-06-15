package com.mrbt.yeston.web.vo;

import java.util.Date;

/**
 * @author 罗鑫
 * Date 2017年3月7日
 */
public class YtCartLoanInfoSearchVo {

	private String plateNumber;// 车牌号
	private String vehicleType;// 车辆型号
	private String ownerName;// 车主姓名
	private String deptId;// 部门
	private Integer userId;// 申请人
	private Integer status;// 状态
	private Date startTime;// 最早申请时间
	private Date endTime;// 最晚申请时间
	private Double loanAmountMin;// 最小借款金额
	private Double loanAmountMax;// 最大借款金额
	private Integer loanTernMin;// 最小借款期限
	private Integer loanTernMax;// 最大借款期限
	
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getPlateNumber() {
		return plateNumber;
	}
	public void setPlateNumber(String plateNumber) {
		this.plateNumber = plateNumber;
	}
	public String getVehicleType() {
		return vehicleType;
	}
	public void setVehicleType(String vehicleType) {
		this.vehicleType = vehicleType;
	}
	public String getOwnerName() {
		return ownerName;
	}
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public Double getLoanAmountMin() {
		return loanAmountMin;
	}
	public void setLoanAmountMin(Double loanAmountMin) {
		this.loanAmountMin = loanAmountMin;
	}
	public Double getLoanAmountMax() {
		return loanAmountMax;
	}
	public void setLoanAmountMax(Double loanAmountMax) {
		this.loanAmountMax = loanAmountMax;
	}
	public Integer getLoanTernMin() {
		return loanTernMin;
	}
	public void setLoanTernMin(Integer loanTernMin) {
		this.loanTernMin = loanTernMin;
	}
	public Integer getLoanTernMax() {
		return loanTernMax;
	}
	public void setLoanTernMax(Integer loanTernMax) {
		this.loanTernMax = loanTernMax;
	}
	
}
