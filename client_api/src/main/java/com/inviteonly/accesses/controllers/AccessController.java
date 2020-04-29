package com.inviteonly.accesses.controllers;

import com.inviteonly.accesses.entities.Access;
import com.inviteonly.accesses.repositories.AccessRepository;
import org.springframework.hateoas.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

@RestController
public class AccessController {
	private final AccessRepository repository;

	private final AccessResourceAssembler assembler;

	public AccessController(AccessRepository repository, AccessResourceAssembler assembler) {
		this.repository = repository;
		this.assembler = assembler;
	}

	@PostMapping("/spaces/{spaceId}/accesses")
	Resource<Access> createAccess(@RequestBody Access access) {
		Access createdAccess = repository.save(access);

		return assembler.toResource(createdAccess);
	}

	@GetMapping("/spaces/{spaceId}/accesses/{accessId}")
	Resource<Access> readAccess(@PathVariable String accessId) {
		Access space = repository.findById(accessId)
				.orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Could not find access with id " + accessId));

		return assembler.toResource(space);
	}
}
