import 'package:equatable/equatable.dart';

abstract class EarningsState extends Equatable {
  const EarningsState();

  @override
  List<Object> get props => [];
}

class EarningsInitial extends EarningsState {}

class EarningsLoaded extends EarningsState {
  final double weekTotal;
  final double balance;
  final List<double> chartData;

  const EarningsLoaded({
    required this.weekTotal,
    required this.balance,
    required this.chartData,
  });

  @override
  List<Object> get props => [weekTotal, balance, chartData];
}
