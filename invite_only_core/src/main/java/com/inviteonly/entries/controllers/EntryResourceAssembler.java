package com.inviteonly.entries.controllers;

import com.inviteonly.entries.entities.SpaceEntry;
import org.jetbrains.annotations.NotNull;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.RepresentationModelAssembler;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Component
public class EntryResourceAssembler implements RepresentationModelAssembler<SpaceEntry, EntityModel<SpaceEntry>> {
	@NotNull
	@Override
	public EntityModel<SpaceEntry> toModel(@NotNull SpaceEntry entry) {
		return new EntityModel<>(entry);
	}

	@NotNull
	@Override
	public CollectionModel<EntityModel<SpaceEntry>> toCollectionModel(Iterable<? extends SpaceEntry> entries) {
		List<EntityModel<SpaceEntry>> entityModelList = StreamSupport.stream(entries.spliterator(), false)
				.map(this::toModel)
				.collect(Collectors.toList());

		return new CollectionModel<>(entityModelList);
	}
}
