package it.astaweb.service;

import it.astaweb.model.Configuration;
import it.astaweb.repository.ConfigurationRepository;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("propertyService")
public class PropertyServiceImpl implements PropertyService{
	
	private static Map<String, String> properties;
	
	@Autowired(required = true)
	private ConfigurationRepository configurationRepository;
	
	@PostConstruct
	public void init(){
		properties = new HashMap<String, String>();
		refresh();
	}

	@Override
	public String getValue(String key) {
		return properties.get(key);
	}

	@Override
	public void refresh() {
		if(configurationRepository==null){
			return;
		}
		List<Configuration> configurations = configurationRepository.findAll();
		
		properties.clear();
		
		for (Iterator<Configuration> iterator = configurations.iterator(); iterator.hasNext();) {
			Configuration configuration =  iterator.next();
			
			properties.put(configuration.getName(), configuration.getValue());
			
		}
		
	}

	@Override
	public Map<String, String> getProperties() {
		return properties;
	}

}
