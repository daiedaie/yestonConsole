package com.mrbt.cache;

import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.expression.EvaluationContext;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.stereotype.Component;

import com.mrbt.cache.annotation.OperType;
import com.mrbt.cache.annotation.RedisOper;


/**
 * 缓存保存类
 * 
 * @author lzp
 *
 */
@Component
public class RedisSet {
	@Autowired
	RedisTemplate<String, Object> redisTemplate;

	@Autowired
	RedisDao redisDao;

	/**
	 * spring el表达式解析类
	 */
	private ExpressionParser parser = new SpelExpressionParser();

	public boolean setRedisResult(RedisOper oper, String key,
			EvaluationContext ec, Object result) {
		if (oper != null) {
			if (oper.cmd() == OperType.HSET) {
				return setRedisHSetResult(oper, key, ec, result);
			}
			if (oper.cmd() == OperType.ZADD) {
				return setRedisZAddResult(oper, key, ec, result);
			}
		} else if (StringUtils.isNotBlank(key)) {
			return setRedisStringResult(key, result);
		}
		return false;
	}

	/**
	 * 设置key的值
	 * 
	 * @param key
	 * @param result
	 */
	public boolean setRedisStringResult(String key, Object result) {
		return redisDao.set(key, result);
	}
	/**
	 * 设置key的值 
	 * @param key
	 * @param result
	 * @param timeout 时间
	 * @param timeUinit 时间单位
	 * @return
	 */
	public boolean setRedisStringResult(String key, Object result,long timeout, TimeUnit timeUinit) {
		return redisDao.set(key, result)&&redisDao.expire(key, timeout, timeUinit);
	}

	/**
	 * 设置HSet结果
	 * 
	 * @param oper
	 * @param key
	 * @param ec
	 * @param result
	 */
	public boolean setRedisHSetResult(RedisOper oper, String key,
			EvaluationContext ec, Object result) {
		String setKey = oper.key();
		setKey = parser.parseExpression(setKey).getValue(ec, String.class);
		return redisDao.setHashByHSET(key, setKey, result);
	}

	/**
	 * 有序集合的zadd操作
	 * 
	 * @param oper
	 * @param key
	 * @param ec
	 * @param result
	 */
	public boolean setRedisZAddResult(RedisOper oper, String key,
			EvaluationContext ec, Object result) {
		String score = oper.score();
		if (StringUtils.isNotBlank(score)) {
			Long scoreVal = parser.parseExpression(score).getValue(ec,
					Long.class);
			return redisDao.ZAdd(key, scoreVal, result);
		}
		return false;
	}
	
	/**
	 * 存入map，用于基金超市首字母--》公司名操作 ， 设置一周超时
	 *@Description  
	 *@param key 
	 *@param map A:name，name 类型
	 *@param timeout 超时时间单位
	 *@param timeUinit 时间类型
	 *@return
	 */
	public boolean setExpireMap(String key,Map<Object,Object> map,long timeout, TimeUnit timeUinit) {
		Boolean b = redisDao.putAll(key, map);
		if(b) {
			return redisDao.expire(key, timeout, timeUinit);
		}
		return b;
	}
	
	/**
	 * 存入list用于首页净值展示
	 *@Description  
	 *@param key 'netvalue'前缀+fundcode格式
	 *@param list 净值list，为List<List<object>> 类型
	 *@param timeout 超时时间单位
	 *@param timeUnit 时间类型
	 *@return
	 */
	public boolean setExpireList(String key, List<Object> list, long timeout, TimeUnit timeUnit) {
		Boolean b = redisDao.setList(key, list);
		if(b) {
			return redisDao.expire(key, timeout, timeUnit);
		}
		return b;
	}
}
