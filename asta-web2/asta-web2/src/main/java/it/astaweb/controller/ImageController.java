package it.astaweb.controller;

import it.astaweb.service.ImageService;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@DependsOn(value={"imageService"})
public class ImageController {

	@Autowired(required = true)
	private ImageService imageService;

	@RequestMapping(value = "/image")
	public void getImage(@RequestParam Map<String, String> params,
			HttpServletResponse response) {

		String imageId = params.get("imageid");
		String itemId = params.get("itemid");
		String imageName = params.get("imagename");

//		String filePath = imageService.findImagePathByIdAndItemIdAndName(imageId, itemId, imageName);
//		
//		File file = new File(filePath);
//		if(!file.exists()){
//			return;
//		}
		
		byte b[] = imageService.get(imageName);

		response.setContentType("image/jpeg");
		response.setContentLength((int) b.length);

		response.setHeader("Content-Disposition",
				"inline; filename=\"" + imageName + "\"");

		ByteArrayInputStream fis = null;
		OutputStream os = null;
		try {
			fis = new ByteArrayInputStream(b);
//			byte b[];
			int x = fis.available();
//			b = new byte[x];
			fis.read(b);
			os = response.getOutputStream();
			os.write(b);
			os.flush();
			response.flushBuffer();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (os != null)
				try {
					os.close();
				} catch (IOException ignore) {
				}
			if (fis != null)
				try {
					fis.close();
				} catch (IOException ignore) {
				}
		}

	}
	
	
	public static void main(String[] args) {
		
		File file = new File("/home/cremo80/asta/store/img/1/1_80cm_vintage.jpg");
		
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(file);
			byte b[];
			int x = fis.available();
			b = new byte[x];
			
//			printArray(b);
			fis.read(b);
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
	}


	private static void printArray(byte[] b) {
		for (int i = 0; i < b.length; i++) {
			System.out.print(b[i]);
		}
		System.out.println("");
		System.out.println("");
	}
}
