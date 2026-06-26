import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';

/// Two-step permanent account deletion: an explicit "this is permanent"
/// confirmation, then a password challenge → DELETE /api/auth/delete-account.
Future<void> showDeleteAccountFlow(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Delete account?'),
      content: const Text(
        'This is permanent. Your account, trips and data will be removed '
        'and cannot be recovered.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: AppColors.darkRed),
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Continue'),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return;

  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => BlocProvider.value(
      value: context.read<AuthCubit>(),
      child: const _PasswordChallengeDialog(),
    ),
  );
}

class _PasswordChallengeDialog extends StatefulWidget {
  const _PasswordChallengeDialog();

  @override
  State<_PasswordChallengeDialog> createState() =>
      _PasswordChallengeDialogState();
}

class _PasswordChallengeDialogState extends State<_PasswordChallengeDialog> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.of(context).pop();
          context.go('/login');
        } else if (state is AuthFailure) {
          setState(() => _error = state.message);
        }
      },
      builder: (context, state) {
        final loading = state is AuthLoading;
        return AlertDialog(
          title: const Text('Confirm your password'),
          content: TextField(
            controller: _controller,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              errorText: _error,
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: loading ? null : () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: AppColors.darkRed),
              onPressed: loading
                  ? null
                  : () {
                      if (_controller.text.isEmpty) {
                        setState(() => _error = 'Password is required');
                        return;
                      }
                      context
                          .read<AuthCubit>()
                          .deleteAccount(password: _controller.text);
                    },
              child: loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Delete permanently'),
            ),
          ],
        );
      },
    );
  }
}
