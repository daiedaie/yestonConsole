package com.mrbt.yeston.web.vo;

import java.math.BigDecimal;
import java.util.Date;

public class TradingVo {
	private Integer tradingId;// 交易ID
	private Integer productId;// 产品ID
	private String productName;// 产品名称
	private Integer usersId;// 用户ID
	private String usersName;// 用户姓名
	private String usersTelephone;// 用户手机号
	private String usersIDCard;// 用户身份证号
	private BigDecimal financialMoney;// 理财金额
	private Date buyTime; // 购买时间
	private Integer status;// 订单状态

	public Integer getTradingId() {
		return tradingId;
	}

	public void setTradingId(Integer tradingId) {
		this.tradingId = tradingId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Integer getUsersId() {
		return usersId;
	}

	public void setUsersId(Integer usersId) {
		this.usersId = usersId;
	}

	public String getUsersName() {
		return usersName;
	}

	public void setUsersName(String usersName) {
		this.usersName = usersName;
	}

	public String getUsersTelephone() {
		return usersTelephone;
	}

	public void setUsersTelephone(String usersTelephone) {
		this.usersTelephone = usersTelephone;
	}

	public String getUsersIDCard() {
		return usersIDCard;
	}

	public void setUsersIDCard(String usersIDCard) {
		this.usersIDCard = usersIDCard;
	}

	public BigDecimal getFinancialMoney() {
		return financialMoney;
	}

	public void setFinancialMoney(BigDecimal financialMoney) {
		this.financialMoney = financialMoney;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getBuyTime() {
		return buyTime;
	}

	public void setBuyTime(Date buyTime) {
		this.buyTime = buyTime;
	}

}
