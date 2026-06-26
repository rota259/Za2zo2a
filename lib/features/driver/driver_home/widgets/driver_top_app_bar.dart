import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../injection_container.dart';
import '../../../../../core/services/session_manager.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../../../auth/cubit/auth_state.dart';

class DriverTopAppBar extends StatefulWidget {
  final bool isOnline;

  const DriverTopAppBar({super.key, required this.isOnline});

  @override
  State<DriverTopAppBar> createState() => _DriverTopAppBarState();
}

class _DriverTopAppBarState extends State<DriverTopAppBar> {
  String? _photoPath;

  @override
  void initState() {
    super.initState();
    _loadPhoto();
  }

  Future<void> _loadPhoto() async {
    final path = await sl<SessionManager>().readProfilePhoto();
    if (mounted && path != null) setState(() => _photoPath = path);
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final user = authState is Authenticated ? authState.user : null;
    final displayName = user?.name ?? 'Driver';

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.widthPct(16),
        vertical: context.heightPct(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: context.widthPct(18),
            backgroundColor: Colors.blueGrey.shade800,
            backgroundImage:
                _photoPath != null ? FileImage(File(_photoPath!)) : null,
            child: _photoPath == null
                ? Text(
                    displayName.isNotEmpty
                        ? displayName[0].toUpperCase()
                        : 'D',
                    style: TextStyle(
                      color: Colors.amber.shade200,
                      fontSize: context.widthPct(18),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          SizedBox(width: context.widthPct(12)),
          Expanded(
            child: Text(
              displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.h2(context).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: context.fontPct(22),
              ),
            ),
          ),
          if (widget.isOnline)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.widthPct(12),
                vertical: context.heightPct(6),
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(context.widthPct(20)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.sensors,
                    color: AppColors.primary,
                    size: context.widthPct(14),
                  ),
                  SizedBox(width: context.widthPct(4)),
                  Text(
                    'ONLINE',
                    style: AppTextStyles.caption(context).copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          else
            Icon(Icons.sensors_off, color: AppColors.grey500),
        ],
      ),
    );
  }
}
