package com.mrbt.yeston.admin.model;

/**
 * 
 * @author 罗鑫
 *
 */
public class ProcessDefinationVo {

	private String id;
	private String name;
	private String key;
	private Integer version;
	private String deploymentId;
	private String resourceImg;
	private String resourceFile;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}

	public Integer getVersion() {
		return version;
	}
	public void setVersion(Integer version) {
		this.version = version;
	}
	public String getDeploymentId() {
		return deploymentId;
	}
	public void setDeploymentId(String deploymentId) {
		this.deploymentId = deploymentId;
	}
	public String getResourceImg() {
		return resourceImg;
	}
	public void setResourceImg(String resourceImg) {
		this.resourceImg = resourceImg;
	}
	public String getResourceFile() {
		return resourceFile;
	}
	public void setResourceFile(String resourceFile) {
		this.resourceFile = resourceFile;
	}
}
