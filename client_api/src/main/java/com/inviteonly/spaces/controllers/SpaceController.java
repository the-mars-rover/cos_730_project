package com.inviteonly.spaces.controllers;

import com.inviteonly.spaces.entities.Space;
import com.inviteonly.spaces.repositories.SpaceRepository;
import org.springframework.hateoas.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

@RestController("/users/{phoneNumber}/spaces")
public class SpaceController {
	private final SpaceRepository repository;

	private final SpaceResourceAssembler assembler;

	public SpaceController(SpaceRepository repository, SpaceResourceAssembler assembler) {
		this.repository = repository;
		this.assembler = assembler;
	}

	@PostMapping
	Resource<Space> createSpace(@RequestBody Space space) {
		Space createdSpace = repository.save(space);

		return assembler.toResource(createdSpace);
	}

	@GetMapping("{spaceId}")
	Resource<Space> readSpace(@PathVariable String spaceId) {
		Space space = repository.findById(spaceId)
				.orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Could not find space with id " + spaceId));

		return assembler.toResource(space);
	}

	@DeleteMapping("{spaceId}")
	ResponseEntity<?> deleteSpace(@PathVariable String spaceId) {
		repository.deleteById(spaceId);

		return ResponseEntity.noContent().build();
	}
}
