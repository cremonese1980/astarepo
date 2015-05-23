package it.astaweb.repository;

import it.astaweb.model.Item;
import it.astaweb.model.ItemImage;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository("itemRepository")
public interface ItemRepository extends JpaRepository<Item, Integer> {

  @Query("select i from Item i where i.name = :name")
  Item findByName(@Param("name") String name);
  
  @Query("select * from Item ")
  List<Item> findAll();
  
}

