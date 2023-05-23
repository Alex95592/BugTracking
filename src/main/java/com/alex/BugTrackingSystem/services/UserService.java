package com.alex.BugTrackingSystem.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.alex.BugTrackingSystem.models.User;
import com.alex.BugTrackingSystem.repositories.RoleRepository;
import com.alex.BugTrackingSystem.repositories.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private RoleRepository roleRepository;
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	public User findById(Long id) {
		Optional<User> potentialUser = userRepository.findById(id);
		if (!potentialUser.isPresent()) {
			return null;
		} else {
			return potentialUser.get();
		}
	}

	public List<User> allUsers() {
		return userRepository.findAll();
	}

	public User updateUser(User user) {
		return userRepository.save(user);
	}

	public void deleteUser(User user) {
		userRepository.delete(user);
	}

	public User saveWithUserRole(User newUser, BindingResult result) {
		Optional<User> potentialUser = userRepository.findByEmail(newUser.getEmail());
		if (potentialUser.isPresent()) {
			result.rejectValue("email", null, "An account with this email already exists.");
		}
		if (!newUser.getPassword().equals(newUser.getConfirmPassword())) {
			result.rejectValue("confirmPassword", null, "Password do not match.");
		}
		if (result.hasErrors()) {
			return null;
		} else {
			newUser.setPassword(bCryptPasswordEncoder.encode(newUser.getPassword()));
			newUser.setRoles(roleRepository.findByName("ROLE_USER"));
			return userRepository.save(newUser);
		}
	}

	public User saveUserWithAdminRole(User newUser, BindingResult result) {
		Optional<User> potentialUser = userRepository.findByEmail(newUser.getEmail());
		if (potentialUser.isPresent()) {
			result.rejectValue("email", null, "An account with this email already exists.");
		}
		if (!newUser.getPassword().equals(newUser.getConfirmPassword())) {
			result.rejectValue("confirmPassword", null, "Password do not match.");
		}
		if (result.hasErrors()) {
			return null;
		} else {
			newUser.setPassword(bCryptPasswordEncoder.encode(newUser.getPassword()));
			newUser.setRoles(roleRepository.findByName("ROLE_ADMIN"));
			return userRepository.save(newUser);
		}
	}

	public User setUserAsAdmin(User user, BindingResult result) {
		user.setRoles(roleRepository.findByName("ROLE_ADMIN"));
		return userRepository.save(user);
	}

	public User findByUsername(String username) {
		return userRepository.findByUsername(username);

	}
}
