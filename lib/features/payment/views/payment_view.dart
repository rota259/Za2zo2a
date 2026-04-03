import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/payment_cubit.dart';
import '../cubit/payment_state.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                        Icon(
                          Icons.menu,
                          color: AppColors.primary,
                          size: context.widthPct(26),
                        ),
                        SizedBox(width: context.widthPct(8)),
                        Text(
                          'Crimson Velocity',
                          style: AppTextStyles.h2(context).copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.widthPct(12),
                            vertical: context.heightPct(5),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF8F00),
                            borderRadius: BorderRadius.circular(
                              context.widthPct(20),
                            ),
                          ),
                          child: Text(
                            'PREMIUM',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: context.fontPct(10),
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                        SizedBox(width: context.widthPct(10)),
                        CircleAvatar(
                          radius: context.widthPct(20),
                          backgroundColor: AppColors.grey200,
                          child: Icon(
                            Icons.person,
                            color: AppColors.grey500,
                            size: context.widthPct(20),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: context.heightPct(4)),

                  // ── Balance card
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(16),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(context.widthPct(24)),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE23030), Color(0xFFFF6B6B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(
                          context.widthPct(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AVAILABLE BALANCE',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: context.fontPct(11),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: context.heightPct(8)),
                          Text(
                            r'$142.50',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: context.fontPct(36),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: context.heightPct(20)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(
                                horizontal: context.widthPct(32),
                                vertical: context.heightPct(12),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  context.widthPct(50),
                                ),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Top Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: context.fontPct(14),
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: context.heightPct(20)),

                  // ── Primary Method
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(16),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(context.widthPct(16)),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(
                          context.widthPct(12),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PRIMARY METHOD',
                            style: AppTextStyles.bodySmall(context).copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                            ),
                          ),
                          SizedBox(height: context.heightPct(12)),
                          Row(
                            children: [
                              // Card icon
                              Container(
                                padding: EdgeInsets.all(context.widthPct(10)),
                                decoration: BoxDecoration(
                                  color: AppColors.grey50,
                                  borderRadius: BorderRadius.circular(
                                    context.widthPct(8),
                                  ),
                                ),
                                child: Icon(
                                  Icons.credit_card,
                                  color: AppColors.primary,
                                  size: context.widthPct(24),
                                ),
                              ),
                              SizedBox(width: context.widthPct(14)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Visa •••• 4421',
                                      style: AppTextStyles.bodyLarge(
                                        context,
                                      ).copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'EXPIRY   09/27',
                                      style: AppTextStyles.bodySmall(context)
                                          .copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Edit Card',
                                  style: AppTextStyles.bodySmall(context)
                                      .copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: context.heightPct(12)),

                  // ── Add Payment Method
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(16),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        context.read<PaymentCubit>().addCard('Visa **** 9999');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Card added (Demo)'),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.widthPct(16),
                          vertical: context.heightPct(16),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(
                            context.widthPct(12),
                          ),
                          border: Border.all(
                            color: AppColors.grey200,
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: AppColors.primary,
                              size: context.widthPct(20),
                            ),
                            SizedBox(width: context.widthPct(12)),
                            Text(
                              'Add Payment Method',
                              style: AppTextStyles.bodyLarge(context).copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.chevron_right, color: AppColors.grey400),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: context.heightPct(28)),

                  // ── Recent Transactions header
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Transactions',
                          style: AppTextStyles.h3(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/trips'),
                          child: Text(
                            'VIEW ALL',
                            style: AppTextStyles.bodySmall(context).copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: context.heightPct(12)),

                  // ── Transaction Cards
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(16),
                    ),
                    child: Column(
                      children: const [
                        _TransactionCard(
                          icon: Icons.flight_takeoff,
                          iconBg: Color(0xFFFFEBEE),
                          iconColor: Color(0xFFE23030),
                          title: 'Airport Transfer',
                          date: 'Oct 24, 2023 • 10:45 AM',
                          amount: r'$32.00',
                        ),
                        _TransactionCard(
                          icon: Icons.bolt,
                          iconBg: Color(0xFFFFF3E0),
                          iconColor: Color(0xFFFF8F00),
                          title: 'Rush Hour Priority',
                          date: 'Oct 22, 2023 • 06:12 PM',
                          amount: r'$18.50',
                        ),
                        _TransactionCard(
                          icon: Icons.directions_car,
                          iconBg: Color(0xFFFFEBEE),
                          iconColor: Color(0xFFE23030),
                          title: 'City Centre Hop',
                          date: 'Oct 20, 2023 • 02:30 PM',
                          amount: r'$12.20',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String date;
  final String amount;

  const _TransactionCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
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
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.widthPct(10)),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: context.widthPct(22)),
          ),
          SizedBox(width: context.widthPct(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLarge(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: context.heightPct(2)),
                Text(
                  date,
                  style: AppTextStyles.bodySmall(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: AppTextStyles.bodyLarge(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: context.heightPct(4)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.widthPct(6),
                  vertical: context.heightPct(2),
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(context.widthPct(4)),
                ),
                child: Text(
                  'COMPLETED',
                  style: TextStyle(
                    color: const Color(0xFF388E3C),
                    fontSize: context.fontPct(9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
