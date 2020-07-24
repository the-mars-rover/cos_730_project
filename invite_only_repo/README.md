# Invite Only Repo

[![Codemagic build status](https://api.codemagic.io/apps/5ed4f6a067d168000dd90859/5edc9c6a0e8f47156c993d6a/status_badge.svg)](https://codemagic.io/apps/5ed4f6a067d168000dd90859/5edc9c6a0e8f47156c993d6a/latest_build)

This is the root of the Invite Only Repo flutter package. The package provides the means for any flutter application to
interact with the [Invite Only Core API](../invite_only_core).

## Usage

### Authenticating a User

All functionality is restricted to users who have been authenticated. Follow the steps in this section to 
authenticate a user.

#### 1. Check if the user is already authenticated.
```dart
import 'package:invite_only_repo/invite_only_repo.dart';

final _inviteOnlyRepo = InviteOnlyRepo.instance;
final currentPhoneNumber = await _inviteOnlyRepo.currentUser();
if (currentPhoneNumber != null) {
  // user is already signed in, currentPhoneNumber is the current user's phone number.
}

// User needs to be authenticated.
```

#### 2. If the user is not authenticated, verify their phone number.
```dart
import 'package:invite_only_repo/invite_only_repo.dart';

final _inviteOnlyRepo = InviteOnlyRepo.instance;
await _inviteOnlyRepo.verifyPhoneNumber(
    phoneNumber: phoneNumber, // the phone number being verified
    retrievalTimeout: timeout, // the amount of time to wait for the phone number to be automatically verified
    verificationCompleted: (authCredential) {
      // sign in with the provided credential
    },
    verificationFailed: (authException) {
      // handle failed phone verification
    },
    codeSent: (verificationId, [forceResendingToken]) {
      // an SMS code has been sent (but not automatically verified) - get a credential using verificationId and the provided sms code
    },
);
```

#### 3. Sign in using an authentication credential

If the `verificationCompleted` callback from the previous step was called, the phone number was automatically verified
and an authentication credential provided - use the credential to complete the sign in.
```dart
import 'package:invite_only_repo/invite_only_repo.dart';

final _inviteOnlyRepo = InviteOnlyRepo.instance;
...
try {
  await _inviteOnlyRepo.signInWithCredential(authCredential);

  // the user has been signed in 
} on AuthFailure catch (e) {
  // the credential could not be used to sign in - handle the error
}
```
If the `codeSent` callback from the previous step was called, the user must provide an SMS code - use this with the
verificationId to get a credential.
```dart
import 'package:invite_only_repo/invite_only_repo.dart';

final _inviteOnlyRepo = InviteOnlyRepo.instance;
...
try {
  final authCredential = _inviteOnlyRepo.getAuthCredential(verificationId, smsCode);
  await _inviteOnlyRepo.signInWithCredential(event.authCredential);

  // the user has been signed in 
} on AuthFailure catch (e) {
  // the credential could not be used to sign in - handle the error
}
```

#### 4. Sign out
After being signed in, the user will remain signed in until signing out.
```dart
import 'package:invite_only_repo/invite_only_repo.dart';

final _inviteOnlyRepo = InviteOnlyRepo.instance;
...
await _inviteOnlyRepo.signOut();
```

### Provided functionality
After being authenticated, there are a range of different methods available to use. Detailed more extensively within
the code documentation, these include:
- Fetching a user's ID Documents
- Adding an ID Document to a user
- Deleting an ID Document
- Fetching accessible spaces
- Adding a space
- Updating a space
- Deleting a space
- Creating an invite code
- Fetching viewable entries
- Adding a new entry

## Contributing

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects. For help getting started with Flutter, view the 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

When familiar with the above mentioned documentation developers should be able
to recognize the structure of this package. The code is documented such that understanding the 
implementation itself should also be simple.

For any new features or enhancements please submit a pull request on the root repository with
all necessary details and the pull request will be reviewed by the necessary code owners.
