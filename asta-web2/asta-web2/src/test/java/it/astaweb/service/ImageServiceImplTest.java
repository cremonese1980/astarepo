package it.astaweb.service;

import static org.junit.Assert.*;
import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;

import org.junit.Test;

public class ImageServiceImplTest {

	@Test
	public void testBuildTemplatePath() {
		
		ImageServiceImpl imageService = new ImageServiceImpl();
		ItemImage itemImage=new ItemImage();
		Item item = new Item();
		item.setId(12);
		itemImage.setId(4);
		itemImage.setName("Ciccio pasticcio.jpg");
		itemImage.setItem(item);
		String templatePath = imageService.buildTemplatePath(itemImage, 1);
		System.out.println("orginal: " + templatePath);
		templatePath = imageService.buildTemplatePath(itemImage, 2);
		System.out.println("thumb: " + templatePath);
		
		System.out.println(itemImage.getName());
		
		System.out.println(itemImage.getThumbName());
	}

}
