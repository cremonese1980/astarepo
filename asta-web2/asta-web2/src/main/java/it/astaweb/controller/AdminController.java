package it.astaweb.controller;

import it.astaweb.model.Item;
import it.astaweb.model.User;
import it.astaweb.service.AstaService;
import it.astaweb.service.UserService;
import it.astaweb.utils.CalendarUtils;
import it.astaweb.utils.UserType;

import java.util.List;

import javax.validation.Valid;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;



@Controller
@SessionAttributes("user")
public class AdminController {
	
	private static final Log LOG = LogFactory.getLog(AdminController.class);

  @Autowired(required=true)
  private UserService userService;
  
  @Autowired(required=true)
  private AstaService astaService;

  @RequestMapping(value="/loginAdmin", method=RequestMethod.GET)
  public String loginAdmin(Model model) {
	  
	  User loggedUser =  (User)model.asMap().get("user");
	  if(loggedUser!=null && loggedUser.getType()!=UserType.USER){
		  model.addAttribute("user", loggedUser);
    	  return "redirect:adminPage.html";
      }
	  
	  if(loggedUser==null){
		  loggedUser = new User();
	  }
      model.addAttribute("user", loggedUser);     
      return "loginAdmin";
  }

  @RequestMapping(value="/loginAdmin", method=RequestMethod.POST)
  public String loginAdmin(@Valid @ModelAttribute("user") User user, BindingResult result, Model model) {        
      if(result.hasErrors()) {
          return "loginAdmin";
      } 
      User userFound = userService.findByUsername(user.getUsername()); 
      if(userFound == null) {
          model.addAttribute("userMessage", "Utente sconosciuto, ritenta.");
          result.addError(new ObjectError("user.username", "Utente sconosciuto, ritenta"));
          return "loginAdmin";
      } 
      if(!userFound.getPassword().equals(user.getPassword())){
          model.addAttribute("passwordMessage", "Password sbagliata, ritenta");
          result.addError(new ObjectError("user.password", "Password sbagliata, ritenta"));
          return "loginAdmin";
      }
      userFound.setLastLogin(CalendarUtils.currentTimeInItaly());
      userService.update(userFound);
      List<Item> itemList = astaService.findAllItem();        
      model.addAttribute("itemlist", itemList);   
      model.addAttribute("user", userFound);
      return "adminPage";
  }
  
  @RequestMapping(value="/logout", method=RequestMethod.GET)
  public String logout(Model model) {
	  
	  User loggedUser =  (User)model.asMap().get("user");
	  System.out.println("Logout user " + loggedUser);
	  loggedUser = new User();	  
      model.addAttribute("user", loggedUser);     
      return "index";
  }
  
  
  @RequestMapping(value="/adminPage", method=RequestMethod.GET)
  public String adminPage(Model model) {
      
	  User loggedUser =  (User)model.asMap().get("user");
      
      if(loggedUser==null || loggedUser.getType() == UserType.USER){
    	  return "redirect:loginAdmin.html";
      }
      List<Item> itemList = astaService.findAllItem();        
      model.addAttribute("itemlist", itemList);    
      return "adminPage";
  }

  @RequestMapping(value="/adminPage", method=RequestMethod.POST)
  public String adminPage(@Valid @ModelAttribute("user") User user, BindingResult result, Model model) {        
      if(result.hasErrors()) {
          return "loginAdmin";
      } 
      User userFound = userService.findByUsername(user.getUsername()); 
      if(userFound == null) {
          model.addAttribute("message", "Utente sconosciuto, ritenta.");
          return "loginAdmin";
      } 
      if(!userFound.getPassword().equals(user.getPassword())){
          model.addAttribute("message", "Password sbagliata, ritenta");
          return "loginAdmin";
      }
      List<Item> itemList = astaService.findAllItem();        
      model.addAttribute("itemlist", itemList);    
      return "adminPage";
//      return "redirect:login.html";
  }

  
}