<!-- PROJECT LOGO -->
<p align="right">
<a href="https://pub.dev">
<img src="https://raw.githubusercontent.com/marcus-bornman/invite_only_platform/master/invite_only_repo/assets/project_badge.png" height="100" alt="Project Badge">
</a>
</p>
<p align="center">
<img src="https://raw.githubusercontent.com/marcus-bornman/invite_only_platform/master/invite_only_repo/assets/project_logo.png" height="100" alt="Project Logo" />
</p>

<!-- PROJECT SHIELDS -->
<p align="center">
<a href="https://github.com/marcus-bornman/cos_700_project/actions?query=workflow%3Atest-io-repo"><img src="https://img.shields.io/github/workflow/status/marcus-bornman/cos_700_project/test-io-repo?label=test" alt="test"></a>
<a href="https://github.com/marcus-bornman/cos_700_project/issues"><img src="https://img.shields.io/github/issues/marcus-bornman/cos_700_project" alt="issues"></a>
<a href="https://github.com/marcus-bornman/cos_700_project/network"><img src="https://img.shields.io/github/forks/marcus-bornman/cos_700_project" alt="forks"></a>
<a href="https://github.com/marcus-bornman/cos_700_project/stargazers"><img src="https://img.shields.io/github/stars/marcus-bornman/cos_700_project" alt="stars"></a>
<a href="https://dart.dev/guides/language/effective-dart/style"><img src="https://img.shields.io/badge/style-effective_dart-40c4ff.svg" alt="style"></a>
<a href="https://github.com/marcus-bornman/cos_700_project/blob/master/LICENSE"><img src="https://img.shields.io/github/license/marcus-bornman/cos_700_project" alt="license"></a>
</p>

---

<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
* [Getting Started](#getting-started)
* [Usage](#usage)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)
* [Acknowledgements](#acknowledgements)



<!-- ABOUT THE PROJECT -->
## About The Project
<p align="center">
<img src="https://raw.githubusercontent.com/marcus-bornman/invite_only_platform/master/invite_only_repo/assets/screenshot_1.png" width="800" alt="Screenshot 1" />
</p>

This project provides a [Flutter package](https://flutter.dev/docs/development/packages-and-plugins) which provides the 
means for any flutter application to interact with the [Invite Only Core API](../invite_only_core).

### Built With
* [Flutter](https://flutter.dev/)
* [Firebase](https://firebase.google.com)



<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

Since this is a [Flutter package](https://flutter.dev/docs/development/packages-and-plugins), you will need to use it from
within a Flutter App. A few resources to get you started with your first Flutter project:                   
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

Also, because this plugin makes use of Firebase Authentication, you must [configure Firebase for your project](https://firebase.google.com/docs/flutter/setup). 

### Installation
Add `invite_only_repo` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

#### iOS
[Configure Firebase for your iOS project](https://firebase.flutter.dev/docs/installation/ios).

#### Android
[Configure Firebase for your Android project](https://firebase.flutter.dev/docs/installation/android).


<!-- USAGE EXAMPLES -->
## Usage
### Authenticating a User
All functionality is restricted to users who have been authenticated. Follow the steps in this section to 
authenticate a user.

#### 1. Check if the user is already authenticated.
```dart
import 'package:invite_only_repo/invite_only_repo.dart';

final _inviteOnlyRepo = InviteOnlyRepo.instance;
final currentPhoneNumber = _inviteOnlyRepo.currentUser();
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
the API documentation, these include:
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



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/marcus-bornman/cos_700_project/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See [LICENSE](LICENSE) for more information.



<!-- CONTACT -->
## Contact

BornIdeas - [marcusbornman.com](https://www.marcusbornman.com) - [marcus.bornman@gmail.com](mailto:marcus.bornman@gmail.com)

Project Link: [https://github.com/marcus-bornman/invite_only_platform](https://github.com/marcus-bornman/invite_only_platform)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [invite_only_core](../invite_only_core)
* [Shields IO](https://shields.io)
* [Open Source Licenses](https://choosealicense.com)