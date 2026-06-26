import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'widgets/auth_nav.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          routeByRole(context, state.user);
        } else if (state is AuthFailure) {
          showAuthError(context, state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Za2zo2a',
              style: AppTextStyles.h2(context).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: context.fontPct(20),
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.widthPct(24)),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.heightPct(24)),
                    Center(
                      child: Container(
                        width: context.widthPct(60),
                        height: context.widthPct(60),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBEB),
                          borderRadius:
                              BorderRadius.circular(context.widthPct(12)),
                        ),
                        child: Icon(
                          Icons.local_taxi_rounded,
                          color: AppColors.primary,
                          size: context.widthPct(30),
                        ),
                      ),
                    ),
                    SizedBox(height: context.heightPct(24)),
                    Text(
                      'Welcome Back',
                      style: AppTextStyles.h1(context).copyWith(
                        fontSize: context.fontPct(28),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: context.heightPct(8)),
                    Text(
                      'Log in to your Za2zo2a account',
                      style: AppTextStyles.bodyMedium(context)
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    SizedBox(height: context.heightPct(32)),

                    _label(context, 'Phone number'),
                    SizedBox(height: context.heightPct(8)),
                    CustomTextField(
                      controller: _phoneController,
                      hintText: '01XXXXXXXXX',
                      prefixIcon: Icon(Icons.phone_outlined,
                          color: AppColors.grey400),
                      keyboardType: TextInputType.phone,
                      validator: Validators.phone,
                    ),
                    SizedBox(height: context.heightPct(20)),

                    _label(context, 'Password'),
                    SizedBox(height: context.heightPct(8)),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Enter your password',
                      prefixIcon: Icon(Icons.lock_outline_rounded,
                          color: AppColors.grey400),
                      obscureText: _obscure,
                      validator: Validators.password,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.grey400,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    SizedBox(height: context.heightPct(32)),

                    SizedBox(
                      width: double.infinity,
                      height: context.heightPct(56),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(context.widthPct(12)),
                          ),
                        ),
                        // Disabled while a request is in flight (no double-submit).
                        onPressed: isLoading ? null : () => _submit(context),
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.4,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Login',
                                style: AppTextStyles.button(context).copyWith(
                                  fontSize: context.fontPct(18),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: context.heightPct(24)),

                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: AppTextStyles.bodyMedium(context)
                                .copyWith(color: AppColors.textSecondary),
                          ),
                          GestureDetector(
                            onTap: isLoading
                                ? null
                                : () => context.push('/signup'),
                            child: Text(
                              'Sign up',
                              style: AppTextStyles.bodyMedium(context).copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.heightPct(8)),
                    Center(
                      child: GestureDetector(
                        onTap: isLoading
                            ? null
                            : () => context.push('/signup/driver'),
                        child: Text(
                          'Become a driver',
                          style: AppTextStyles.bodyMedium(context).copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.heightPct(24)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _label(BuildContext context, String text) => Text(
        text,
        style: AppTextStyles.bodyMedium(context).copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary.withValues(alpha: 0.8),
        ),
      );
}
