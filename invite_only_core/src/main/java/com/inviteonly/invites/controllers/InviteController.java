package com.inviteonly.invites.controllers;

import com.inviteonly.invites.entities.Invite;
import com.inviteonly.invites.services.InvitesServiceInterface;
import com.inviteonly.security.services.SecurityService;
import com.inviteonly.spaces.errors.SpaceAuthorizationException;
import com.inviteonly.spaces.errors.SpaceNotFoundException;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequiredArgsConstructor
@RequestMapping("/spaces/{spaceId}/invites")
public class InviteController {

  private final SecurityService securityService;

  private final InvitesServiceInterface invitesService;

  @Operation(
      summary = "Create an invite for the space with the given ID",
      description =
          "Only inviters of the space will be authorized to call this endpoint. A successful "
              + "response"
              + " includes an invite code that can be used to add an entry to the space.",
      security = @SecurityRequirement(name = "Phone Number Auth"))
  @PostMapping
  @ResponseStatus(HttpStatus.CREATED)
  Invite postInvite(@PathVariable Long spaceId) {
    try {
      String phoneNumber = securityService.authenticatedPhone();

      return invitesService.createInvite(phoneNumber, spaceId);
    } catch (SpaceNotFoundException error) {
      throw new ResponseStatusException(
          HttpStatus.NOT_FOUND, String.format("Space with id %s could not be found.", spaceId));
    } catch (SpaceAuthorizationException error) {
      throw new ResponseStatusException(HttpStatus.FORBIDDEN, error.getMessage());
    } catch (Exception error) {
      throw new ResponseStatusException(
          HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
    }
  }
}
