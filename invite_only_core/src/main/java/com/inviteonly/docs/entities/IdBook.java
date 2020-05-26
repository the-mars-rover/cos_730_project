package com.inviteonly.docs.entities;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
public class IdBook extends IdDocument {
	@NotNull
	private String gender;

	@NotNull
	private LocalDate birthDate;

	@NotNull
	private String citizenshipStatus;
}
