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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

	@GetMapping("/account/{username}")
	public String account(@PathVariable("username")String username, @RequestParam(name = "searchOption", required = false) String searchOption, @RequestParam(name = "query", required = false) String query, Principal principal, Model model) {
		User user = userService.findByUsername(username);
		List<BugTicket> reportedTickets = user.getBugTickets();
		List<BugTicket> assignedTickets = ticketService.onlyAssignedTickets(user);
		model.addAttribute("currentUser", user);
		if (query != null) {
			System.out.println("lol");
			model.addAttribute("reportedTickets", ticketService.searchNames(query,reportedTickets));
			model.addAttribute("assignedTickets", ticketService.searchNames(query,assignedTickets));
		}else if (searchOption != null) {
			model.addAttribute("assignedTickets", ticketService.sortBy(assignedTickets, searchOption));
			model.addAttribute("reportedTickets", ticketService.sortBy(reportedTickets, searchOption));
		} else {
			
			model.addAttribute("reportedTickets", reportedTickets);
			model.addAttribute("assignedTickets", assignedTickets);
		}
		return "account.jsp";
		
	}

	@GetMapping("/ticket/{id}")
	public String ticketInfo(@PathVariable("id") Long id, Principal principal, Model model) {
		String username=principal.getName();
		User user = userService.findByUsername(username);
		BugTicket bugTicket = ticketService.findById(id);
		List<User> users = userService.allUsers();
		model.addAttribute("bugTicket", bugTicket);
		model.addAttribute("allUsers", users);
		model.addAttribute("currentUser",user);
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
		userService.updateUser(user);
		ticketService.updateTicket(bugTicket);
		return "redirect:/";

	}
	@RequestMapping(value="/ticket/{id}", method=RequestMethod.PUT)
	public String update(@Valid @ModelAttribute("bugTicket") BugTicket bugTicket, BindingResult result) {
		if(result.hasErrors()) {
			return "ticketInfo.jsp";
		}
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
