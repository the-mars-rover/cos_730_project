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
  final RsaIdBook scannedIdBook;
  final RsaIdCard scannedIdCard;

  UploadDocument({
    this.scannedIdBook,
    this.scannedIdCard,
  });

  @override
  List<Object> get props => [scannedIdBook, scannedIdCard];
}
