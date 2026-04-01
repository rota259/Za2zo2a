import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<String> savedCards; // Just last 4 digits for demo

  const PaymentLoaded(this.savedCards);

  @override
  List<Object> get props => [savedCards];
}
