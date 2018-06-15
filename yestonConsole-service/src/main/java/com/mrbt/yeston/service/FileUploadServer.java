package com.mrbt.yeston.service;

import org.springframework.web.multipart.MultipartFile;

public interface FileUploadServer {

	public void uploadJodExcel(MultipartFile file, String batchName);

	public void uploadFile(MultipartFile multfile);

}
