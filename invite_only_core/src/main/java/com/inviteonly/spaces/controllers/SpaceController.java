package com.inviteonly.spaces.controllers;

import com.inviteonly.security.services.SecurityService;
import com.inviteonly.spaces.entities.Space;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import com.inviteonly.spaces.services.ISpaceService;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import lombok.RequiredArgsConstructor;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
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

	private final SpaceResourceAssembler assembler;

	@PostMapping
	EntityModel<Space> postSpace(@Validated @RequestBody Space space) {
		try {
			Space createdSpace = spaceService.createSpace(space);

			return assembler.toModel(createdSpace);
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}

	@PutMapping("/{spaceId}")
	EntityModel<Space> putSpace(@PathVariable Long spaceId, @Validated @RequestBody Space space) {
		try {
			String phoneNumber = securityService.authenticatedPhone();

			space.setId(spaceId);
			Space createdSpace = spaceService.updateSpace(phoneNumber, space);

			return assembler.toModel(createdSpace);
		} catch (SpaceNotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No space with the given Id exists");
		} catch (SpaceAuthorizationException e) {
			throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, e.getMessage());
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}

	@GetMapping
	CollectionModel<EntityModel<Space>> getSpaces() {
		try {
			String phoneNumber = securityService.authenticatedPhone();

			List<Space> spaceList = spaceService.findUserSpaces(phoneNumber);

			return assembler.toCollectionModel(spaceList);
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}

	@DeleteMapping("/{spaceId}")
	void deleteSpace(@PathVariable Long spaceId) {
		try {
			String phoneNumber = securityService.authenticatedPhone();

			spaceService.deleteSpace(phoneNumber, spaceId);
		} catch (SpaceNotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No space with the given Id exists");
		} catch (SpaceAuthorizationException e) {
			throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, e.getMessage());
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}
}
