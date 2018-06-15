package com.mrbt.yeston.rong360.tianji.httpclient;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.Proxy;
import java.net.Socket;

import javax.net.ssl.SSLContext;
import javax.xml.ws.spi.http.HttpContext;

import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.X509HostnameVerifier;

/**
 * SSLSocketFactory工厂类
 * @author 融360-天机
 *
 */
@SuppressWarnings("deprecation")
public class MySSLSocketFactory extends SSLConnectionSocketFactory {

	/**
	 * 构造方法
	 * @param sslContext ssl上下文
	 * @param hostnameVerifier 主机名验证
	 */
	public MySSLSocketFactory(SSLContext sslContext,
			X509HostnameVerifier hostnameVerifier) {
		super(sslContext, hostnameVerifier);
	}
	
	/**
	 * 创建socket
	 * @param context Http上下文
	 */
	public Socket createSocket(final HttpContext context) throws IOException {
		InetSocketAddress socksAddr = (InetSocketAddress) context
				.getAttribute("socks.address");
		if (socksAddr != null) {
			Proxy proxy = new Proxy(Proxy.Type.SOCKS, socksAddr);
			return new Socket(proxy);
		}
		return new Socket();
	}
}
