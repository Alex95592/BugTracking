package com.alex.BugTrackingSystem.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.alex.BugTrackingSystem.models.LoginUser;
import com.alex.BugTrackingSystem.models.User;
import com.alex.BugTrackingSystem.services.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	@GetMapping("/")
	public String index(Model model, HttpSession session) {
		session.setAttribute("userId", null);
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "login_register.jsp";
		
	}
	
	@PostMapping("/loginUser")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model, HttpSession session) {
		User user = userService.login(newLogin, result);
		if(result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "login_register.jsp";
		}else {
			session.setAttribute("userId", user.getId());
			System.out.println(user.getEmail());
			return "redirect:/dashboard";
		}
	}
	@PostMapping("/registerUser")
	public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model, HttpSession session) {
		User user = userService.register(newUser, result);
		if(user == null) {
			model.addAttribute("newLogin", new LoginUser());
			return "login_register.jsp";
		}else {
			session.setAttribute("userId", user.getId());
			System.out.println(user.getEmail());
			return "redirect:/dashboard";
		}
	}
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.setAttribute("userId", null);
		return "redirect:/";
	}
}
