package com.mrbt.cache.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.springframework.data.redis.connection.DataType;

@Target({ ElementType.METHOD, ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
@Inherited
@Documented
public @interface RedisCache {

	DataType type() default DataType.STRING;

	String condition() default "";

	String key() default "";

	RedisOper oper() default @RedisOper;

	/**
	 * 保存对象
	 * 
	 * @return
	 */
	RedisPut put() default @RedisPut;
}
