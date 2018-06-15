package com.mrbt.yeston.rong360.tianji.utils;

import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.net.ssl.SSLContext;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContextBuilder;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultRedirectStrategy;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import com.mrbt.yeston.rong360.tianji.httpclient.MyPlainSocketFactory;
import com.mrbt.yeston.rong360.tianji.httpclient.MySSLSocketFactory;

/**
 * Http请求响应相关类
 * @author 融360-天机
 *
 */
@SuppressWarnings("deprecation")
public class HttpTools {
    
    /**
     * 超时时间
     */
    public static final int TIMEOUT = 10000;
    
    /**
     * HTTP最大连接数
     */
    private static final int MAX_TOTAL_CONNECTIONS = 400;
    
    /**
     * HTTP最大路由数
     */
    private static final int MAX_ROUTE_CONNECTIONS = 100;
    
    /**
     * HTTP连接超时时间
     */
    public static final int CONNECT_TIMEOUT = 10000;
    
    /**
     * HTTP套接字SOCKET超时时间
     */
    public static final int SOCKET_TIMEOUT = 20000;
    
    /**
     * 连接池管理对象
     */
    private static PoolingHttpClientConnectionManager connectionManager = null;
    
    /**
     * 初始化连接池
     */
    static {
        try {
			SSLContext sslContext = new SSLContextBuilder().loadTrustMaterial(null, new TrustStrategy() {
                // 信任所有
                @Override
				public boolean isTrusted(X509Certificate[] chain, String authType)
                    throws CertificateException
                {
                    return true;
                }
            }).build();
			Registry<ConnectionSocketFactory> socketFactoryRegistry =
                RegistryBuilder.<ConnectionSocketFactory> create()
                    .register("http", new MyPlainSocketFactory())
                    .register("https",
                        new MySSLSocketFactory(sslContext, SSLConnectionSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER))
                    .build();
            
            connectionManager = new PoolingHttpClientConnectionManager(socketFactoryRegistry);
            connectionManager.setMaxTotal(MAX_TOTAL_CONNECTIONS);
            connectionManager.setDefaultMaxPerRoute(MAX_ROUTE_CONNECTIONS);
			connectionManager.setValidateAfterInactivity(4000);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    }
    
    /**
     * 创建CloseableHttpClient实例
     * @param connectTimeout 连接超时时间
     * @param socketTimeout HTTP套接字SOCKET超时时间
     * @return CloseableHttpClient 创建好的CloseableHttpClient实例
     */
    public static CloseableHttpClient createInstance(int connectTimeout, int socketTimeout) {
        if(connectTimeout == 0) {
            connectTimeout = HttpTools.CONNECT_TIMEOUT;
        }
        if(socketTimeout == 0) {
            socketTimeout = HttpTools.SOCKET_TIMEOUT;
        }
        
        boolean redirectAll = false;
        DefaultRedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
        if(redirectAll) {
            redirectStrategy = new LaxRedirectStrategy();
        }
        
		RequestConfig requestConfig =
            RequestConfig.custom()
                .setConnectTimeout(connectTimeout)
                .setSocketTimeout(socketTimeout)
                .setConnectionRequestTimeout(connectTimeout)
                .setRedirectsEnabled(true)
                .setStaleConnectionCheckEnabled(true)
                .setCookieSpec("easy")
                .build();
        
        return HttpClients.custom()
            .setConnectionManager(connectionManager)
            .setDefaultRequestConfig(requestConfig)
            .setRedirectStrategy(redirectStrategy)
            .setUserAgent("Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1;.NET CLR 1.1.4322; CIBA; .NET CLR 2.0.50727)")
            .build();
    }
    
    /**
     * 发送post请求
     * @param url 请求的URL
     * @param params 请求参数
     * @param connectTimeout 连接服务器超时时间
     * @param readTimeout URL响应超时时间
     * @return String URL响应字符串
     * @throws Exception 异常
     */
    public static String post(String url, Map<String, String> params, int connectTimeout, 
    		int readTimeout) throws Exception {
        CloseableHttpClient httpclient = null;
        HttpPost httppost = new HttpPost(url);
        try {
            httpclient = HttpTools.createInstance(connectTimeout, readTimeout);
            if(params == null || params.size() == 0) {
                return "";
            }
            
            // 创建参数队列
            List<NameValuePair> formparams = new ArrayList<NameValuePair>();
            for (String key : params.keySet()) {
                formparams.add(new BasicNameValuePair(key, params.get(key)));
            }
            UrlEncodedFormEntity uefEntity = new UrlEncodedFormEntity(formparams, "UTF-8");
            httppost.setEntity(uefEntity);
            
            HttpResponse response = null;
            response = httpclient.execute(httppost);
            
            if(response == null) {
            	return "";
            }
            HttpEntity entity = response.getEntity();
            if(entity != null) {
            	return EntityUtils.toString(entity, "UTF-8");
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if(httppost != null) {
                httppost.releaseConnection();
            }
        }
        return "";
    }
    
}
