package com.inviteonly.docs.controllers;

import com.inviteonly.docs.entities.IdDocument;
import lombok.SneakyThrows;
import org.jetbrains.annotations.NotNull;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.RepresentationModelAssembler;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;


@Component
public class UserDocAssembler implements RepresentationModelAssembler<IdDocument, EntityModel<IdDocument>> {
	@NotNull
	@Override
	public EntityModel<IdDocument> toModel(@NotNull IdDocument entity) {
		return new EntityModel<>(entity);
	}

	@SneakyThrows
	@NotNull
	@Override
	public CollectionModel<EntityModel<IdDocument>> toCollectionModel(Iterable<? extends IdDocument> entities) {
		List<EntityModel<IdDocument>> entityModelList = StreamSupport.stream(entities.spliterator(), false)
				.map(this::toModel)
				.collect(Collectors.toList());

		return new CollectionModel<>(entityModelList,
				linkTo(methodOn(DocsController.class).getDocuments()).withSelfRel());
	}
}