package com.mrbt.yeston.web.vo;

import java.util.Date;

/**
 * @author 罗鑫
 * Date 2017年3月7日
 */
public class YtCarLoanInfoVo {

	private String id;// id
	private String plateNumber;// 车牌号
	private String ownerName;// 车主姓名
	private String vehicleType;// 车辆型号
	private Double loanAmount;// 借款金额
	private Integer loanTerm;// 借款期限
	private Double rate;// 利率
	private String userName;// 申请人
	private String cooperateName;// 供应商
	private String regionName;// 地域
	private Date startTime;// 申请时间
	private Double estRepAmount;// 预计还款金额
	private Double actRepAmount;// 实际还款金额
	private String status;// 状态
	private Integer productId;// 产品id
	private Integer businessType;// 业务类型
	
	public Integer getBusinessType() {
		return businessType;
	}
	public void setBusinessType(Integer businessType) {
		this.businessType = businessType;
	}
	public Integer getProductId() {
		return productId;
	}
	public void setProductId(Integer productId) {
		this.productId = productId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Integer getLoanTerm() {
		return loanTerm;
	}
	public void setLoanTerm(Integer loanTerm) {
		this.loanTerm = loanTerm;
	}
	public String getRegionName() {
		return regionName;
	}
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public String getPlateNumber() {
		return plateNumber;
	}
	public void setPlateNumber(String plateNumber) {
		this.plateNumber = plateNumber;
	}
	public String getOwnerName() {
		return ownerName;
	}
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}
	public String getVehicleType() {
		return vehicleType;
	}
	public void setVehicleType(String vehicleType) {
		this.vehicleType = vehicleType;
	}
	public Double getLoanAmount() {
		return loanAmount;
	}
	public void setLoanAmount(Double loanAmount) {
		this.loanAmount = loanAmount;
	}
	public Double getRate() {
		return rate;
	}
	public void setRate(Double rate) {
		this.rate = rate;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCooperateName() {
		return cooperateName;
	}
	public void setCooperateName(String cooperateName) {
		this.cooperateName = cooperateName;
	}
	public Double getEstRepAmount() {
		return estRepAmount;
	}
	public void setEstRepAmount(Double estRepAmount) {
		this.estRepAmount = estRepAmount;
	}
	public Double getActRepAmount() {
		return actRepAmount;
	}
	public void setActRepAmount(Double actRepAmount) {
		this.actRepAmount = actRepAmount;
	}
}
