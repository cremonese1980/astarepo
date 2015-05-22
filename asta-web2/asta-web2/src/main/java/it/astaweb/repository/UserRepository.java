package it.astaweb.repository;

import it.astaweb.model.User;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository("userRepository")
public interface UserRepository extends JpaRepository<User, String> {

  @Query("select u from User u where u.username = :username")
  User findByUsername(@Param("username") String username);
  
}

