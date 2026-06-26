import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/cubit/auth_state.dart';
import '../../auth/views/widgets/auth_nav.dart';

/// Boot screen. The global [AuthCubit] starts session restore at app start
/// (GET /api/auth/me when a token is stored); this screen reacts to the
/// resolved state and routes by role, or to login when unauthenticated.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    // Handle the case where restore already resolved before we subscribed.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handle(context.read<AuthCubit>().state);
    });
  }

  void _handle(AuthState state) {
    if (_navigated || !mounted) return;
    if (state is Authenticated) {
      _navigated = true;
      routeByRole(context, state.user);
    } else if (state is Unauthenticated || state is AuthFailure) {
      _navigated = true;
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) => _handle(state),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_taxi,
                  size: context.widthPct(80), color: Colors.white),
              SizedBox(height: context.heightPct(16)),
              Text(
                'Za2zo2a',
                style: AppTextStyles.h1(context).copyWith(
                    color: Colors.white, fontSize: context.fontPct(36)),
              ),
              SizedBox(height: context.heightPct(32)),
              const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
