package com.inviteonly.entries.controllers;

import com.inviteonly.docs.entities.IdDocument;
import com.inviteonly.docs.errors.DocNotFoundException;
import com.inviteonly.entries.entities.SpaceEntry;
import com.inviteonly.entries.services.IEntryService;
import com.inviteonly.invites.errors.InvalidInviteCode;
import com.inviteonly.security.services.SecurityService;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import javax.validation.constraints.NotNull;


@RestController
@RequiredArgsConstructor
@RequestMapping("/spaces/{spaceId}/entries")
public class EntryController {
	private final SecurityService securityService;

	private final IEntryService entryService;

	@Operation(summary = "Add an Entry to the space with the given ID",
			description = "Only guards of the space will be authorized to call this endpoint. " +
					"An inviteCode is optional if the person with the given idDocument has access to the space" +
					"(ie. has been added as a manager, inviter or guard for the space) however, an inviteCode must be " +
					"provided if not.",
			security = @SecurityRequirement(name = "Phone Number Auth"))
	@PostMapping
	@ResponseStatus(HttpStatus.CREATED)
	SpaceEntry postEntry(@PathVariable Long spaceId, @Validated @RequestBody IdDocument idDocument,
	                     @Validated @RequestParam(required = false) String inviteCode) {
		try {
			String phoneNumber = securityService.authenticatedPhone();

			if (inviteCode != null) {
				return entryService.addVisitorEntry(phoneNumber, spaceId, idDocument, inviteCode);
			}

			return entryService.addResidentEntry(phoneNumber, spaceId, idDocument);
		} catch (DocNotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No user with matching ID Document");
		} catch (SpaceNotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No space with the given Id");
		} catch (SpaceAuthorizationException e) {
			throw new ResponseStatusException(HttpStatus.FORBIDDEN, e.getMessage());
		} catch (InvalidInviteCode e) {
			throw new ResponseStatusException(HttpStatus.NOT_ACCEPTABLE, "Invalid invite code");
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}

	@Operation(summary = "Retrieve entries for the space with the given ID",
			description = "If the user with the authenticated phone number is a manager for the space this response" +
					" will include all entries for the space. Otherwise, it will only include entries relevant to the user.",
			security = @SecurityRequirement(name = "Phone Number Auth"))
	@GetMapping
	Page<SpaceEntry> getEntries(@PathVariable Long spaceId, @NotNull Pageable pageable) {
		try {
			String phoneNumber = securityService.authenticatedPhone();

			return entryService.findEntries(phoneNumber, spaceId, pageable);
		} catch (SpaceNotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No space with the given Id");
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}
}
