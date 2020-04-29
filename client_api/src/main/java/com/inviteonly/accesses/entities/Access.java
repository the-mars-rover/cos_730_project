package com.inviteonly.accesses.entities;

import com.inviteonly.invites.entities.Invite;
import com.inviteonly.spaces.entities.Space;
import com.inviteonly.users.entities.IdDocument;
import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Data
public class Access {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@ManyToOne(optional = false)
	private Space space;

	@ManyToOne(optional = false)
	private IdDocument idDocument;

	@Column(nullable = false)
	private LocalDateTime accessDate;

	@OneToOne
	private Invite invite;
}
