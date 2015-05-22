package it.astaweb.service;

import it.astaweb.model.User;

public interface UserService {
	User findByUsername(String username);

	void update(User userFound);
}
