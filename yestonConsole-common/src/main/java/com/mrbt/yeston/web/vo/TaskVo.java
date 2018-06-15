package com.mrbt.yeston.web.vo;

import java.util.Date;

/**
 * @author 罗鑫
 * Date 2017年3月13日
 */
public class TaskVo {
	private String taskId;
	private String ytCarLoanId;
	private String taskName;
	private Date createTime;
	private String userName;
	public String getYtCarLoanId() {
		return ytCarLoanId;
	}
	public void setYtCarLoanId(String ytCarLoanId) {
		this.ytCarLoanId = ytCarLoanId;
	}
	public String getTaskId() {
		return taskId;
	}
	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	public String getTaskName() {
		return taskName;
	}
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
}
