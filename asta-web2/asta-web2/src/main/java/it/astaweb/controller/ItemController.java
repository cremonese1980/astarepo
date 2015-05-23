package it.astaweb.controller;

import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;
import it.astaweb.model.User;
import it.astaweb.service.AstaService;
import it.astaweb.service.UserService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
			BindingResult result, @RequestParam(value = "image", required = false) MultipartFile image, Model model) throws IOException {
		if (result.hasErrors()) {
			return "insertItem";
		}

		/*
		 * TODO aggiungere validazione
		 */
//		item = astaService.findItemById(item.getId());
		
		ItemImage itemImage = new ItemImage();
		itemImage.setImage(image.getBytes());
		itemImage.setName(image.getName());
		itemImage.setItem(item);
		astaService.addImage(itemImage);
		astaService.saveItem(item);

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
		return "adminPage";
	}

	@RequestMapping(value = "/modifyItem", method = RequestMethod.GET)
	public String adminPage(@RequestParam Map<String, String> params, Model model) {

		User loggedUser = (User) model.asMap().get("user");

		if (loggedUser == null) {
			return "redirect:index.html";
		}

		Item item = astaService.findItemById(Integer.parseInt((String)params.get("itemid")));
		model.addAttribute("item", item);
		return "insertItem";
	}

	@RequestMapping(value = "/modifyItem", method = RequestMethod.POST)
	public String adminPage(@Valid @ModelAttribute("user") User user,
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
	
	@RequestMapping(value = "/deleteItem", method = RequestMethod.GET)
	public String deleteItem(@RequestParam Map<String, String> params, Model model) {

		User loggedUser = (User) model.asMap().get("user");

		if (loggedUser == null) {
			return "redirect:index.html";
		}

		Item item = astaService.findItemById(Integer.parseInt((String)params.get("itemid")));
		astaService.deleteItem(item);
		List<Item> itemList = astaService.findAllItem();
		model.addAttribute("itemlist", itemList);
		return "adminPage";
	}

}