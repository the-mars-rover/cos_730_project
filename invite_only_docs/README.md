# invite_only_docs

Access and manage identity document information for Invite Only users.

## Prerequisites

### Android

1. Using the [Firebase Console](http://console.firebase.google.com/), add an Android app to your project.
2. Follow the assistant, and download the generated `google-services.json` file and place it inside `android/app`.
3. Modify the `android/build.gradle` file and the `android/app/build.gradle` file to add the Google services plugin as described by the Firebase assistant. Ensure that your `android/build.gradle` file contains the
`maven.google.com` as [described here](https://firebase.google.com/docs/android/setup#add_the_sdk).

### iOS

1. Using the [Firebase Console](http://console.firebase.google.com/), add an iOS app to your project.
2. Follow the assistant, download the generated `GoogleService-Info.plist` file. Do **NOT** follow the steps named _"Add Firebase SDK"_ and _"Add initialization code"_ in the Firebase assistant.
3. Open `ios/Runner.xcworkspace` with Xcode, and **within Xcode** place the `GoogleService-Info.plist` file inside `ios/Runner`.

## Usage

Retrieve a stream of a documented user's details:
```dart
    import import 'package:invite_only_docs/invite_only_docs.dart';

    IdDocsRepository idDocsRepository = IdDocsRepository.instance;
    Stream<DocumentedUser> documentedUserStream = await idDocsRepository.documentedUser(userId);
```

Retrieve a stream of a documented user's details, note that if no user is found with the given ID
a user with no attached documents will be created with the given ID:
```dart
    import import 'package:invite_only_docs/invite_only_docs.dart';

    IdDocsRepository idDocsRepository = IdDocsRepository.instance;
    Stream<DocumentedUser> documentedUserStream = await idDocsRepository.documentedUser(userId);
```

Submit a document for a user:
```dart
    import import 'package:invite_only_docs/invite_only_docs.dart';

    IdDocsRepository idDocsRepository = IdDocsRepository.instance;
    IdBook idBook = IdDocument.idBook(idNumber: '5809155800088', gender: 'M', birthDate: DateTime(1958, 9, 15), citizenshipStatus: 'SA Citizen');
    try {
      await idDocsRepository.submitDocument(userId, idBook);
    } on DocumentedRejected catch (e) {
      print (e.reason);
    } 
```

Delete all stored information for a user:
```dart
    import import 'package:invite_only_docs/invite_only_docs.dart';

    IdDocsRepository idDocsRepository = IdDocsRepository.instance;
    await idDocsRepository.deleteUser(userId);
```