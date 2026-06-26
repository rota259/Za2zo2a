import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/network/api_error.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../injection_container.dart';
import '../../data/driver_repo.dart';

class DriverBonusCard extends StatefulWidget {
  const DriverBonusCard({super.key});

  @override
  State<DriverBonusCard> createState() => _DriverBonusCardState();
}

class _DriverBonusCardState extends State<DriverBonusCard> {
  String _title = 'Loading…';
  int _completed = 0;
  int _target = 1;
  double _reward = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await sl<DriverRepo>().getBonus();
      if (!mounted) return;
      setState(() {
        _reward = data.reward;
        _completed = data.completed;
        _target = data.target > 0 ? data.target : 1;
        final currency = data.currency.isNotEmpty ? data.currency : 'EGP';
        final achieved = data.achieved;
        if (achieved) {
          _title = 'Bonus earned! $currency ${_reward.toStringAsFixed(0)}';
        } else if (_reward > 0) {
          _title = '+$currency ${_reward.toStringAsFixed(0)} for ${_target - _completed} more rides';
        } else {
          _title = 'No active bonus';
        }
      });
    } on ApiError {
      if (mounted) setState(() => _title = 'No active bonus');
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = _target > 0 ? (_completed / _target).clamp(0.0, 1.0) : 0.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.widthPct(16)),
      child: Container(
        padding: EdgeInsets.all(context.widthPct(16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.widthPct(16)),
          border: Border.all(color: Colors.orange.shade200),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome,
                    color: Colors.orange, size: context.widthPct(16)),
                SizedBox(width: context.widthPct(6)),
                Text("TODAY'S BONUS",
                    style: AppTextStyles.caption(context).copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1)),
              ],
            ),
            SizedBox(height: context.heightPct(8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(_title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.h3(context)
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.all(context.widthPct(6)),
                  decoration: BoxDecoration(
                      color: Colors.orange.shade50, shape: BoxShape.circle),
                  child: Icon(Icons.flash_on,
                      color: Colors.orange, size: context.widthPct(16)),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(12)),
            Text('$_completed/$_target COMPLETED',
                style: AppTextStyles.caption(context).copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: context.heightPct(6)),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.grey200,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ],
        ),
      ),
    );
  }
}
