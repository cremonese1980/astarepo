package it.astaweb.controller;

import it.astaweb.exceptions.ObjectExpiredException;
import it.astaweb.model.Item;
import it.astaweb.model.Relaunch;
import it.astaweb.model.User;
import it.astaweb.model.UserObserver;
import it.astaweb.service.AstaService;
import it.astaweb.service.ObserveService;
import it.astaweb.service.PropertyService;
import it.astaweb.service.UserService;
import it.astaweb.utils.CalendarUtils;
import it.astaweb.utils.Constants;
import it.astaweb.utils.ItemStatus;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
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
@SessionAttributes({"user", "userObserver"})
public class AstaController {
	
	private static final String DATE_PATTERN = "dd/MM/yyyy HH:mm:ss";

  @Autowired(required=true)
  private AstaService astaService;
  
  @Autowired(required=true)
  private UserService userService;
  
  @Autowired(required=true)
  PropertyService propertyService;
  
  @Autowired(required=true)
  ObserveService observeService;
  
  private static List<String> secretWords;
  
  private static final ThreadLocal<DateFormat> df = new ThreadLocal<DateFormat>(){
	    @Override
	    protected DateFormat initialValue() {
	        return new SimpleDateFormat(DATE_PATTERN);
	    }
	  };
	  
	  private static final ThreadLocal<DecimalFormat> decimalFormat = new ThreadLocal<DecimalFormat>(){
		    @Override
		    protected DecimalFormat initialValue() {
		        return new DecimalFormat();
		    }
		  };
	  

	  
  
  @PostConstruct
  public void init(){
	  System.out.println("Asta controller inizializzato");
	  decimalFormat.get().setMaximumFractionDigits(2);
	  decimalFormat.get().setMinimumFractionDigits(0);
  }
  
  @RequestMapping(value="/sendCode", method=RequestMethod.GET)
  public String sendCode(@RequestParam Map<String, String> params, Model model) {
	  
//	  User loggedUser =  (User)model.asMap().get("user");
//	  if(loggedUser!=null && loggedUser.getName()!=null && !loggedUser.getName().trim().equals("")){
//		  model.addAttribute("user", loggedUser);
//    	  return "redirect:itemlist.html";
//      }
//	  loggedUser = new User();
//      model.addAttribute("user", loggedUser);  
	  
	  String email = (String) params.get("email");
	  String itemid = (String) params.get("itemid");
	  
	  System.out.println("email " + email);
	  System.out.println("itemid " + itemid);
	  
	  String observeMessage = observeService.sendCode(itemid, email);
	  String statusCode = observeMessage.equals("ok") ? observeMessage : "ko";
	  observeMessage = observeMessage.equals("ok") ? "Codice Verifica inviato a " + email : observeMessage;
	  
	  model.addAttribute("statusMessage", observeMessage);
	  model.addAttribute("statusCode", statusCode);
	  
      return "sendCode";
  }
  
  @RequestMapping(value="/observeItem", method=RequestMethod.GET)
 	public String observeItem(@RequestParam Map<String, String> params, Model model) {

 		 String email = (String) params.get("email");
 		 String itemid = (String) params.get("itemid");
 		 String code = (String) params.get("code");
 		  
 		 System.out.println("Verificando il codice  " + code + " per l'email " + email + " per l'item con id  " + itemid);
 		  System.out.println("email " + email);
 		  System.out.println("itemid " + itemid);
 		
 		String observeMessage = observeService.observe(itemid, email, code);
 		String statusCode = observeMessage.equals("ok") ? observeMessage : "ko";
 		observeMessage = observeMessage.equals("ok") ? "Da ora riceverai le notifiche riguardo questo articolo": observeMessage;

 		model.addAttribute("statusMessage", observeMessage);
 		model.addAttribute("statusCode", statusCode);

 		return "sendCode";
 	}
  
  @RequestMapping(value="/updateItem", method=RequestMethod.GET)
	public String updateItem(@RequestParam Map<String, String> params,
			Model model) {

		String itemid = (String) params.get("itemid");
		String nowDateString = (String) params.get("nowDate");
		long clientTime = Long.parseLong(nowDateString);

//		System.out.println("Verificando aggiornamenti per l'item  " + itemid);
//		System.out.println("Now date " + nowDateString);

		Item item = astaService.findItemById(Integer.parseInt(itemid));
		
		boolean newRelaunch = item.getBestRelaunch()!=null&&
				item.getBestRelaunch().getAmount()!=null &&
						item.getBestRelaunch().getAmount().longValue()>0
								&& item.getBestRelaunch().getDate().getTime()>clientTime?
										true:false;
						
		String message = "";
								
		if(newRelaunch){
			Long expiringSeconds = (item.getExpiringDate().getTime() - CalendarUtils.currentTimeInItaly().getTime())/1000;
			if(expiringSeconds<=0){
				expiringSeconds = 0L;
			}
			
			System.out.println(expiringSeconds);

			model.addAttribute("item", item);
			model.addAttribute("expiringSeconds", expiringSeconds);
			model.addAttribute("username", item.getBestRelaunch().getUsername());
			model.addAttribute("amount", decimalFormat.get().format(item.getBestRelaunch().getAmount()));
			model.addAttribute("date", df.get().format(item.getBestRelaunch().getDate()));
			model.addAttribute("expiringDate", df.get().format(item.getExpiringDate()));
			
			message = "Attenzione, &egrave; stato effettuato un rilancio da " + item.getBestRelaunch().getUsername()
					+" di &euro; " + item.getBestRelaunch().getAmount() + " in data " + df.get().format(item.getBestRelaunch().getDate()
					) ;
		}


		model.addAttribute("itemMessage", message);

		return "itemUpdateResult";
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
		model.addAttribute("relaunches", relaunches);
		model.addAttribute("expiringSeconds", expiringSeconds);
		
		UserObserver userObserver = new UserObserver(loggedUser, item, relaunches, expiringSeconds);
		model.addAttribute("userObserver", userObserver);
		
		String relaunchMessage = (String) params.get("relaunchMessage");
		if(relaunchMessage !=  null && !relaunchMessage.trim().equals("")){
			model.addAttribute("relaunchMessage", "Formato non valido. Usa il punto come separatore dei decimali");
		}

		return "relaunchItem";
	}

