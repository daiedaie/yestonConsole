package com.mrbt.yeston.service;


import com.alibaba.fastjson.JSONObject;
import com.mrbt.yeston.web.echo.DO.MortgagorDataVo;

public interface EchoApiService {

	/**
	 * 查询个人信用信息
	 * @param name
	 * @param idNo
	 * @return
	 */
	JSONObject queryPersionalInfo(String name, String idNo, String queryReason);

	/**
	 * 上传证件号码共享数据请求
	 * 机构共享数据的日的是告知平台，当被查询人包含于被上传的数据里边时，接受平能的访问请求
	 * @param idNos
	 * @return
	 */
	JSONObject shareUploadIdNo(String idNos);

	/**
	 * 查询列表
	 * @param page
	 * @param rows
	 * @param personal
	 * @param idCNo
	 * @return
	 */
	Object findDataGrid(Integer page, Integer rows, String name, String idNo);

	/**
	 * 查旬个人信用历史查询记录
	 * @param idNo
	 * @return
	 */
	JSONObject queryHistory(String idNo);

	/**
	 * 平台查询机构
	 * @param resjson
	 * @return
	 */
	JSONObject echomComeQuery(JSONObject resjson);

	/**
	 * 添加贷款人用户数据，用于与平台测试
	 * @return
	 */
	JSONObject saveAppendMortgagor(MortgagorDataVo mortDataVo);

}
