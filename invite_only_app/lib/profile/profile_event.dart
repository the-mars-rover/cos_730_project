import 'package:equatable/equatable.dart';
import 'package:rsa_scan/rsa_scan.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LoadProfileDetails extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class UploadIdCard extends ProfileEvent {
  final RsaIdCard scannedIdCard;

  UploadIdCard(this.scannedIdCard);

  @override
  List<Object> get props => [scannedIdCard];
}

class UploadIdBook extends ProfileEvent {
  final RsaIdBook scannedIdBook;

  UploadIdBook(this.scannedIdBook);

  @override
  List<Object> get props => [scannedIdBook];
}
