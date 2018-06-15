package com.mrbt.cache;

import java.util.List;
import java.util.Map;

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
 * 缓存获取类
 * 
 * @author lzp
 *
 */
@Component
public class RedisGet {
	@Autowired
	RedisTemplate<String, Object> redisTemplate;

	@Autowired
	RedisDao redisDao;

	/**
	 * spring el表达式解析类
	 */
	private ExpressionParser parser = new SpelExpressionParser();

	/**
	 * 根据cmd命令获取结果
	 * 
	 * @param cmd
	 * @return
	 */
	public Object getRedisResult(RedisOper oper, String key,
			EvaluationContext ec) {
		if (StringUtils.isBlank(key)) {
			return null;
		}
		if (oper != null) {
			if (oper.cmd() == OperType.HGET) {
				return getRedisHGetResult(oper, key, ec);
			}
			if (oper.cmd() == OperType.ZADD) {
				return null;
			}
		} else if (StringUtils.isNotBlank(key)) {
			return getRedisStringResult(key);
		}
		return null;
	}

	/**
	 * 返回string的key值
	 * 
	 * @param key
	 * @return
	 */
	public Object getRedisStringResult(String key) {
		return redisDao.get(key);
	}

	/**
	 * 获取hset的值
	 * 
	 * @param oper
	 * @param ec
	 * @return
	 */
	public Object getRedisHGetResult(RedisOper oper, String key,
			EvaluationContext ec) {
		String setKey = oper.key();
		setKey = parser.parseExpression(setKey).getValue(ec, String.class);
		return redisDao.getHashByHGET(key, setKey);
	}
	
	/**
	 * 获取map的值
	 *@Description  
	 *@param key
	 *@return
	 */
	public Map<Object, Object> getMap(String key) {
		return redisDao.getMap(key);
	}
	
	/**
	 * 获取list的值
	 *@Description  
	 *@param key
	 *@return
	 */
	public List<Object> getList(String key) {
		return redisDao.getList(key);
	}
	public long getExpire(String key){
		return redisTemplate.getExpire(key);
	}
}
