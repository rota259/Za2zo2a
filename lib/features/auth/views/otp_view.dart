import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/loading_overlay.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go('/home');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
          );
        }
      },
      builder: (context, state) {
        return LoadingOverlay(
          isLoading: state is AuthLoading,
          child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () => context.pop(),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(context.widthPct(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Verify Phone', style: AppTextStyles.h1(context)),
                    SizedBox(height: context.heightPct(8)),
                    Text('Code is sent to +1 234 567 8900', style: AppTextStyles.bodyMedium(context)),
                    SizedBox(height: context.heightPct(40)),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          width: context.widthPct(60),
                          height: context.widthPct(60),
                          child: TextFormField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: AppTextStyles.h2(context),
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(context.widthPct(12)),
                                borderSide: BorderSide(color: AppColors.grey300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(context.widthPct(12)),
                                borderSide: BorderSide(color: AppColors.primary, width: 2),
                              ),
                            ),
                            onChanged: (value) => _onTextChanged(index, value),
                          ),
                        );
                      }),
                    ),
                    
                    SizedBox(height: context.heightPct(40)),
                    CustomButton(
                      text: 'Verify',
                      onPressed: () {
                        String otp = _controllers.map((c) => c.text).join();
                        if (otp.length == 4) {
                          context.read<AuthCubit>().verifyOtp(otp);
                        }
                      },
                    ),
                    
                    SizedBox(height: context.heightPct(24)),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Resend Code in 00:30', 
                          style: AppTextStyles.bodyMedium(context).copyWith(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
