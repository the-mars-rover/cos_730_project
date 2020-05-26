package com.inviteonly.docs.controllers;

import com.inviteonly.docs.entities.IdDocument;
import com.inviteonly.docs.services.DocsService;
import lombok.RequiredArgsConstructor;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

/**
 * Defines a controller to handle HTTP requests relating to users.
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/docs")
public class DocsController {
	private final DocsService service;

	private final UserDocAssembler assembler;

	@PostMapping
	EntityModel<IdDocument> postDocument(@Validated @RequestBody IdDocument newDocument) {
		try {
			// TODO: Replace this with auth user phone number
			String phoneNumber = "+27815029249";

			IdDocument savedDocument = service.addUserDocument(phoneNumber ,newDocument);

			return assembler.toModel(savedDocument);
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}

	}

	@GetMapping
	CollectionModel<EntityModel<IdDocument>> getDocuments() {
		// TODO: Replace this with auth user phone number
		String phoneNumber = "+27815029249";

		return assembler.toCollectionModel(service.findUserDocuments(phoneNumber));
	}
}
