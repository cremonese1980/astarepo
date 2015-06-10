package it.astaweb.model;

import it.astaweb.utils.ItemNewsStatus;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "item_news")
public class ItemNews implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2198764365786823144L;
	@Id
	@GeneratedValue
	private Integer id;
	@NotNull
	@Column(name="id_status", columnDefinition="varchar")
	private ItemNewsStatus status = ItemNewsStatus.TO_SEND;
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm:ss")
	@Column(name="sent_date")
	private Date sentDate;	
	@Column(name="cc_list")
	private String ccList;
	@ManyToOne(cascade={CascadeType.MERGE})
	@JoinColumn(name="id_item")
	private Item item;
	
	public ItemNews() {
	}
	
	
	public ItemNews(String ccList, Item item) {
		this.ccList = ccList;
		this.item = item;
	}


	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public ItemNewsStatus getStatus() {
		return status;
	}
	public void setStatus(ItemNewsStatus status) {
		this.status = status;
	}
	public Date getSentDate() {
		return sentDate;
	}
	public void setSentDate(Date sentDate) {
		this.sentDate = sentDate;
	}
	public String getCcList() {
		return ccList;
	}
	public void setCcList(String ccList) {
		this.ccList = ccList;
	}


	public Item getItem() {
		return item;
	}


	public void setItem(Item item) {
		this.item = item;
	}
	
	

}