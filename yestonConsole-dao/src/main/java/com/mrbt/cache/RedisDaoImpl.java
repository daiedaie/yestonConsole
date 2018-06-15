package com.mrbt.cache;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.DataType;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.SetOperations;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.data.redis.serializer.JdkSerializationRedisSerializer;
import org.springframework.stereotype.Repository;

@Repository("redisDao")
public class RedisDaoImpl implements RedisDao {

	@Autowired
	private RedisTemplate<String, Object> redisTemplate;
	@Resource(name = "redisTemplate")
	private ValueOperations<String, Object> valueOps;
	@Resource(name = "redisTemplate")
	private ListOperations<String, Object> listOps;
	@Resource(name = "redisTemplate")
	private SetOperations<String, Object> setOps;
	@Resource(name = "redisTemplate")
	private HashOperations<String, Object, Object> hashOps;

	/**
	 * jdk的序列化对象
	 */
	private JdkSerializationRedisSerializer getSerial() {
		return (JdkSerializationRedisSerializer) redisTemplate.getValueSerializer();
	}

	/**
	 * 设置过期时间
	 * 
	 * @param key
	 * @param dt
	 * @return
	 */
	@Override
	public boolean expire(String key, Date dt) {
		return redisTemplate.expireAt(key, dt);

	}

	/** -------------------->> pojo + string 操作 <<-------------------- */

	@Override
	public boolean set(String key, Object value) {
		if (key == null || value == null)
			return false;
		valueOps.set(key, value);
		return true;
	}

	@Override
	public Object get(String key) {
		return valueOps.get(key);
	}
	
	@Override
	public Object incr(String key) {
		return valueOps.increment(key, 1);
	}

	/** --------------->> list操作 <<--------------- */

	@Override
	public boolean setList(String key, List<Object> list) {
		for (Object value : list)
			listOps.rightPush(key, value);
		return true;
	}

	@Override
	public List<Object> getList(String key) {
		return getListByRange(key, 0, -1);
	}

	/**
	 * 获取list长度
	 * 
	 * @param key
	 * @return
	 */

	@Override
	public Long getListSize(String key) {
		return listOps.size(key);
	}

	/**
	 * 按范围索引
	 * 
	 * @param key
	 * @param start
	 * @param end
	 * @return
	 */

	@Override
	public List<Object> getListByRange(String key, int start, int end) {
		List<Object> list = listOps.range(key, start, end);
		return list;
	}

	/**
	 * 按索引赋值
	 * 
	 * @param key
	 * @param index
	 * @param value
	 * @return
	 */

	@Override
	public boolean setByIndex(String key, long index, Object value) {
		listOps.set(key, index, value);
		return true;
	}

	/**
	 * 按索引取值
	 * 
	 * @return
	 */

	@Override
	public Object getByIndex(String key, long index) {
		return listOps.index(key, index);
	}

	/**
	 * 按索引删除
	 */

	@Override
	public boolean deleteByIndex(String key, long index, Object value) {
		listOps.remove(key, index, value);
		return true;
	}

	/** --------------------->> set操作 <<--------------------- */
	/**
	 * 存set
	 */

	@Override
	public boolean addSet(String key, Set<Object> set) {
		for (Object value : set)
			setOps.add(key, value);
		return true;
	}

	/**
	 * 取set
	 */

	@Override
	public Set<Object> getSet(String key) {
		Set<Object> ret = setOps.members(key);
		return ret.isEmpty() ? null : ret;
	}

	/**
	 * 获取set长度
	 */

	@Override
	public Long getSetSize(String key) {
		return setOps.size(key);
	}

	/**
	 * 删除指定key中的set集合的某个元素
	 */

	@Override
	public boolean deleteElement(String key, Object value) {
		return setOps.remove(key, value) > 0;
	}

	/**
	 * 判断指定key中的set集合是否包含某元素
	 */

	@Override
	public boolean isMemBer(String key, Object value) {
		return setOps.isMember(key, value);
	}

	/** --------------------->> map操作 <<--------------------- */
	@Override
	public boolean putAll(String key, Map<Object, Object> map) {
		hashOps.putAll(key, map);
		return true;
	}

	/**
	 * 更新hash中的key值
	 * 
	 * @param hkey
	 * @param mapKey
	 * @param value
	 * @return
	 */
	@Override
	public boolean put(String hkey, Object mapKey, Object value) {
		hashOps.put(hkey, mapKey, value);
		return true;
	}

