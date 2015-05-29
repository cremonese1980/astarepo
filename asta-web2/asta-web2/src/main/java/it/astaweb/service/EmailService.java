package it.astaweb.service;



import it.astaweb.utils.Constants;

import java.util.Arrays;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.annotation.PostConstruct;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Service;

@Service("emailService")
public class EmailService extends ApplicationObjectSupport {
	
	@Autowired
    private PropertyService propertyService;
	
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

    public void sendEmail(String subject, String body, String[] to) {
	sendEmail(subject, body, to, null);
    }

    public void sendEmail(String subject, String body, String[] to, String[] attachments) {
	sendEmail(null, subject, body, to, null, null, attachments);
    }

    public void sendEmail(String from, String subject, String body,
	    String[] to, String[] cc, String[] bcc, String[] attachments) {

	String cclist = propertyService.getValue("email.cclist");

	    String[] ccext = cclist.replaceAll(" ", "").split(",");
	    if (cc != null) {
		String[] merge = new String[cc.length + ccext.length];
		System.arraycopy(cc, 0, merge, 0, cc.length);
		System.arraycopy(ccext, 0, merge, cc.length, ccext.length);
		cc = merge;
	    } else
		cc = ccext;

		send();
    }
    
    	public void send() {
	    
	    try {
	    	Session session = setupSession();
		Message m = new MimeMessage(session);
		m.setSentDate(new Date());
		m.setSubject("AstaWeb - Subject - Test");
		if (from != null)
		    m.setFrom(new InternetAddress(from));

		Multipart mp = new MimeMultipart();
		MimeBodyPart body = new MimeBodyPart();
		body.setContent("corpo mail automatica di prova", "text/html");
		mp.addBodyPart(body);

//		if (attachments != null) {
//		    for (String f : attachments) {
//			MimeBodyPart atts = new MimeBodyPart();
//			FileDataSource fds = new FileDataSource(f);
//			atts.setDataHandler(new DataHandler(fds));
//			atts.setFileName(fds.getName());
//			mp.addBodyPart(atts);
//		    }
//		}
		m.setContent(mp);

		    m.addRecipient(Message.RecipientType.TO, new InternetAddress("gabriele.cremonese@gmail.com"));
		    m.addRecipient(Message.RecipientType.TO, new InternetAddress("chevuoi@hotmail.com"));

//		if (cc != null) {
//		    for (String a : cc) {
//			m.addRecipient(Message.RecipientType.CC, new InternetAddress(a));
//		    }
//		}
//
//		if (bcc != null) {
//		    for (String a : bcc) {
//			m.addRecipient(Message.RecipientType.BCC, new InternetAddress(a));
//		    }
//		}

//		Transport.send(m);
		    
			Transport transport = session.getTransport("smtp");
			// Enter your correct gmail UserID and Password (XXXApp Shah@gmail.com)
			transport.connect("smtp.gmail.com", "astaweb.server", "r1l4nc10");
			transport.sendMessage(m, m.getAllRecipients());
			transport.close();
		    
//		logger.debug("Email '" + subject + "' sent to " +
//			Arrays.toString(to) + " with " + Arrays.toString(attachments));
	    }
	    catch (Exception e) {
//		logger.error("Subject: '" + subject + "' to '" +
//			Arrays.toString(to) + "':", e);
	    }
	}
	
	private Session setupSession() {
	    
	    Properties props = new Properties();
	    props.put("mail.smtp.host", host);
	    props.put("mail.smtp.port", port );
	    props.put("mail.smtp.timeout", "10000");
	    if (from == null)
		props.put("mail.smtp.from", propertyService.getValue("email.from"));
	    
	    Authenticator auth = null;
		auth = new Authenticator()
		{
		    @Override
		    protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(
				propertyService.getValue(username), 
				propertyService.getValue(password));
		    }
		};
		
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.socketFactory.class", smtpSocketFactory);
		
	    
	    Session session = Session.getDefaultInstance(props, auth);
	    if (logger.isDebugEnabled())
		session.setDebug(true);
	    
	    return session;
	}
    
}
