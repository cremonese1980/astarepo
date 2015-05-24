package it.astaweb.service;

import it.astaweb.model.Configuration;
import it.astaweb.repository.ConfigurationRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("configurationService")
public class ConfigurationServiceImpl implements ConfigurationService {

	@Autowired(required = true)
	private ConfigurationRepository configurationRepository;

	@Override
	public Configuration findByName(String propertyName) {
		return configurationRepository.findOne(propertyName);
	}

	@Override
	public List<Configuration> findAll() {
		return configurationRepository.findAll();
	}


}
