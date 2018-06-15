package com.mrbt.yeston.web.vo;

import java.util.Date;

/**
 * @author 罗鑫
 * Date 2017年3月13日
 */
public class CommentVo {

	private Date time;
	private String message;
	private String userName;
	private String voucher;
	
	public String getVoucher() {
		return voucher;
	}
	public void setVoucher(String voucher) {
		this.voucher = voucher;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
}
