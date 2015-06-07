package it.astaweb.repository;

import it.astaweb.model.Relaunch;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository("relaunch")
public interface RelaunchRepository extends JpaRepository<Relaunch, Integer> {

  
  @Query("select * from relaunch ")
  List<Relaunch> findAll();

  @Query("from Relaunch r where r.item.id = (:idItem) order by r.amount desc")
  List<Relaunch> getRelaunchesByItem(@Param("idItem") Integer idItem);

  /*
   * TODO realunch by item, by user etc
   */

  
}

