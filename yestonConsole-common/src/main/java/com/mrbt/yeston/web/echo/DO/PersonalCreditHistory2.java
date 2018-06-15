package com.mrbt.yeston.web.echo.DO;

import java.io.Serializable;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "personal_credit_history")
public class PersonalCreditHistory2 implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 被查人姓名
	 */
	private String personal_name;
	
	/**
	 * 被查人身份证
	 */
	private String id_no;

	/**
	 * 查询时间
	 */
	private String query_time;

	/**
	 * 流水号
	 */
	private String flow_id;

	/**
	 * 致诚信用分
	 */
	private String zcCreditScore;

	/**
	 * 违约概率
	 */
	private String contractBreakRate;

	/**
	 * 数据来源编码
	 */
	private int source_code;
	
	/**
	 * 数据来源说明
	 */
	private String source_info;

	public String getPersonal_name() {
		return personal_name;
	}

	public void setPersonal_name(String personal_name) {
		this.personal_name = personal_name;
	}

	public String getId_no() {
		return id_no;
	}

	public void setId_no(String id_no) {
		this.id_no = id_no;
	}

	public String getQuery_time() {
		return query_time;
	}

	public void setQuery_time(String query_time) {
		this.query_time = query_time;
	}

	public String getFlow_id() {
		return flow_id;
	}

	public void setFlow_id(String flow_id) {
		this.flow_id = flow_id;
	}

	public String getZcCreditScore() {
		return zcCreditScore;
	}

	public void setZcCreditScore(String zcCreditScore) {
		this.zcCreditScore = zcCreditScore;
	}

	public String getContractBreakRate() {
		return contractBreakRate;
	}

	public void setContractBreakRate(String contractBreakRate) {
		this.contractBreakRate = contractBreakRate;
	}

	public int getSource_code() {
		return source_code;
	}

	public void setSource_code(int source_code) {
		this.source_code = source_code;
	}

	public String getSource_info() {
		return source_info;
	}

	public void setSource_info(String source_info) {
		this.source_info = source_info;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
