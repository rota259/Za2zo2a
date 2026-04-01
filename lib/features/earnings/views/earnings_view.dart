import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/earnings_cubit.dart';
import '../cubit/earnings_state.dart';

class EarningsView extends StatelessWidget {
  const EarningsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Earnings', style: AppTextStyles.h2(context)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<EarningsCubit, EarningsState>(
        builder: (context, state) {
          if (state is! EarningsLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final earnings = state;

          return ListView(
            padding: EdgeInsets.all(context.widthPct(24)),
            children: [
              Container(
                padding: EdgeInsets.all(context.widthPct(24)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, Color(0xFFB71C1C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(context.widthPct(16)),
                ),
                child: Column(
                  children: [
                    Text('This Week', style: AppTextStyles.bodyMedium(context).copyWith(color: Colors.white70)),
                    SizedBox(height: context.heightPct(8)),
                    Text('\$${earnings.weekTotal.toStringAsFixed(2)}', style: AppTextStyles.h1(context).copyWith(color: Colors.white, fontSize: context.fontPct(36))),
                  ],
                ),
              ),
              
              SizedBox(height: context.heightPct(40)),
              Text('Available Balance', style: AppTextStyles.h3(context)),
              SizedBox(height: context.heightPct(8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${earnings.balance.toStringAsFixed(2)}', style: AppTextStyles.h2(context)),
                  SizedBox(
                    width: context.widthPct(120),
                    child: CustomButton(
                      text: 'Cash Out',
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              
              SizedBox(height: context.heightPct(40)),
              Text('Weekly Chart', style: AppTextStyles.h3(context)),
              SizedBox(height: context.heightPct(24)),
              
              // Custom Bar Chart (Demo)
              SizedBox(
                height: context.heightPct(200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(7, (index) {
                    final value = earnings.chartData[index];
                    final maxHeight = 120.0;
                    final height = (value / maxHeight) * context.heightPct(150); // max chart height scaled
                    final isToday = index == 3; // fake today as Thursday
                    
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: context.widthPct(20),
                          height: height.clamp(0.0, context.heightPct(150)),
                          decoration: BoxDecoration(
                            color: isToday ? AppColors.primary : AppColors.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(context.widthPct(4)),
                          ),
                        ),
                        SizedBox(height: context.heightPct(8)),
                        Text(
                          ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                          style: AppTextStyles.caption(context).copyWith(
                            color: isToday ? AppColors.primary : AppColors.textSecondary,
                            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
