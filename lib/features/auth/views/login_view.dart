import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/loading_overlay.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go('/home');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
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
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: AppColors.primary,
                onPressed: () => context.pop(),
              ),
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
                    children: [
                      SizedBox(height: context.heightPct(30)),
                      // ── Logo
                      Container(
                        width: context.widthPct(60),
                        height: context.widthPct(60),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBEB),
                          borderRadius: BorderRadius.circular(
                            context.widthPct(12),
                          ),
                        ),
                        child: Icon(
                          Icons.flash_on_rounded,
                          color: AppColors.primary,
                          size: context.widthPct(30),
                        ),
                      ),
                      SizedBox(height: context.heightPct(24)),

                      // ── Welcome Text
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
                        style: AppTextStyles.bodyMedium(
                          context,
                        ).copyWith(color: AppColors.textSecondary),
                      ),
                      SizedBox(height: context.heightPct(40)),

                      // ── Email/Phone Field
                      _buildFieldLabel(context, 'Email or Phone'),
                      SizedBox(height: context.heightPct(8)),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Enter your email or phone',
                        prefixIcon: Icon(
                          Icons.mail_outline_rounded,
                          color: AppColors.grey400,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: context.heightPct(20)),

                      // ── Password Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFieldLabel(context, 'Password'),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Forgot Password?',
                              style: AppTextStyles.bodySmall(context).copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(8)),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Enter your password',
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.grey400,
                        ),
                        obscureText: true,
                        suffixIcon: Icon(
                          Icons.visibility_outlined,
                          color: AppColors.grey400,
                        ),
                      ),
                      SizedBox(height: context.heightPct(30)),

                      // ── Login Button
                      SizedBox(
                        width: double.infinity,
                        height: context.heightPct(56),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                context.widthPct(12),
                              ),
                            ),
                            elevation: 8,
                            shadowColor: AppColors.primary.withOpacity(0.4),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                _emailController.text,
                                _passwordController.text,
                              );
                            }
                          },
                          child: Text(
                            'Login',
                            style: AppTextStyles.button(context).copyWith(
                              fontSize: context.fontPct(18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: context.heightPct(40)),

                      // ── Divider
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.widthPct(16),
                            ),
                            child: Text(
                              'OR CONTINUE WITH',
                              style: AppTextStyles.caption(context).copyWith(
                                color: AppColors.grey400,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: context.heightPct(24)),

                      // ── Social Buttons
                      Row(
                        children: [
                          Expanded(
                            child: _SocialButton(
                              icon: FaIcon(
                                FontAwesomeIcons.google,
                                size: context.widthPct(18),
                              ),
                              label: 'Google',
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: context.widthPct(16)),
                          Expanded(
                            child: _SocialButton(
                              icon: FaIcon(
                                FontAwesomeIcons.apple,
                                size: context.widthPct(18),
                              ),
                              label: 'Apple',
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(40)),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: context.heightPct(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyles.bodyMedium(
                      context,
                    ).copyWith(color: AppColors.textSecondary),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/signup'),
                    child: Text(
                      'Sign up for free',
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldLabel(BuildContext context, String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: AppTextStyles.bodyMedium(context).copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary.withOpacity(0.8),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: context.heightPct(12)),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey200),
          borderRadius: BorderRadius.circular(context.widthPct(12)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: context.widthPct(8)),
            Text(
              label,
              style: AppTextStyles.bodyMedium(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
