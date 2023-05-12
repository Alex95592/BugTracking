package com.alex.BugTrackingSystem.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alex.BugTrackingSystem.models.BugTicket;
import com.alex.BugTrackingSystem.repositories.BugTicketRepository;

@Service
public class BugTicketService {
	
	@Autowired
	private BugTicketRepository bugTicketRepository;
	
	public BugTicket findById(Long id) {
		Optional<BugTicket> potentialTicket = bugTicketRepository.findById(id);
		if(!potentialTicket.isPresent()) {
			return null;
		}else {
			return potentialTicket.get();
		}
	}
	
	public BugTicket createTicket(BugTicket bugTicket) {
		return bugTicketRepository.save(bugTicket);
	}
	public BugTicket updateTicket(BugTicket bugTicket) {
		return bugTicketRepository.save(bugTicket);
	}
	
	public List<BugTicket> findAllTickets(){
		return bugTicketRepository.findAll();
	}
	
	public void deleteTicket(BugTicket bugTicket) {
		bugTicketRepository.delete(bugTicket);
	}
	
}
