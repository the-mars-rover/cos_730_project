package com.inviteonly.spaces.controllers;

import com.inviteonly.spaces.entities.Space;
import org.jetbrains.annotations.NotNull;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.RepresentationModelAssembler;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Component
public class SpaceResourceAssembler implements RepresentationModelAssembler<Space, EntityModel<Space>> {

	@NotNull
	@Override
	public EntityModel<Space> toModel(@NotNull Space space) {
		// TODO: Add any relevant links
		return new EntityModel<>(space);
	}

	@NotNull
	@Override
	public CollectionModel<EntityModel<Space>> toCollectionModel(Iterable<? extends Space> entities) {
		// TODO: Add any relevant links
		List<EntityModel<Space>> entityModelList = StreamSupport.stream(entities.spliterator(), false)
				.map(this::toModel)
				.collect(Collectors.toList());

		return new CollectionModel<>(entityModelList);
	}
}
