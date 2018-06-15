package com.mrbt.yeston.web.echo.DO;

import org.springframework.stereotype.Component;

@Component
public class MortgagorDataVo {
	private String name;//姓名
	private String certNo;//身份证号
	private String loanDate;//借款时间
	private int periods;//期数
	private String loanAmount;//借款金额
	private String approvalStatusCode;//审批结果码
	private String loanStatusCode;//还款状态码
	private String loanTypeCode;//借款类型码
	private String overdueAmount;//逾期金额
	private String overdueStatus;//逾期情况
	private String overdueTotal;//历史逾期总次数
	private String overdueM3;//历史逾期M3+次数据(不含M3，包括M6及以上)
	private String overdueM6;//历史逾期M6+次数据(不含M6)
	private String riskItemTypeCode;//命中项码
	private String riskItemValue;//命中内容
	private String riskDetail;//风险明细
	private String riskTime;//风险最近时间
	private int dataCome;//记录来源
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCertNo() {
		return certNo;
	}
	public void setCertNo(String certNo) {
		this.certNo = certNo;
	}
	public String getLoanDate() {
		return loanDate;
	}
	public void setLoanDate(String loanDate) {
		this.loanDate = loanDate;
	}
	public int getPeriods() {
		return periods;
	}
	public void setPeriods(int periods) {
		this.periods = periods;
	}
	public String getLoanAmount() {
		return loanAmount;
	}
	public void setLoanAmount(String loanAmount) {
		this.loanAmount = loanAmount;
	}
	public String getApprovalStatusCode() {
		return approvalStatusCode;
	}
	public void setApprovalStatusCode(String approvalStatusCode) {
		this.approvalStatusCode = approvalStatusCode;
	}
	public String getLoanStatusCode() {
		return loanStatusCode;
	}
	public void setLoanStatusCode(String loanStatusCode) {
		this.loanStatusCode = loanStatusCode;
	}
	public String getLoanTypeCode() {
		return loanTypeCode;
	}
	public void setLoanTypeCode(String loanTypeCode) {
		this.loanTypeCode = loanTypeCode;
	}
	public String getOverdueAmount() {
		return overdueAmount;
	}
	public void setOverdueAmount(String overdueAmount) {
		this.overdueAmount = overdueAmount;
	}
	public String getOverdueStatus() {
		return overdueStatus;
	}
	public void setOverdueStatus(String overdueStatus) {
		this.overdueStatus = overdueStatus;
	}
	public String getOverdueTotal() {
		return overdueTotal;
	}
	public void setOverdueTotal(String overdueTotal) {
		this.overdueTotal = overdueTotal;
	}
	public String getOverdueM3() {
		return overdueM3;
	}
	public void setOverdueM3(String overdueM3) {
		this.overdueM3 = overdueM3;
	}
	public String getOverdueM6() {
		return overdueM6;
	}
	public void setOverdueM6(String overdueM6) {
		this.overdueM6 = overdueM6;
	}
	public String getRiskItemTypeCode() {
		return riskItemTypeCode;
	}
	public void setRiskItemTypeCode(String riskItemTypeCode) {
		this.riskItemTypeCode = riskItemTypeCode;
	}
	public String getRiskItemValue() {
		return riskItemValue;
	}
	public void setRiskItemValue(String riskItemValue) {
		this.riskItemValue = riskItemValue;
	}
	public String getRiskDetail() {
		return riskDetail;
	}
	public void setRiskDetail(String riskDetail) {
		this.riskDetail = riskDetail;
	}
	public String getRiskTime() {
		return riskTime;
	}
	public void setRiskTime(String riskTime) {
		this.riskTime = riskTime;
	}
	public int getDataCome() {
		return dataCome;
	}
	public void setDataCome(int dataCome) {
		this.dataCome = dataCome;
	}
}
