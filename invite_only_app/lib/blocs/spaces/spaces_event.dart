import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SpacesEvent extends Equatable {
  const SpacesEvent();
}

class LoadSpaces extends SpacesEvent {
  @override
  List<Object> get props => [];
}
