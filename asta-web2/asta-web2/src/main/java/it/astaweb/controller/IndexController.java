package it.astaweb.controller;

import java.util.List;

import it.astaweb.model.Item;
import it.astaweb.model.Student;
import it.astaweb.model.StudentLogin;
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
@SessionAttributes("itemlist")
public class IndexController {

  @Autowired(required=true)
  private AstaService astaService;

  @RequestMapping(value="/index", method=RequestMethod.GET)
  public String itemList(Model model) {
//      List<Item> itemList = astaService.findAllItem();        
//      model.addAttribute("itemlist", itemList);    
      return "index";
  }

  @RequestMapping(value="/index", method=RequestMethod.POST)
  public String itemList(@Valid @ModelAttribute("item") Item item, BindingResult result, Model model) {   
	  
	  
//      if(result.hasErrors()) {
          return "index";
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
}
