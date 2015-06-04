package it.astaweb.controller;

import it.astaweb.model.Item;
import it.astaweb.model.Player;
import it.astaweb.service.AstaService;
import it.astaweb.service.PropertyService;
import it.astaweb.service.UserService;
import it.astaweb.utils.Constants;
import it.astaweb.utils.ItemStatus;

import java.util.Arrays;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes({"user", "player"})
public class AstaController {

  @Autowired(required=true)
  private AstaService astaService;
  
  @Autowired(required=true)
  private UserService userService;
  
  @Autowired(required=true)
  PropertyService propertyService;
  
  private static List<String> secretWords;
  
  @PostConstruct
  public void init(){
	  System.out.println("Asta controller inizializzato");
  }
  
  @RequestMapping(value="/loginUser", method=RequestMethod.GET)
  public String loginUser(Model model) {
      Player player = new Player();        
      model.addAttribute("player", player);     
      return "loginUser";
  }

  @RequestMapping(value="/loginUser", method=RequestMethod.POST)
  public String loginUser(@Valid @ModelAttribute("player") Player player, BindingResult result, Model model) {        
      if(result.hasErrors()) {
          return "loginUser";
      } 
      if(player.getName() == null || player.getName().trim().equals("")) {
          model.addAttribute("nameMessage", "Inerisci il tuo nome!");
          return "loginUser";
      } 
      if(player.getLastName() == null || player.getLastName().trim().equals("")){
          model.addAttribute("lastNameMessage", "Inerisci il tuo cognome!");
          return "loginUser";
      }
      if(player.getPassword() == null || player.getPassword().trim().equals("")){
          model.addAttribute("passwordMessage", "Inerisci la parola d'ordine!");
          return "loginUser";
      }
      readWords();
      
      if(!secretWords.contains(player.getPassword().trim().toLowerCase())){
    	  model.addAttribute("passwordMessage", "Parola d'ordine sbagliata, contatta astaweb.server@gmail.com");
          return "loginUser";
      }
      
      player.setLastName(player.getLastName().trim());
      player.setName(player.getName().trim());
      player.setPassword(player.getPassword().trim().toLowerCase());
      
      List<Item> itemList = astaService.findAllItemByStatusJoinImages(ItemStatus.ON_SELL);        
      model.addAttribute("itemlist", itemList);
      model.addAttribute("player", player);  
      return "itemlist";
  }

  @RequestMapping(value="/itemlist", method=RequestMethod.GET)
  public String itemList(Model model) {
	  System.out.println("Item List get");
	  
	  Player loggedPlayer = (Player) model.asMap().get("player");
	  
	  if(loggedPlayer==null || loggedPlayer.getPassword()==null){
		  return "redirect:loginUser.html";
	  }
      List<Item> itemList = astaService.findAllItemByStatusJoinImages(ItemStatus.ON_SELL);        
      model.addAttribute("itemlist", itemList);    
      System.out.println("Trovati " + itemList.size() + " oggetti");
      return "itemlist";
  }

  @RequestMapping(value="/itemlist", method=RequestMethod.POST)
  public String itemList(@Valid @ModelAttribute("item") Item item, BindingResult result, Model model) {   
	  
	  
//      if(result.hasErrors()) {
          return "itemlist";
//      } 
//      else if(astaService.findByUserName(student.getUserName())) {
//          model.addAttribute("message", "User Name exists. Try another user name");
//          return "signup";
//      } else {
//    	  astaService.save(student);
//          model.addAttribute("message", "Saved student details");
//          return "redirect:login.html";
//      }
  }

//  @RequestMapping(value="/login", method=RequestMethod.GET)
//  public String login(Model model) {          
//      StudentLogin studentLogin = new StudentLogin();     
//      model.addAttribute("studentLogin", studentLogin);
//      return "login";
//  }
//
//  @RequestMapping(value="/login", method=RequestMethod.POST)
//  public String login(@Valid @ModelAttribute("studentLogin") StudentLogin studentLogin, BindingResult result) {
////      if (result.hasErrors()) {
//          return "login";
////      } 
////      else {
////          boolean found = astaService.findByLogin(studentLogin.getUserName(), studentLogin.getPassword());
////          if (found) {                
////              return "success";
////          } else {                
////              return "failure";
////          }
////      }
//
//  }
  
  private void readWords(){
	  secretWords = Arrays.asList(propertyService.getValue(Constants.PROPERTY_SECRET_WORDS.getValue()).split(","));
	  System.out.println("Parole segrete: " + secretWords);
  }
}
