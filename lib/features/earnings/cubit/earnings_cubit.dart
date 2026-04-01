import 'package:flutter_bloc/flutter_bloc.dart';
import 'earnings_state.dart';

class EarningsCubit extends Cubit<EarningsState> {
  EarningsCubit() : super(EarningsInitial()) {
    _loadEarnings();
  }

  void _loadEarnings() async {
    await Future.delayed(const Duration(milliseconds: 500));
    emit(const EarningsLoaded(
      weekTotal: 450.50,
      balance: 120.00,
      chartData: [40, 80, 50, 120, 90, 60, 10.5], // Mon-Sun demo values
    ));
  }
}
