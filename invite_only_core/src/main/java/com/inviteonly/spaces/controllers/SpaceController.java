package com.inviteonly.spaces.controllers;

import com.inviteonly.security.services.SecurityService;
import com.inviteonly.spaces.entities.Space;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import com.inviteonly.spaces.services.ISpaceService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/spaces")
public class SpaceController {
	private final SecurityService securityService;

	private final ISpaceService spaceService;

	@Operation(summary = "Create a new access-controlled space",
			security = @SecurityRequirement(name = "Phone Number Auth"))
	@PostMapping
	@ResponseStatus(HttpStatus.CREATED)
	Space postSpace(@Validated @RequestBody Space space) {
		try {
			return spaceService.createSpace(space);
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}

	@Operation(summary = "Update a space's details",
			description = "Only managers of the space will be authorized to call this endpoint.",
			security = @SecurityRequirement(name = "Phone Number Auth"))
	@PutMapping("/{spaceId}")
	Space putSpace(@PathVariable Long spaceId, @Validated @RequestBody Space space) {
		try {
			String phoneNumber = securityService.authenticatedPhone();

			space.setId(spaceId);
			return spaceService.updateSpace(phoneNumber, space);
		} catch (SpaceNotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No space with the given Id exists");
		} catch (SpaceAuthorizationException e) {
			throw new ResponseStatusException(HttpStatus.FORBIDDEN, e.getMessage());
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}

	@Operation(summary = "Retrieve all access-controlled space",
			description = "Responds with a list of all space for which the authenticated phone number is a manager, inviter or guard.",
			security = @SecurityRequirement(name = "Phone Number Auth"))
	@GetMapping
	List<Space> getSpaces() {
		try {
			String phoneNumber = securityService.authenticatedPhone();

			return spaceService.findUserSpaces(phoneNumber);
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}

	@Operation(summary = "Delete the space with the given ID",
			description = "Only managers of the space will be authorized to call this endpoint.",
			security = @SecurityRequirement(name = "Phone Number Auth"))
	@DeleteMapping("/{spaceId}")
	void deleteSpace(@PathVariable Long spaceId) {
		try {
			String phoneNumber = securityService.authenticatedPhone();

			spaceService.deleteSpace(phoneNumber, spaceId);
		} catch (SpaceNotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No space with the given Id exists");
		} catch (SpaceAuthorizationException e) {
			throw new ResponseStatusException(HttpStatus.FORBIDDEN, e.getMessage());
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}
}
