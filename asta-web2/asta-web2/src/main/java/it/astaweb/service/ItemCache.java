package it.astaweb.service;

import it.astaweb.model.Item;
import it.astaweb.utils.ItemStatus;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.domain.Sort;

public interface ItemCache {

	BigDecimal getTotalOffer();//impl in itemRepository

	void saveItem(Item item);

	List<Item> findAllItem(Sort sort);

	void deleteItem(Integer id);

	Item findItemById(Integer id);

	List<Item> findAllItemByStatus(ItemStatus status);

//	List<Item> findAllItemByStatusJoinImages(ItemStatus status);

	Item findItemByIdAndFetchImagesFetchRelaunches(Integer id);
	
	

}
