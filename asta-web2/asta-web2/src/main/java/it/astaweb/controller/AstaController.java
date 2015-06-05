package it.astaweb.controller;

import it.astaweb.exceptions.ObjectExpiredException;
import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;
import it.astaweb.model.Player;
import it.astaweb.model.Relaunch;
import it.astaweb.model.User;
import it.astaweb.service.AstaService;
import it.astaweb.service.PropertyService;
import it.astaweb.service.UserService;
import it.astaweb.utils.CalendarUtils;
import it.astaweb.utils.Constants;
import it.astaweb.utils.ItemStatus;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.validation.Valid;

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
	  
	  User loggedUser =  (User)model.asMap().get("user");
	  if(loggedUser!=null){
		  Player player = new Player(loggedUser);
		  model.addAttribute("player", player);
    	  return "redirect:itemlist.html";
      }
	  
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
	  
	  User loggedUser =  (User)model.asMap().get("user");
	  Player loggedPlayer = (Player) model.asMap().get("player");
	  
	  if(loggedPlayer==null || loggedUser==null){
		  return "redirect:loginUser.html";
	  }
      List<Item> itemList = astaService.findAllItemByStatusJoinImages(ItemStatus.ON_SELL);        
      model.addAttribute("itemlist", itemList);
      model.addAttribute("player", loggedPlayer);
      model.addAttribute("user", loggedUser);
      return "itemlist";
  }

  @RequestMapping(value="/itemlist", method=RequestMethod.POST)
  public String itemList(@Valid @ModelAttribute("item") Item item, BindingResult result, Model model) {   
	  
          return "itemlist";
  }
  
  @RequestMapping(value = "/relaunchItem", method = RequestMethod.GET)
	public String itemPage(@RequestParam Map<String, String> params, Model model) {

		User loggedUser = (User) model.asMap().get("user");
		Player loggedPlayer = (Player) model.asMap().get("player");

		if (loggedPlayer == null || loggedUser == null) {
			return "redirect:loginUser.html";
		}
		String username = loggedUser != null
				&& !loggedUser.getName().trim().equals("") ? loggedUser
				.getName() + " " + loggedUser.getLastName() : 
					loggedPlayer != null
					&& !loggedPlayer.getName().trim().equals("")? 
							loggedPlayer
							.getName() + " " + loggedPlayer.getLastName(): null;

		Item item = astaService.findItemByIdAndFetchImagesFetchRelaunches(Integer
				.parseInt((String) params.get("itemid")));
		
		List<Relaunch> relaunches = new ArrayList<Relaunch>();
		relaunches.addAll(item.getRelaunches());
		
		Collections.sort(relaunches);
		Relaunch bestRelaunch = relaunches.isEmpty()? new Relaunch(): relaunches.get(0);
		
		Relaunch relaunch = new Relaunch();
		relaunch.setItem(item);
		relaunch.setUsername(username);
		
		Long expiringSeconds = (item.getExpiringDate().getTime() - CalendarUtils.currentTimeInItaly().getTime())/1000;
		if(expiringSeconds<=0){
			expiringSeconds = 0L;
		}

		model.addAttribute("item", item);
		model.addAttribute("player", loggedPlayer);
		model.addAttribute("user", loggedUser);
		model.addAttribute("relaunch", relaunch);
		model.addAttribute("bestRelaunch", bestRelaunch);
		model.addAttribute("relaunches", relaunches);
		model.addAttribute("expiringSeconds", expiringSeconds);

		return "relaunchItem";
	}

	@Transactional
	@RequestMapping(value = "/relaunchItem", method = RequestMethod.POST)
	public String relaunchItem(@Valid @ModelAttribute("relaunch") Relaunch relaunch,
			BindingResult result, Model model) 
					 {
		if (result.hasErrors()) {
			return "relaunchItem";
		}

		User loggedUser = (User) model.asMap().get("user");
		Player loggedPlayer = (Player) model.asMap().get("player");

		if (loggedPlayer == null || loggedUser == null) {
			return "redirect:loginUser.html";
		}
		
		Item item = astaService.findItemByIdAndFetchImages(relaunch.getItem().getId());
		relaunch.setItem(item);
		/*
		 * TODO controlli
		 */
		
		relaunch.setDate(CalendarUtils.currentTimeInItaly());
		try {
			astaService.relaunch(relaunch);
		} catch (ObjectExpiredException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Relaunch newRelaunch = new Relaunch();
		newRelaunch.setItem(relaunch.getItem());
		newRelaunch.setUsername(relaunch.getUsername());

		model.addAttribute("item", relaunch.getItem());
		model.addAttribute("player", loggedPlayer);
		model.addAttribute("user", loggedUser);
		model.addAttribute("newRelaunch", newRelaunch);


		return "redirect:relaunchItem.html?itemid=" + relaunch.getItem().getId();
	}

  
  private void readWords(){
	  secretWords = Arrays.asList(propertyService.getValue(Constants.PROPERTY_SECRET_WORDS.getValue()).split(","));
	  System.out.println("Parole segrete: " + secretWords);
  }
  
	public static void main(String[] args) {
		
		int diff = 5*24*60*60 - (7*60*60) - 50*60;
		
		int days = (diff / 86400) | 0;
		int hours =((diff- days*86400) / 3600) | 0;
        int minutes = ((diff - hours*3600 - days*86400) /60) | 0 ;
        int seconds = (diff % 60) | 0;
        
        System.out.println("diff " + diff);
        System.out.println("days " + days);
        System.out.println("hours " + hours);
        System.out.println("minutes " + minutes);
        System.out.println("seconds " + seconds);

	}
}
