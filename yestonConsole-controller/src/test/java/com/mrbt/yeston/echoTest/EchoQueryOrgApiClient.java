package com.mrbt.yeston.echoTest;

import java.net.URLDecoder;
import java.util.Date;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;

import com.alibaba.fastjson.JSONObject;
import com.mrbt.yeston.web.echo.base.ApiQueryClient;
import com.mrbt.yeston.web.echo.util.ApiRestTemplate;
import com.mrbt.yeston.web.echo.util.RC4_128_V2;
/**
 * 
 * @author Derek Zhu
 *
 */
public class EchoQueryOrgApiClient extends ApiQueryClient {

	/**
	 * @param args
	 * @throws ConfigurationException
	 */
	public static void main(final String[] args) throws ConfigurationException {

		try {
			final PropertiesConfiguration config = new PropertiesConfiguration("prop.properties");
			String data = null;
//			final String url = "http://api.ylfin.com/api-credit/echo";
			final String url = "http://mfk.lingmoney.cn/echoApi/echoComeQuery";
			final String rc4Key = config.getString("password");
			System.out.println("[" + df.format(new Date()) + "]查询程序启动~~~~~~~~");
			final String name = "孙宝凤";
			final String idNo = "230523197805283826";
			
//			"name" : "程中富", "certNo" : "232103197601072810"
//			"name" : "丁丽里", "certNo" : "210181198805206556"
//			 "name" : "丁丽卫", "certNo" : "232103199003142814"
//				 "张淑杰", "certNo" : "232103197604182820",
			
			final long startTime=System.currentTimeMillis();
			data = ApiRestTemplate.echoQueryOrg(url, rc4Key, name, idNo);
			System.out.println( data );
			final JSONObject jsonObject = JSONObject.parseObject(data);
			if (jsonObject.containsKey("errorCode") && "0000".equals(jsonObject.getString("errorCode"))) {
				// 解密解码返回结果
				final String dataField = URLDecoder.decode(jsonObject.getString("params"), "utf-8");
				final String decryptResult = RC4_128_V2.decode(dataField, rc4Key);
				jsonObject.put("params", JSONObject.parse(decryptResult));
				
			}
			final String decrptedString = jsonObject.toString();
			System.out.println("decrpted data: " + decrptedString);
			final long endTime=System.currentTimeMillis();
			System.out.println("Time duration: " + formatDuring(endTime - startTime));
			System.out.println("[" + df.format(new Date()) + "]查询程序结束~~~~~~~~");
			
		} catch (final Exception e) {
			e.printStackTrace(); 
		}
	}

	public static String formatDuring(final long mss) {
		final long days = mss / (1000 * 60 * 60 * 24);
		final long hours = (mss % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60);
		final long minutes = (mss % (1000 * 60 * 60)) / (1000 * 60);
		final long seconds = (mss % (1000 * 60)) / 1000;
		return days + " days " + hours + " hours " + minutes + " minutes " + seconds + " seconds ";
	}
}
