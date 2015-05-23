package it.astaweb.repository;

import it.astaweb.model.ItemImage;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository("itemImageRepository")
public interface ItemImageRepository extends JpaRepository<ItemImage, Integer> {

  @Query("select img from ItemImage img where item.id= :idItem")
  List<ItemImage> findAllImagesByItem(Integer idItem);
  
}

