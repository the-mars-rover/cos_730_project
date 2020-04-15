import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_docs/invite_only_docs.dart';
import './profile.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  /// The repository for retrieving authentication details
  final _authRepository = AuthRepository.instance;

  /// The repository for retrieving documented users
  final _idDocsRepository = IdDocsRepository.instance;

  @override
  ProfileState get initialState => LoadingProfileDetails();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LoadProfileDetails) {
      yield* _mapLoadProfilDetailsToState(event);
    }

    if (event is CaptureDocument) {
      yield* _mapCaptureDocumentToState(event);
    }
  }

  Stream<ProfileState> _mapLoadProfilDetailsToState(
      LoadProfileDetails event) async* {
    final user = await _authRepository.currentUser();
    final documentedUserStream =
        await _idDocsRepository.documentedUser(user.id);

    yield ProfileDetailsLoaded(user.phoneNumber, documentedUserStream);
  }

  Stream<ProfileState> _mapCaptureDocumentToState(
      CaptureDocument event) async* {
    yield CapturingDocument();

//    final image = await ImagePicker.pickImage(
//      source: ImageSource.camera,
//      imageQuality: Resolol,
//    );
//
//    if (image == null) {
//      this.add(LoadProfileDetails());
//      return;
//    }

//    final visionImage = FirebaseVisionImage.fromFile(image);

//    final cloudLabeler = FirebaseVision.instance.cloudImageLabeler();
//    final labeler = FirebaseVision.instance.imageLabeler();
//    final textRecognizer = FirebaseVision.instance.textRecognizer();
//    final barcodeDetector = FirebaseVision.instance.barcodeDetector();

//    final cloudLabels = await cloudLabeler.processImage(visionImage);
//    final labels = await labeler.processImage(visionImage);
//    final visionText = await textRecognizer.processImage(visionImage);
//    final barcodes = await barcodeDetector.detectInImage(visionImage);

//    await cloudLabeler.close();
//    await labeler.close();
//    await textRecognizer.close();
//    await barcodeDetector.close();

    this.add(LoadProfileDetails());
  }
}
