package it.astaweb.utils;


public enum Constants {
	
	PROPERTY_NAME_BASE_PATH("base.directory"),
	PROPERTY_NAME_MAX_UPLOAD_SIZE("max.upload.size"),
	PROPERTY_MIN_SELL_TIME_HOUR("min.sell.time.hour"),
	PROPERTY_MAIL_SENDER_HOST("mail.sender.host"),
	PROPERTY_MAIL_SENDER_PORT("mail.sender.port"),
	PROPERTY_MAIL_SENDER_PROTOCOL("mail.sender.protocol"),
	PROPERTY_MAIL_SENDER_USERNMAE("mail.sender.username"),
	PROPERTY_MAIL_SENDER_PASSWORD("mail.sender.password"),
	PROPERTY_MAIL_SMTP_AUTH("mail.smtp.auth"),
	PROPERTY_MAIL_SMTP_STARTTTLS("mail.smtp.starttls.enable"),
	PROPERTY_MAIL_SENDER_FROM("mail.sender.from"),
	PROPERTY_MAIL_SENDER_CC("mail.sender.cc"),
	PROPERTY_MAIL_SENDER_TO("mail.sender.to"),
	PROPERTY_MAIL_SENDER_SMTP_SOCKETFACTORYCLASS("mail.sender.smtp.socketFactory.class"),
	PROPERTY_RELAUNCH_POSTPONE_SECONDS("relaunch.postpone.seconds"), 
	PROPERTY_SECRET_WORDS("secret.words"), 
	EMAIL_ONSELL_SUBJECT(""), 
	EMAIL_ONSELL_BODY("");
	
	
	
	
	private final String value;
	
	private Constants(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return value;
	}
}
