package com.inviteonly.users.entities;


import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.Entity;
import java.time.LocalDate;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
public class IdCard extends IdDocument {
	private String firstNames;

	private String surname;

	private String gender;

	private LocalDate birthDate;

	private LocalDate issueDate;

	private String smartIdNumber;

	private String nationality;

	private String countryOfBirth;

	private String citizenshipStatus;
}
