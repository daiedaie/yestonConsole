package com.mrbt.yeston.rong360.tianji.mongo;

import java.io.Serializable;

import org.springframework.data.mongodb.core.mapping.Document;

/** 
 * @author  suyibo 
 * @date 创建时间：2018年2月24日
 */
@Document(collection = "tianji_jiguang_policy_mongo")
public class JiguangPolicy implements Serializable {
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
	 * 行为年龄水平(指客户在移动互联网上表现出来的年龄特征，年龄段:0.00=0~15岁,0.25=16~25岁,0.50=26~35岁,0.75=36
	 * ~45岁,1.00表示大于46)
	 */
	private String CPL_AGE_LEVEL;
	/**
	 * 行为性别水平(指客户在移动互联网上表现出来的性别倾向（这里返回男性的概率），大于0.5可认为行为以男性为主)
	 */
	private String CPL_SEX_LEVEL;
	/**
	 * 设备价值水平指数(通过客户所持移动设备的品牌、型号、参数及出厂价格等因素综合体现设备的价值水平，值越大代表价值越高)
	 */
	private String CPL_DEVICE_LEVEL;
	/**
	 * 客户触达稳定指数(反映客户的联系方式、使用设备等变更频次的稳定程度，值越小代表越稳定)
	 */
	private String CPL_CPS_LEVEL;
	/**
	 * 风险人群关联指数(指用户在各种圈子、群体中的关联风险倾向，值越大代表风险越大)
	 */
	private String SOM_RNI_RSI;
	/**
	 * 互金业务关注指数2(反映客户对于各类大额借贷类产品的持续关注程度和稳定使用程度，值越大代表特征强度越大)
	 */
	private String FIM_NF_BCI2;
	/**
	 * 互金业务关注指数3(反映客户对于各类短期借贷类产品的持续关注程度和稳定使用程度，值越大代表特征强度越大)
	 */
	private String FIM_NF_BCI3;
	/**
	 * 互金业务偏好指数(通过客户的移动互联网行为及其他合作平台数据获得该用户多平台借款行为的风险指数，值越大代表风险越大)
	 */
	private String FIM_NF_BPI;
	/**
	 * 互金业务频度指数(反映客户对于互金应用的接触、了解、使用等活跃行为的综合评价指标，值越大代表越活跃)
	 */
	private String FIM_NF_BFI;
	/**
	 * 互金业务强度指数(反映客户对于各类借贷应用的热衷时长、更换频次等使用行为综合评价指标，值越大代表特征强度越大)
	 */
	private String FIM_NF_BSI;
	/**
	 * 信用消费规模指数1(反映客户对于不同信用消费平台的关注广度，值越大代表特征强度越大)
	 */
	private String FIM_CC_BSI1;
	/**
	 * 信用消费规模指数2(通过使用频度、使用时长、使用规模等不同维度数据交叉分析，洞察客户在消费金融平台上的兴趣度，值越大代表特征强度越大)
	 */
	private String FIM_CC_BSI2;
	/**
	 * 信用消费规模指数3(通过使用频度、使用时长、使用规模等不同维度数据交叉分析，洞察客户对综合金融理财的兴趣度，值越大代表兴趣越大)
	 */
	private String FIM_CC_BSI3;
	/**
	 * 信用消费频度指数(反映客户对于不同信用消费平台的关注深度，值越大代表特征强度越大)
	 */
	private String FIM_CC_BFI;
	/**
	 * 支付行为偏好指数(通过使用偏好、使用时长、使用规模等不同维度数据交叉分析，衡量客户所有线上支付领域的活跃指数，值越大代表越活跃)
	 */
	private String FIM_PAY_BPI;
	/**
	 * 支付行为频度指数(通过使用偏好、使用时长、安装/卸载频次等不同维度数据交叉分析，衡量客户传统线上支付领域的活跃指数，值越大代表越活跃)
	 */
	private String FIM_PAY_BFI;
	/**
	 * 出行方式规模指数(综合反映客户在移动应用上使用租车、拼车、代驾、自驾等出行方式的使用强度，值越大代表特征强度越大)
	 */
	private String GBM_TM_BSI;
	/**
	 * 生活服务频度指数(通过线上购物、生活缴费、社交、医疗等使用频度，综合定义出该客户的O2O生活消费指数，值越大代表特征强度越大)
	 */
	private String GBM_LH_BFI;
	/**
	 * 特定行为规模指数(反映客户在特定移动应用上表现出来的消遣、娱乐、游戏等方面的使用强度，值越大代表越活跃)
	 */
	private String GBM_SBH_HSI;
	/**
	 * 一般行为规模指数(反映客户在移动应用上的总体使用强度，值越大代表特征强度越大 H)
	 */
	private String GBM_CBH_HSI;
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

	public String getCPL_AGE_LEVEL() {
		return CPL_AGE_LEVEL;
	}

