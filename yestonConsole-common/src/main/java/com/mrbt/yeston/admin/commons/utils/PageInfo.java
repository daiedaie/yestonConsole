package com.mrbt.yeston.admin.commons.utils;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.List;
import java.util.Map;

/**
 * @description：分页实体类 (结合jqery easyui)
 * @author：ruochen.yu
 * @date：2016年4月23日 上午1:41:46
 */
public class PageInfo<T> {

	private final static int PAGESIZE = 10; // 默认显示的记录数

	private int code; //返回码
	
	private String msg; //返回说明

	private int total; // 总记录
	
	private List<T> rows; // 显示的记录
	
	private Object obj;

	@JsonIgnore
	private int from;
	
	@JsonIgnore
	private int size;
	
	@JsonIgnore
	private int nowpage; // 当前页
	
	@JsonIgnore
	private int pagesize; // 每页显示的记录数
	
	@JsonIgnore
	private Map<String, Object> condition; // 查询条件

	@JsonIgnore
	private String sort = "seq";// 排序字段
	
	@JsonIgnore
	private String order = "asc";// asc，desc mybatis Order 关键字

	public PageInfo() {
		
	}

	// 构造方法
	public PageInfo(int nowpage, int pagesize) {
		// 计算当前页
		if (nowpage < 0) {
			this.nowpage = 1;
		} else {
			// 当前页
			this.nowpage = nowpage;
		}
		// 记录每页显示的记录数
		if (pagesize < 0) {
			this.pagesize = PAGESIZE;
		} else {
			this.pagesize = pagesize;
		}
		
		// 计算开始的记录和结束的记录
		this.from = (this.nowpage - 1) * this.pagesize;
		this.size = this.pagesize;
	}

	// 构造方法
	public PageInfo(int nowpage, int pagesize, String sort, String order) {
		// 计算当前页
		if (nowpage < 0) {
			this.nowpage = 1;
		} else {
			// 当前页
			this.nowpage = nowpage;
		}
		// 记录每页显示的记录数
		if (pagesize < 0) {
			this.pagesize = PAGESIZE;
		} else {
			this.pagesize = pagesize;
		}
		
		// 计算开始的记录和结束的记录
		this.from = (this.nowpage - 1) * this.pagesize;
		this.size = this.pagesize;
		
		// 排序字段，正序还是反序
		this.sort = sort;
		this.order = order;
	}

	public int getCode() {
		return code;
	}

	/**
	 * code	说明
		200 	服务器已成功处理了请求。
		400 	服务器不理解请求的语法。
		404 	服务器找不到请求的网页。
		500 	服务器遇到错误，无法完成请求。
		1001 	参数缺失
		1002 	请求json格式有误
		1003	请求的数据不存在
		1004 	用户不存在
		1005 	手机号未绑定
		1006 	密码错误
		1007 	用户已存在
		1008 	手机号已绑定过其他账号
		1009 	验证码错误或失效
		1010	session失效或为空
		1011	用户没有绑定银行卡
		1012	用户订单错误，无法交易
		1013	订单交易处理中
		1014	请勿重复绑定
		1015	密码修改失败
		1016	积分不足，兑换失败
		1017	绑定银行卡请先签约
		1018	绑定银行卡失败
		1019	微信号已绑定过其他账号
		1020	微信支付错误
	 * @param code
	 */
	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public int getFrom() {
		return from;
	}

	public void setFrom(int from) {
		this.from = from;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public int getNowpage() {
		return nowpage;
	}

	public void setNowpage(int nowpage) {
		this.nowpage = nowpage;
	}

	public int getPagesize() {
		return pagesize;
	}

	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}

	public Map<String, Object> getCondition() {
		return condition;
	}

	public void setCondition(Map<String, Object> condition) {
		this.condition = condition;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}
}
