package it.astaweb.service;

import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;
import it.astaweb.repository.ConfigurationRepository;
import it.astaweb.repository.ItemImageRepository;
import it.astaweb.repository.ItemRepository;
import it.astaweb.utils.Constants;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.imageio.ImageIO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service("imageService")
public class ImageServiceImpl implements ImageService {
	
	private static final Log LOG = LogFactory.getLog(ImageServiceImpl.class);
	
	private static final int IMG_ORIGINAL = 1;
	private static final int IMG_THUMB = 2;
	
	private static final int IMG_MAX_WIDTH = 100;
	private static final int IMG_MAX_HEIGHT = 100;
	
	private final static int WIDTH_RELATIVELY_GREATER= 1;
	private final static int HEIGHT_RELATIVELY_GREATER= 2;
	
	private static final String IMG_PLACEHOLDER = "_placeholdertosubstituremaythiscannotbediscoveredbyusers_";
	private static final String IMG_THUMB_VALUE = "_thumb";
	private static final String IMG_ORIGINAL_VALUE = "";
	private static final String JPG_SUFFIX = ".jpg";
	

	@Autowired(required = true)
	private ItemRepository itemRepository;

	@Autowired(required = true)
	private ItemImageRepository itemImageRepository;
	
	@Autowired(required = true)
	private ConfigurationRepository configurationRepository;
	
	@Autowired(required = true)
	private PropertyService propertyService;

	private  String BASE_PATH = "/home/asta/store/img";
	private  File BASE_FOLDER;
	
	@PostConstruct
	public void init(){
		BASE_PATH = propertyService.getValue(Constants.PROPERTY_NAME_BASE_PATH.getValue());
		BASE_FOLDER = new File(BASE_PATH);
		if(!BASE_FOLDER.exists()){
			LOG.info("Base folder [" + BASE_PATH + "] doesen't exists. I create it right now!" );
			if(!BASE_FOLDER.mkdir()){
				LOG.info("Huston, we have a problem");
			}else{
				LOG.info("Base folder created. We are Lucky");
			}
		}
	}
	
	@Override
	public ItemImage saveImage(ItemImage itemImage, MultipartFile uploadImage) throws IllegalStateException, IOException {
		LOG.info("Saving Image in base disk path: " + BASE_PATH);

		File image = writeImage(itemImage, uploadImage, IMG_ORIGINAL);
		File imageThumb = writeImage(itemImage, uploadImage, IMG_THUMB);;
		
		itemImage.setName(image.getName());
		itemImage.setThumbName(imageThumb.getName());
		itemImage.setPath(image.getAbsolutePath().substring(0,image.getAbsolutePath().lastIndexOf("/")+1));
		
		return itemImage;
	}


	
	@Override
	public ItemImage findImageByName(String name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ItemImage findImageById(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteImage(ItemImage itemImage) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ItemImage> findAllImage() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ItemImage> findAllImageByItem(Item item) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public String findImagePathByIdAndItemIdAndName(String id, String itemId,
			String name) {
		
		return BASE_PATH + File.separator + itemId + File.separator + name;
	}

	/*
	 * SUPPORT METHODS
	 */
	private File writeImage(ItemImage itemImage, MultipartFile uploadImage, int type) throws IllegalStateException, IOException {
		
		File temp = File.createTempFile("temp_" + System.currentTimeMillis(), ".jpg");
		uploadImage.transferTo(temp);
		
		String path = buildTemplatePath(itemImage, type);
		
		buildItemFolder(itemImage);
		
		File image = new File(path);
		BufferedImage originalImage = ImageIO.read(temp);
		BufferedImage resizeImageJpg = null;
		
		if(type==IMG_THUMB){
			int imageType = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();	 
			resizeImageJpg = resizeImage(originalImage, imageType);
		}else{
			resizeImageJpg = originalImage;
		}
		ImageIO.write(resizeImageJpg, "jpg", image);
		
		temp.delete();
		
		return image;
	}


	protected String buildTemplatePath(ItemImage itemImage, int type) {
		String imageName = itemImage.getName().trim().replaceAll(" ", "_");
		if(!imageName.endsWith(JPG_SUFFIX)){
			imageName = imageName + JPG_SUFFIX;
		}
		String path = BASE_PATH
				+ File.separator
				+ itemImage.getItem().getId()
				+ File.separator
				+ itemImage.getId()
				+ "_"
				+ imageName.substring(0,
						imageName.lastIndexOf("."))
				+ IMG_PLACEHOLDER
				+ imageName.substring(
						imageName.lastIndexOf("."));
		
		switch (type) {
		case IMG_ORIGINAL:
			path = path.replaceAll(IMG_PLACEHOLDER, IMG_ORIGINAL_VALUE);
			break;
			
		case IMG_THUMB:
			path = path.replaceAll(IMG_PLACEHOLDER, IMG_THUMB_VALUE);
			break;
		}
		
		return path;
	}
	
	private void buildItemFolder(ItemImage itemImage) {
		
		File itemFolder = new File(BASE_PATH + File.separator + itemImage.getItem().getId());
		if(!itemFolder.exists()){
			itemFolder.mkdir();
		}
		
	}
	
	private static BufferedImage resizeImage(BufferedImage originalImage,
			int type) {
		
		if (originalImage.getWidth() < IMG_MAX_WIDTH
				&& originalImage.getHeight() < IMG_MAX_HEIGHT) {

			return originalImage;
		}
		
		int sideRealtivelyGreater = ((double) originalImage.getWidth())	/ IMG_MAX_WIDTH > 
		((double) originalImage.getHeight()) / IMG_MAX_HEIGHT ? WIDTH_RELATIVELY_GREATER
			: HEIGHT_RELATIVELY_GREATER;
		float ratio = sideRealtivelyGreater == WIDTH_RELATIVELY_GREATER ? (originalImage
				.getWidth()) / IMG_MAX_WIDTH
				: (originalImage.getHeight()) / IMG_MAX_HEIGHT;
		
		int newWidth = (int)(originalImage.getWidth()/ratio);
		int newHeight = (int)(originalImage.getHeight()/ratio);
		
		BufferedImage resizedImage = new BufferedImage(newWidth, newHeight,
				type);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(originalImage, 0, 0, newWidth, newHeight, null);
		g.dispose();

		return resizedImage;
	}

}