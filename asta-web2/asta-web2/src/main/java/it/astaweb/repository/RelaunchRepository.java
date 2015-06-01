package it.astaweb.repository;

import it.astaweb.model.Relaunch;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository("relaunch")
public interface RelaunchRepository extends JpaRepository<Relaunch, Integer> {

  
  @Query("select * from relaunch ")
  List<Relaunch> findAll();

  /*
   * TODO realunch by item, by user etc
   */

  
}

