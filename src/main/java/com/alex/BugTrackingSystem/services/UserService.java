package com.alex.BugTrackingSystem.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.alex.BugTrackingSystem.models.LoginUser;
import com.alex.BugTrackingSystem.models.User;
import com.alex.BugTrackingSystem.repositories.UserRepository;

@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepository;
	
	public User findById(Long id) {
		Optional<User> potentialUser = userRepository.findById(id);
		if(!potentialUser.isPresent()) {
			return null;
		}else {
			return potentialUser.get();
		}
	}
	
	public List<User> allUsers(){
		return userRepository.findAll();
	}
	
	public User updateUser(User user) {
		return userRepository.save(user);
	}
	
	public User register(User newUser, BindingResult result) {
		Optional<User> potentialUser = userRepository.findByEmail(newUser.getEmail());
		if(potentialUser.isPresent()) {
			result.rejectValue("email", null, "An account with this email already exists.");
		}
		if(!newUser.getPassword().equals(newUser.getConfirmPassword())) {
			result.rejectValue("confirmPassword", null, "Password do not match.");
		}
		if(result.hasErrors()) {
			return null;
		}else {
			String hashPassword = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
			newUser.setPassword(hashPassword);
			return userRepository.save(newUser);
		}
	}
	public User login(LoginUser newLogin, BindingResult result) {
		Optional<User> potentialUser = userRepository.findByEmail(newLogin.getEmail());
		if(!potentialUser.isPresent()) {
			result.rejectValue("email", "Matches", "User not found");
			return null;
		}
		User user = potentialUser.get();
		
		if(!BCrypt.checkpw(newLogin.getPassword(), user.getPassword())) {
			result.rejectValue("password", "Matches", "Invalid Password!");
		}
		if(result.hasErrors()) {
			return null;
		}
		return user;
	}
}
