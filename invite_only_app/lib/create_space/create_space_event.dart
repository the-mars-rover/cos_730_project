import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class CreateSpaceEvent extends Equatable {
  const CreateSpaceEvent();
}

class InitializeCreateSpace extends CreateSpaceEvent {
  @override
  List<Object> get props => [];
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
  final int maxCapacity;

  CreateSpace({
    @required this.title,
    @required this.imageUrl,
    @required this.managerPhones,
    @required this.guardPhones,
    @required this.inviterPhones,
    @required this.locationLatitude,
    @required this.locationLongitude,
    @required this.minAge,
    @required this.maxCapacity,
  });

  @override
  List<Object> get props => [];
}
