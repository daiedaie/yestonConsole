package com.mrbt.yeston.code;

import java.io.Serializable;

public class RespondBean implements Serializable{
	
	private int resCode;
	private String resMsg;
	private Object data;
	public int getResCode() {
		return resCode;
	}
	public void setResCode(int resCode) {
		this.resCode = resCode;
	}
	public String getResMsg() {
		return resMsg;
	}
	public void setResMsg(String resMsg) {
		this.resMsg = resMsg;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	
}
