package com.mrbt.yeston.admin.commons.utils;

import java.io.File;  
import java.io.FileInputStream;  
import java.io.FileNotFoundException;  
import java.io.IOException;  
import java.text.DecimalFormat;  
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;  
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;  
import org.apache.poi.hssf.usermodel.HSSFDateUtil;  
import org.apache.poi.hssf.usermodel.HSSFRow;  
import org.apache.poi.hssf.usermodel.HSSFSheet;  
import org.apache.poi.hssf.usermodel.HSSFWorkbook;  
import org.apache.poi.xssf.usermodel.XSSFCell;  
import org.apache.poi.xssf.usermodel.XSSFRow;  
import org.apache.poi.xssf.usermodel.XSSFSheet;  
import org.apache.poi.xssf.usermodel.XSSFWorkbook; 

/**
 * excel解析
 * 
 * @author ruochen.yu
 *
 */
public class AnalysisExcel {
	
	DecimalFormat df = new DecimalFormat("0");// 格式化 number String
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 格式化日期字符串
	private static DecimalFormat nf = new DecimalFormat("0");// 格式化数字
	
	private File file;
	
	public AnalysisExcel(File file){
		this.file = file;
	}

	public static void main(String[] args) throws Exception {  
        //读取Excel文件 
		AnalysisExcel analysis = new AnalysisExcel(new File("E:/保险职业.xlsx"));
        try {  
        	List<List<Object>> oneList = analysis.readExcel();
        	
        	Map<Object, Object> oneMap = new HashMap<Object, Object>();
        	
        	for (int i = 0; i < oneList.size(); i++) {
				List<Object> twoList = oneList.get(i);
				System.out.println(twoList);  //5个数据
				
				System.out.println(twoList.get(0));
				if(oneMap.containsKey(twoList.get(0))){
					
				}else{
					//插入行业数据
					
				}
				
			}
        	
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
  
    }

	/**
	 * 对外提供读取excel 的方法
	 */
	public List<List<Object>> readExcel() throws IOException {
		if(!file.exists()){
			return null;
		}
		
		String fileName = file.getName();
		String extension = fileName.lastIndexOf(".") == -1 ? "" : fileName.substring(fileName.lastIndexOf(".") + 1);
		if ("xls".equals(extension)) {
			return read2003Excel(file);
		} else if ("xlsx".equals(extension)) {
			return read2007ExcelByJob(file);
		} else {
			throw new IOException("不支持的文件类型");
		}
	}


	/**
	 * 读取Office 2007 excel
	 * 解析保险行业数据
	 */
	private List<List<Object>> read2007ExcelByJob(File file) throws IOException {

		List<List<Object>> list = new LinkedList<List<Object>>();
		// 构造 XSSFWorkbook 对象，strPath 传入文件路径
		XSSFWorkbook xwb = new XSSFWorkbook(new FileInputStream(file));

		// 读取第一章表格内容
		XSSFSheet sheet = xwb.getSheetAt(0);
		Object value = null;
		XSSFRow row = null;
		XSSFCell cell = null;
		
		Object oneColumn = "";
		Object towColumn = "";
		
		//循环行
		for (int i = sheet.getFirstRowNum() + 1; i <= sheet.getPhysicalNumberOfRows(); i++) {
			row = sheet.getRow(i);//获取行
			if (row == null) {
				continue;
			}
			
			List<Object> linked = new LinkedList<Object>();			
			//循环列
			for (int j = row.getFirstCellNum(); j <= row.getLastCellNum(); j++) {
				cell = row.getCell(j);
				if (cell == null) {
					continue;
				}

				switch (cell.getCellType()) {  //获取数据类型
					case XSSFCell.CELL_TYPE_STRING:
						value = cell.getStringCellValue();
						if(value != null){
							if(j == 0){
								oneColumn = value;
							}
							if(j == 1){
								towColumn = value;
							}
						}
						break;
					case XSSFCell.CELL_TYPE_NUMERIC:
						if ("@".equals(cell.getCellStyle().getDataFormatString())) {
							value = df.format(cell.getNumericCellValue());
						} else if ("General".equals(cell.getCellStyle().getDataFormatString())) {
							value = nf.format(cell.getNumericCellValue());
						} else {
							value = sdf.format(HSSFDateUtil.getJavaDate(cell.getNumericCellValue()));
						}
						break;
					case XSSFCell.CELL_TYPE_BOOLEAN:
						value = cell.getBooleanCellValue();
						break;
					case XSSFCell.CELL_TYPE_BLANK:
						value = "";
						if(j == 0){
							value = oneColumn;
						}
						if(j == 1){
							value = towColumn;
						}
						break;
					default:
						value = cell.toString();
					}
				if (value == null || "".equals(value)) {
					continue;
				}
				linked.add(value);
			}
			list.add(linked);
		}
		return list;
	}
	
	/**
	 * 读取 office 2003 excel
	 * 
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	private static List<List<Object>> read2003Excel(File file) throws IOException {
		List<List<Object>> list = new LinkedList<List<Object>>();
		HSSFWorkbook hwb = new HSSFWorkbook(new FileInputStream(file));
		HSSFSheet sheet = hwb.getSheetAt(0);
		Object value = null;
		HSSFRow row = null;
		HSSFCell cell = null;
		System.out.println("读取office 2003 excel内容如下：");
		for (int i = sheet.getFirstRowNum(); i <= sheet.getPhysicalNumberOfRows(); i++) {
			row = sheet.getRow(i);
			if (row == null) {
				continue;
			}
			List<Object> linked = new LinkedList<Object>();
			for (int j = row.getFirstCellNum(); j <= row.getLastCellNum(); j++) {
				cell = row.getCell(j);
				if (cell == null) {
					continue;
				}
				DecimalFormat df = new DecimalFormat("0");// 格式化 number String
				// 字符
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 格式化日期字符串
				DecimalFormat nf = new DecimalFormat("0.00");// 格式化数字
				switch (cell.getCellType()) {
				case XSSFCell.CELL_TYPE_STRING:
					value = cell.getStringCellValue();
					break;
				case XSSFCell.CELL_TYPE_NUMERIC:
					if ("@".equals(cell.getCellStyle().getDataFormatString())) {
						value = df.format(cell.getNumericCellValue());

					} else if ("General".equals(cell.getCellStyle().getDataFormatString())) {
						value = nf.format(cell.getNumericCellValue());
					} else {
						value = sdf.format(HSSFDateUtil.getJavaDate(cell.getNumericCellValue()));
					}
					System.out.print("  " + value + "  ");
					break;
				case XSSFCell.CELL_TYPE_BOOLEAN:
					value = cell.getBooleanCellValue();
					System.out.print("  " + value + "  ");
					break;
				case XSSFCell.CELL_TYPE_BLANK:
					value = "";
					System.out.print("  " + value + "  ");
					break;
				default:
					value = cell.toString();
				}
				if (value == null || "".equals(value)) {
					continue;
				}
				linked.add(value);

			}
			list.add(linked);
		}

		return list;
	}
}
