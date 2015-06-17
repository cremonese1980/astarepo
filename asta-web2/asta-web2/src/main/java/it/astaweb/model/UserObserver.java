package it.astaweb.model;


public class UserObserver {
	
	private User user;
	private Item item;
	private Long expiringSeconds;
	private String verificationCode;
	
	public UserObserver(User user, Item item, 
			Long expiringSeconds) {
		this.user = user;
		this.item = item;
		this.expiringSeconds = expiringSeconds;
	}
	public UserObserver() {
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Item getItem() {
		return item;
	}
	public void setItem(Item item) {
		this.item = item;
	}
	public Long getExpiringSeconds() {
		return expiringSeconds;
	}
	public void setExpiringSeconds(Long expiringSeconds) {
		this.expiringSeconds = expiringSeconds;
	}
	public String getVerificationCode() {
		return verificationCode;
	}
	public void setVerificationCode(String verificationCode) {
		this.verificationCode = verificationCode;
	}
	
	

}
