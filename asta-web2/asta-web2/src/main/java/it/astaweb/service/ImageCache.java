package it.astaweb.service;

import it.astaweb.model.ItemImage;

import java.io.File;

public interface ImageCache {

	void add(File file, ItemImage itemImage);
	
	byte[] get(ItemImage itemImage);
	
	void remove(ItemImage itemImage);

	void refresh();

	String findImagePathByIdAndItemIdAndName(String id, String itemId,
			String name);
	

}
