package com.inviteonly.users.entities;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.Entity;
import java.time.LocalDate;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
public class IdBook extends IdDocument {
	private String gender;

	private LocalDate birthDate;

	private String citizenshipStatus;
}
