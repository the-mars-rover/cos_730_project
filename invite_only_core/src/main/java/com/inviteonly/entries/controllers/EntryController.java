package com.inviteonly.entries.controllers;

import com.inviteonly.docs.entities.IdDocument;
import com.inviteonly.docs.errors.DocNotFoundException;
import com.inviteonly.entries.entities.SpaceEntry;
import com.inviteonly.entries.services.EntryService;
import com.inviteonly.invites.errors.InvalidInviteCode;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.PagedModel;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import javax.validation.constraints.NotNull;

@RestController
@RequiredArgsConstructor
@RequestMapping("/spaces/{spaceId}/entries")
public class EntryController {
	private final EntryService entryService;

	private final EntryResourceAssembler entryResourceAssembler;

	private final PagedResourcesAssembler<SpaceEntry> pagedResourcesAssembler;

	@PostMapping
	EntityModel<SpaceEntry> postEntry(@PathVariable Long spaceId, @Validated @RequestBody IdDocument idDocument,
	                                  @Validated @RequestParam(required = false) String inviteCode) {
		try {
			// TODO: Replace with auth user phone
			String phoneNumber = "+27815029249";

			SpaceEntry newEntry;
			if (inviteCode != null) {
				newEntry = entryService.addVisitorEntry(phoneNumber, spaceId, idDocument,  inviteCode);
			} else {
				newEntry = entryService.addResidentEntry(phoneNumber, spaceId, idDocument);
			}

			return entryResourceAssembler.toModel(newEntry);
		} catch (DocNotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No user with matching ID Document");
		} catch (SpaceNotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No space with the given Id");
		} catch (SpaceAuthorizationException e) {
			throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, e.getMessage());
		} catch (InvalidInviteCode e) {
			throw new ResponseStatusException(HttpStatus.NOT_ACCEPTABLE, "Invalid invite code");
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}

	@GetMapping
	PagedModel<EntityModel<SpaceEntry>> getEntries(@PathVariable Long spaceId, @NotNull Pageable pageable) {
		try {
			// TODO: Replace with auth user phone
			String phoneNumber = "+27815029249";

			Page<SpaceEntry> page = entryService.findEntries(phoneNumber, spaceId, pageable);

			return pagedResourcesAssembler.toModel(page, entryResourceAssembler);
		} catch (SpaceNotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No space with the given Id");
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}
}
