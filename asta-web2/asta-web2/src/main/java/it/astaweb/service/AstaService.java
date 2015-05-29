package it.astaweb.service;

import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;
import it.astaweb.utils.ItemStatus;

import java.util.List;

public interface AstaService {

	Item saveItem(Item item) ;

	Item findItemByName(String name);

	Item findItemById(Integer id);

	Item findItemByIdAndFetchImages(Integer id);

	void deleteItem(Item item) ;

	List<Item> findAllItem();

	void updateItem(Item item) ;

	void addImage(ItemImage image);

	List<ItemImage> findAllImagesByItem(Integer idItem);

	List<ItemImage> findAllImages();

	void deleteItemImage(ItemImage itemImage) ;

	ItemImage findImageById(Integer parseInt);

	List<Item>  findAllItemByStatus(ItemStatus preSell);

}
