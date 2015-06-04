package it.astaweb.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name = "configuration")
public class Configuration implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3723084178154413871L;
	@Id
	@NotEmpty
	private String name;
	@NotEmpty
	private String value;
	private String type;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	

	
	
}