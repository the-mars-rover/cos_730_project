package com.inviteonly.invites.controllers;

import com.inviteonly.invites.entities.Invite;
import com.inviteonly.invites.services.IInvitesService;
import com.inviteonly.security.services.SecurityService;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequiredArgsConstructor
@RequestMapping("/spaces/{spaceId}/invites")
public class InviteController {
	private final SecurityService securityService;

	private final IInvitesService invitesService;

	@PostMapping
	Invite postInvite(@PathVariable Long spaceId) {
		try {
			String phoneNumber = securityService.authenticatedPhone();

			return invitesService.createInvite(phoneNumber, spaceId);
		} catch (SpaceNotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, String.format("Space with id %s could not be found.", spaceId));
		} catch (SpaceAuthorizationException e) {
			throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, e.getMessage());
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}
}
