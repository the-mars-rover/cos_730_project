package com.inviteonly.invites.entities;

import com.inviteonly.accesses.entities.Access;
import com.inviteonly.spaces.entities.Space;
import com.inviteonly.users.entities.User;
import lombok.Data;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Data
public class Invite {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	private int id;

	@Column(nullable = false)
	private String code;

	@ManyToOne(optional = false)
	private Space space;

	@ManyToOne(optional = false)
	private User inviter;

	@Column(nullable = false)
	private Timestamp expiryDate;

	@OneToOne
	private Access access;
}
