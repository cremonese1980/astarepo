package it.astaweb.service;

import it.astaweb.exceptions.ObjectExpiredException;
import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;
import it.astaweb.model.ItemNews;
import it.astaweb.model.Relaunch;
import it.astaweb.utils.ItemStatus;

import java.math.BigDecimal;
import java.util.List;

public interface AstaService {

	Item saveItem(Item item) ;

	Item findItemById(Integer id);

	void deleteItem(Item item) ;

	List<Item> findAllItem();

	void updateItem(Item item) ;

	void addImage(ItemImage image);

	List<ItemImage> findAllImagesByItem(Integer idItem);

	List<ItemImage> findAllImages();

	void deleteItemImage(ItemImage itemImage) ;

	ItemImage findImageById(Integer parseInt);

	List<Item>  findAllItemByStatus(ItemStatus preSell);
	
	BigDecimal getTotalOffers();

	void relaunch(Relaunch relaunch) throws ObjectExpiredException;

	void setExpired(Item item);

	List<Item> findAllItemByStatusJoinImages(ItemStatus status);

	Item findItemByIdAndFetchImagesFetchRelaunches(Integer id);

	Relaunch getBestRelaunch(Item item);
	
	String getTestPhaseMessage();

	List<ItemNews> findAllItemNews();

	void saveItemNews(ItemNews itemNews);

	void refresh();

}
