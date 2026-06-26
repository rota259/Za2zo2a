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

/// Rider sign-up: name, phone, email, password → POST /register (role=rider).
class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().registerRider(
        name: _name.text.trim(),
        phone: _phone.text.trim(),
        email: _email.text.trim(),
        password: _password.text,
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
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: () => context.pop(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(context.widthPct(24)),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create Account', style: AppTextStyles.h1(context)),
                    SizedBox(height: context.heightPct(8)),
                    Text(
                      'Sign up to book rides',
                      style: AppTextStyles.bodyMedium(context)
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    SizedBox(height: context.heightPct(28)),
                    CustomTextField(
                      controller: _name,
                      hintText: 'Full Name',
                      prefixIcon: const Icon(Icons.person_outline),
                      validator: Validators.name,
                    ),
                    SizedBox(height: context.heightPct(16)),
                    CustomTextField(
                      controller: _phone,
                      hintText: 'Phone Number (01XXXXXXXXX)',
                      prefixIcon: const Icon(Icons.phone_outlined),
                      keyboardType: TextInputType.phone,
                      validator: Validators.phone,
                    ),
                    SizedBox(height: context.heightPct(16)),
                    CustomTextField(
                      controller: _email,
                      hintText: 'Email address',
                      prefixIcon: const Icon(Icons.email_outlined),
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.email,
                    ),
                    SizedBox(height: context.heightPct(16)),
                    CustomTextField(
                      controller: _password,
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      obscureText: _obscure,
                      validator: Validators.password,
                      suffixIcon: IconButton(
                        icon: Icon(_obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    SizedBox(height: context.heightPct(28)),
                    SizedBox(
                      width: double.infinity,
                      height: context.heightPct(54),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(context.widthPct(12)),
                          ),
                        ),
                        onPressed: isLoading ? null : () => _submit(context),
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2.4, color: Colors.white),
                              )
                            : Text('Sign Up',
                                style: AppTextStyles.button(context)),
                      ),
                    ),
                    SizedBox(height: context.heightPct(20)),
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text("Already have an account? ",
                              style: AppTextStyles.bodyMedium(context)),
                          GestureDetector(
                            onTap: isLoading ? null : () => context.pop(),
                            child: Text('Sign in',
                                style: AppTextStyles.bodyMedium(context)
                                    .copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ],
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
