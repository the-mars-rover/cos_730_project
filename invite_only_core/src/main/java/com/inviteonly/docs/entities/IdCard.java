package com.inviteonly.docs.entities;


import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
public class IdCard extends IdDocument {
	@NotNull
	private String firstNames;

	@NotNull
	private String surname;

	@NotNull
	private String gender;

	@NotNull
	private LocalDate birthDate;

	@NotNull
	private LocalDate issueDate;

	@NotNull
	private String smartIdNumber;

	@NotNull
	private String nationality;

	@NotNull
	private String countryOfBirth;

	@NotNull
	private String citizenshipStatus;
}
