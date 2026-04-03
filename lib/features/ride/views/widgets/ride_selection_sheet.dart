import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../cubit/ride_cubit.dart';
import '../../cubit/ride_state.dart';
import '../../data/models/ride_model.dart';

class RideSelectionSheet extends StatefulWidget {
  final RideState state;
  const RideSelectionSheet({super.key, required this.state});

  @override
  State<RideSelectionSheet> createState() => _RideSelectionSheetState();
}

class _RideSelectionSheetState extends State<RideSelectionSheet> {
  RideModel? _selectedRide;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(context.widthPct(24)),
            topRight: Radius.circular(context.widthPct(24)),
          ),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: context.heightPct(12)),
              Container(
                width: context.widthPct(40),
                height: context.heightPct(4),
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: context.heightPct(16)),
              Text('Choose a Ride', style: AppTextStyles.h3(context)),
              SizedBox(height: context.heightPct(16)),
              if (widget.state is RideLoading)
                Padding(
                  padding: EdgeInsets.all(context.widthPct(32)),
                  child: const CircularProgressIndicator(),
                )
              else if (widget.state is RideOptionsLoaded)
                _buildRideOptions(
                  context,
                  (widget.state as RideOptionsLoaded).rides,
                ),
              Padding(
                padding: EdgeInsets.all(context.widthPct(16)),
                child: CustomButton(
                  text: _selectedRide == null
                      ? 'Select a Ride'
                      : 'Confirm ${_selectedRide!.title}',
                  onPressed: _selectedRide == null
                      ? () {}
                      : () => context.read<RideCubit>().requestRide(
                          _selectedRide!,
                        ),
                  backgroundColor: _selectedRide == null
                      ? AppColors.grey400
                      : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRideOptions(BuildContext context, List<RideModel> rides) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: rides.length,
        itemBuilder: (context, index) {
          final ride = rides[index];
          final isSelected = _selectedRide?.id == ride.id;
          return GestureDetector(
            onTap: () => setState(() => _selectedRide = ride),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: context.widthPct(16),
                vertical: context.heightPct(8),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.grey200,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(context.widthPct(12)),
                color: isSelected
                    ? AppColors.primary.withOpacity(0.05)
                    : Colors.white,
              ),
              padding: EdgeInsets.all(context.widthPct(16)),
              child: Row(
                children: [
                  Icon(
                    Icons.directions_car,
                    size: context.widthPct(40),
                    color: AppColors.textPrimary,
                  ),
                  SizedBox(width: context.widthPct(16)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ride.title,
                          style: AppTextStyles.bodyLarge(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${ride.durationMinutes} min',
                          style: AppTextStyles.bodySmall(context),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${ride.price.toStringAsFixed(2)}',
                    style: AppTextStyles.h3(context),
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
