package it.astaweb.service;

import java.io.File;

public interface ImageCache {

	void add(File file, String name);
	
	byte[] get(String imageName);
	
	void remove(String imageName);

	void refresh(boolean get);

	String findImagePathByIdAndItemIdAndName(String id, String itemId,
			String name);
	

}
