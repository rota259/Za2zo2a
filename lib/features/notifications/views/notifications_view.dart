import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  String _selectedFilter = 'ALL';

  final List<_NotifItem> _notifications = const [
    _NotifItem(
      icon: Icons.directions_car,
      iconBg: Color(0xFFFFEBEE),
      iconColor: Color(0xFFE23030),
      title: 'Trip Completed',
      body:
          'Your ride with Marcus has ended. We\'ve sent the receipt to your email. Don\'t forget to rate your experience!',
      time: '2M AGO',
      filter: 'TRIP UPDATES',
      hasImage: false,
    ),
    _NotifItem(
      icon: Icons.local_offer_outlined,
      iconBg: Color(0xFFFFF8E1),
      iconColor: Color(0xFFFF8F00),
      title: '50% Off Your Next Ride',
      body:
          'The weekend pulse is here! Use code VELOCITY50 for half-price rides until Sunday midnight.',
      time: '1H AGO',
      filter: 'PROMOTION',
      hasImage: true,
    ),
    _NotifItem(
      icon: Icons.shield_outlined,
      iconBg: Color(0xFFE3F2FD),
      iconColor: Color(0xFF1976D2),
      title: 'New Login Detected',
      body:
          'A new login was recorded from a Chrome browser on Windows. If this wasn\'t you, please secure your account.',
      time: 'YESTERDAY',
      filter: 'TRIP UPDATES',
      hasImage: false,
    ),
    _NotifItem(
      icon: Icons.my_location,
      iconBg: Color(0xFFE8F5E9),
      iconColor: Color(0xFF388E3C),
      title: 'Route Update',
      body:
          'Traffic on Broadway is heavier than usual. We\'ve optimized your preferred routes for tomorrow\'s commute.',
      time: '2 DAYS AGO',
      filter: 'TRIP UPDATES',
      hasImage: false,
    ),
    _NotifItem(
      icon: Icons.star_outline,
      iconBg: Color(0xFFFCE4EC),
      iconColor: Color(0xFFE91E63),
      title: 'Anniversary Perk!',
      body:
          'You\'ve been riding with Crimson Velocity for 1 year. Claim your Gold Member badge in your profile.',
      time: '3 DAYS AGO',
      filter: 'PROMOTION',
      hasImage: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedFilter == 'ALL'
        ? _notifications
        : _notifications.where((n) => n.filter == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: SafeArea(
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
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(
                      Icons.menu,
                      color: AppColors.primary,
                      size: context.widthPct(26),
                    ),
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

            // ── Inbox header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.widthPct(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inbox',
                    style: AppTextStyles.h1(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: context.heightPct(4)),
                  Text(
                    'Stay updated with your latest urban movements.',
                    style: AppTextStyles.bodyMedium(
                      context,
                    ).copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.heightPct(16)),

            // ── Filter chips
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.widthPct(20)),
              child: Row(
                children: ['ALL', 'TRIP UPDATES', 'PROMOTION'].map((filter) {
                  final selected = _selectedFilter == filter;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = filter),
                    child: Container(
                      margin: EdgeInsets.only(right: context.widthPct(10)),
                      padding: EdgeInsets.symmetric(
                        horizontal: context.widthPct(14),
                        vertical: context.heightPct(8),
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(
                          context.widthPct(20),
                        ),
                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : AppColors.grey200,
                        ),
                      ),
                      child: Text(
                        filter,
                        style: AppTextStyles.bodySmall(context).copyWith(
                          color: selected
                              ? Colors.white
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: context.heightPct(16)),

            // ── Notification List
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: context.widthPct(16)),
                itemCount: filtered.length + 1,
                itemBuilder: (context, index) {
                  if (index == filtered.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.heightPct(32),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            color: AppColors.grey300,
                            size: context.widthPct(40),
                          ),
                          SizedBox(height: context.heightPct(8)),
                          Text(
                            'END OF NOTIFICATIONS',
                            style: AppTextStyles.bodySmall(context).copyWith(
                              color: AppColors.grey400,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  final notif = filtered[index];
                  return _NotifCard(notif: notif, context: context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotifCard extends StatelessWidget {
  final _NotifItem notif;
  final BuildContext context;

  const _NotifCard({required this.notif, required this.context});

  @override
  Widget build(BuildContext outerContext) {
    return Container(
      margin: EdgeInsets.only(bottom: context.heightPct(12)),
      padding: EdgeInsets.all(context.widthPct(16)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(context.widthPct(12)),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0A000000),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(context.widthPct(10)),
                decoration: BoxDecoration(
                  color: notif.iconBg,
                  borderRadius: BorderRadius.circular(context.widthPct(10)),
                ),
                child: Icon(
                  notif.icon,
                  color: notif.iconColor,
                  size: context.widthPct(22),
                ),
              ),
              SizedBox(width: context.widthPct(14)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            notif.title,
                            style: AppTextStyles.bodyLarge(
                              context,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          notif.time,
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color: AppColors.textSecondary,
                            fontSize: context.fontPct(10),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.heightPct(4)),
                    Text(
                      notif.body,
                      style: AppTextStyles.bodySmall(
                        context,
                      ).copyWith(color: AppColors.textSecondary, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (notif.hasImage) ...[
            SizedBox(height: context.heightPct(12)),
            Container(
              height: context.heightPct(80),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(context.widthPct(8)),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.music_note,
                      color: Colors.white70,
                      size: context.widthPct(20),
                    ),
                    SizedBox(width: context.widthPct(8)),
                    Text(
                      'ACTIVE IN YOUR AREA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: context.fontPct(11),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NotifItem {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String body;
  final String time;
  final String filter;
  final bool hasImage;

  const _NotifItem({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.body,
    required this.time,
    required this.filter,
    required this.hasImage,
  });
}
