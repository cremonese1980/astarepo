package it.astaweb.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "relaunch")
public class Relaunch implements Comparable<Relaunch>{
	
	
	@Id
	@GeneratedValue
	private Integer id;
	@NotEmpty
	private String username;
	@ManyToOne(cascade={CascadeType.MERGE})
	@JoinColumn(name="id_item")
	private Item item;
	@DateTimeFormat(pattern = "dd/MM/yyyy")
	private Date date;
	private BigDecimal amount;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Item getItem() {
		return item;
	}
	public void setItem(Item item) {
		this.item = item;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	@Override
	public int compareTo(Relaunch o) {
		return o.amount.compareTo(this.amount);
	}

}