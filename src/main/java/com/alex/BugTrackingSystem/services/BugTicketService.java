package com.alex.BugTrackingSystem.services;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alex.BugTrackingSystem.models.BugTicket;
import com.alex.BugTrackingSystem.models.User;
import com.alex.BugTrackingSystem.repositories.BugTicketRepository;

@Service
public class BugTicketService {

	@Autowired
	private BugTicketRepository bugTicketRepository;

	public List<BugTicket> sortBy(List<BugTicket> tickets, String searchOption) {
		Comparator<BugTicket> dateComparator = new Comparator<BugTicket>() {
			@Override
			public int compare(BugTicket ticket1, BugTicket ticket2) {
				return ticket2.getCreatedDate().compareTo(ticket1.getCreatedDate());
			};
		};
		Comparator<BugTicket> dueDateComparator = new Comparator<BugTicket>() {
			@Override
			public int compare(BugTicket ticket1, BugTicket ticket2) {
				return ticket2.getDueDate().compareTo(ticket1.getDueDate());
			};
		};
		Comparator<BugTicket> nameComparator = new Comparator<BugTicket>() {
			@Override
			public int compare(BugTicket ticket1, BugTicket ticket2) {
				return ticket1.getName().compareTo(ticket2.getName());
			}
		};
		Comparator<BugTicket> importanceComparator = new Comparator<BugTicket>() {
			@Override
			public int compare(BugTicket ticket1, BugTicket ticket2) {
				String priority1 = ticket1.getImportance();
				String priority2 = ticket2.getImportance();

				if (priority1.equals("Immediate") && !priority2.equals("Immediate")) {
					return -1;
				} else if (priority2.equals("Immediate") && !priority1.equals("Immediate")) {
					return 1;
				} else if (priority1.equals("High") && priority2.equals("Medium")) {
					return -1;
				} else if (priority1.equals("Medium") && priority2.equals("High")) {
					return 1;
				} else if (priority1.equals("Medium") && priority2.equals("Low")) {
					return -1;
				} else if (priority1.equals("Low") && priority2.equals("Medium")) {
					return 1;
				} else if (priority1.equals("Low") && priority2.equals("None")) {
					return -1;
				} else if (priority1.equals("None") && priority2.equals("Low")) {
					return 1;
				} else {
					return 0;
				}
			}
		};
		Comparator<BugTicket> reporterComparator = new Comparator<BugTicket>() {
			@Override
			public int compare(BugTicket ticket1, BugTicket ticket2) {
				User firstObject = ticket1.getUsers().get(0);
				User secondObject = ticket2.getUsers().get(0);

				return firstObject.getUsername().compareTo(secondObject.getUsername());
			}
		};
		Comparator<BugTicket> statusComparator = new Comparator<BugTicket>() {
			@Override
			public int compare(BugTicket ticket1, BugTicket ticket2) {
				return ticket1.getStatus().compareTo(ticket2.getStatus());
			}
		};
		if (searchOption.contains("createdBy")) {
			Collections.sort(tickets, dateComparator);
			System.out.println(searchOption);
			return tickets;
		} else if (searchOption.contains("reverseCreatedBy")) {
			Collections.sort(tickets, dateComparator.reversed());
			return tickets;
		} else if (searchOption.contains("name")) {
			Collections.sort(tickets, nameComparator);
			return tickets;
		} else if (searchOption.contains("reverseName")) {
			Collections.sort(tickets, nameComparator.reversed());
			return tickets;
		} else if (searchOption.contains("importance")) {
			Collections.sort(tickets, importanceComparator);
			return tickets;
		} else if (searchOption.contains("reporter")) {
			Collections.sort(tickets, reporterComparator);
			return tickets;
		} else if (searchOption.contains("status")) {
			Collections.sort(tickets, statusComparator);
			return tickets;
		} else if (searchOption.contains("reverseStatus")) {
			Collections.sort(tickets, statusComparator.reversed());
			return tickets;
		} else if (searchOption.contains("dueDate")) {
			Collections.sort(tickets, dueDateComparator);
			return tickets;
		} else if (searchOption.contains("reverseDueDate")) {
			Collections.sort(tickets, dueDateComparator.reversed());
			return tickets;
		} else {
			return tickets;
		}
	}

	public List<BugTicket> searchNames(String query) {
		List<BugTicket> allTickets = bugTicketRepository.findAll();
		List<BugTicket> searchResults = new ArrayList<>();

		for (BugTicket bugTicket : allTickets) {
			if (bugTicket.getName().contains(query)) {
				searchResults.add(bugTicket);
			}
		}
		return searchResults;
	}

	public BugTicket findById(Long id) {
		Optional<BugTicket> potentialTicket = bugTicketRepository.findById(id);
		if (!potentialTicket.isPresent()) {
			return null;
		} else {
			return potentialTicket.get();
		}
	}

	public BugTicket createTicket(BugTicket bugTicket) {
		return bugTicketRepository.save(bugTicket);
	}

	public BugTicket updateTicket(BugTicket bugTicket) {
		return bugTicketRepository.save(bugTicket);
	}

	public List<BugTicket> findAllTickets() {
		return bugTicketRepository.findAll();
	}

	public void deleteTicket(BugTicket bugTicket) {
		bugTicketRepository.delete(bugTicket);

	}

}
