package it.astaweb.repository;

import it.astaweb.model.Configuration;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository("configurationRepository")
public interface ConfigurationRepository extends JpaRepository<Configuration, String> {

  
}

