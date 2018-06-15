package com.mrbt.yeston.service.impl;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mrbt.yeston.admin.commons.utils.AnalysisExcel;
import com.mrbt.yeston.web.utils.Common;
import com.mrbt.yeston.service.FileUploadServer;

/**
 * 上传文件
 * 
 * @author ruochen.yu
 *
 */
@Service
public class FileUploadServerImpl implements FileUploadServer {
	// 上传EXCEL存放位置
	private static String path = Common.getStaticProperty("upload.properties", "excelPath");

	/**
	 * 调用解析excel,插入行业数据
	 */
	@Override
	public void uploadJodExcel(MultipartFile multfile, String batchName) {

		String batchNo = new Date().getTime() + "";
		batchName = batchName + "[" + batchNo + "]";
		try {
			File f_path = new File(path);
			if (!f_path.exists()) {
				f_path.mkdirs();
			}
			File file = new File(path + UUID.randomUUID().toString() + ".xlsx");
			multfile.transferTo(file);

			// 解析excel
			AnalysisExcel analy = new AnalysisExcel(file);
			List<List<Object>> oneList = analy.readExcel();

			// 入库
			// 记录同一个excel文件中的行业数据ID,key:行业名称,value:行业数据ID
			Map<Object, Object> oneMap = new HashMap<Object, Object>();
			// 记录同一个excel文件中的行业分类数据id,key:行业名称+行业分类名称,value:行业分类ID
			Map<Object, Object> twoMap = new HashMap<Object, Object>();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void uploadFile(MultipartFile multfile) {
		try {
			// 获取文件类型
			String fileName = multfile.getOriginalFilename();
			String[] fileArr = fileName.split("\\.");
			String fileType = fileArr[fileArr.length - 1];
			byte[] file = multfile.getBytes();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		String a = "http://192.168.1.88/ytCarLoan/6a2a4f4603f8484281211081002315f7/vehicleEvaluationReport/cb09574335134a0a8e234d9bb7803652.jpg";
		System.out.println(a.length());
	}
}
