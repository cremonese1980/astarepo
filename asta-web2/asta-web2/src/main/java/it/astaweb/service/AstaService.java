package it.astaweb.service;

import java.util.List;

import it.astaweb.model.Item;


public interface AstaService {
	
	  Item saveItem(Item item);
	  Item findItemByName(String name);
	  List<Item> findAllItem();
	}
