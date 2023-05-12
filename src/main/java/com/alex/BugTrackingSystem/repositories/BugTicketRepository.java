package com.alex.BugTrackingSystem.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.alex.BugTrackingSystem.models.BugTicket;

@Repository
public interface BugTicketRepository extends CrudRepository<BugTicket, Long>{

	List<BugTicket> findAll();
}
