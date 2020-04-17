# invite_only_users

Provides means to authenticate users for the Invite Only platform or to retrieve the currently authenticated user.

## Prerequisites

This package depends on the [firebase_auth](https://pub.dev/packages/firebase_auth); therefore, you must configure 
Firebase for each platform project: Android and iOS (see https://firebase.google.com/docs/flutter/setup?platform=android).

### iOS
Enable Phone as a Sign-In method in the [Firebase console](https://console.firebase.google.com/u/0/project/_/authentication/providers)

[Enable App verification](https://firebase.google.com/docs/auth/ios/phone-auth#enable-app-verification) 

**Note:** App verification may use APNs, if using a simulator (where APNs does not work) or APNs is not setup on the
device you are using you must set the `URL Schemes` to the `REVERSE_CLIENT_ID` from the GoogleServices-Info.plist file.

### Android
Enable Phone as a Sign-In method in the [Firebase console](https://console.firebase.google.com/u/0/project/_/authentication/providers)

Enable the Google services by configuring the Gradle scripts as such.

1. Add the classpath to the `[project]/android/build.gradle` file.
```gradle
dependencies {
  // Example existing classpath
  classpath 'com.android.tools.build:gradle:3.2.1'
  // Add the google services classpath
  classpath 'com.google.gms:google-services:4.3.0'
}
```

2. Add the apply plugin to the `[project]/android/app/build.gradle` file.
```gradle
// ADD THIS AT THE BOTTOM
apply plugin: 'com.google.gms.google-services'
```

*Note:* If this section is not completed you will get an error like this:
```
java.lang.IllegalStateException:
Default FirebaseApp is not initialized in this process [package name].
Make sure to call FirebaseApp.initializeApp(Context) first.
```

*Note:* When you are debugging on android, use a device or AVD with Google Play services.
Otherwise you will not be able to authenticate.

## Usage

### Retrieving the currently authenticated user

To retrieve a user that has already been authenticated use AuthRepository.currentUser:
```dart
    import 'package:invite_only_auth/invite_only_auth.dart';

    AuthRepository authRepository = AuthRepository.instance;
    User currentUser = await authRepository.currentUser();
```

### Authenticating a new user

All users must provide a valid phone number to create a profile or to sign in.
To verify the user's phone number use `AuthRepository.verifyPhoneNumber`:
```dart
    import 'package:invite_only_auth/invite_only_auth.dart';

    AuthRepository authRepository = AuthRepository.instance;
    await authRepository.verifyPhoneNumber(
      phoneNumber: phoneNumber, // the user's phone number
      retrievalTimeout: timeout, // the timeout for automatically retrieving the verification code
      verificationCompleted: (authCredential) {
        // the phone number has been automatically verified, use authCredential to sign in.
      },
      verificationFailed: (authException) {
        // something went wrong when verifying the phone number, handle the authException.
      },
      codeSent: (verificationId) {
        // an SMS code has been sent to verify the phone number, use verificationId to get an auth credential.
      },
    );
```

If the `verificationCompleted` callback is not called, the phone number could not be automatically validated. So, the user
must submit the SMS code manually. Use the manually submitted SMS code, along with the `verificationId` received from the
`codeSent` callback, to get an authentication credential as follows:
```dart
    import 'package:invite_only_auth/invite_only_auth.dart';

    AuthRepository authRepository = AuthRepository.instance;
    final authCredential = authRepository.getAuthCredential(verificationId, smsCode);
```

Finally, now that you have an authentication credential (retrieved either from the `verificationCompleted` callback or
manually using `AuthRepository.getAuthCredential`), sign the use in using the credential:
```dart
    import 'package:invite_only_auth/invite_only_auth.dart';

    AuthRepository authRepository = AuthRepository.instance;
    final authCredential = authRepository.signInWithCredential(authCredential);
```