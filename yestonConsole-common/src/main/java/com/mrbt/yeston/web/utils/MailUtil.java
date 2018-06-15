// ~ CopyRight © 2012 USTC SINOVATE  SOFTWARE CO.LTD All Rights Reserved.

package com.mrbt.yeston.web.utils;

import java.net.URL;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.URLDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.springframework.util.StringUtils;

import com.sun.mail.util.MailSSLSocketFactory;


/**
 * 邮件发送辅助类
 * @author YJQ
 *
 */
public class MailUtil {

	/**
	 * 发送电子邮件
	 * 
	 * @param smtpHost
	 *            发信主机
	 * @param receiver
	 *            邮件接收者
	 * @param copyReceiver  
	 * 			     邮件抄收者 [多个间用逗号隔开]     
	 * @param title
	 *            邮件的标题
	 * @param content
	 *            邮件的内容
	 * @param sender
	 *            邮件发送者
	 * @param user
	 *            发送者邮箱用户名
	 * @param pwd
	 *            发送者邮箱密码
	 * @param fileUrl
	 *            附件url
	 * @param fileName
	 *            附件名           
	 * @throws MessagingException3
	 */
	public static boolean sendEmail(String smtpHost, String receiver,String copyReceiver,String title, String content, String sender,
			String senderNick,String user, String pwd, String fileUrl,String fileName) {
		try {
			Properties props = new Properties();
			props.put("mail.host", smtpHost);
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.auth", "true");
			
			if (smtpHost != null && smtpHost.equals("smtp.qq.com")) {
				// 开启ssl加密(qq邮箱)
				MailSSLSocketFactory msf = new MailSSLSocketFactory();
				msf.setTrustAllHosts(true);
				props.put("mail.smtp.ssl.enable", "true");
				props.put("mail.smtp.ssl.socketFactory", msf);
			}

			Session s = Session.getDefaultInstance(props);
			s.setDebug(true);

			// 给消息对象设置发件人/收件人/抄送列表/主题/发信时间
			MimeMessage message = new MimeMessage(s);
			
			//设置自定义发件人昵称  
	        String nick=javax.mail.internet.MimeUtility.encodeText(senderNick);  
			InternetAddress from = new InternetAddress(nick+"<"+sender+">");
			message.setFrom(from);
			
			InternetAddress to = new InternetAddress(receiver);
			message.setRecipient(Message.RecipientType.TO, to);
			if(!StringUtils.isEmpty(copyReceiver)){
				new InternetAddress();
				InternetAddress[] copyToList = InternetAddress.parse(copyReceiver); 
				message.setRecipients(Message.RecipientType.CC, copyToList);
			}
		    message.setSubject(MimeUtility.encodeText(title, "UTF-8", "B"));
			
			//message.setSubject(title);
			message.setSentDate(new Date());
			
			// 给消息对象设置内容
			Multipart mm = new MimeMultipart();// 用来存放BodyPart对象

			BodyPart contentPart = new MimeBodyPart();// 存放信件内容
			contentPart.setContent(content, "text/html;charset=gb2312");
			mm.addBodyPart(contentPart);
			if (fileUrl != "") {
				BodyPart filePart = new MimeBodyPart();// 存放附件
				//File f = new File(fileUrl);
				URL url = new URL(fileUrl);
				DataSource source = new URLDataSource(url);
				if(source!=null){
					filePart.setDataHandler(new DataHandler(source));
					filePart.setFileName(fileName);
					mm.addBodyPart(filePart);
				}
				
			}
			message.setContent(mm);
			message.saveChanges();

			Transport transport = s.getTransport("smtp");
			// 设置发邮件的网关，发信的帐户和密码
			transport.connect(smtpHost, user, pwd);
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}

	public static void main(String[] args) {
		/*try {
			sendEmail("smtp.qq.com", "yangjieqiong@mrbt.com.cn", "系统测试邮件", "测试附件", "403633318@qq.com",
					"403633318@qq.com", "meqtuiurekqubiad", "E:/miao.JPG","");

		} catch (Exception e) {
			e.printStackTrace();
		}*/
	}
}
