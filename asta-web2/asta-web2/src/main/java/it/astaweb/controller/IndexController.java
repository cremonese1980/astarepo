package it.astaweb.controller;

import java.util.List;

import it.astaweb.model.Item;
import it.astaweb.model.Student;
import it.astaweb.model.StudentLogin;
import it.astaweb.model.User;
import it.astaweb.service.AstaService;

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
@SessionAttributes("user")
public class IndexController {

  @Autowired(required=true)
  private AstaService astaService;

  @RequestMapping(value="/index", method=RequestMethod.GET)
  public String itemList(Model model) {
      return "index";
  }

  @RequestMapping(value="/index", method=RequestMethod.POST)
  public String itemList(@Valid @ModelAttribute("item") Item item, BindingResult result, Model model) {   
	  
	  
          return "index";
  }

  @RequestMapping(value="/hello", method=RequestMethod.GET)
  public String hello(Model model) {          
      return "hello";
  }
  
  @RequestMapping(value="/wall", method=RequestMethod.GET)
  public String wall(Model model) {      
	  User loggedUser =  (User)model.asMap().get("user");
	  
	  if(loggedUser==null || loggedUser.getName()==null || loggedUser.getName().trim().equals("")){
		  return "redirect:loginUser.html";
	  }
      return "wall";
  }

}
