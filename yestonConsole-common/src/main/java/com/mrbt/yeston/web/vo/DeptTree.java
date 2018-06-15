package com.mrbt.yeston.web.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 罗鑫
 * Date 2017年3月9日
 */
public class DeptTree {

	private Integer id;
	private String text;
	private List<DeptTree> children = new ArrayList<>();
	private Integer parentId ;
	
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public List<DeptTree> getChildren() {
		return children;
	}
	public void setChildren(List<DeptTree> children) {
		this.children = children;
	}
}
