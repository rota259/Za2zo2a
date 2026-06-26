import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../dispatch/driver_dispatch_cubit.dart';

class DriverOfflineButton extends StatelessWidget {
  final bool isOnline;

  const DriverOfflineButton({super.key, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: context.heightPct(20),
      left: context.widthPct(30),
      right: context.widthPct(30),
      child: GestureDetector(
        onTap: () {
          if (isOnline) {
            context.read<DriverDispatchCubit>().goOffline();
          } else {
            context.read<DriverDispatchCubit>().goOnline();
          }
        },
        child: Container(
          height: context.heightPct(60),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isOnline
                  ? [Colors.grey.shade700, Colors.grey.shade900]
                  : [AppColors.primary, Colors.pinkAccent.shade400],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(context.widthPct(30)),
            boxShadow: [
              BoxShadow(
                color: (isOnline ? Colors.grey : AppColors.primary).withValues(
                  alpha: 0.4,
                ),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.power_settings_new,
                color: Colors.white,
                size: context.widthPct(24),
              ),
              SizedBox(width: context.widthPct(10)),
              Text(
                isOnline ? 'GO OFFLINE' : 'GO ONLINE',
                style: AppTextStyles.button(
                  context,
                ).copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
