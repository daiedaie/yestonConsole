package com.mrbt.cache.annotation;

/**
 * OPER中的命令type
 * 
 * @author lzp
 *
 */
public enum OperType {
	NONE("无操作"), HGET("hash操作，获取元素从hash中，要带key参数"), HSET("hash操作，设置元素到hash中"), ZADD(
			"添加元素到有序集合中，要带score参数"), ZREMRANGEBYSCORE("删除有序集合中的元素，按照正序分数");
	private String value;

	private OperType(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}