	@Transactional
	@RequestMapping(value = "/relaunchItem", method = RequestMethod.POST)
	public String relaunchItem(@Valid @ModelAttribute("relaunch") Relaunch relaunch,
			BindingResult result, Model model) 
					 {
		if (result.hasErrors()) {
			return "redirect:relaunchItem.html?itemid=" + relaunch.getItem().getId() + "&relaunchMessage=formatException";
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

		model.addAttribute("item", relaunch.getItem());
		model.addAttribute("user", loggedUser);
		model.addAttribute("newRelaunch", newRelaunch);
		
		if(!validateRelaunch(relaunch, model)){
			return "relaunchItem";
		}
		
		try {
			astaService.relaunch(relaunch);
		} catch (ObjectExpiredException e) {
			model.addAttribute("relaunchMessage", e.getMessage());
			return "relaunchItem";
		}
		
		


		return "redirect:relaunchItem.html?itemid=" + relaunch.getItem().getId();
	}
	
	 @RequestMapping(value="/results", method=RequestMethod.GET)
	  public String results(Model model) {
		  
		  User loggedUser =  (User)model.asMap().get("user");
		  
		  if(loggedUser==null || loggedUser.getName()==null || loggedUser.getName().trim().equals("")){
			  return "redirect:loginUser.html";
		  }
	      List<Item> itemList = astaService.findAllItemByStatusJoinImages(ItemStatus.SOLD_OUT);        
	      model.addAttribute("itemlist", itemList);
	      model.addAttribute("user", loggedUser);
	      return "results";
	  }

	
	 
  
  private boolean validateRelaunch(Relaunch relaunch, Model model) {
		
	  if(relaunch.getDate().getTime()>relaunch.getItem().getExpiringDate().getTime()){
		  model.addAttribute("relaunchMessage", "Asta terminata!");
		  return false;
	  }
	  if(relaunch.getAmount()==null || relaunch.getAmount().doubleValue() < relaunch.getItem().getBaseAuctionPrice().doubleValue()){
		  model.addAttribute("relaunchMessage", "L'offerta minima è di &euro; " + relaunch.getItem().getBaseAuctionPrice().longValue());
		  return false;
	  }
	  
	  	int noRelaunches = relaunch.getItem().getBestRelaunch()!=null &&relaunch.getItem().getBestRelaunch().getAmount()!=null? 1:0;
	  
		Relaunch current = relaunch.getItem().getBestRelaunch() != null && relaunch.getItem().getBestRelaunch().getAmount()!=null? relaunch
				.getItem().getBestRelaunch() : new Relaunch(relaunch.getItem()
						.getBaseAuctionPrice()) ;

		if (relaunch.getAmount().doubleValue() < noRelaunches + current.getAmount().doubleValue()) {
			String message = "Il rilancio minimo è pari alla base d'asta";
			if(noRelaunches==1){
				message = "Il rilancio minimo è di &euro; 1 in più rispetto  all'offerta corrente di &euro; " + current.getAmount();
			}
					
			model.addAttribute("relaunchMessage", message);
			return false;
		}
		BigDecimal maxAbs = new BigDecimal(
				propertyService.getValue(Constants.PROPERTY_RELAUNCH_MAX_ABS
						.getValue()));
		if (relaunch.getAmount().compareTo(maxAbs.add(current.getAmount())) >= 1) {
			model.addAttribute(
					"relaunchMessage",
					"Il rilancio massimo è di &euro; "
							+ maxAbs
							+ " in più rispetto all'offerta corrente di &euro;  "
							+ relaunch.getItem().getBestRelaunch().getAmount());
			return false;
		}

		BigDecimal maxRel = new BigDecimal(
				propertyService.getValue(Constants.PROPERTY_RELAUNCH_MAX_REL
						.getValue()));
		if (relaunch.getAmount().compareTo(maxRel.multiply(current.getAmount())) >= 1) {
			model.addAttribute(
					"relaunchMessage",
					"Il rilancio massimo è di "
							+ maxRel
							+ " volte superiore rispetto all'offerta corrente di &euro;  "
							+ relaunch.getItem().getBestRelaunch().getAmount());
			return false;
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
