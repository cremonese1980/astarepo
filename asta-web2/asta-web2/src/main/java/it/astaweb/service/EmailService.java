package it.astaweb.service;



import it.astaweb.model.Item;
import it.astaweb.model.Relaunch;
import it.astaweb.utils.CalendarUtils;
import it.astaweb.utils.Constants;
import it.astaweb.utils.ItemStatus;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Properties;

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
	
	private static final String DATE_PATTERN = "dd/MM/yyyy HH:mm:ss";
	private static DateFormat dateFormat;
	
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
	private String to;
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
		to = propertyService.getValue(Constants.PROPERTY_MAIL_SENDER_TO.getValue());
		smtpSocketFactory = propertyService.getValue(Constants.PROPERTY_MAIL_SENDER_SMTP_SOCKETFACTORYCLASS.getValue());
		
		dateFormat = new SimpleDateFormat(DATE_PATTERN);
		
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

		send(subject, body);
    }
    
    	public void send(String subjectText, String bodyText) {
	    
	    try {
	    	Session session = setupSession();
		Message mailMessage = new MimeMessage(session);
		mailMessage.setSentDate(CalendarUtils.currentTimeInItaly());
		mailMessage.setSubject(subjectText);
		if (from != null)
		    mailMessage.setFrom(new InternetAddress(from));

		Multipart mp = new MimeMultipart();
		MimeBodyPart body = new MimeBodyPart();
		body.setContent(bodyText, "text/html");
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
		mailMessage.setContent(mp);
		
		String[] mailTo = this.to.split(",");
		
		for (int i = 0; i < mailTo.length; i++) {
			 mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(mailTo[i]));
		}

//		    mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress("gabriele.cremonese@gmail.com"));
//		    mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress("chevuoi@hotmail.com"));

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
		    
			Transport transport = session.getTransport(protocol);
			transport.connect(host, "astaweb.server", "r1l4nc10");
			transport.sendMessage(mailMessage, mailMessage.getAllRecipients());
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

	public void sendOnSell(Item item) {
		String subject = "L'articolo " + item.getName() + " è appena stao messo in vendita";
		String body = "Ciao!<br/><br/>L'articolo " + item.getName() + " è appena stato messo in vendita.<br/>"
				+ "Descrizione: " + item.getDescription()
				+ "<br/>Data inizio asta: " + dateFormat.format(item.getFromDate()) + 
				"<br/>Data fine asta: " + dateFormat.format(item.getExpiringDate()) +
				"<br/>Prezzo base &euro;: " + item.getBaseAuctionPrice()+
				"<br/><br/>Normali saluti,<br/>Il tuo Servente"
				;
		send(subject, body);
		
	}

	public void sendExpired(Item item, Relaunch relaunch) {
		String subject = "L'articolo " + item.getName() + " è appena scaduto";
		String body = "Ciao!<br/><br/>L'articolo " + item.getName() + " è appena scaduto."
				+ "<br/>Descrizione: " + item.getDescription() +
				"<br/>Data fine asta: " + dateFormat.format(item.getExpiringDate())  +
				"<br/>Prezzo base &euro;: " + item.getBaseAuctionPrice()
				;
		if(item.getStatus()==ItemStatus.SOLD_OUT){
			body+="<br/><br/><b>Venduto per &euro; " + item.getBestRelaunch() + "</b>";
			body+="<br/>a " + relaunch.getUsername() +
					" con rilancio in data " + dateFormat.format(relaunch.getDate());
		}else{
			body+= "<br/><br/>Purtroppo è rimasto invenduto, ma non disperiamo, l'ho appena rimesso in vendita ad un prezzo inferiore del 20% rispetto alla base d'asta";
		}
		
		body+="<br/><br/>Normali saluti,<br/>Il tuo Servente";
		send(subject, body);
	}
    
}
