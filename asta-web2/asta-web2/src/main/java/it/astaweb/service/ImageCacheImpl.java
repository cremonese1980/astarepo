package it.astaweb.service;

import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;
import it.astaweb.repository.ItemImageRepository;
import it.astaweb.repository.ItemRepository;
import it.astaweb.utils.Constants;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.WeakHashMap;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("imageCache")
public class ImageCacheImpl implements ImageCache {
	
	public static String BASE_PATH;
	
	
	@Autowired(required = true)
	private PropertyService propertyService;
	
	
	private Map<Integer, byte[]> imageCache;
	
	@Autowired(required = true)
	private ItemImageRepository itemImageRepository;
	
	@PostConstruct
	private void init(){
		BASE_PATH = propertyService.getValue(Constants.PROPERTY_NAME_BASE_PATH.getValue());
		refresh();
		
	}
	
	@Override
	public void add(File file, ItemImage itemImage) {
		imageCache.put(itemImage.getId(), readFile(file));
		
	}


	@Override
	public byte[] get(ItemImage itemImage) {
		return imageCache.get(itemImage.getId());
	}


	@Override
	public void remove(ItemImage itemImage) {
		imageCache.remove(itemImage.getId());
		
	}
	
	@Override
	public String findImagePathByIdAndItemIdAndName(String id, String itemId,
			String name) {
		
		return ImageCacheImpl.BASE_PATH + File.separator + itemId + File.separator + name;
	}
	
	
	@Override
	public synchronized void refresh() {
		imageCache = Collections.synchronizedMap(new WeakHashMap<Integer, byte[]>());
		List<ItemImage> itemImageList = itemImageRepository.findAll();
		initDb(itemImageList, imageCache);
		
	}

	private void initDb(List<ItemImage> itemImageList,
			Map<Integer, byte[]> imageCache) {
		
		for (Iterator<ItemImage> iterator = itemImageList.iterator(); iterator.hasNext();) {
			ItemImage itemImage = iterator.next();
			
			File file = accessFile(itemImage);
			
			if(imageCache.get(itemImage.getId())==null){
				imageCache.put(itemImage.getId(), readFile(file));
			}
			
		}
		
	}

	private File accessFile(ItemImage itemImage) {
		String filePath = findImagePathByIdAndItemIdAndName(itemImage.getId()+"", itemImage.getItem().getId()+"", itemImage.getName());
		
		File file = new File(filePath);
		if(!file.exists()){
			return null;
		}
		return file;
	}

	byte[] readFile(File file){
		
		FileInputStream fis = null;
		byte b[] = null;
		try {
			fis = new FileInputStream(file);
			int x = fis.available();
			b = new byte[x];
			System.out.println("file " + file.length());
			
//			printArray(b);
			fis.read(b);
			System.out.println("array " + b.length);
//			printArray(b);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (fis != null)
				try {
					fis.close();
				} catch (IOException ignore) {
				}
		}
		/*
		 * Gestire eccezioni
		 */
		return b;
		
	}
	


}
