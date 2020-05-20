package com.inviteonly.invites.controllers;

import com.inviteonly.invites.entities.Invite;
import com.inviteonly.invites.services.InviteService;
import lombok.RequiredArgsConstructor;
import org.springframework.hateoas.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/invites")
@RequiredArgsConstructor
public class InviteController {
	private final InviteService inviteService;

	private final InviteResourceAssembler assembler;

	@PostMapping
	@ResponseStatus(code = HttpStatus.CREATED)
	public Resource<Invite> createInvite(@RequestBody Invite invite) {
		Invite createdInvite = inviteService.createInvite(invite);

		return assembler.toResource(createdInvite);
	}

	@GetMapping
	public Resource<Invite> readInvite(@RequestParam String inviteCode, @RequestParam String spaceId) {
		Invite invite = inviteService.findInvite(inviteCode, spaceId);
		if (invite == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No valid invite found");
		}

		return assembler.toResource(invite);
	}
}
