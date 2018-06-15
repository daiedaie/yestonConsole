package com.mrbt.yeston.web.vo;

/**
 * 部门
 * @author 罗鑫
 * Date 2017年3月10日
 */
public class DeptVo {

	private Integer id;
	private String name;
	private Integer pid;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	} 
}
