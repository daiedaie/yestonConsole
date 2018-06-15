package com.mrbt.yeston.web.echo.DO;

import org.springframework.data.mongodb.core.mapping.Document;

/**
 * 风险项记录表
 * @author ruochen.yu
 *
 */
@Document(collection = "risk_record")
public class RiskRecord {
	private String name;//姓名
	private String certNo;//身份证号
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
