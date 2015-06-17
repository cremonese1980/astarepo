package it.astaweb.service;

import it.astaweb.model.ItemImage;
import it.astaweb.repository.ItemImageRepository;
import it.astaweb.utils.Constants;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("imageCache")
public class ImageCacheImpl implements ImageCache {
	
	public static String BASE_PATH;
	
	
	@Autowired(required = true)
	private PropertyService propertyService;
	
	
	private Map<String, byte[]> imageCache = Collections.synchronizedMap(new HashMap<String, byte[]>());
	
	@Autowired(required = true)
	private ItemImageRepository itemImageRepository;
	
	@PostConstruct
	private void init(){
		BASE_PATH = propertyService.getValue(Constants.PROPERTY_NAME_BASE_PATH.getValue());
		refresh(false);
		
	}
	
	@Override
	public void add(File file, String name) {
		getImageCache().put(name, readFile(file));
		
	}


	@Override
	public byte[] get(String imageName) {
		if(getImageCache().isEmpty()){
			System.out.println("empty ");
			refresh(true);
		}else{
			System.out.println("NOT empty ");
		}
		return getImageCache().get(imageName);
	}


	@Override
	public void remove(String imageName) {
		if(getImageCache().keySet().size()==0){
			refresh(false);
		}
		getImageCache().remove(imageName);
		
	}
	
	@Override
	public String findImagePathByIdAndItemIdAndName(String id, String itemId,
			String name) {
		
		return ImageCacheImpl.BASE_PATH + File.separator + itemId + File.separator + name;
	}
	
	private synchronized Map<String, byte[]> getImageCache(){
		return imageCache;
	}
	
	@Override
	public synchronized void refresh(boolean get) {
		getImageCache().clear();
		List<ItemImage> itemImageList = itemImageRepository.findAll();
		initDb(itemImageList, getImageCache());
		if(get){
			
			System.out.println("from get");
		}else{
			System.out.println("NOT get");
			
		}
		
	}

	private void initDb(List<ItemImage> itemImageList,
			Map<String, byte[]> imageCache) {
		
		for (Iterator<ItemImage> iterator = itemImageList.iterator(); iterator.hasNext();) {
			ItemImage itemImage = iterator.next();
			
			File file = accessFile(itemImage.getId()+"", itemImage.getItem().getId()+"", itemImage.getName());
			File fileThumb = accessFile(itemImage.getId()+"", itemImage.getItem().getId()+"", itemImage.getThumbName());
			
			if(imageCache.get(itemImage.getName())==null){
				imageCache.put(itemImage.getName(), readFile(file));
			}
			if(imageCache.get(itemImage.getThumbName())==null){
				imageCache.put(itemImage.getThumbName(), readFile(fileThumb));
			}
			
		}
		
	}

	private File accessFile(String itemImageId, String itemId, String imageName) {
		String filePath = findImagePathByIdAndItemIdAndName(itemImageId, itemId, imageName);
		
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
//			System.out.println("file " + file.length());
			
//			printArray(b);
			fis.read(b);
//			System.out.println("array " + b.length);
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
