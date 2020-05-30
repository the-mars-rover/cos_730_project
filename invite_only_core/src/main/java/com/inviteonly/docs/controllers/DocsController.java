package com.inviteonly.docs.controllers;

import com.inviteonly.docs.entities.IdDocument;
import com.inviteonly.docs.errors.DocNotFoundException;
import com.inviteonly.docs.errors.DocOwnerException;
import com.inviteonly.docs.services.IDocsService;
import com.inviteonly.security.services.SecurityService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

/**
 * Defines a controller to handle HTTP requests relating to users.
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/docs")
public class DocsController {
	private final SecurityService securityService;

	private final IDocsService docsService;

	@Operation(summary = "Add an ID document belonging to the authenticated phone number",
			security = @SecurityRequirement(name = "Phone Number Auth"))
	@PostMapping
	@ResponseStatus(HttpStatus.CREATED)
	IdDocument postDocument(@Validated @RequestBody IdDocument newDocument) {
		try {
			String phoneNumber = securityService.authenticatedPhone();

			return docsService.addUserDocument(phoneNumber, newDocument);
		} catch (DocOwnerException e) {
			throw new ResponseStatusException(HttpStatus.CONFLICT, "The document already belongs to someone else.");
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}

	}

	@Operation(summary = "Get all ID documents belonging to the authenticated phone number",
			security = @SecurityRequirement(name = "Phone Number Auth"))
	@GetMapping
	@ResponseStatus(HttpStatus.OK)
	List<IdDocument> getDocuments() {
		try {
			String phoneNumber = securityService.authenticatedPhone();

			return docsService.findUserDocuments(phoneNumber);
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}

	@Operation(summary = "Delete an ID document belonging to the authenticated phone number",
			security = @SecurityRequirement(name = "Phone Number Auth"))
	@DeleteMapping("/{documentId}")
	@ResponseStatus(HttpStatus.OK)
	IdDocument deleteDocument(@PathVariable Long documentId) {
		try {
			String phoneNumber = securityService.authenticatedPhone();

			return docsService.deleteUserDocument(phoneNumber, documentId);
		} catch (DocOwnerException e) {
			throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Document does not belong to the authenticated user.");
		} catch (DocNotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No document with the given Id exists.");
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}
	}
}
