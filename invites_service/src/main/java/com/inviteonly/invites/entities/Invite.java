package com.inviteonly.invites.entities;

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

	@Column(nullable = false)
	private String spaceId;

	@Column(nullable = false)
	private String inviterPhoneNumber;

	@Column(nullable = false)
	private Timestamp expiryDate;
}
