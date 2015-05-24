package it.astaweb.controller;

import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;
import it.astaweb.model.User;
import it.astaweb.service.AstaService;
import it.astaweb.service.ImageService;
import it.astaweb.service.UserService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

@Controller
@SessionAttributes("user")
public class ItemController {

	private static final Log LOG = LogFactory.getLog(ItemController.class);

	@Autowired(required = true)
	private UserService userService;

	@Autowired(required = true)
	private AstaService astaService;
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private ImageService imageService;

	@RequestMapping(value = "/insertItem", method = RequestMethod.GET)
	public String insertItem(Model model) {

		User loggedUser = (User) model.asMap().get("user");
		if (loggedUser == null) {
			return "redirect:index.html";
		}

		Item item = new Item();
		model.addAttribute("item", item);

		return "insertItem";
	}

	@RequestMapping(value = "/insertItem", method = RequestMethod.POST)
	public String insertItem(@Valid @ModelAttribute("item") Item item,
			BindingResult result, Model model) throws IOException {
		if (result.hasErrors()) {
			return "insertItem";
		}

		/*
		 * TODO aggiungere validazione
		 */
		String okMessage = "Oggetto salvato correttaemente";
		if(item.getId()!=null){
			okMessage = "Oggetto modficato correttaemente";
		}
		astaService.saveItem(item);
		model.addAttribute("okMessage", okMessage);

		// if(userFound == null) {
		// model.addAttribute("userMessage", "Utente sconosciuto, ritenta.");
		// result.addError(new ObjectError("user.username",
		// "Utente sconosciuto, ritenta"));
		// return "loginAdmin";
		// }
		// if(!userFound.getPassword().equals(user.getPassword())){
		// model.addAttribute("passwordMessage", "Password sbagliata, ritenta");
		// result.addError(new ObjectError("user.password",
		// "Password sbagliata, ritenta"));
		// return "loginAdmin";
		// }
		List<Item> itemList = astaService.findAllItem();
		model.addAttribute("itemlist", itemList);
		List<ItemImage> images = astaService.findAllImagesByItem(item.getId());
		model.addAttribute("images", images);
		return "insertItem";
	}

	@RequestMapping(value = "/modifyItem", method = RequestMethod.GET)
	public String modifyItem(@RequestParam Map<String, String> params, Model model) {

		User loggedUser = (User) model.asMap().get("user");

		if (loggedUser == null) {
			return "redirect:index.html";
		}

		Item item = astaService.findItemById(Integer.parseInt((String)params.get("itemid")));
		model.addAttribute("item", item);
		
		List<ItemImage> images = astaService.findAllImagesByItem(item.getId());
		model.addAttribute("images", images);
		
		return "insertItem";
	}

	@RequestMapping(value = "/modifyItem", method = RequestMethod.POST)
	public String modifyItem(@Valid @ModelAttribute("user") User user,
			BindingResult result, Model model) {
		if (result.hasErrors()) {
			return "loginAdmin";
		}
		User userFound = userService.findByUsername(user.getUsername());
		if (userFound == null) {
			model.addAttribute("message", "Utente sconosciuto, ritenta.");
			return "loginAdmin";
		}
		if (!userFound.getPassword().equals(user.getPassword())) {
			model.addAttribute("message", "Password sbagliata, ritenta");
			return "loginAdmin";
		}
		return "adminPage";
		// return "redirect:login.html";
	}
	
	@Transactional
	@RequestMapping(value = "/deleteItem", method = RequestMethod.GET)
	public String deleteItem(@RequestParam Map<String, String> params, Model model) {

		User loggedUser = (User) model.asMap().get("user");

		if (loggedUser == null) {
			return "redirect:index.html";
		}

		Item item = astaService.findItemByIdAndFetchImages(Integer.parseInt((String)params.get("itemid")));
		astaService.deleteItem(item);
		List<Item> itemList = astaService.findAllItem();
		model.addAttribute("itemlist", itemList);
		return "adminPage";
	}
	
	@RequestMapping(value = "/addImage", method = RequestMethod.GET)
	public String addImage(@RequestParam Map<String, String> params, Model model) {

		User loggedUser = (User) model.asMap().get("user");
		if (loggedUser == null) {
			return "redirect:index.html";
		}

		Item item = astaService.findItemById(Integer.parseInt((String)params.get("itemid")));
		ItemImage itemImage = new ItemImage();
		itemImage.setItem(item);
		model.addAttribute("itemImage", itemImage);		
		model.addAttribute("item", item);

		return "addImage";
	}

	@Transactional
	@RequestMapping(value = "/addImage", method = RequestMethod.POST)
	public String addImage(@Valid @ModelAttribute("itemImage") ItemImage itemImage,
			BindingResult result, @RequestParam(value = "uploadImage", required = false) MultipartFile uploadImage, Model model) 
					 {
		if (result.hasErrors()) {
			return "insertItem";
		}

		User loggedUser = (User) model.asMap().get("user");
		if (loggedUser == null) {
			return "redirect:index.html";
		}
		boolean error = false;
		if (!validateImage(uploadImage)) {
			model.addAttribute("uploadImageMessage", "L'immagine deve essere una JPG, di dimensioni inferiori a 2 MB");
			error = true;
		}
		if (itemImage.getName()==null || itemImage.getName().trim().equals("")) {
			model.addAttribute("nameMessage", "Titolo immagine obbligatorio");
			error = true;
		}
		if (itemImage.getDescription()==null || itemImage.getDescription().trim().equals("")) {
			model.addAttribute("descriptionMessage", "Descrizione immagine obbligatoria");
			error = true;
		}

		model.addAttribute("item", itemImage.getItem());
		
		if(error){
			return "addImage";
			
		}
		
		astaService.addImage(itemImage);
		try {
			imageService.saveImage(itemImage, uploadImage);
			Item item = astaService.findItemById(itemImage.getItem().getId());
			itemImage.setItem(item);
			astaService.addImage(itemImage);
		} catch (Exception e) {
			model.addAttribute("uploadImageMessage", "Errore durante il salvataggio dell'immagine: " + e.getMessage());
			astaService.deleteItemImage(itemImage);
			return "addImage";
		} 	
//		model.addAttribute("item", itemImage.getItem());
		

		return "redirect:modifyItem.html?itemid=" + itemImage.getItem().getId();
	}
	
	@Transactional
	@RequestMapping(value = "/deleteImage", method = RequestMethod.GET)
	public String deleteImage(@RequestParam Map<String, String> params, Model model) {

		User loggedUser = (User) model.asMap().get("user");

		if (loggedUser == null) {
			return "redirect:index.html";
		}

		ItemImage itemImage = astaService.findImageById(Integer.parseInt((String)params.get("imageid")));
		astaService.deleteItemImage(itemImage);
		
		return "redirect:modifyItem.html?itemid=" + itemImage.getItem().getId();
	}
	
	private boolean validateImage(MultipartFile image) {
		if (image==null || image.getSize()<=0 ||  image.getContentType()==null
				|| image.getContentType().trim().equals("") || !image.getContentType().equals("image/jpeg")
				|| image.getSize()>1999999) {
			return false;
		}
		return true;
	}

}