package it.astaweb.service;

import it.astaweb.utils.Constants;

import java.util.Properties;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;

public class EmailSender extends JavaMailSenderImpl {
	
	
	
	private String host;
	private String port;
	private String protocol;
	private String username;
	private String password;
	private String smtpAuth;
	private String startTtls;
	private String from;
	private String cc;
	private String smtpSocketFactory;
	
	@Autowired
	PropertyService propertyService;
	
	private String mailPort;
	private String mailProtocol;
	private Properties javaMailProperties;
	
	@PostConstruct
	public void init(){
		
		host = propertyService.getValue(Constants.PROPERTY_MAIL_SENDER_HOST.getValue());
		port = propertyService.getValue(Constants.PROPERTY_MAIL_SENDER_PORT.getValue());
		protocol = propertyService.getValue(Constants.PROPERTY_MAIL_SENDER_PROTOCOL.getValue());
		username = propertyService.getValue(Constants.PROPERTY_MAIL_SENDER_USERNMAE.getValue());
		password = propertyService.getValue(Constants.PROPERTY_MAIL_SENDER_PASSWORD.getValue());
		smtpAuth = propertyService.getValue(Constants.PROPERTY_MAIL_SMTP_AUTH.getValue());
		startTtls = propertyService.getValue(Constants.PROPERTY_MAIL_SMTP_STARTTTLS.getValue());
		from = propertyService.getValue(Constants.PROPERTY_MAIL_SENDER_FROM.getValue());
		cc = propertyService.getValue(Constants.PROPERTY_MAIL_SENDER_CC.getValue());
		smtpSocketFactory = propertyService.getValue(Constants.PROPERTY_MAIL_SENDER_SMTP_SOCKETFACTORYCLASS.getValue());
		
		
//		<property name="host" value="${mail.sender.host}"/>
//        <property name="username" value="${mail.sender.username}"/>
//        <property name="password" value="${mail.sender.password}"/>
//        <property name="port" value="${mail.sender.port}"/>
//        <property name="protocol" value="${mail.sender.protocol}"/>
//        <property name="javaMailProperties">
//            <props>
//                <prop key="mail.smtp.auth">${mail.smtp.auth}</prop>
//                <prop key="mail.smtp.starttls.enable">${mail.smtp.starttls.enable}</prop>
//<!--                Per invio con GMAIL-->
//                <prop key="mail.smtp.socketFactory.class">${mail.sender.smtp.socketFactory.class}</prop>
//            </props>
//        </property>
	}
	
	public String getMailPort() {
		return mailPort;
	}
	public void setMailPort(String mailPort) {
		this.mailPort = mailPort;
		if(this.mailPort.length() > 0)
			super.setPort(Integer.valueOf(mailPort));
	}
	public String getMailProtocol() {
		return mailProtocol;
	}
	public void setMailProtocol(String mailProtocol) {
		this.mailProtocol = mailProtocol;
		if(this.mailProtocol.length() > 0)
			super.setProtocol(this.mailProtocol);
	}
	public Properties getJavaMailProperties() {
		return javaMailProperties;
	}
	public void setJavaMailProperties(Properties javaMailProperties) {
		this.javaMailProperties = javaMailProperties;
		if(!javaMailProperties.isEmpty())
			super.setJavaMailProperties(javaMailProperties);
	}
	
}
