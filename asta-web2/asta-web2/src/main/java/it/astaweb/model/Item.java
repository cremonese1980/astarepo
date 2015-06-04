package it.astaweb.model;

import it.astaweb.utils.ItemStatus;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "item")
public class Item implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7937266920408887712L;
	@Id
	@GeneratedValue
	private Integer id;
	@NotEmpty
	private String name;
	@NotEmpty
	private String description;
	@NotNull
	@Column(name="base_auction_price")
	private BigDecimal baseAuctionPrice;
	@NotNull
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm:ss")
	@Column(name="expiring_date")
	private Date expiringDate;
	@NotNull
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm:ss")
	@Column(name="from_date")
	private Date fromDate;
	@OneToMany(mappedBy="item",fetch=FetchType.LAZY)
	private Set<ItemImage> images = new HashSet<ItemImage>();
	@NotNull
	@Column(name="id_status", columnDefinition="varchar")
	private ItemStatus status = ItemStatus.PRE_SELL;
	@Column(name="best_relaunch")
	private BigDecimal bestRelaunch;
	@OneToMany(mappedBy="item",fetch=FetchType.LAZY)
	private Set<Relaunch> relaunches = new HashSet<Relaunch>();
	
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
	public Set<ItemImage> getImages() {
		return images;
	}
	public void setImages(Set<ItemImage> images) {
		this.images = images;
	}
	public Date getFromDate() {
		return fromDate;
	}
	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}
	public ItemStatus getStatus() {
		return status;
	}
	public void setStatus(ItemStatus status) {
		this.status = status;
	}
	public BigDecimal getBestRelaunch() {
		return bestRelaunch;
	}
	public void setBestRelaunch(BigDecimal bestRelaunch) {
		this.bestRelaunch = bestRelaunch;
	}
	public Set<Relaunch> getRelaunches() {
		return relaunches;
	}
	public void setRelaunches(Set<Relaunch> relaunches) {
		this.relaunches = relaunches;
	}
	@Override
	public String toString() {
		return "Item [id=" + id + ", name=" + name + ", baseAuctionPrice="
				+ baseAuctionPrice + ", expiringDate=" + expiringDate
				+ ", fromDate=" + fromDate + ", status=" + status
				+ ", bestRelaunch=" + bestRelaunch + "]";
	}
	
	
}