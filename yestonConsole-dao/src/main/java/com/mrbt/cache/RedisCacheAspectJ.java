package com.mrbt.cache;

import org.apache.commons.lang.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.EvaluationContext;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;
import org.springframework.stereotype.Component;

import com.mrbt.cache.annotation.RedisCache;
import com.mrbt.cache.annotation.RedisCacheEvict;
import com.mrbt.cache.annotation.RedisPut;

/**
 * redis cache的拦截器
 * 
 * @author lzp
 *
 */
@Aspect
@Component
public class RedisCacheAspectJ {
	@Autowired
	RedisGet redisGet;

	@Autowired
	RedisSet redisSet;
	
	@Autowired
	RedisDelete redisDelete;

	@Autowired
	RedisDao redisDao;

	/**
	 * spring el表达式解析类
	 */
	private ExpressionParser parser = new SpelExpressionParser();

	/**
	 * 获取和保存的point
	 */
	@Pointcut(value = "@annotation(com.mrbt.cache.annotation.RedisCache) ")
	public void methodCachePointcut() {
	}

	/**
	 * 删除的point
	 */
	@Pointcut("@annotation(com.mrbt.cache.annotation.RedisCacheEvict)")
	public void methodCacheEvictPointcut() {

	}

	/**
	 * 保存的point
	 */
	@Pointcut("@annotation(com.mrbt.cache.annotation.RedisPut)")
	public void methodCachePutPointcut() {

	}

	@Around(value = "methodCachePointcut()")
	public Object methodCacheGetAndHold(ProceedingJoinPoint joinPoint) throws Throwable {
		MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();

		Object[] arguments = joinPoint.getArgs();
		Object result = null;
		boolean saveFlag = true;
		EvaluationContext ec = getContext(methodSignature.getParameterNames(), arguments);
		RedisCache redisCache = methodSignature.getMethod().getAnnotation(RedisCache.class);
		// 获取到key的值
		String key = StringUtils.isBlank(redisCache.key()) ? null
				: parser.parseExpression(redisCache.key()).getValue(ec, String.class);
		// 保存对象的annotation
		RedisPut put = redisCache.put();
		// 判断有没有oper，没有，按照string类型去结果
		result = redisGet.getRedisResult(redisCache.oper(), key, ec);
		if (result != null) {
			return result;
		}
		result = joinPoint.proceed(arguments);
		// 保存的时候看看有没有保存的条件
		if (put != null && StringUtils.isNotBlank(put.saveCondition())) {
			saveFlag = parser.parseExpression(put.saveCondition()).getValue(ec, Boolean.class);
		}
		if (result != null && saveFlag) {
			redisSet.setRedisResult(put.oper(), key, ec, result);
		}
		return result;
	}

	@Around(value = "methodCachePutPointcut()")
	public Object methodCacheHold(ProceedingJoinPoint joinPoint) throws Throwable {
		MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();

		Object[] arguments = joinPoint.getArgs();
		boolean saveFlag = true;
		EvaluationContext ec = getContext(methodSignature.getParameterNames(), arguments);
		RedisPut put = methodSignature.getMethod().getAnnotation(RedisPut.class);
		// 获取到key的值
		String key = StringUtils.isBlank(put.key()) ? null
				: parser.parseExpression(put.key()).getValue(ec, String.class);
		if (put != null && StringUtils.isNotBlank(key) && StringUtils.isNotBlank(put.saveCondition())) {
			saveFlag = parser.parseExpression(put.saveCondition()).getValue(ec, Boolean.class);
		}
		if (arguments.length > 0 && arguments[0] != null && saveFlag) {
			if (!redisSet.setRedisResult(put.oper(), key, ec, arguments[0])) {
				throw new RuntimeException("缓存发布失败，请重新操作");
			}
		}
		return joinPoint.proceed(arguments);
	}

	/**
	 * 删除key的操作
	 *
	 * @param joinPoint
	 */
	@Around("methodCacheEvictPointcut()")
	public Object methodCacheEvict(ProceedingJoinPoint joinPoint) throws Throwable {
		MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
		Object[] arguments = joinPoint.getArgs();
		RedisCacheEvict evict = methodSignature.getMethod().getAnnotation(RedisCacheEvict.class);
		EvaluationContext ec = getContext(methodSignature.getParameterNames(), arguments);
		String key = parser.parseExpression(evict.key()).getValue(ec, String.class);
		boolean flag = redisDelete.delete(evict.oper(), key, ec);
		if (!flag) {
			throw new RedisCacheException("删除缓存错误，请重新操作");
		}
		Object result = joinPoint.proceed(arguments);

		return result;
	}

	/**
	 * 获取环境上下文
	 * 
	 * @param key
	 * @param methodSignature
	 * @return
	 */
	public EvaluationContext getContext(String arg_names[], Object[] arguments) {
		EvaluationContext ec = new StandardEvaluationContext();
		for (int i = 0; i < arguments.length; i++) {
			ec.setVariable(arg_names[i], arguments[i]);
		}
		return ec;
	}

}