	/**
	 * 给某一个hash字段增加long值
	 * 
	 * @param hkey
	 * @param mapKey
	 * @param value
	 * @return
	 */
	@Override
	public boolean hincrbyLong(String hkey, Object mapKey, long value) {
		hashOps.increment(hkey, mapKey, value);
		return true;
	}

	@Override
	public Map<Object, Object> getMap(String key) {
		Map<Object, Object> ret = hashOps.entries(key);
		return ret.isEmpty() ? null : ret;
	}

	/** --------------------->> zset(暂未实现)操作 <<--------------------- */

	@Override
	public Object getHashByHGET(String key, String setKey) {
		return hashOps.get(key, setKey);
	}

	@Override
	public boolean setHashByHSET(String key, String setKey, Object obj) {
		hashOps.put(key, setKey, obj);
		return true;
	}

	/** --------------------->>sort操作<<--------------------- */

	@Override
	public boolean ZAdd(final String key, final double score, final Object member) {
		return redisTemplate.execute(new RedisCallback<Object>() {

			@Override
			public String doInRedis(RedisConnection connection) throws DataAccessException {
				JdkSerializationRedisSerializer serial = (JdkSerializationRedisSerializer) redisTemplate
						.getValueSerializer();
				connection.zAdd(redisTemplate.getStringSerializer().serialize(key), score, serial.serialize(member));
				return "okay";
			}
		}).equals("okay");
	}

	/**
	 * 删除排序队列中的内容，根据分数
	 * 
	 * @param key
	 * @param score
	 * @return
	 */
	public boolean deleteByScore(final String key, final double score) {
		return redisTemplate.execute(new RedisCallback<Object>() {

			@Override
			public String doInRedis(RedisConnection connection) throws DataAccessException {
				return connection.zRemRangeByScore(redisTemplate.getStringSerializer().serialize(key), score, score) > 0
						? "ok" : "fail";
			}
		}).equals("okay");
	}

	@Override
	public List<Object> ZRANGE(final String key, final long start, final long end) {
		return redisTemplate.execute(new RedisCallback<List<Object>>() {

			@Override
			public List<Object> doInRedis(RedisConnection connection) throws DataAccessException {
				Set<byte[]> result = connection.zRange(redisTemplate.getStringSerializer().serialize(key), start, end);
				List<Object> reList = new ArrayList<Object>();
				for (byte[] tmp : result) {
					reList.add(getSerial().deserialize(tmp));
				}
				result.clear();
				result = null;
				return reList;
			}
		});
	}

	@Override
	public List<Object> ZREVRANGE(final String key, final long start, final long end) {
		return redisTemplate.execute(new RedisCallback<List<Object>>() {

			@Override
			public List<Object> doInRedis(RedisConnection connection) throws DataAccessException {
				Set<byte[]> result = connection.zRevRange(redisTemplate.getStringSerializer().serialize(key), start,
						end);
				List<Object> reList = new ArrayList<Object>();
				for (byte[] tmp : result) {
					reList.add(getSerial().deserialize(tmp));
				}
				result.clear();
				result = null;
				return reList;
			}
		});
	}

	@Override
	public Long ZREVRANK(final String key, final Object member) {
		return redisTemplate.execute(new RedisCallback<Long>() {

			@Override
			public Long doInRedis(RedisConnection connection) throws DataAccessException {
				return connection.zRevRank(redisTemplate.getStringSerializer().serialize(key),
						getSerial().serialize(member));
			}
		});
	}

	@Override
	public Long ZRANK(final String key, final Object member) {
		return redisTemplate.execute(new RedisCallback<Long>() {

			@Override
			public Long doInRedis(RedisConnection connection) throws DataAccessException {
				return connection
						.zRank(redisTemplate.getStringSerializer().serialize(key), getSerial().serialize(member))
						.longValue();
			}
		});
	}

	@Override
	public List<Object> ZRANGE_BY_ZRANK(String key, Object member, long start_offset, long end_offset) {
		long index = ZRANK(key, member);
		return ZRANGE(key, index + start_offset < 0 ? 0 : index + start_offset, index + end_offset);
	}

