package it.astaweb.controller;

import it.astaweb.exceptions.ObjectExpiredException;
import it.astaweb.model.Item;
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
import java.util.Date;
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

@Controller
@SessionAttributes({"user",})
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
	  if(loggedUser!=null && loggedUser.getName()!=null && !loggedUser.getName().trim().equals("")){
		  model.addAttribute("user", loggedUser);
    	  return "redirect:itemlist.html";
      }
	  loggedUser = new User();
      model.addAttribute("user", loggedUser);     
      return "loginUser";
  }

  @RequestMapping(value="/loginUser", method=RequestMethod.POST)
  public String loginUser(@Valid @ModelAttribute("user") User user, BindingResult result, Model model) {        
      if(result.hasErrors()) {
          return "loginUser";
      } 
      if(user.getName() == null || user.getName().trim().equals("")) {
          model.addAttribute("nameMessage", "Inerisci il tuo nome!");
          return "loginUser";
      } 
      if(user.getLastName() == null || user.getLastName().trim().equals("")){
          model.addAttribute("lastNameMessage", "Inerisci il tuo cognome!");
          return "loginUser";
      }
      if(user.getPassword() == null || user.getPassword().trim().equals("")){
          model.addAttribute("passwordMessage", "Inerisci la parola d'ordine!");
          return "loginUser";
      }
      readWords();
      
      if(!secretWords.contains(user.getPassword().trim().toLowerCase())){
    	  model.addAttribute("passwordMessage", "Parola d'ordine sbagliata, contatta astaweb.server@gmail.com");
          return "loginUser";
      }
      
      user.setLastName(user.getLastName().trim());
      user.setName(user.getName().trim());
      user.setPassword(user.getPassword().trim().toLowerCase());
      
      List<Item> itemList = astaService.findAllItemByStatusJoinImages(ItemStatus.ON_SELL);        
      model.addAttribute("itemlist", itemList);
      model.addAttribute("user", user);  
      return "itemlist";
  }

  @RequestMapping(value="/itemlist", method=RequestMethod.GET)
  public String itemList(Model model) {
	  
	  User loggedUser =  (User)model.asMap().get("user");
	  
	  if(loggedUser==null || loggedUser.getName()==null || loggedUser.getName().trim().equals("")){
		  return "redirect:loginUser.html";
	  }
      List<Item> itemList = astaService.findAllItemByStatusJoinImages(ItemStatus.ON_SELL);        
      model.addAttribute("itemlist", itemList);
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
		Item item = (Item)model.asMap().get("item");

		if (loggedUser==null || loggedUser.getName()==null || loggedUser.getName().trim().equals("")) {
			return "redirect:loginUser.html";
		}
		String username = loggedUser != null && loggedUser.getName()!=null
				&& !loggedUser.getName().trim().equals("") ? loggedUser
				.getName() + " " + loggedUser.getLastName() : null;

							
		item = item!=null? item: astaService.findItemByIdAndFetchImagesFetchRelaunches(Integer
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

		if (loggedUser==null || loggedUser.getName()==null || loggedUser.getName().trim().equals("")) {
			return "redirect:loginUser.html";
		}
		
		Item item = astaService.findItemByIdAndFetchImagesFetchRelaunches(relaunch.getItem().getId());
		relaunch.setItem(item);
		
		Date now = CalendarUtils.currentTimeInItaly();
		relaunch.setDate(now);
		
		Relaunch newRelaunch = new Relaunch();
		newRelaunch.setItem(relaunch.getItem());
		newRelaunch.setUsername(relaunch.getUsername());
		
		List<Relaunch> relaunches = new ArrayList<Relaunch>();
		relaunches.addAll(item.getRelaunches());
		
		Collections.sort(relaunches);
		Relaunch bestRelaunch = relaunches.isEmpty()? new Relaunch(): relaunches.get(0);

		model.addAttribute("item", relaunch.getItem());
		model.addAttribute("user", loggedUser);
		model.addAttribute("newRelaunch", newRelaunch);
		model.addAttribute("bestRelaunch", bestRelaunch);
		
		if(!validateRelaunch(relaunch, model)){
			return "relaunchItem";
		}
		
		try {
			astaService.relaunch(relaunch);
			model.addAttribute("bestRelaunch", relaunch);
		} catch (ObjectExpiredException e) {
			model.addAttribute("relaunchMessage", e.getMessage());
			return "relaunchItem";
		}
		
		


		return "redirect:relaunchItem.html?itemid=" + relaunch.getItem().getId();
	}

  
  private boolean validateRelaunch(Relaunch relaunch, Model model) {
		
	  if(relaunch.getDate().getTime()>relaunch.getItem().getExpiringDate().getTime()){
		  model.addAttribute("relaunchMessage", "Asta terminata!");
		  return false;
	  }
	  if(relaunch.getAmount()==null || relaunch.getAmount().longValue() < relaunch.getItem().getBaseAuctionPrice().longValue()){
		  model.addAttribute("relaunchMessage", "L'offerta minima è di &euro; " + relaunch.getItem().getBaseAuctionPrice().longValue());
		  return false;
	  }
	  
	  if(relaunch.getItem().getBestRelaunch()!=null){
		  
		  if(relaunch.getAmount().longValue() < 1 + relaunch.getItem().getBestRelaunch().longValue()){
			  model.addAttribute("relaunchMessage",
					  "Il rilancio minimo è di &euro; 1 in più rispetto all'offerta corrente di &euro;  "
							  + relaunch.getItem().getBestRelaunch()
							  .longValue());
			  return false;
		  }
	  }
	  
	  
	  
	  return true;
		
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
