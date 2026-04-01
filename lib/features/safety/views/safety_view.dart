import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';

class SafetyView extends StatefulWidget {
  const SafetyView({super.key});

  @override
  State<SafetyView> createState() => _SafetyViewState();
}

class _SafetyViewState extends State<SafetyView> {
  bool _holding = false;

  final List<_Contact> _contacts = const [
    _Contact(name: 'Sarah Jenkins', relation: 'Wife', phone: '+1 (555) 012-3456'),
    _Contact(name: 'Marcus Volt', relation: 'Brother', phone: '+1 (555) 012-7890'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        title: Text('Safety & Emergency', style: AppTextStyles.h2(context)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
            context.widthPct(16), context.heightPct(8), context.widthPct(16), context.heightPct(40)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── SOS Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.widthPct(24)),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE23030), Color(0xFFFF6B6B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(context.widthPct(16)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(context.widthPct(16)),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.wifi_tethering, color: Colors.white, size: context.widthPct(36)),
                  ),
                  SizedBox(height: context.heightPct(12)),
                  Text('SOS EMERGENCY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: context.fontPct(22),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      )),
                  SizedBox(height: context.heightPct(8)),
                  Text('Immediately notify authorities and your\nemergency contacts.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: context.fontPct(13),
                        height: 1.4,
                      )),
                  SizedBox(height: context.heightPct(20)),
                  GestureDetector(
                    onLongPress: () {
                      setState(() => _holding = true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('🚨 SOS Activated! Contacting emergency services...'),
                          backgroundColor: AppColors.error,
                        ),
                      );
                    },
                    onLongPressEnd: (_) => setState(() => _holding = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: EdgeInsets.symmetric(
                        horizontal: context.widthPct(32),
                        vertical: context.heightPct(14),
                      ),
                      decoration: BoxDecoration(
                        color: _holding ? Colors.white.withOpacity(0.9) : Colors.white,
                        borderRadius: BorderRadius.circular(context.widthPct(50)),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Text(
                        'HOLD TO ACTIVATE SOS',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: context.fontPct(13),
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.heightPct(20)),

            // ── Map placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(context.widthPct(12)),
              child: Container(
                height: context.heightPct(160),
                color: const Color(0xFFCDD5BF),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(painter: _GridPainter()),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map, color: Colors.white70, size: context.widthPct(40)),
                          SizedBox(height: context.heightPct(4)),
                          Text('New York', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Positioned(
                      top: context.heightPct(40),
                      left: context.widthPct(60),
                      child: Icon(Icons.location_on, color: AppColors.primary, size: context.widthPct(28)),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: context.heightPct(20)),

            // ── Share Trip Status
            Container(
              padding: EdgeInsets.all(context.widthPct(16)),
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(context.widthPct(12)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(context.widthPct(8)),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.share_location, color: AppColors.primary, size: context.widthPct(22)),
                  ),
                  SizedBox(width: context.widthPct(14)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Share Trip Status',
                            style: AppTextStyles.bodyLarge(context)
                                .copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(height: context.heightPct(4)),
                        Text('Keep your loved ones informed. Let them track your ride in real-time until you arrive safely.',
                            style: AppTextStyles.bodySmall(context)
                                .copyWith(color: AppColors.textSecondary, height: 1.4)),
                        SizedBox(height: context.heightPct(14)),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(context.widthPct(50))),
                              padding: EdgeInsets.symmetric(vertical: context.heightPct(14)),
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: Text('Share with Family',
                                style: AppTextStyles.button(context)
                                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.heightPct(24)),

            // ── Emergency Contacts header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Emergency Contacts',
                    style: AppTextStyles.h3(context).copyWith(fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(Icons.add_circle_outline, color: AppColors.primary, size: context.fontPct(16)),
                      SizedBox(width: context.widthPct(4)),
                      Text('Add New',
                          style: AppTextStyles.bodySmall(context)
                              .copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(12)),

            // ── Contacts list
            ..._contacts.map((c) => Container(
                  margin: EdgeInsets.only(bottom: context.heightPct(10)),
                  padding: EdgeInsets.all(context.widthPct(16)),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(context.widthPct(12)),
                    boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 6, offset: Offset(0, 2))],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(context.widthPct(10)),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.person_outline, color: AppColors.primary, size: context.widthPct(20)),
                      ),
                      SizedBox(width: context.widthPct(14)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(c.name,
                                style: AppTextStyles.bodyLarge(context)
                                    .copyWith(fontWeight: FontWeight.bold)),
                            Text('${c.relation} • ${c.phone}',
                                style: AppTextStyles.bodySmall(context)
                                    .copyWith(color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.phone_outlined, color: AppColors.primary),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )),

            SizedBox(height: context.heightPct(24)),

            // ── Bottom 2 cards
            Row(
              children: [
                Expanded(
                  child: _BottomCard(
                    icon: Icons.shield_outlined,
                    title: 'Safety Center',
                    subtitle: 'Read our safety guide',
                    onTap: () {},
                  ),
                ),
                SizedBox(width: context.widthPct(12)),
                Expanded(
                  child: _BottomCard(
                    icon: Icons.mic_outlined,
                    title: 'Audio Record',
                    subtitle: 'Securely record ride audio',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _BottomCard(
      {required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.widthPct(16)),
        decoration: BoxDecoration(
          color: AppColors.grey50,
          borderRadius: BorderRadius.circular(context.widthPct(12)),
          border: Border.all(color: AppColors.grey200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(context.widthPct(8)),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(context.widthPct(8)),
              ),
              child: Icon(icon, color: AppColors.primary, size: context.widthPct(20)),
            ),
            SizedBox(height: context.heightPct(8)),
            Text(title,
                style: AppTextStyles.bodyMedium(context).copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: context.heightPct(2)),
            Text(subtitle,
                style:
                    AppTextStyles.bodySmall(context).copyWith(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _Contact {
  final String name;
  final String relation;
  final String phone;
  const _Contact({required this.name, required this.relation, required this.phone});
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
