import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Temporary Logo text instead of image since we don't have assets yet
            Icon(
              Icons.local_taxi,
              size: context.widthPct(80),
              color: Colors.white,
            ),
            SizedBox(height: context.heightPct(16)),
            Text(
              'Za2zo2a',
              style: AppTextStyles.h1(context).copyWith(
                color: Colors.white,
                fontSize: context.fontPct(36),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
