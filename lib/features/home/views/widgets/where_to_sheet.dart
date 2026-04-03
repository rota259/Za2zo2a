import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';

class WhereToSheet extends StatelessWidget {
  const WhereToSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.widthPct(24)),
          topRight: Radius.circular(context.widthPct(24)),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.widthPct(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: context.widthPct(40),
                  height: context.heightPct(4),
                  decoration: BoxDecoration(
                    color: AppColors.grey300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: context.heightPct(20)),
              Text('Hello, Alex!', style: AppTextStyles.h3(context)),
              SizedBox(height: context.heightPct(8)),
              Text(
                'Where would you like to go?',
                style: AppTextStyles.bodyMedium(context),
              ),
              SizedBox(height: context.heightPct(20)),

              // Search Input Box
              GestureDetector(
                onTap: () {
                  context.push('/home/search/destination');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(16),
                    vertical: context.heightPct(16),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(context.widthPct(12)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: AppColors.textSecondary),
                      SizedBox(width: context.widthPct(12)),
                      Text(
                        'Enter destination',
                        style: AppTextStyles.bodyMedium(
                          context,
                        ).copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: context.heightPct(16)),

              // Saved Locations Quick Access
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  String? homeAddress;
                  String? workAddress;

                  if (state is HomeLoaded) {
                    homeAddress = state.savedHomeAddress;
                    workAddress = state.savedWorkAddress;
                  }

                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: AppColors.grey200,
                          child: Icon(Icons.home, color: AppColors.textPrimary),
                        ),
                        title: Text(
                          'Home',
                          style: AppTextStyles.bodyMedium(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          homeAddress ?? 'Set home address',
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color: homeAddress == null
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ),
                        onTap: () {
                          if (homeAddress == null) {
                            context.push('/home/search/home');
                          } else {
                            context.read<HomeCubit>().selectDestination(
                              homeAddress,
                            );
                          }
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: AppColors.grey200,
                          child: Icon(Icons.work, color: AppColors.textPrimary),
                        ),
                        title: Text(
                          'Work',
                          style: AppTextStyles.bodyMedium(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          workAddress ?? 'Set work address',
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color: workAddress == null
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ),
                        onTap: () {
                          if (workAddress == null) {
                            context.push('/home/search/work');
                          } else {
                            context.read<HomeCubit>().selectDestination(
                              workAddress,
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
