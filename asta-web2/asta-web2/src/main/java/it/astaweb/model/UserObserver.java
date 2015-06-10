package it.astaweb.model;

import java.util.List;

public class UserObserver {
	
	private User user;
	private Item item;
	private List<Relaunch> relaunches;
	private Long expiringSeconds;
	
	public UserObserver(User user, Item item, List<Relaunch> relaunches,
			Long expiringSeconds) {
		this.user = user;
		this.item = item;
		this.relaunches = relaunches;
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
	public List<Relaunch> getRelaunches() {
		return relaunches;
	}
	public void setRelaunches(List<Relaunch> relaunches) {
		this.relaunches = relaunches;
	}
	public Long getExpiringSeconds() {
		return expiringSeconds;
	}
	public void setExpiringSeconds(Long expiringSeconds) {
		this.expiringSeconds = expiringSeconds;
	}
	
	

}
