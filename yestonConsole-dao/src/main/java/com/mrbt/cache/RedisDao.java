package com.mrbt.cache;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * rediscache对外接口 应用程序一致通过此接口调用缓存 此接口对应的缓存实现类为单例类
 */

public interface RedisDao {
	boolean expire(String key, Date dt);

	/** --------------------->>pojo+string操作<<--------------------- */
	boolean set(String key, Object obj); // 添加和更新为同一接口,redis中含key为更新，不含为添加

	Object get(String key);
	
	Object incr(String key);

	/** --------------------->>list操作<<--------------------- */
	boolean setList(String key, List<Object> list);

	List<Object> getList(String key);

	Long getListSize(String key); // list长度

	List<Object> getListByRange(String key, int start, int end); // 按范围索引

	boolean setByIndex(String key, long index, Object value); // 按索引赋值

	Object getByIndex(String key, long index); // 按索引取值

	boolean deleteByIndex(String key, long index, Object value); // 按索引删除(list里数据可重复,所以需要给值)

	/** --------------------->>set操作 <<--------------------- */
	boolean addSet(String key, Set<Object> set);

	Set<Object> getSet(String key);

	Long getSetSize(String key);

	boolean deleteElement(String key, Object value);

	boolean isMemBer(String key, Object value);

	/** --------------------->>hashMap操作 <<--------------------- */

	boolean putAll(String key, Map<Object, Object> map);

	boolean put(String hkey, Object mapKey, Object value);

	boolean hincrbyLong(String hkey, Object mapKey, long value);

	Map<Object, Object> getMap(String key);

	/** --------------------->>zset操作(暂未实现)<<--------------------- */
	Object getHashByHGET(String key, String setKey);

	boolean setHashByHSET(String key, String setKey, Object obj);

	/** --------------------->>sort操作(暂未实现)<<--------------------- */
	/**
	 * 添加到有序队列
	 * 
	 * @param key
	 * @param score
	 * @param member
	 * @param isDelete
	 *            是否删除原score分值
	 * @return
	 */
	boolean ZAdd(String key, double score, Object member);

	/**
	 * 做排名
	 * 
	 * @param key
	 * @param start
	 * @param end
	 * @return
	 */
	List<Object> ZRANGE(String key, long start, long end);

	/**
	 * 按分数倒叙排名
	 * 
	 * @param key
	 * @param start
	 * @param end
	 * @return
	 */
	List<Object> ZREVRANGE(String key, long start, long end);

	/**
	 * 根据对象，获取排名
	 * 
	 * @param key
	 *            关键字
	 * @param member
	 *            对象内容
	 * @param start_offset
	 *            开始位置的偏移量
	 * @param end_offset
	 *            结束位置的偏移量
	 * @return
	 */
	List<Object> ZRANGE_BY_ZRANK(String key, Object member, long start_offset, long end_offset);

	/**
	 * 根据对象获取倒叙排名
	 * 
	 * @param key
	 * @param member
	 * @param start_offset
	 * @param end_offset
	 * @return
	 */
	List<Object> Z_REV_RANGE_BY_ZRANK(String key, Object member, long start_offset, long end_offset);

	/**
	 * 获取对象的排名
	 * 
	 * @param key
	 * @param member
	 * @return
	 */
	Long ZRANK(String key, Object member);

	/**
	 * 获取对象的倒叙排名
	 * 
	 * @param key
	 * @param member
	 * @return
	 */
	Long ZREVRANK(final String key, final Object member);

	/**
	 * 按照分数删除有序集合中的数据
	 * 
	 * @param key
	 * @param min
	 * @param max
	 * @return
	 */
	boolean ZREMRANGEBYSCORE(String key, long min, long max);

	/**
	 * 正序，根据分数查找对象
	 * 
	 * @param key
	 * @return
	 */
	List<Object> ZRANGEBYSCORE(String key, long min, long max);

	/**
	 * 倒序，根据分数查找对象
	 * 
	 * @param key
	 * @return
	 */
	List<Object> ZREVRANGEBYSCORE(final String key, final long min, final long max);

	/** --------------------->>通用操作 <<--------------------- */
	// 删除
	boolean delete(String key);

	// 主键是否存在
	boolean hasKey(String key);

	// 清空缓存
	boolean clear();

	public Set findKeys(String pattern);

	public boolean expire(String key, long timeout, TimeUnit timeUinit);

	public void refreshKeyValueList(String key, List<Object> list);

	public boolean setList(String key, Object object);

	public Object getListObject(String key);

}
