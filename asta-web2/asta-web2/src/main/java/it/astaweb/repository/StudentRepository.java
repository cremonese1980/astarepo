package it.astaweb.repository;

import it.astaweb.model.Student;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository("studentRepository")
public interface StudentRepository extends JpaRepository<Student, Long> {

  @Query("select s from Student s where s.userName = :userName")
  Student findByUserName(@Param("userName") String userName);
  
}

