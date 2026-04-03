import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/ride_cubit.dart';

class DriverRatingView extends StatefulWidget {
  const DriverRatingView({super.key});

  @override
  State<DriverRatingView> createState() => _DriverRatingViewState();
}

class _DriverRatingViewState extends State<DriverRatingView> {
  double _rating = 0;
  final _feedbackController = TextEditingController();
  final List<String> _quickTags = [
    'Great Service',
    'Clean Car',
    'Expert Driving',
  ];
  final Set<String> _selectedTags = {};

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.widthPct(8),
                vertical: context.heightPct(4),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: AppColors.textPrimary),
                    onPressed: () {
                      context.read<RideCubit>().cancelRide();
                      context.go('/home');
                    },
                  ),
                  Expanded(
                    child: Text(
                      'Rate Driver',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.h2(context),
                    ),
                  ),
                  SizedBox(width: context.widthPct(48)), // balance space
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: context.widthPct(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: context.heightPct(16)),

                    // ── Driver Avatar with verified badge
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2.5,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: context.widthPct(48),
                            backgroundColor: AppColors.grey200,
                            child: Icon(
                              Icons.person,
                              size: context.widthPct(46),
                              color: AppColors.grey400,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            padding: EdgeInsets.all(context.widthPct(5)),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.background,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.verified,
                              color: Colors.white,
                              size: context.fontPct(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.heightPct(16)),

                    // ── Driver Name
                    Text(
                      'Marcus Thompson',
                      style: AppTextStyles.h2(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: context.heightPct(4)),
                    Text(
                      'Toyota Camry • ABC-1234',
                      style: AppTextStyles.bodyMedium(
                        context,
                      ).copyWith(color: AppColors.primary),
                    ),
                    SizedBox(height: context.heightPct(4)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.warning,
                          size: context.fontPct(14),
                        ),
                        SizedBox(width: context.widthPct(4)),
                        Text(
                          '4.9',
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color: AppColors.warning,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' (1,462 trips)',
                          style: AppTextStyles.bodySmall(
                            context,
                          ).copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),

                    SizedBox(height: context.heightPct(32)),

                    // ── How was your ride
                    Text(
                      'How was your ride?',
                      style: AppTextStyles.h3(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: context.heightPct(20)),

                    // ── Star Rating bar
                    RatingBar.builder(
                      initialRating: _rating,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      unratedColor: AppColors.grey300,
                      itemPadding: EdgeInsets.symmetric(
                        horizontal: context.widthPct(6),
                      ),
                      itemSize: context.widthPct(40),
                      itemBuilder: (context, _) =>
                          Icon(Icons.star, color: AppColors.warning),
                      onRatingUpdate: (rating) =>
                          setState(() => _rating = rating),
                    ),

                    SizedBox(height: context.heightPct(28)),

                    // ── Optional feedback text
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Optional feedback',
                        style: AppTextStyles.bodySmall(
                          context,
                        ).copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                    SizedBox(height: context.heightPct(8)),
                    TextField(
                      controller: _feedbackController,
                      maxLines: 3,
                      style: AppTextStyles.bodyMedium(context),
                      decoration: InputDecoration(
                        hintText: 'Tell us more about your experience...',
                        hintStyle: AppTextStyles.bodyMedium(
                          context,
                        ).copyWith(color: AppColors.grey400),
                        filled: true,
                        fillColor: AppColors.grey50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.widthPct(12),
                          ),
                          borderSide: BorderSide(color: AppColors.grey200),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.widthPct(12),
                          ),
                          borderSide: BorderSide(color: AppColors.grey200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.widthPct(12),
                          ),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                        contentPadding: EdgeInsets.all(context.widthPct(16)),
                      ),
                    ),

                    SizedBox(height: context.heightPct(20)),

                    // ── Quick Tags
                    Wrap(
                      spacing: context.widthPct(10),
                      runSpacing: context.heightPct(8),
                      children: _quickTags.map((tag) {
                        final selected = _selectedTags.contains(tag);
                        return GestureDetector(
                          onTap: () => setState(() {
                            selected
                                ? _selectedTags.remove(tag)
                                : _selectedTags.add(tag);
                          }),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.widthPct(16),
                              vertical: context.heightPct(8),
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.background,
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.grey300,
                              ),
                              borderRadius: BorderRadius.circular(
                                context.widthPct(20),
                              ),
                            ),
                            child: Text(
                              tag,
                              style: AppTextStyles.bodySmall(context).copyWith(
                                color: selected
                                    ? Colors.white
                                    : AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: context.heightPct(24)),

                    // ── Add tip row
                    Container(
                      padding: EdgeInsets.all(context.widthPct(16)),
                      decoration: BoxDecoration(
                        color: AppColors.grey50,
                        borderRadius: BorderRadius.circular(
                          context.widthPct(12),
                        ),
                        border: Border.all(color: AppColors.grey200),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(context.widthPct(8)),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.card_giftcard,
                              color: AppColors.primary,
                              size: context.widthPct(18),
                            ),
                          ),
                          SizedBox(width: context.widthPct(12)),
                          Expanded(
                            child: Text(
                              'Add a tip for Marcus?',
                              style: AppTextStyles.bodyMedium(
                                context,
                              ).copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // show tip bottom sheet
                              _showTipSheet(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.widthPct(14),
                                vertical: context.heightPct(8),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(
                                  context.widthPct(8),
                                ),
                              ),
                              child: Text(
                                'Add Tip',
                                style: AppTextStyles.bodySmall(context)
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: context.heightPct(30)),
                  ],
                ),
              ),
            ),

            // ── Submit button pinned at bottom
            Padding(
              padding: EdgeInsets.all(context.widthPct(24)),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(
                      vertical: context.heightPct(18),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.widthPct(50)),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: Text(
                    'Submit Feedback →',
                    style: AppTextStyles.button(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    context.read<RideCubit>().cancelRide();
                    context.go('/home');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTipSheet(BuildContext context) {
    final tips = [2, 5, 10, 20];
    int selected = 5;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.widthPct(24)),
        ),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.all(context.widthPct(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add a tip for Marcus', style: AppTextStyles.h3(context)),
              SizedBox(height: context.heightPct(24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: tips.map((amt) {
                  final isSel = selected == amt;
                  return GestureDetector(
                    onTap: () => setModalState(() => selected = amt),
                    child: Container(
                      width: context.widthPct(72),
                      padding: EdgeInsets.symmetric(
                        vertical: context.heightPct(14),
                      ),
                      decoration: BoxDecoration(
                        color: isSel ? AppColors.primary : AppColors.grey50,
                        borderRadius: BorderRadius.circular(
                          context.widthPct(10),
                        ),
                        border: Border.all(
                          color: isSel ? AppColors.primary : AppColors.grey200,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '\$$amt',
                          style: AppTextStyles.bodyLarge(context).copyWith(
                            color: isSel ? Colors.white : AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: context.heightPct(24)),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.widthPct(50)),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: context.heightPct(16),
                    ),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    'Confirm \$$selected Tip',
                    style: AppTextStyles.button(
                      context,
                    ).copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: context.heightPct(8)),
            ],
          ),
        ),
      ),
    );
  }
}
