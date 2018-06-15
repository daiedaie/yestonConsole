package com.mrbt.yeston.rong360.tianji.httpclient;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.Proxy;
import java.net.Socket;

import javax.xml.ws.spi.http.HttpContext;

import org.apache.http.conn.socket.PlainConnectionSocketFactory;

/**
 * PlainSocketFactory工厂类
 * @author 融360-天机
 *
 */
public class MyPlainSocketFactory extends PlainConnectionSocketFactory {

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
