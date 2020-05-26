package com.inviteonly.spaces.entities;

import lombok.Data;
import org.springframework.lang.Nullable;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Set;

@Entity
@Data
public class Space {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@NotNull
	private String title;

	@NotNull
	@ElementCollection
	private Set<String> managerPhones;

	@NotNull
	@ElementCollection
	private Set<String> guardPhones;

	@NotNull
	@ElementCollection
	private Set<String> inviterPhones;

	@Nullable
	private String imageUrl;

	@Nullable
	private BigDecimal locationLatitude;

	@Nullable
	private BigDecimal locationLongitude;

	public boolean hasManager(String phoneNumber) {
		return managerPhones.contains(phoneNumber);
	}

	public boolean hasInviter(String phoneNumber) {
		return inviterPhones.contains(phoneNumber);
	}

	public boolean hasGuard(String phoneNumber) {
		return guardPhones.contains(phoneNumber);
	}

	public boolean hasResident(String phoneNumber) {
		return managerPhones.contains(phoneNumber) || inviterPhones.contains(phoneNumber) || guardPhones.contains(phoneNumber);
	}
}
