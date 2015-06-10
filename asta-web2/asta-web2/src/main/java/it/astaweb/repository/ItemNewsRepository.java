package it.astaweb.repository;

import it.astaweb.model.ItemNews;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository("itemNewsRepository")
public interface ItemNewsRepository extends JpaRepository<ItemNews, Integer> {

	@Query("select i from ItemNews i where i.item.id= ?1")
	ItemNews findNewsByItem(Integer idItem);
	
	@Query("delete from ItemNews where item.id= ?1")
	void deleteByItem(Integer idItem);

}
