package it.astaweb.repository;

import it.astaweb.model.Item;
import it.astaweb.utils.ItemStatus;

import java.math.BigDecimal;
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

	@Query("select i from Item i LEFT JOIN FETCH i.images where i.id = (:id)")
	Item findByIdAndFetchImages(@Param("id") Integer id);

	@Query("from Item i where i.status = (:status) order by expiringDate asc")
	List<Item> findAllByStatus(@Param("status") ItemStatus status);

	@Query("select distinct i from Item i JOIN FETCH i.images img where i.status = (:status) order by i.expiringDate asc")
	List<Item> findAllByStatusJoinImages(@Param("status") ItemStatus status);

	@Query("select sum(bestRelaunch) from Item")
	BigDecimal getTotalOffer();

	@Query("select distinct i  from Item i LEFT JOIN FETCH i.images LEFT JOIN FETCH i.relaunches where i.id = (:id)")
	Item findByIdAndFetchImagesFetchRelaunches(@Param("id") Integer id);

}
