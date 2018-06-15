package com.mrbt.yeston.rong360.tianji.mongo;

import java.io.Serializable;

import org.springframework.data.mongodb.core.mapping.Document;

/** 
 * @author  suyibo 
 * @date 创建时间：2018年2月24日
 */
@Document(collection = "tianji_umneg_score_mongo")
public class UmengScore implements Serializable {
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
	 * 设备价格 设备价格 {1:1000元以下,2:1000-2000元,3:2000-3000元,4:3000-4000元,5:4000元以上}
	 */
	private String devicePrice;
	/**
	 * 综合风控评分 根据用户移动端综合情况得出的预测模型分数,整形,正常值域[350,950],信息不足取值为-1
	 */
	private String creditScore;
	/**
	 * idmmapping 评分
	 */
	private String idScore;
	/**
	 * 设备品牌 设备品牌名称,字符串
	 */
	private String deviceBrand;
	/**
	 * 兴趣偏好分 根据用户移动端兴趣计算的预测模型分数,整形,正常值域[350,950],信息不足取值为-1
	 */
	private String interestScore;
	/**
	 * 地理分 根据用户移动端得到的地理位置计算的预测模型分数,整形,正常值域[350,950],信息不足取值为-1
	 */
	private String locationScore;
	/**
	 * 设备质量等级 根据用户移动端综合情况给出的设备评级:{0:优质,1:良好,2:一般,3:低质量}
	 */
	private String deviceRank;
	/**
	 * 操作系统 设备操作系统名称,字符串
	 */
	private String deviceOs;
	/**
	 * 设备基本信息分 根据用户设备属性计算的预测模型分数,整形,正常值域[350,950],信息不足取值为-1
	 */
	private String deviceScore;
	/**
	 * app评分 根据用户移动端得到的应用安装数据计算的预测模型分数,整形,正常值域[350,950],信息不足取值为-1
	 */
	private String appScore;
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

	public String getDevicePrice() {
		return devicePrice;
	}

	public void setDevicePrice(String devicePrice) {
		this.devicePrice = devicePrice;
	}

	public String getCreditScore() {
		return creditScore;
	}

	public void setCreditScore(String creditScore) {
		this.creditScore = creditScore;
	}

	public String getIdScore() {
		return idScore;
	}

	public void setIdScore(String idScore) {
		this.idScore = idScore;
	}

	public String getDeviceBrand() {
		return deviceBrand;
	}

	public void setDeviceBrand(String deviceBrand) {
		this.deviceBrand = deviceBrand;
	}

	public String getInterestScore() {
		return interestScore;
	}

	public void setInterestScore(String interestScore) {
		this.interestScore = interestScore;
	}

	public String getLocationScore() {
		return locationScore;
	}

	public void setLocationScore(String locationScore) {
		this.locationScore = locationScore;
	}

	public String getDeviceRank() {
		return deviceRank;
	}

	public void setDeviceRank(String deviceRank) {
		this.deviceRank = deviceRank;
	}

	public String getDeviceOs() {
		return deviceOs;
	}

	public void setDeviceOs(String deviceOs) {
		this.deviceOs = deviceOs;
	}

	public String getDeviceScore() {
		return deviceScore;
	}

	public void setDeviceScore(String deviceScore) {
		this.deviceScore = deviceScore;
	}

	public String getAppScore() {
		return appScore;
	}

	public void setAppScore(String appScore) {
		this.appScore = appScore;
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