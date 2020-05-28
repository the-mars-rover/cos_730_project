package com.inviteonly.docs.controllers;

import com.inviteonly.docs.entities.IdDocument;
import com.inviteonly.docs.errors.DocNotFoundException;
import com.inviteonly.docs.errors.DocOwnerException;
import com.inviteonly.docs.services.IDocsService;
import com.inviteonly.security.services.SecurityService;
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

	@PostMapping
	@ResponseStatus(HttpStatus.CREATED)
	IdDocument postDocument(@Validated @RequestBody IdDocument newDocument) {
		try {
			String phoneNumber = securityService.authenticatedPhone();

			return docsService.addUserDocument(phoneNumber, newDocument);
		} catch (Exception e) {
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
		}

	}

	@GetMapping
	@ResponseStatus(HttpStatus.OK)
	List<IdDocument> getDocuments() {
		String phoneNumber = securityService.authenticatedPhone();

		return docsService.findUserDocuments(phoneNumber);
	}

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
