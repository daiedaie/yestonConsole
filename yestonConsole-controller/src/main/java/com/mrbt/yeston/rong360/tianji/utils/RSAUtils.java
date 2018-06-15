package com.mrbt.yeston.rong360.tianji.utils;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.security.KeyFactory;
import java.security.Signature;
import java.security.interfaces.RSAPrivateKey;
import java.security.spec.PKCS8EncodedKeySpec;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;

/**
 * RSA加密工具类
 * @author 融360-天机
 *
 */
public class RSAUtils {

	/**
	 * 私钥签名
	 * @param src 源字符串
	 * @param priKey 私钥
	 * @param charset 编码方式
	 * @return byte[] 加密后的字节数组
	 * @throws Exception 异常
	 */
    public static byte[] generateSHA1withRSASigature(String src, String priKey, String charset) throws Exception
    {
    	Signature sigEng = Signature.getInstance("SHA1withRSA");
    	byte[] pribyte = Base64Utils.decode(priKey);
    	PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(pribyte);
    	KeyFactory fac = KeyFactory.getInstance("RSA");
    	RSAPrivateKey privateKey = (RSAPrivateKey) fac.generatePrivate(keySpec);
    	sigEng.initSign(privateKey);
    	sigEng.update(src.getBytes(charset));
    	byte[] signature = sigEng.sign();
    	return signature;
    }
    
    /**
     * 从文件中获取私钥
     * @return String 返回文件中的私钥字符串
     */
    public static String getPrivateKey() {
		try {
			PropertiesConfiguration config = null;
			try {
				config = new PropertiesConfiguration("prop.properties");
			} catch (ConfigurationException e) {
				e.printStackTrace();
			}
			
			FileReader fileReader = new FileReader(config.getString("privateKeyPath"));
			BufferedReader br = new BufferedReader(fileReader);
			String tempStr = "";
			String privateKey = "";
			int i=0;
			while((tempStr = br.readLine()) != null) {
				if(i==0 || i==15) {
					if(tempStr.contains("BEGIN PRIVATE KEY") || tempStr.contains("END PRIVATE KEY")) {
						i++;
						continue;
					}else {
						privateKey = privateKey + tempStr + "\n";
					}
				}else{
					privateKey = privateKey + tempStr + "\n";
					i++;
				}
			}
			br.close();
			fileReader.close();
			return privateKey;
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	} 

}