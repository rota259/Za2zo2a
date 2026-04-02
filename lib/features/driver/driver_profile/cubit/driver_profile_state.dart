import 'package:equatable/equatable.dart';
import '../data/models/driver_profile_model.dart';

abstract class DriverProfileState extends Equatable {
  const DriverProfileState();

  @override
  List<Object?> get props => [];
}

class DriverProfileInitial extends DriverProfileState {}

class DriverProfileLoading extends DriverProfileState {}

class DriverProfileLoaded extends DriverProfileState {
  final DriverProfileModel profile;

  const DriverProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class DriverProfileUpdating extends DriverProfileState {
  final DriverProfileModel profile;

  const DriverProfileUpdating(this.profile);

  @override
  List<Object?> get props => [profile];
}

class DriverProfileError extends DriverProfileState {
  final String message;

  const DriverProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
