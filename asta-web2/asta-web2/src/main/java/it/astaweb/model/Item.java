package it.astaweb.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "item")
public class Item {
	@Id
	@GeneratedValue
	private Integer id;
	@NotEmpty
	private String name;
	@NotEmpty
	private String description;
	@NotEmpty
	@Column(name="base_auction_price")
	private BigDecimal baseAuctionPrice;
	@NotNull
	@DateTimeFormat(pattern = "dd/MM/yyyy")
	@Column(name="expiring_date")
	private Date expiringDate;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Date getExpiringDate() {
		return expiringDate;
	}
	public void setExpiringDate(Date expiringDate) {
		this.expiringDate = expiringDate;
	}
	public BigDecimal getBaseAuctionPrice() {
		return baseAuctionPrice;
	}
	public void setBaseAuctionPrice(BigDecimal baseAuctionPrice) {
		this.baseAuctionPrice = baseAuctionPrice;
	}

	
}