	public void setCPL_AGE_LEVEL(String cPL_AGE_LEVEL) {
		CPL_AGE_LEVEL = cPL_AGE_LEVEL;
	}

	public String getCPL_SEX_LEVEL() {
		return CPL_SEX_LEVEL;
	}

	public void setCPL_SEX_LEVEL(String cPL_SEX_LEVEL) {
		CPL_SEX_LEVEL = cPL_SEX_LEVEL;
	}

	public String getCPL_DEVICE_LEVEL() {
		return CPL_DEVICE_LEVEL;
	}

	public void setCPL_DEVICE_LEVEL(String cPL_DEVICE_LEVEL) {
		CPL_DEVICE_LEVEL = cPL_DEVICE_LEVEL;
	}

	public String getCPL_CPS_LEVEL() {
		return CPL_CPS_LEVEL;
	}

	public void setCPL_CPS_LEVEL(String cPL_CPS_LEVEL) {
		CPL_CPS_LEVEL = cPL_CPS_LEVEL;
	}

	public String getSOM_RNI_RSI() {
		return SOM_RNI_RSI;
	}

	public void setSOM_RNI_RSI(String sOM_RNI_RSI) {
		SOM_RNI_RSI = sOM_RNI_RSI;
	}

	public String getFIM_NF_BCI2() {
		return FIM_NF_BCI2;
	}

	public void setFIM_NF_BCI2(String fIM_NF_BCI2) {
		FIM_NF_BCI2 = fIM_NF_BCI2;
	}

	public String getFIM_NF_BCI3() {
		return FIM_NF_BCI3;
	}

	public void setFIM_NF_BCI3(String fIM_NF_BCI3) {
		FIM_NF_BCI3 = fIM_NF_BCI3;
	}

	public String getFIM_NF_BPI() {
		return FIM_NF_BPI;
	}

	public void setFIM_NF_BPI(String fIM_NF_BPI) {
		FIM_NF_BPI = fIM_NF_BPI;
	}

	public String getFIM_NF_BFI() {
		return FIM_NF_BFI;
	}

	public void setFIM_NF_BFI(String fIM_NF_BFI) {
		FIM_NF_BFI = fIM_NF_BFI;
	}

	public String getFIM_NF_BSI() {
		return FIM_NF_BSI;
	}

	public void setFIM_NF_BSI(String fIM_NF_BSI) {
		FIM_NF_BSI = fIM_NF_BSI;
	}

	public String getFIM_CC_BSI1() {
		return FIM_CC_BSI1;
	}

	public void setFIM_CC_BSI1(String fIM_CC_BSI1) {
		FIM_CC_BSI1 = fIM_CC_BSI1;
	}

	public String getFIM_CC_BSI2() {
		return FIM_CC_BSI2;
	}

	public void setFIM_CC_BSI2(String fIM_CC_BSI2) {
		FIM_CC_BSI2 = fIM_CC_BSI2;
	}

	public String getFIM_CC_BSI3() {
		return FIM_CC_BSI3;
	}

	public void setFIM_CC_BSI3(String fIM_CC_BSI3) {
		FIM_CC_BSI3 = fIM_CC_BSI3;
	}

	public String getFIM_CC_BFI() {
		return FIM_CC_BFI;
	}

	public void setFIM_CC_BFI(String fIM_CC_BFI) {
		FIM_CC_BFI = fIM_CC_BFI;
	}

	public String getFIM_PAY_BPI() {
		return FIM_PAY_BPI;
	}

	public void setFIM_PAY_BPI(String fIM_PAY_BPI) {
		FIM_PAY_BPI = fIM_PAY_BPI;
	}

	public String getFIM_PAY_BFI() {
		return FIM_PAY_BFI;
	}

	public void setFIM_PAY_BFI(String fIM_PAY_BFI) {
		FIM_PAY_BFI = fIM_PAY_BFI;
	}

	public String getGBM_TM_BSI() {
		return GBM_TM_BSI;
	}

	public void setGBM_TM_BSI(String gBM_TM_BSI) {
		GBM_TM_BSI = gBM_TM_BSI;
	}

	public String getGBM_LH_BFI() {
		return GBM_LH_BFI;
	}

	public void setGBM_LH_BFI(String gBM_LH_BFI) {
		GBM_LH_BFI = gBM_LH_BFI;
	}

	public String getGBM_SBH_HSI() {
		return GBM_SBH_HSI;
	}

	public void setGBM_SBH_HSI(String gBM_SBH_HSI) {
		GBM_SBH_HSI = gBM_SBH_HSI;
	}

	public String getGBM_CBH_HSI() {
		return GBM_CBH_HSI;
	}

	public void setGBM_CBH_HSI(String gBM_CBH_HSI) {
		GBM_CBH_HSI = gBM_CBH_HSI;
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
