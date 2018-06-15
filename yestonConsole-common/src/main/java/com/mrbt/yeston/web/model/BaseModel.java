package com.mrbt.yeston.web.model;

public class BaseModel {
	/**
	 * 添加分页功能 xml文件中 
	 * selectByExample 
	 * <if test="start !=0 or limit!=0">
	 *  limit #{start},#{limit} 
	 * </if>
	 */
	protected int start;
	
	protected int limit;

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}
}
