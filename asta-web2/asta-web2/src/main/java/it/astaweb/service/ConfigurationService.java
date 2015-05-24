package it.astaweb.service;

import it.astaweb.model.Configuration;

import java.util.List;

public interface ConfigurationService {
	
	
	Configuration findByName(String propertyName);

	List<Configuration> findAll(); 
}
