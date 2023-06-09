package com.alex.BugTrackingSystem.controllers;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import com.alex.BugTrackingSystem.models.BugTicket;
import com.alex.BugTrackingSystem.models.User;
import com.alex.BugTrackingSystem.services.UserService;

@Controller
public class AdminController {

	private UserService userService;

	public AdminController(UserService userService) {
		this.userService = userService;
	}
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@GetMapping("/adminRegistration")
	public String adminRegister(@ModelAttribute("user") User user) {
		return "registerAdminPage.jsp";
	}

	@PostMapping("/adminRegistration")
	public String adminRegistration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model) {
		if (result.hasErrors()) {

			return "registerAdminPage.jsp";
		}
		if (userService.saveUserWithAdminRole(user, result) != null) {
	        return "redirect:/login";
	    } else {
	        model.addAttribute("errorMessage", "Failed to save user.");
	        return "registerPage.jsp";
	    }
	}

	@GetMapping("/users")
	public String adminPage(Principal principle, Model model) {
		String username = principle.getName();

		model.addAttribute("currentUser", userService.findByUsername(username));
		model.addAttribute("users", userService.allUsers());
		return "adminUsersPage.jsp";
	}
	@GetMapping("/edit/user/{id}")
	public String editUser(@PathVariable("id") Long id, Principal principal, Model model) {
		model.addAttribute("user", userService.findById(id));
		return "editUser.jsp";
	}
	@PostMapping("/edit/user/{id}")
	public String updateUser(@PathVariable("id") Long id, @ModelAttribute("user") @Valid User user, BindingResult result, Model model) {
		if(result.hasErrors()) {
			System.out.println("Not working");
			List<String> errors = new ArrayList<>();
            for (FieldError error : result.getFieldErrors()) {
                errors.add(error.getDefaultMessage());
            }
            
            model.addAttribute("errors", errors);
			return "editUser.jsp";
		}
		User existingUser = userService.findById(id);
		existingUser.setUsername(user.getUsername());
		existingUser.setEmail(user.getEmail());
		String newPassword = user.getPassword();
		if (!user.getPassword().equals(user.getConfirmPassword())) {
			result.rejectValue("confirmPassword", null, "Password do not match.");
		}
		 if (!StringUtils.hasText(newPassword) || !passwordEncoder.matches(newPassword, existingUser.getPassword())) {
	            existingUser.setPassword(passwordEncoder.encode(newPassword));
	        }
		User updatedUser = userService.updateUser(existingUser);
		return "redirect:/";
	}

	@DeleteMapping("/delete/user/{id}")
	public String deleteUser(@PathVariable("id") Long id, Principal principal) {
		User user = userService.findById(id);
		userService.deleteUser(user);
		return "redirect:/users";
	}

}
