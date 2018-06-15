package com.mrbt.cache;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.expression.EvaluationContext;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.stereotype.Component;

import com.mrbt.cache.annotation.OperType;
import com.mrbt.cache.annotation.RedisOper;

@Component
public class RedisDelete {
	@Autowired
	RedisTemplate<String, Object> redisTemplate;

	@Autowired
	RedisDao redisDao;

	/**
	 * spring el表达式解析类
	 */
	private ExpressionParser parser = new SpelExpressionParser();

	public boolean delete(RedisOper oper, String key, EvaluationContext ec) {
		if (oper != null) {
			if (oper.cmd() == OperType.ZREMRANGEBYSCORE) {
				return ZREM_RANGE_BY_SCORE(oper, key, ec);
			}
		} else if (StringUtils.isNotBlank(key)) {
			return redisDao.delete(key);
		}
		return false;
	}

	/**
	 * 删除有序集合的范围，根据分数
	 * 
	 * @return
	 */
	public boolean ZREM_RANGE_BY_SCORE(RedisOper oper, String key,
			EvaluationContext ec) {
		String score = oper.score();
		if (StringUtils.isNotBlank(score)) {
			Long scoreVal = parser.parseExpression(score).getValue(ec,
					Long.class);
			return redisDao.ZREMRANGEBYSCORE(key, scoreVal, scoreVal);
		}
		return false;
	}
}
