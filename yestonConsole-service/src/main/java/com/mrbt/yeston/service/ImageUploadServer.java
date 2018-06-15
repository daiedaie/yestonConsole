package com.mrbt.yeston.service;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

public interface ImageUploadServer {

	String uploadFileToFtp(MultipartFile file, String pictureUrl) throws IOException;

	String uploadFileToFtp(MultipartFile file, String fileUrl, String FileName) throws IOException;

	String uploadFileToFtp2(MultipartFile file, String provision) throws IOException;

}
