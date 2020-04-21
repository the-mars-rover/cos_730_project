import 'package:equatable/equatable.dart';
import 'package:rsa_scan/rsa_scan.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LoadProfileDetails extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class UploadDocument extends ProfileEvent {
  final RsaIdDocument scannedDocument;

  UploadDocument(this.scannedDocument);

  @override
  List<Object> get props => [scannedDocument];
}
