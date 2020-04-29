package com.inviteonly.users.entities;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.Entity;
import java.time.LocalDate;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
public class DriversLicense extends IdDocument {
	private String firstNames;

	private String surname;

	private String gender;

	private LocalDate birthDate;

	private String licenseNumber;

	private String vehicleCodes;

	private String prdpCode;

	private String idCountryOfIssue;

	private String licenseCountryOfIssue;

	private String vehicleRestrictions;

	private String idNumberType;

	private String driverRestrictions;

	private LocalDate prdpExpiry;

	private String licenseIssueNumber;

	private LocalDate validFrom;

	private LocalDate validTo;
}
