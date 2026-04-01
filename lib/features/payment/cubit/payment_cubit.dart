import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial()) {
    _loadCards();
  }

  void _loadCards() async {
    await Future.delayed(const Duration(milliseconds: 500));
    emit(const PaymentLoaded(['Visa **** 1234', 'MasterCard **** 5678']));
  }

  void addCard(String card) {
    if (state is PaymentLoaded) {
      final current = (state as PaymentLoaded).savedCards;
      emit(PaymentLoaded([...current, card]));
    }
  }
}
