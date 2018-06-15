package com.mrbt.yeston.service.impl;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mrbt.yeston.admin.commons.utils.FtpUtils;
import com.mrbt.yeston.admin.commons.utils.StringUtils;
import com.mrbt.yeston.service.ImageUploadServer;

@Service
public class ImageUploadServerImpl implements ImageUploadServer {

	@Autowired
	private FtpUtils ftpUtils;

	/**
	 * 上传图片实现类 file : 上传文件流 pictureUrl : 上传文件目录 return 文件完整url
	 * 
	 * @throws IOException
	 */
	@Override
	public String uploadFileToFtp(MultipartFile file, String pictureUrl) throws IOException {
		BufferedImage img = ImageIO.read(file.getInputStream());// 读取流
		if (img != null) {

			String fileName = UUID.randomUUID().toString();
			String type = file.getOriginalFilename().substring(file.getOriginalFilename().indexOf("."));

			if (StringUtils.isNotBlank(type)) {
				fileName += type;
			} else {
				fileName += ".jpg";
			}

			ftpUtils.upload(file.getInputStream(), pictureUrl, fileName);// 上传到ftp

			return ftpUtils.getUrl() + pictureUrl + "/" + fileName;
		} else {
			return null;
		}
	}

	@Override
	public String uploadFileToFtp(MultipartFile file, String fileUrl, String FileName) throws IOException {
		if (file.getInputStream() != null) {
			ftpUtils.upload(file.getInputStream(), fileUrl, FileName);// 上传到ftp
			return ftpUtils.getUrl() + fileUrl + "/" + FileName;
		} else {
			return null;
		}
	}

	@Override
	public String uploadFileToFtp2(MultipartFile file, String provision) throws IOException {
		InputStream br = file.getInputStream();
		if (br != null) {

			String type = file.getOriginalFilename().substring(file.getOriginalFilename().indexOf("."));

			String fileName = UUID.randomUUID().toString() + type;

			ftpUtils.upload(file.getInputStream(), provision, fileName);// 上传到ftp

			return ftpUtils.getUrl() + provision + "/" + fileName;
		} else {
			return null;
		}
	}

}