	@Override
	public List<Object> Z_REV_RANGE_BY_ZRANK(String key, Object member, long start_offset, long end_offset) {
		long index = ZREVRANK(key, member);
		return ZREVRANGE(key, index + start_offset < 0 ? 0 : index + start_offset, index + end_offset);
	}

	@Override
	public boolean ZREMRANGEBYSCORE(final String key, final long min, final long max) {
		return redisTemplate.execute(new RedisCallback<String>() {

			@Override
			public String doInRedis(RedisConnection connection) throws DataAccessException {
				connection.zRemRangeByScore(redisTemplate.getStringSerializer().serialize(key), min, max);
				return "ok";
			}
		}).equals("ok");
	}

	@Override
	public List<Object> ZRANGEBYSCORE(final String key, final long min, final long max) {
		return redisTemplate.execute(new RedisCallback<List<Object>>() {

			@Override
			public List<Object> doInRedis(RedisConnection connection) throws DataAccessException {
				Set<byte[]> result = connection.zRangeByScore(redisTemplate.getStringSerializer().serialize(key), min,
						max);
				List<Object> reList = new ArrayList<Object>();
				for (byte[] tmp : result) {
					reList.add(getSerial().deserialize(tmp));
				}
				result.clear();
				result = null;
				return reList;
			}
		});
	}

	@Override
	public List<Object> ZREVRANGEBYSCORE(final String key, final long min, final long max) {
		return redisTemplate.execute(new RedisCallback<List<Object>>() {

			@Override
			public List<Object> doInRedis(RedisConnection connection) throws DataAccessException {
				Set<byte[]> result = connection.zRevRangeByScore(redisTemplate.getStringSerializer().serialize(key),
						min, max);
				List<Object> reList = new ArrayList<Object>();
				for (byte[] tmp : result) {
					reList.add(getSerial().deserialize(tmp));
				}
				result.clear();
				result = null;
				return reList;
			}
		});
	}

	/** --------------------->> 通用操作 <<--------------------- */

	@Override
	public boolean hasKey(String key) {
		return !redisTemplate.type(key).equals(DataType.NONE);
	}

	/**
	 * 清空缓存
	 */

	@Override
	public boolean clear() {
		return redisTemplate.execute(new RedisCallback<Object>() {

			@Override
			public String doInRedis(RedisConnection connection) throws DataAccessException {
				connection.flushDb();
				return "okay";
			}
		}).equals("okay");
	}

	/**
	 * 删除
	 */

	@Override
	public boolean delete(String key) {
		try {
			valueOps.getOperations().delete(key);
		} catch (Exception e) {
			e.getStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public Set findKeys(String pattern) {
		return redisTemplate.keys(pattern);
	}

	public boolean expire(String key, long timeout, TimeUnit timeUinit) {
		try {
			redisTemplate.expire(key, timeout, timeUinit);

		} catch (Exception e) {
			e.getStackTrace();
			return false;
		}

		return true;
	}

	/*
	 * public void refreshKeyValueList(String key, List<Object> list) {
	 * 
	 * RedisConnectionFactory factory = redisTemplate.getConnectionFactory();
	 * RedisConnection connection = factory.getConnection(); try{ //打开管道 //
	 * connection.openPipeline(); //connection.multi();
	 * connection.del(key.getBytes()); JSONArray json =
	 * JSONArray.fromObject(list); System.out.println(json.toString());
	 * connection.set(key.getBytes(), json.toString().getBytes() );
	 * //connection.exec();
	 * 
	 * }catch (Exception e){ e.printStackTrace(); }finally{
	 * //connection.closePipeline();
	 * RedisConnectionUtils.releaseConnection(connection,factory); }
	 * 
	 * 
	 * }
	 */

	public void refreshKeyValueList(String key, List<Object> list) {

		try {
			// redisTemplate.multi();
			JSONArray json = JSONArray.fromObject(list);
			redisTemplate.delete(key);
			valueOps.set(key, json.toString());
			/*
			 * redisTemplate.execute(new RedisCallback<String>() {
			 * 
			 * @Override public String doInRedis(RedisConnection connection)
			 * throws DataAccessException { connection.multi(); return null; }
			 * });
			 */

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public boolean setList(String key, Object object) {

		listOps.rightPush(key, object);
		return true;
	}

	public Object getListObject(String key) {
		return listOps.leftPop(key);
	}


}
