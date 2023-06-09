package com.alex.BugTrackingSystem.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.Nullable;

@Entity
@Table(name="bugTickets")
public class BugTicket {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@NotEmpty(message = "Ticket name is required.")
	@Size(min= 3, max =40, message="Ticket name must be at least 3 characters in length.")
	private String name; 
	
	@NotEmpty(message = "Please rank the importance of this task.")
	private String importance;
	
	@NotEmpty(message = "Please add the status of this task.")
	private String status;
	
	@NotEmpty(message = "Please add the description of this Bug.")
	private String description;
	
	@NotEmpty(message = "Please add steps to re-create Bug.")
	private String recreationSteps;
	
	@NotNull(message = "Please add the Due date for this task.")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date dueDate;
	
	@Nullable
	private String assignedUser;
	
	@Column(updatable = false)
	private Date createdAt;
	private Date updatedAt;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name = "users_bugTickets",
			joinColumns = @JoinColumn(name = "bugTicket_id"),
			inverseJoinColumns = @JoinColumn(name = "user_id")
			)
	private List<User> users; 
	
	
	
	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public BugTicket() {}
	
	public BugTicket(String name, String importance, String status, String description, String recreationSteps, Date dueDate, String assignedUser) {
		this.name = name; 
		this.importance = importance;
		this.status = status;
		this.description = description;
		this.recreationSteps = recreationSteps;
		this.dueDate = dueDate;
		this.assignedUser =assignedUser;
	}
	
	
	public String getRecreationSteps() {
		return recreationSteps;
	}

	public void setRecreationSteps(String recreationSteps) {
		this.recreationSteps = recreationSteps;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImportance() {
		return importance;
	}

	public void setImportance(String importance) {
		this.importance = importance;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getDueDate() {
		return dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}
	public Date getCreatedDate() {
		return createdAt;
	}
	
	public String getAssignedUser() {
		return assignedUser;
	}

	public void setAssignedUser(String assignedUser) {
		this.assignedUser = assignedUser;
	}

	@PrePersist
	protected void onCreate(){
		this.createdAt = new Date();
	}
	
	@PreUpdate
	protected void onUpdate(){
		this.updatedAt = new Date();
	}
}
