package it.astaweb.service;

import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;


public interface ImageService {
	
	  ItemImage saveImage(ItemImage itemImage, MultipartFile uploadImage) throws IllegalStateException, IOException;
	  ItemImage findImageByName(String name);
	  ItemImage findImageById(Integer id);
	  String findImagePathByIdAndItemIdAndName(String id, String itemId, String name);
	  void deleteImage(ItemImage itemImage);
	  List<ItemImage> findAllImage();
	  List<ItemImage> findAllImageByItem(Item item);
	  byte[] get(String imageName);
	void refresh();
	}
