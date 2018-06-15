package com.mrbt.yeston.web.vo;

import java.io.InputStream;
import java.io.Serializable;

/**
 * @author loxn
 */
public class ZipFileBean implements Serializable{
	private static final long serialVersionUID = 1177429723486641913L;

	private String filePath;//文件保存路径
    private InputStream inputStream;
	public InputStream getInputStream() {
		return inputStream;
	}
	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
}
