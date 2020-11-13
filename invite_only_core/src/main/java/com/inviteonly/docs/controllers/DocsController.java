package com.inviteonly.docs.controllers;

import com.inviteonly.docs.entities.IdDocument;
import com.inviteonly.docs.errors.DocNotFoundException;
import com.inviteonly.docs.errors.DocOwnerException;
import com.inviteonly.docs.services.DocsServiceInterface;
import com.inviteonly.security.services.SecurityService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

/**
 * Defines a controller to handle HTTP requests relating to users.
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/docs")
public class DocsController {

  private final SecurityService securityService;

  private final DocsServiceInterface docsService;

  @Operation(
      summary = "Add an ID document belonging to the authenticated phone number",
      security = @SecurityRequirement(name = "Phone Number Auth"))
  @PostMapping
  @ResponseStatus(HttpStatus.CREATED)
  IdDocument postDocument(@Validated @RequestBody IdDocument newDocument) {
    try {
      String phoneNumber = securityService.authenticatedPhone();

      return docsService.addUserDocument(phoneNumber, newDocument);
    } catch (DocOwnerException error) {
      throw new ResponseStatusException(
          HttpStatus.CONFLICT, "The document already belongs to someone else.");
    } catch (Exception error) {
      throw new ResponseStatusException(
          HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
    }
  }

  @Operation(
      summary = "Get all ID documents belonging to the authenticated phone number",
      security = @SecurityRequirement(name = "Phone Number Auth"))
  @GetMapping
  @ResponseStatus(HttpStatus.OK)
  List<IdDocument> getDocuments() {
    try {
      String phoneNumber = securityService.authenticatedPhone();

      return docsService.findUserDocuments(phoneNumber);
    } catch (Exception error) {
      throw new ResponseStatusException(
          HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
    }
  }

  @Operation(
      summary = "Delete an ID document belonging to the authenticated phone number",
      security = @SecurityRequirement(name = "Phone Number Auth"))
  @DeleteMapping("/{documentId}")
  @ResponseStatus(HttpStatus.OK)
  void deleteDocument(@PathVariable Long documentId) {
    try {
      String phoneNumber = securityService.authenticatedPhone();

      docsService.deleteUserDocument(phoneNumber, documentId);
    } catch (DocOwnerException error) {
      throw new ResponseStatusException(
          HttpStatus.FORBIDDEN, "Document does not belong to the authenticated user.");
    } catch (DocNotFoundException error) {
      throw new ResponseStatusException(
          HttpStatus.NOT_FOUND, "No document with the given Id exists.");
    } catch (Exception error) {
      throw new ResponseStatusException(
          HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
    }
  }
}
