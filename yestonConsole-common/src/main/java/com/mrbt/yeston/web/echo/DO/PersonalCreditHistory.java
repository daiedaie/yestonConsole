package com.mrbt.yeston.web.echo.DO;

import java.io.Serializable;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "personal_credit_history")
public class PersonalCreditHistory implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 数据ID
	 */
	private String _id;
	
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
	 * 返回码
	 */
	private String errorCode;
	
	/**
	 * 返回信息
	 */
	private String message;

	/**
	 * 业务类型编号
	 */
	private String tx;
	
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
	 * 被查询统计
	 */
	private String queryStatistics;

	/**
	 * 被查询历史
	 */
	private String queryHistory;

	/**
	 * 业务类型编号
	 */
	private Object data_info;
	
	/**
	 * 数据来源编码
	 */
	private int source_code;
	
	/**
	 * 数据来源说明
	 */
	private String source_info;

	public String get_id() {
		return _id;
	}

	public void set_id(String _id) {
		this._id = _id;
	}

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

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getTx() {
		return tx;
	}

	public void setTx(String tx) {
		this.tx = tx;
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

	public String getQueryStatistics() {
		return queryStatistics;
	}

	public void setQueryStatistics(String queryStatistics) {
		this.queryStatistics = queryStatistics;
	}

	public String getQueryHistory() {
		return queryHistory;
	}

	public void setQueryHistory(String queryHistory) {
		this.queryHistory = queryHistory;
	}

	public Object getData_info() {
		return data_info;
	}

	public void setData_info(Object data_info) {
		this.data_info = data_info;
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
