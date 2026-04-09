import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../map/domain/usecases/get_user_location_use_case.dart';
import '../../map/presentation/view/map_view.dart';
import '../../map/presentation/viewmodel/map_cubit.dart';
import '../cubit/ride_cubit.dart';
import '../cubit/ride_state.dart';
import 'widgets/ride_selection_sheet.dart';

class RideSelectionView extends StatefulWidget {
  const RideSelectionView({super.key});

  @override
  State<RideSelectionView> createState() => _RideSelectionViewState();
}

class _RideSelectionViewState extends State<RideSelectionView> {
  late final MapCubit _mapCubit;

  @override
  void initState() {
    super.initState();
    _mapCubit = MapCubit(getUserLocationUseCase: const GetUserLocationUseCase())
      ..initLocation();
    context.read<RideCubit>().fetchRideOptions();
  }

  @override
  void dispose() {
    _mapCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RideCubit, RideState>(
      listener: (context, state) {
        if (state is RideActive) {
          context.push('/home/finding-driver');
        }
      },
      builder: (context, state) {
        return BlocProvider.value(
          value: _mapCubit,
          child: Scaffold(
            body: Stack(
              children: [
                const Positioned.fill(child: MapView.embedded()),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(context.widthPct(16)),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: () => context.pop(),
                      ),
                    ),
                  ),
                ),
                RideSelectionSheet(state: state),
              ],
            ),
          ),
        );
      },
    );
  }
}
