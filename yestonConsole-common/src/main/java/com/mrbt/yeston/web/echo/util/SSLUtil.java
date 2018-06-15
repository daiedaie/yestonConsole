package com.mrbt.yeston.web.echo.util;

import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.X509TrustManager;

public abstract class SSLUtil {
	public static void trustEveryone() {
        try {
            HttpsURLConnection.setDefaultHostnameVerifier(new HostnameVerifier() {
 
                @Override
				public boolean verify(String hostname, SSLSession session) {
                    return true;
                }
            });
            final SSLContext context = SSLContext.getInstance("TLS");
            context.init(null, new X509TrustManager[]{new X509TrustManager() {
 
                @Override
				public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
                }
 
                @Override
				public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
                }
 
                @Override
				public X509Certificate[] getAcceptedIssuers() {
                    return new X509Certificate[0];
                }
            }}, new SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(context.getSocketFactory());
        } catch (final Exception e) {
            e.printStackTrace();
        }
    }
}
