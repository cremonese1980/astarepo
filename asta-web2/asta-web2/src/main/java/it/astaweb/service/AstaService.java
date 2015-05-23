package it.astaweb.service;

import java.util.List;

import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;


public interface AstaService {
	
	  Item saveItem(Item item);
	  Item findItemByName(String name);
	  Item findItemById(Integer id);
	  Item findItemByIdAndFetchImages(Integer id);
	  void deleteItem(Item item);
	  List<Item> findAllItem();
	  void updateItem(Item item);
	  void addImage(ItemImage image);
	  List<ItemImage> findAllImagesByItem(Integer idItem);
	  List<ItemImage> findAllImages();
	}
