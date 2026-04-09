import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../map/domain/usecases/get_user_location_use_case.dart';
import '../../map/presentation/view/map_view.dart';
import '../../map/presentation/viewmodel/map_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindingDriverView extends StatefulWidget {
  const FindingDriverView({super.key});

  @override
  State<FindingDriverView> createState() => _FindingDriverViewState();
}

class _FindingDriverViewState extends State<FindingDriverView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late final MapCubit _mapCubit;

  @override
  void initState() {
    super.initState();
    _mapCubit = MapCubit(getUserLocationUseCase: const GetUserLocationUseCase())
      ..initLocation();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) context.pushReplacement('/home/active-trip');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _mapCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _mapCubit,
        child: Stack(
          children: [
            const Positioned.fill(child: MapView.embedded()),
            Container(color: AppColors.background.withValues(alpha: 0.85)),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(context.widthPct(16)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => context.pop(),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) => Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Opacity(
                              opacity: _opacityAnimation.value,
                              child: Container(
                                width: context.widthPct(150),
                                height: context.widthPct(150),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: context.widthPct(80),
                          height: context.widthPct(80),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.heightPct(40)),
                  Text(
                    'Finding the fastest driver\nfor your route...',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h2(context).copyWith(height: 1.4),
                  ),
                  SizedBox(height: context.heightPct(16)),
                  Text(
                    'Please wait while we connect you to the best drivers nearby.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium(
                      context,
                    ).copyWith(color: AppColors.textSecondary),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
