package com.inviteonly.users.entities;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
public class IdDocument {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@Column(nullable = false)
	private String idNumber;
}
