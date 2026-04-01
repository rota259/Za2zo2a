import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final String? currentLocation;
  final String? selectedDestination;
  final String? savedHomeAddress;
  final String? savedWorkAddress;

  const HomeLoaded({
    this.currentLocation, 
    this.selectedDestination,
    this.savedHomeAddress,
    this.savedWorkAddress,
  });

  @override
  List<Object?> get props => [
    currentLocation, 
    selectedDestination,
    savedHomeAddress,
    savedWorkAddress,
  ];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
