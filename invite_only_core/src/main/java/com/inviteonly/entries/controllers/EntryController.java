package com.inviteonly.entries.controllers;

import com.inviteonly.docs.entities.IdDocument;
import com.inviteonly.docs.errors.DocNotFoundException;
import com.inviteonly.entries.entities.SpaceEntry;
import com.inviteonly.entries.services.EntryServiceInterface;
import com.inviteonly.invites.errors.InvalidInviteCode;
import com.inviteonly.security.services.SecurityService;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import java.time.LocalDateTime;
import javax.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequiredArgsConstructor
@RequestMapping("/spaces/{spaceId}/entries")
public class EntryController {

  private final SecurityService securityService;

  private final EntryServiceInterface entryService;

  @Operation(
      summary = "Add an Entry to the space with the given ID",
      description =
          "Only guards of the space will be authorized to call this endpoint. An "
              + "inviteCode is optional if the person with the given idDocument has access to the "
              + "space (ie. has been added as a manager, inviter or guard for the space) however, "
              + "an inviteCode must be provided if not.",
      security = @SecurityRequirement(name = "Phone Number Auth"))
  @PostMapping
  @ResponseStatus(HttpStatus.CREATED)
  SpaceEntry postEntry(
      @PathVariable Long spaceId,
      @Validated @RequestBody IdDocument idDocument,
      @Validated @RequestParam(required = false) String inviteCode) {
    try {
      String phoneNumber = securityService.authenticatedPhone();

      if (inviteCode != null) {
        return entryService.addVisitorEntry(phoneNumber, spaceId, idDocument, inviteCode);
      }

      return entryService.addResidentEntry(phoneNumber, spaceId, idDocument);
    } catch (DocNotFoundException error) {
      throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No user with matching ID Document");
    } catch (SpaceNotFoundException error) {
      throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No space with the given Id");
    } catch (SpaceAuthorizationException error) {
      throw new ResponseStatusException(HttpStatus.FORBIDDEN, error.getMessage());
    } catch (InvalidInviteCode error) {
      throw new ResponseStatusException(HttpStatus.NOT_ACCEPTABLE, "Invalid invite code");
    } catch (Exception error) {
      throw new ResponseStatusException(
          HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
    }
  }

  @Operation(
      summary = "Retrieve entries for the space with the given ID",
      description =
          "If the user with the authenticated phone number is a manager for the space "
              + "this response will include all entries for the space. Otherwise, it will only "
              + "include entries relevant to the user.",
      security = @SecurityRequirement(name = "Phone Number Auth"))
  @GetMapping
  Page<SpaceEntry> getEntries(
      @PathVariable Long spaceId,
      @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @Validated @RequestParam(required = false)
          LocalDateTime from,
      @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @Validated @RequestParam(required = false)
          LocalDateTime to,
      @NotNull Pageable pageable) {
    try {
      String phoneNumber = securityService.authenticatedPhone();

      return entryService.findEntries(phoneNumber, spaceId, from, to, pageable);
    } catch (SpaceNotFoundException error) {
      throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No space with the given Id");
    } catch (Exception error) {
      throw new ResponseStatusException(
          HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
    }
  }
}
