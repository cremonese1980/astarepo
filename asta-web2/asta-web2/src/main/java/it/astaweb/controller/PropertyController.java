package it.astaweb.controller;

import it.astaweb.model.Configuration;
import it.astaweb.model.User;
import it.astaweb.repository.ConfigurationRepository;
import it.astaweb.service.PropertyService;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes("user")
public class PropertyController {

	@Autowired(required = true)
	private PropertyService propertyService;
	
	@Autowired(required = true)
	private ConfigurationRepository configurationRepository;


	@RequestMapping(value = "/refreshProperties", method = RequestMethod.GET)
	public String refreshProperties(Model model) {

		User loggedUser = (User) model.asMap().get("user");
		if (loggedUser == null) {
			return "redirect:index.html";
		}

		List<Configuration> configurations = configurationRepository.findAll();
		model.addAttribute("configurations", configurations);
		
		Map<String, String> properties = propertyService.getProperties();
		
		List<String> printProperties = new ArrayList<String>();
		
		for (Iterator<String> iterator = properties.keySet().iterator(); iterator.hasNext();) {
			String key = iterator.next();
			printProperties.add(key + "=" + properties.get(key));
			
		}
		model.addAttribute("printProperties", printProperties);
		
		
		propertyService.refresh();
		
		properties = propertyService.getProperties();
		
		printProperties = new ArrayList<String>();
		
		for (Iterator<String> iterator = properties.keySet().iterator(); iterator.hasNext();) {
			String key = iterator.next();
			printProperties.add(key + "=" + properties.get(key));
			
		}
		model.addAttribute("printRefreshedProperties", printProperties);

		return "refreshProperties";
	}

	@RequestMapping(value = "/updateProperty", method = RequestMethod.GET)
	public String modifyItem(@RequestParam Map<String, String> params, Model model) {

		User loggedUser = (User) model.asMap().get("user");

		if (loggedUser == null) {
			return "redirect:index.html";
		}

		Configuration configuration = configurationRepository.findOne((String)params.get("propertyname"));
		model.addAttribute("configuration", configuration);
		
		return "updateProperty";
	}

	@RequestMapping(value = "/updateProperty", method = RequestMethod.POST)
	public String modifyItem(@Valid @ModelAttribute("configuration") Configuration configuration,
			BindingResult result, Model model) {
		if (result.hasErrors()) {
			return "refreshProperties";
		}
		User loggedUser = (User) model.asMap().get("user");

		if (loggedUser == null) {
			return "redirect:index.html";
		}
		
		configurationRepository.save(configuration);
		
		return "redirect:refreshProperties.html";
	}


}