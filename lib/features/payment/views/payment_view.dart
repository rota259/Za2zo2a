import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../injection_container.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/cubit/auth_state.dart';
import '../../trips/data/models/trip_model.dart';
import '../../trips/data/repos/trips_repo.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  List<TripModel>? _trips;
  bool _loading = true;
  double _totalSpent = 0;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    setState(() => _loading = true);
    try {
      final trips = await sl<TripsRepo>().getTripHistory(page: 1, limit: 20);
      if (!mounted) return;
      double total = 0;
      for (final t in trips) {
        total += t.price;
      }
      setState(() {
        _trips = trips;
        _totalSpent = total;
        _loading = false;
      });
    } on ApiError {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final userName = auth is Authenticated ? auth.user.name : 'User';

    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadHistory,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Top bar
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(20),
                    vertical: context.heightPct(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.account_balance_wallet,
                          color: AppColors.primary,
                          size: context.widthPct(26)),
                      SizedBox(width: context.widthPct(8)),
                      Expanded(
                        child: Text('Wallet',
                            style: AppTextStyles.h2(context).copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold)),
                      ),
                      CircleAvatar(
                        radius: context.widthPct(18),
                        backgroundColor: AppColors.grey200,
                        child: Text(
                          userName.isNotEmpty
                              ? userName[0].toUpperCase()
                              : 'U',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: context.heightPct(4)),

                // ── Balance card — total spent from real trips
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.widthPct(16)),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(context.widthPct(24)),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE23030), Color(0xFFFF6B6B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(context.widthPct(16)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('TOTAL SPENT',
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: context.fontPct(11),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2)),
                        SizedBox(height: context.heightPct(8)),
                        _loading
                            ? const SizedBox(
                                height: 36,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2))
                            : Text(
                                'EGP ${_totalSpent.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: context.fontPct(36),
                                    fontWeight: FontWeight.bold),
                              ),
                        SizedBox(height: context.heightPct(8)),
                        Text(
                          '${_trips?.length ?? 0} completed trips',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: context.fontPct(12)),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: context.heightPct(12)),

                // ── Payment method — cash only for now
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.widthPct(16)),
                  child: Container(
                    padding: EdgeInsets.all(context.widthPct(16)),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius:
                          BorderRadius.circular(context.widthPct(12)),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 6,
                            offset: Offset(0, 2)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PAYMENT METHOD',
                            style: AppTextStyles.bodySmall(context).copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1)),
                        SizedBox(height: context.heightPct(12)),
                        Row(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.all(context.widthPct(10)),
                              decoration: BoxDecoration(
                                color: AppColors.grey50,
                                borderRadius: BorderRadius.circular(
                                    context.widthPct(8)),
                              ),
                              child: Icon(Icons.payments_outlined,
                                  color: AppColors.primary,
                                  size: context.widthPct(24)),
                            ),
                            SizedBox(width: context.widthPct(14)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text('Cash',
                                      style: AppTextStyles.bodyLarge(
                                              context)
                                          .copyWith(
                                              fontWeight:
                                                  FontWeight.bold)),
                                  Text('Pay driver directly',
                                      style: AppTextStyles.bodySmall(
                                              context)
                                          .copyWith(
                                              color: AppColors
                                                  .textSecondary)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text('DEFAULT',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: context.heightPct(28)),

                // ── Recent Transactions — real from trip history
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.widthPct(16)),
                  child: Text('Recent Trips',
                      style: AppTextStyles.h3(context)
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: context.heightPct(12)),

                if (_loading)
                  const Center(
                      child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator()))
                else if (_trips == null || _trips!.isEmpty)
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Text('No trips yet',
                              style: AppTextStyles.bodyMedium(context)
                                  .copyWith(
                                      color: AppColors.textSecondary))))
                else
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.widthPct(16)),
                    child: Column(
                      children: _trips!.map((t) {
                        return _TripTransactionCard(
                          pickup: t.pickup,
                          dropoff: t.dropoff,
                          date: '${t.date} ${t.time}'.trim(),
                          amount: t.price > 0
                              ? 'EGP ${t.price.toStringAsFixed(0)}'
                              : '--',
                          status: t.status,
                        );
                      }).toList(),
                    ),
                  ),
                SizedBox(height: context.heightPct(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TripTransactionCard extends StatelessWidget {
  final String pickup;
  final String dropoff;
  final String date;
  final String amount;
  final String status;

  const _TripTransactionCard({
    required this.pickup,
    required this.dropoff,
    required this.date,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = status.toLowerCase().contains('complet');
    return Container(
      margin: EdgeInsets.only(bottom: context.heightPct(10)),
      padding: EdgeInsets.all(context.widthPct(16)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(context.widthPct(12)),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 6,
              offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.widthPct(10)),
            decoration: BoxDecoration(
              color: isCompleted
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFFFEBEE),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompleted ? Icons.check_circle : Icons.cancel,
              color: isCompleted
                  ? const Color(0xFF388E3C)
                  : AppColors.error,
              size: context.widthPct(22),
            ),
          ),
          SizedBox(width: context.widthPct(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pickup,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLarge(context)
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(dropoff,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall(context)
                        .copyWith(color: AppColors.textSecondary)),
                if (date.isNotEmpty)
                  Text(date,
                      style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textSecondary)),
              ],
            ),
          ),
          Text(amount,
              style: AppTextStyles.bodyLarge(context)
                  .copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
