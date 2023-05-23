package com.alex.BugTrackingSystem.controllers;

import java.security.Principal;
import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import com.alex.BugTrackingSystem.models.User;
import com.alex.BugTrackingSystem.services.UserService;

@Controller
public class AdminController {

	private UserService userService;

	public AdminController(UserService userService) {
		this.userService = userService;
	}

	@GetMapping("/adminRegistration")
	public String adminRegister(@ModelAttribute("user") User user) {
		return "registerAdminPage.jsp";
	}

	@PostMapping("/adminRegistration")
	public String adminRegistration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model) {
		if (result.hasErrors()) {

			return "registerAdminPage.jsp";
		}
		userService.saveUserWithAdminRole(user, result);
		return "redirect:/";
	}

	@GetMapping("/users")
	public String adminPage(Principal principle, Model model) {
		String username = principle.getName();

		model.addAttribute("currentUser", userService.findByUsername(username));
		model.addAttribute("users", userService.allUsers());
		return "adminUsersPage.jsp";
	}

	@DeleteMapping("/delete/user/{id}")
	public String deleteUser(@PathVariable("id") Long id, Principal principal) {
		User user = userService.findById(id);
		userService.deleteUser(user);
		return "redirect:/users";
	}

}
