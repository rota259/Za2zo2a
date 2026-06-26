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
import '../data/models/auth_model.dart';
import 'widgets/auth_nav.dart';

/// Driver sign-up: rider fields + licenseNumber + vehicleInfo
/// → POST /register (role=driver).
class DriverSignupView extends StatefulWidget {
  const DriverSignupView({super.key});

  @override
  State<DriverSignupView> createState() => _DriverSignupViewState();
}

class _DriverSignupViewState extends State<DriverSignupView> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _license = TextEditingController();
  final _make = TextEditingController();
  final _model = TextEditingController();
  final _plate = TextEditingController();
  final _color = TextEditingController();
  final _year = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  @override
  void dispose() {
    for (final c in [
      _name,
      _phone,
      _email,
      _password,
      _license,
      _make,
      _model,
      _plate,
      _color,
      _year,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _submit(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().registerDriver(
        name: _name.text.trim(),
        phone: _phone.text.trim(),
        email: _email.text.trim(),
        password: _password.text,
        licenseNumber: _license.text.trim(),
        vehicleInfo: VehicleInfo(
          make: _make.text.trim(),
          model: _model.text.trim(),
          plate: _plate.text.trim(),
          color: _color.text.trim(),
          year: _year.text.trim(),
        ),
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
            title: Text('Driver Sign Up', style: AppTextStyles.h3(context)),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(context.widthPct(24)),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _section(context, 'Your details'),
                    CustomTextField(
                      controller: _name,
                      hintText: 'Full Name',
                      prefixIcon: const Icon(Icons.person_outline),
                      validator: Validators.name,
                    ),
                    _gap(context),
                    CustomTextField(
                      controller: _phone,
                      hintText: 'Phone Number (01XXXXXXXXX)',
                      prefixIcon: const Icon(Icons.phone_outlined),
                      keyboardType: TextInputType.phone,
                      validator: Validators.phone,
                    ),
                    _gap(context),
                    CustomTextField(
                      controller: _email,
                      hintText: 'Email address',
                      prefixIcon: const Icon(Icons.email_outlined),
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.email,
                    ),
                    _gap(context),
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
                    SizedBox(height: context.heightPct(20)),
                    _section(context, 'License & vehicle'),
                    CustomTextField(
                      controller: _license,
                      hintText: 'License Number',
                      prefixIcon: const Icon(Icons.badge_outlined),
                      validator: (v) =>
                          Validators.required(v, field: 'License number'),
                    ),
                    _gap(context),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _make,
                            hintText: 'Make',
                            validator: (v) =>
                                Validators.required(v, field: 'Make'),
                          ),
                        ),
                        SizedBox(width: context.widthPct(12)),
                        Expanded(
                          child: CustomTextField(
                            controller: _model,
                            hintText: 'Model',
                            validator: (v) =>
                                Validators.required(v, field: 'Model'),
                          ),
                        ),
                      ],
                    ),
                    _gap(context),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _color,
                            hintText: 'Color',
                            validator: (v) =>
                                Validators.required(v, field: 'Color'),
                          ),
                        ),
                        SizedBox(width: context.widthPct(12)),
                        Expanded(
                          child: CustomTextField(
                            controller: _year,
                            hintText: 'Year',
                            keyboardType: TextInputType.number,
                            validator: Validators.year,
                          ),
                        ),
                      ],
                    ),
                    _gap(context),
                    CustomTextField(
                      controller: _plate,
                      hintText: 'Plate Number',
                      prefixIcon: const Icon(Icons.confirmation_number_outlined),
                      validator: (v) =>
                          Validators.required(v, field: 'Plate'),
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
                            : Text('Create Driver Account',
                                style: AppTextStyles.button(context)),
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

  Widget _section(BuildContext context, String title) => Padding(
        padding: EdgeInsets.only(bottom: context.heightPct(12)),
        child: Text(
          title,
          style: AppTextStyles.h3(context).copyWith(fontWeight: FontWeight.w800),
        ),
      );

  Widget _gap(BuildContext context) => SizedBox(height: context.heightPct(14));
}
