import 'package:flutter/material.dart';
import 'package:flutter_tasks_mostafa/core/theme/app_colors.dart';
import 'package:flutter_tasks_mostafa/core/theme/app_styles.dart';
import 'package:flutter_tasks_mostafa/features/auth/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

import 'signup_view.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _email = TextEditingController();

  final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        
        child: ListView(
          
          padding: EdgeInsets.all(24),
          children: [
            Center(
              
              child: Image.asset(
                'assets/photos/Frame 2095585454.png',
                width: 120,
              ),
            ),
            SizedBox(height: 40),
            Text("Welcome", style: AppStyles.titleGreen),
            Text("back!", style: AppStyles.title),
            Text("Find your job now...", style: AppStyles.subTitle),
            SizedBox(height: 30),
            TextField(
              controller: _email,
              decoration: AppStyles.input("Username", Icons.email),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _pass,
              obscureText: true,
              decoration: AppStyles.input("Password", Icons.lock),
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),
              ],
            ),
            if (vm.error != null)
              Text(vm.error!, style: TextStyle(color: Colors.red)),
            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.all(16),
              ),
              onPressed: vm.isLoading
                  ? null
                  : () {
                      vm.login(_email.text, _pass.text);
                    },
              child: vm.isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Sign In", style: TextStyle(color: Colors.white)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?", style: AppStyles.subTitle),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SignupView()),
                  ),
                  child: Text(
                    "Create one",
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
