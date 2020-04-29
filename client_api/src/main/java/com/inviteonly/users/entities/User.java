package com.inviteonly.users.entities;

import com.inviteonly.spaces.entities.Space;
import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
public class User {
	public static User newUser(String phoneNumber) {
		User newUser = new User();
		newUser.phoneNumber = phoneNumber;
		return newUser;
	}

	@Id
	private String phoneNumber;

	@OneToOne(cascade = CascadeType.ALL)
	private IdCard idCard;

	@OneToOne(cascade = CascadeType.ALL)
	private IdBook idBook;

	@OneToOne(cascade = CascadeType.ALL)
	private DriversLicense driversLicense;

	@OneToOne(cascade = CascadeType.ALL)
	private Passport passport;

	@ManyToMany(mappedBy = "managers")
	private List<Space> managedSpaces;

	@ManyToMany(mappedBy = "guards")
	private List<Space> guardingSpaces;

	@ManyToMany(mappedBy = "inviters")
	private List<Space> invitingSpaces;
}
