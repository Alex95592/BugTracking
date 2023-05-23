package com.alex.BugTrackingSystem.controllers;

import java.security.Principal;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.alex.BugTrackingSystem.models.BugTicket;
import com.alex.BugTrackingSystem.models.User;
import com.alex.BugTrackingSystem.services.BugTicketService;
import com.alex.BugTrackingSystem.services.UserService;

@Controller
public class BugTicketController {

	@Autowired
	private UserService userService;

	private BugTicketService ticketService;

	public BugTicketController(BugTicketService ticketService) {
		this.ticketService = ticketService;
	}

	@GetMapping(value = { "/", "/home" })
	public String home(@RequestParam(name = "searchOption", required = false) String searchOption,
			@RequestParam(name = "query", required = false) String query, Principal principal, Model model) {
		String username = principal.getName();
		List<BugTicket> tickets = ticketService.findAllTickets();
		model.addAttribute("currentUser", userService.findByUsername(username));
		model.addAttribute("roles", userService.findByUsername(username).getRoles());
		if (query != null) {
			List<BugTicket> searchResults = ticketService.searchNames(query);
			model.addAttribute("bugTickets", searchResults);
		} else if (searchOption != null) {
			List<BugTicket> sortedTickets = ticketService.sortBy(tickets, searchOption);
			model.addAttribute("bugTickets", sortedTickets);
		} else {
			List<BugTicket> sortedTickets = ticketService.sortBy(tickets, "createdBy");
			model.addAttribute("bugTickets", sortedTickets);

		}

		return "dashboard.jsp";
	}

	@GetMapping("/account")
	public String account(Principal principal, Model model) {
		String username = principal.getName();
		User user = userService.findByUsername(username);
		List<BugTicket> reportedTickets = user.getBugTickets();
		model.addAttribute("currentUser", user);
		model.addAttribute("reportedTickets", reportedTickets);
		return "account.jsp";
	}

	@GetMapping("/ticket/{id}")
	public String ticketInfo(@PathVariable("id") Long id, Principal principal, Model model) {
		BugTicket bugTicket = ticketService.findById(id);
		model.addAttribute("bugTicket", bugTicket);
		return "ticketInfo.jsp";
	}

	@GetMapping("/newTicket")
	public String newTicket(Principal principal, @ModelAttribute("newTicket") BugTicket newTicket, Model model) {
		String username = principal.getName();
		List<User> users = userService.allUsers();
		model.addAttribute("user", userService.findByUsername(username));
		model.addAttribute("allUsers", users);
		return "newTicket.jsp";
	}

	@PostMapping("/newTicket")
	public String createTicket(@Valid @ModelAttribute("newTicket") BugTicket newTicket, BindingResult result,
			Principal principal, Model model) {
		if (result.hasErrors()) {

			return "newTicket.jsp";
		}
		String username = principal.getName();
		User user = userService.findByUsername(username);
		ticketService.createTicket(newTicket);
		BugTicket bugTicket = ticketService.findById(newTicket.getId());
		user.getBugTickets().add(bugTicket);
		userService.updateUser(user);
		ticketService.updateTicket(bugTicket);
		return "redirect:/";

	}

	@DeleteMapping("/delete/ticket/{id}")
	public String deleteTicket(@PathVariable("id") Long id, Principal principal) {
		System.out.println("before delete");

		BugTicket ticket = ticketService.findById(id);
		ticketService.deleteTicket(ticket);
		return "redirect:/";
	}
}
