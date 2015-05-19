package it.astaweb.service;

import it.astaweb.model.Student;

public interface StudentService {
	  Student save(Student student);
	  boolean findByLogin(String userName, String password);
	  boolean findByUserName(String userName);
	}
