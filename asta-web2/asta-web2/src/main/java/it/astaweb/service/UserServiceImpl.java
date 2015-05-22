package it.astaweb.service;

import it.astaweb.model.User;
import it.astaweb.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired(required = true)
	private UserRepository userRepository;

	public User findByUsername(String username) {
		User user = userRepository.findByUsername(username);

		return user;
	}

	@Override
	@Transactional
	public void update(User userFound) {
		userRepository.saveAndFlush(userFound);

	}

}
