package it.astaweb.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name = "authorities")
public class Authorities implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4895649099627175942L;
	@Id
	@NotEmpty
	private String username;
	@NotEmpty
	private String authority;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	
	
	
	
	

}