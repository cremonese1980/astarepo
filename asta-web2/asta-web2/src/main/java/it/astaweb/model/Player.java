package it.astaweb.model;

public class Player {

	private String name;
	private String password;
	private String lastName;
	
	public Player() {
		
	}

	public Player(User loggedUser) {
		name=loggedUser.getName();
		lastName=loggedUser.getLastName();
		password=loggedUser.getPassword();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

}