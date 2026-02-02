import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/signup_view_model.dart';
import 'widgets/auth_widgets.dart';
import 'package:flutter_tasks_mostafa/core/theme/app_styles.dart';

class SignupView2 extends StatelessWidget {
  const SignupView2({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupViewModel2(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.blueAccent,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: AuthBackground(
          child: Consumer<SignupViewModel2>(
            builder: (context, vm, _) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthLogo(),
                  const SizedBox(height: 20),
                  AuthTextField(
                    label: 'Full Name',
                    controller: vm.nameController,
                    hint: 'Enter your Name',
                    icon: Icons.person_outline,
                  ),
                  _buildPhoneField(vm.phoneController),
                  const SizedBox(height: 16),
                  _buildGenderDropdown(vm),
                  const SizedBox(height: 16),
                  AuthTextField(
                    label: 'Email Adress',
                    controller: vm.emailController,
                    hint: 'email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  AuthTextField(
                    label: 'Password',
                    controller: vm.passwordController,
                    hint: 'Enter your password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  AuthTextField(
                    label: 'Birth Day',
                    controller: vm.birthDayController,
                    hint: 'Enter your Birth Day',
                    icon: Icons.calendar_today_outlined,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null)
                        vm.birthDayController.text =
                            "${date.year}-${date.month}-${date.day}";
                    },
                  ),
                  const SizedBox(height: 32),
                  if (vm.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        vm.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  AuthButton(
                    text: 'Sign up',
                    isLoading: vm.isLoading,
                    onPressed: () async {
                      if (await vm.signup()) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Signup Successful, please login'),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  AuthFooter(
                    text: "Already have an account?",
                    actionText: 'Log in',
                    onAction: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone number',
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 80,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: '+20',
                    items: ['+20', '+1']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) {},
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.phone,
                decoration: AppStyles.input(
                  '1022334455',
                  Icons.phone,
                ).copyWith(prefixIcon: null, hintText: '1022334455'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderDropdown(SignupViewModel2 vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: vm.gender,
              isExpanded: true,
              items: [
                'Male',
                'Female',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: vm.setGender,
            ),
          ),
        ),
      ],
    );
  }
}
