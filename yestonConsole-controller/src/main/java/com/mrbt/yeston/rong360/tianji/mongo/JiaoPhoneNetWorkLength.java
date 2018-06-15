package com.mrbt.yeston.rong360.tianji.mongo;

import java.io.Serializable;

import org.springframework.data.mongodb.core.mapping.Document;

/** 
 * @author  suyibo 
 * @date 创建时间：2018年2月24日
 */
@Document(collection = "tianji_jiao_phonenetworklength_mongo")
public class JiaoPhoneNetWorkLength implements Serializable {
	/**
	 * 数据id
	 */
	private String id;
	/**
	 * 接口名
	 */
	private String method;
	/**
	 * 接口名称
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
	 * 省
	 */
	private String province;
	/**
	 * 城市
	 */
	private String city;
	/**
	 * 运营商
	 */
	private String isp;
	/**
	 * 返回信息
	 */
	private String desc;
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

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getIsp() {
		return isp;
	}

	public void setIsp(String isp) {
		this.isp = isp;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
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