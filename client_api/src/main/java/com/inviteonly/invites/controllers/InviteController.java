package com.inviteonly.invites.controllers;

import com.inviteonly.invites.entities.Invite;
import com.inviteonly.invites.repositories.InviteRepository;
import org.apache.commons.lang3.StringUtils;
import org.springframework.hateoas.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.sql.Timestamp;
import java.time.Duration;
import java.time.Instant;
import java.util.Optional;
import java.util.Random;

@RestController
public class InviteController {
	private final InviteRepository repository;

	private final InviteResourceAssembler assembler;

	public InviteController(InviteRepository repository, InviteResourceAssembler assembler) {
		this.repository = repository;
		this.assembler = assembler;
	}

	@PostMapping("/spaces/{spaceId}/invites")
	Resource<Invite> createInvite(@RequestBody Invite invite) {
		int randomNumber =  new Random().nextInt(999999);
		String code = StringUtils.leftPad(Integer.toString(randomNumber), 6, '0');
		invite.setCode(code);
		invite.setExpiryDate(Timestamp.from(Instant.now().plus(Duration.ofHours(48))));
		Invite createdInvite = repository.save(invite);

		return assembler.toResource(createdInvite);
	}

	@GetMapping("/spaces/{spaceId}/invites/{inviteCode}")
	public Resource<Invite> readInvite(@PathVariable String spaceId, @PathVariable String inviteCode) {
		Invite invite = Optional.ofNullable(repository.findSpaceInviteByCode(spaceId, inviteCode))
				.orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Could not find space invite with code " + inviteCode));

		return assembler.toResource(invite);
	}
}
