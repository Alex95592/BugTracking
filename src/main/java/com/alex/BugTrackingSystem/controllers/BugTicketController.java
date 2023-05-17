package com.alex.BugTrackingSystem.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.alex.BugTrackingSystem.models.BugTicket;
import com.alex.BugTrackingSystem.models.User;
import com.alex.BugTrackingSystem.services.BugTicketService;
import com.alex.BugTrackingSystem.services.UserService;

@Controller
public class BugTicketController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private BugTicketService ticketService;
	
	@GetMapping("/dashboard")
	public String dashboard(Model model, HttpSession session) {
		if(session.getAttribute("userId")==null) {
			return "redirect:/";
		}else {
			Long userId = (Long) session.getAttribute("userId");
			User user = userService.findById(userId);
			
			List<BugTicket> bugTickets =ticketService.findAllTickets();
			
			model.addAttribute("user", user);
			model.addAttribute("bugTickets", bugTickets);
			return "dashboard.jsp";
		}
	}
	@GetMapping("/ticket/{id}")
	public String ticketInfo(@PathVariable("id") Long id, HttpSession session, Model model) {
		if(session.getAttribute("userId")==null) {
			return "redirect:/";
		}
		BugTicket bugTicket = ticketService.findById(id);
		model.addAttribute("bugTicket", bugTicket);
		return "ticketInfo.jsp";
	}
	
	@GetMapping("/newTicket")
	public String newTicket(@ModelAttribute("newTicket") BugTicket newTicket, Model model, HttpSession session) {
		if(session.getAttribute("userId")==null) {
			return "redirect:/";
		}else {
			Long userId = (Long) session.getAttribute("userId");
			User user = userService.findById(userId);
			model.addAttribute("user", user);
			return "newTicket.jsp";
		}
	}
	
	@PostMapping("/createTicket")
	public String createTicket(@Valid @ModelAttribute("newTicket") BugTicket newTicket, BindingResult result, Model model, HttpSession session){
		if(session.getAttribute("userId")==null) {
			return "redirect:/";
		}
		if(result.hasErrors()) {
			return "newTicket.jsp";
		}else {
			Long userId = (Long) session.getAttribute("userId");
			User user = userService.findById(userId);
			ticketService.createTicket(newTicket);
			BugTicket bugTicket = ticketService.findById(newTicket.getId());
			user.getBugTickets().add(bugTicket);
			userService.updateUser(user);
			ticketService.updateTicket(bugTicket);
			return "redirect:/dashboard";
		}
	}
}
