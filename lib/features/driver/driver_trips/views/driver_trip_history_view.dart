import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/network/api_error.dart';
import '../../../../injection_container.dart';
import '../../../trips/data/models/trip_model.dart';
import '../../../trips/data/repos/trips_repo.dart';
import '../../driver_earnings/cubit/driver_earnings_cubit.dart';
import '../../driver_earnings/cubit/driver_earnings_state.dart';

class DriverTripHistoryView extends StatefulWidget {
  const DriverTripHistoryView({super.key});

  @override
  State<DriverTripHistoryView> createState() => _DriverTripHistoryViewState();
}

class _DriverTripHistoryViewState extends State<DriverTripHistoryView> {
  List<TripModel>? _trips;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
    context.read<DriverEarningsCubit>().loadEarnings();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final trips = await sl<TripsRepo>().getTripHistory(page: 1, limit: 50);
      if (!mounted) return;
      setState(() {
        _trips = trips;
        _loading = false;
      });
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.message;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go('/driver/home'),
        ),
        title: Text('Trip History', style: AppTextStyles.h2(context)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _summaryBar(context),
          const Divider(height: 1),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _summaryBar(BuildContext context) {
    return BlocBuilder<DriverEarningsCubit, DriverEarningsState>(
      builder: (context, state) {
        if (state is! DriverEarningsLoaded) {
          return const SizedBox(height: 8);
        }
        final e = state.earnings;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: AppColors.grey50,
          child: Row(
            children: [
              _summaryChip('Trips', '${e.totalTrips}'),
              const SizedBox(width: 12),
              _summaryChip('Earnings', '${e.currency} ${e.totalEarnings.toStringAsFixed(0)}'),
              const SizedBox(width: 12),
              _summaryChip('Avg Fare', '${e.currency} ${e.avgFare.toStringAsFixed(1)}'),
            ],
          ),
        );
      },
    );
  }

  Widget _summaryChip(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(value,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    }
    final trips = _trips ?? [];
    if (trips.isEmpty) {
      return const Center(child: Text('No trips yet'));
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: trips.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, i) {
          final t = trips[i];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            leading: CircleAvatar(
              backgroundColor: t.status.toLowerCase().contains('cancel')
                  ? AppColors.error.withValues(alpha: 0.1)
                  : AppColors.primary.withValues(alpha: 0.1),
              child: Icon(
                t.status.toLowerCase().contains('cancel')
                    ? Icons.cancel_outlined
                    : Icons.check_circle_outline,
                color: t.status.toLowerCase().contains('cancel')
                    ? AppColors.error
                    : AppColors.primary,
              ),
            ),
            title: Text(t.pickup,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.dropoff, maxLines: 1, overflow: TextOverflow.ellipsis),
                if (t.date.isNotEmpty || t.time.isNotEmpty)
                  Text('${t.date} ${t.time}'.trim(),
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
            trailing: Text(
              t.price > 0 ? 'EGP ${t.price.toStringAsFixed(0)}' : '',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
          );
        },
      ),
    );
  }
}
