package com.inviteonly.spaces.controllers;

import com.inviteonly.spaces.entities.Space;
import org.springframework.hateoas.Resource;
import org.springframework.hateoas.ResourceAssembler;
import org.springframework.stereotype.Component;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;
import static org.springframework.hateoas.mvc.ControllerLinkBuilder.methodOn;

@Component
public class SpaceResourceAssembler implements ResourceAssembler<Space, Resource<Space>> {
	@Override
	public Resource<Space> toResource(Space space) {
		return new Resource<>(space,
				linkTo(methodOn(SpaceController.class).readSpace(String.valueOf(space.getId()))).withSelfRel());
	}
}
