package com.inviteonly.invites.controllers;

import com.inviteonly.invites.entities.Invite;
import org.jetbrains.annotations.NotNull;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.RepresentationModelAssembler;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Component
public class InviteResourceAssembler implements RepresentationModelAssembler<Invite, EntityModel<Invite>> {

	@NotNull
	@Override
	public EntityModel<Invite> toModel(@NotNull Invite invite) {
		// TODO: Add any relevant links
		return new EntityModel<>(invite);
	}

	@NotNull
	@Override
	public CollectionModel<EntityModel<Invite>> toCollectionModel(Iterable<? extends Invite> invites) {
		List<EntityModel<Invite>> entityModelList = StreamSupport.stream(invites.spliterator(), false)
				.map(this::toModel)
				.collect(Collectors.toList());

		// TODO: Add any relevant links
		return new CollectionModel<>(entityModelList);
	}
}
