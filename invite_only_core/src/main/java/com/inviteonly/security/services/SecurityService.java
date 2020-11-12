package com.inviteonly.security.services;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.google.firebase.auth.UserRecord;
import com.google.firebase.internal.NonNull;
import com.inviteonly.security.errors.AuthenticationException;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.IOException;

@Service
@RequiredArgsConstructor
public class SecurityService {
	@PostConstruct
	public void initializeFirebase() throws IOException {
		FirebaseOptions options = new FirebaseOptions.Builder()
				.setCredentials(GoogleCredentials.getApplicationDefault())
				.build();
		if (FirebaseApp.getApps().isEmpty()) {
			FirebaseApp.initializeApp(options);
		}
	}

	public String authenticatedPhone() {
		SecurityContext securityContext = SecurityContextHolder.getContext();
		Object principal = securityContext.getAuthentication().getPrincipal();
		if (principal instanceof String) {
			return (String) principal;
		}
		return null;
	}

	public String phoneNumberForToken(@NonNull String token) throws AuthenticationException {
		try {
			FirebaseToken firebaseToken = FirebaseAuth.getInstance().verifyIdToken(token);
			UserRecord userRecord = FirebaseAuth.getInstance().getUser(firebaseToken.getUid());
			return userRecord.getPhoneNumber();
		} catch (FirebaseAuthException e) {
			throw new AuthenticationException("Error verifying token with firebase.", e);
		}
	}
}
