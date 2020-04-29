package com.inviteonly.accesses.controllers;

import com.inviteonly.accesses.entities.Access;
import org.springframework.hateoas.Resource;
import org.springframework.hateoas.ResourceAssembler;
import org.springframework.stereotype.Component;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;
import static org.springframework.hateoas.mvc.ControllerLinkBuilder.methodOn;

@Component
public class AccessResourceAssembler implements ResourceAssembler<Access, Resource<Access>> {
	@Override
	public Resource<Access> toResource(Access access) {
		return new Resource<>(access,
				linkTo(methodOn(AccessController.class).readAccess(String.valueOf(access.getId()))).withSelfRel());
	}
}
