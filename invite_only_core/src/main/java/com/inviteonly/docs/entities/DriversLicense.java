package com.inviteonly.docs.entities;

import com.inviteonly.utils.StringListConverter;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.lang.Nullable;

import javax.persistence.Convert;
import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
public class DriversLicense extends IdDocument {
	@NotNull
	private String firstNames;

	@NotNull
	private String surname;

	@NotNull
	private String gender;

	@NotNull
	private LocalDate birthDate;

	@NotNull
	private String licenseNumber;

	@NotNull
	@Convert(converter = StringListConverter.class)
	private List<String> vehicleCodes;

	@Nullable
	private String prdpCode;

	@NotNull
	private String idCountryOfIssue;

	@NotNull
	private String licenseCountryOfIssue;

	@NotNull
	@Convert(converter = StringListConverter.class)
	private List<String> vehicleRestrictions;

	@NotNull
	private String idNumberType;

	@Nullable
	private String driverRestrictions;

	@Nullable
	private LocalDate prdpExpiry;

	@NotNull
	private String licenseIssueNumber;

	@NotNull
	private LocalDate validFrom;

	@NotNull
	private LocalDate validTo;
}
