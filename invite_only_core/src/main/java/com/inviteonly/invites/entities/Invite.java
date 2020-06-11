package com.inviteonly.invites.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.inviteonly.entries.entities.SpaceEntry;
import com.inviteonly.spaces.entities.Space;
import lombok.Data;
import org.springframework.lang.Nullable;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Entity
@Data
public class Invite {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	private Long id;

	@NotNull
	private String code;

	@JsonIgnore
	@ManyToOne
	@NotNull
	private Space space;

	@NotNull
	private String inviterPhone;

	@NotNull
	private LocalDateTime expiryDate;

	@JsonIgnore
	@OneToOne(mappedBy = "invite", cascade = CascadeType.ALL)
	@Nullable
	private SpaceEntry entry;
}
