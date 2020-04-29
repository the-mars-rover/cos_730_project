package com.inviteonly.spaces.entities;

import com.inviteonly.users.entities.User;
import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
public class Space {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@Column(nullable = false)
	private String title;

	@Column(nullable = false)
	private boolean inviteOnly;

	@ManyToMany(cascade = {CascadeType.ALL})
	@JoinTable(
			name = "Space_Manager",
			joinColumns = {@JoinColumn(name = "space_id")},
			inverseJoinColumns = {@JoinColumn(name = "user_id")}
	)
	private List<User> managers;

	@ManyToMany(cascade = {CascadeType.ALL})
	@JoinTable(
			name = "Space_Guard",
			joinColumns = {@JoinColumn(name = "space_id")},
			inverseJoinColumns = {@JoinColumn(name = "user_id")}
	)
	private List<User> guards;

	@ManyToMany(cascade = {CascadeType.ALL})
	@JoinTable(
			name = "Space_Inviter",
			joinColumns = {@JoinColumn(name = "space_id")},
			inverseJoinColumns = {@JoinColumn(name = "user_id")}
	)
	private List<User> inviters;

	private int minAge;

	@Lob
	private Byte[] image;

	private double locationLatitude;

	private double locationLongitude;
}
