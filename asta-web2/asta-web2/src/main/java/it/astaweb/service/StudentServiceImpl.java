package it.astaweb.service;

import it.astaweb.model.Student;
import it.astaweb.repository.StudentRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("studentService")
public class StudentServiceImpl implements StudentService{

  @Autowired(required=true)
  private StudentRepository studentRepository;

  @Transactional
  public Student save(Student student) {
      return studentRepository.save(student);
  }

  public boolean findByLogin(String userName, String password) {  
      Student stud = studentRepository.findByUserName(userName);

      if(stud != null && stud.getPassword().equals(password)) {
          return true;
      } 

      return false;       
  }

  public boolean findByUserName(String userName) {
      Student stud = studentRepository.findByUserName(userName);

      if(stud != null) {
          return true;
      }

      return false;
  }

}
