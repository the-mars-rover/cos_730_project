package com.inviteonly.users.controllers;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.inviteonly.users.entities.User;
import com.inviteonly.users.services.UserService;
import org.springframework.hateoas.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

/**
 * Defines a controller to handle HTTP requests relating to users.
 */
@RestController("/users")
public class UserController {
	private final UserService service;

	private final UserResourceAssembler assembler;

	public UserController(UserService service, UserResourceAssembler assembler) {
		this.service = service;
		this.assembler = assembler;
	}

	@GetMapping("{phoneNumber}")
	Resource<User> readUser(@PathVariable String phoneNumber) throws FirebaseAuthException, IOException {
		FirebaseOptions options = new FirebaseOptions.Builder()
				.setCredentials(GoogleCredentials.getApplicationDefault())
				.build();
		FirebaseApp.initializeApp(options);

		FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken("");
		FirebaseAuth.getInstance().getUser(decodedToken.getUid()).getPhoneNumber();
		decodedToken.getUid();

		User user = service.findUser(phoneNumber);

		return assembler.toResource(user);
	}

	@PutMapping("{phoneNumber}")
	ResponseEntity<?> updateUser(@RequestBody User newUser, @PathVariable String phoneNumber) throws URISyntaxException {
		User updatedUser = service.updateUser(phoneNumber, newUser);
		Resource<User> resource = assembler.toResource(updatedUser);
		return ResponseEntity
				.created(new URI(resource.getId().expand().getHref()))
				.body(resource);
	}

	@DeleteMapping("{phoneNumber}")
	ResponseEntity<?> deleteUser(@PathVariable String phoneNumber) {
		service.deleteUser(phoneNumber);
		return ResponseEntity.noContent().build();
	}
}
