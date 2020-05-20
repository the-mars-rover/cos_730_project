package com.inviteonly.invites.controllers;

import com.inviteonly.invites.entities.Invite;
import org.springframework.hateoas.Resource;
import org.springframework.hateoas.ResourceAssembler;
import org.springframework.stereotype.Component;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;
import static org.springframework.hateoas.mvc.ControllerLinkBuilder.methodOn;

@Component
public class InviteResourceAssembler implements ResourceAssembler<Invite, Resource<Invite>> {
	@Override
	public Resource<Invite> toResource(Invite invite) {
		return new Resource<>(invite,
				linkTo(methodOn(InviteController.class).readInvite(String.valueOf(invite.getCode()), invite.getSpaceId())).withSelfRel());
	}
}
