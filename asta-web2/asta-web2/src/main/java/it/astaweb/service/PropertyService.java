package it.astaweb.service;

import java.util.Map;

public interface PropertyService {

	String getValue(String key);
	
	void refresh();
	
	Map<String, String> getProperties();
	
}
