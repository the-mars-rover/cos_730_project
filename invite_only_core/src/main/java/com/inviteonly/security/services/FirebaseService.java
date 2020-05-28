package com.inviteonly.security.services;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.google.firebase.auth.UserRecord;
import com.google.firebase.internal.NonNull;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.IOException;

@Service
public class FirebaseService {
	@PostConstruct
	public void initializeFirebase() throws IOException {
		FirebaseOptions options = new FirebaseOptions.Builder()
				.setCredentials(GoogleCredentials.getApplicationDefault())
				.build();
		if (FirebaseApp.getApps().isEmpty()) {
			FirebaseApp.initializeApp(options);
		}
	}

	public String phoneNumberForToken(@NonNull String token) throws FirebaseAuthException {
		FirebaseToken firebaseToken = FirebaseAuth.getInstance().verifyIdToken(token);
		UserRecord userRecord = FirebaseAuth.getInstance().getUser(firebaseToken.getUid());
		return userRecord.getPhoneNumber();
	}
}
