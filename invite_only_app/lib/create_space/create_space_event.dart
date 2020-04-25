import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class CreateSpaceEvent extends Equatable {
  const CreateSpaceEvent();
}

class CreateSpace extends CreateSpaceEvent {
  final String title;
  final String imageUrl;
  final List<String> managerPhones;
  final List<String> guardPhones;
  final List<String> inviterPhones;
  final double locationLatitude;
  final double locationLongitude;
  final int minAge;

  CreateSpace({
    @required this.title,
    @required this.imageUrl,
    @required this.managerPhones,
    @required this.guardPhones,
    @required this.inviterPhones,
    @required this.locationLatitude,
    @required this.locationLongitude,
    @required this.minAge,
  });

  @override
  List<Object> get props => [];
}
