import 'package:equatable/equatable.dart';
import '../data/models/driver_earnings_model.dart';

abstract class DriverEarningsState extends Equatable {
  const DriverEarningsState();

  @override
  List<Object?> get props => [];
}

class DriverEarningsInitial extends DriverEarningsState {}

class DriverEarningsLoading extends DriverEarningsState {}

class DriverEarningsLoaded extends DriverEarningsState {
  final DriverEarningsModel earnings;
  final String selectedPeriod; // 'today' | 'week' | 'month'

  const DriverEarningsLoaded({
    required this.earnings,
    this.selectedPeriod = 'week',
  });

  @override
  List<Object?> get props => [earnings, selectedPeriod];
}

class DriverEarningsError extends DriverEarningsState {
  final String message;

  const DriverEarningsError(this.message);

  @override
  List<Object?> get props => [message];
}
