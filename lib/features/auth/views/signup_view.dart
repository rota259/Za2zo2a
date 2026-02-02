import 'package:flutter/material.dart';
import 'package:flutter_tasks_mostafa/core/theme/app_colors.dart';
import 'package:flutter_tasks_mostafa/features/auth/view_models/signup_view_model.dart';
import 'package:flutter_tasks_mostafa/features/auth/views/login_view.dart';
import 'package:flutter_tasks_mostafa/features/auth/views/widgets/widget_field.dart';
import 'package:provider/provider.dart';

class SignupView extends StatelessWidget {
  final _email = TextEditingController();
  final _pass = TextEditingController();

  SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SignupViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text(
          "Create new account",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile Photo",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "Change",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        "Delete",
                        style: TextStyle(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          field("full name", Icons.person_outline),
          field("email", Icons.email_outlined, controller: _email),
          field("phone", Icons.phone_android, prefixText: "+20 | "),
          field(
            "Country",
            Icons.location_on_outlined,
            suffixIcon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ),
          field(
            "City",
            Icons.location_city_outlined,
            suffixIcon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ),
          field(
            "Password",
            Icons.lock_outline,
            controller: _pass,
            isPass: true,
          ),
          field("Confirm Password", Icons.lock_outline, isPass: true),
          if (vm.error != null) ...[
            SizedBox(height: 10),
            Text(vm.error!, style: TextStyle(color: Colors.red)),
          ],
          SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: vm.isLoading
                ? null
                : () => vm.signup(_email.text, _pass.text),
            child: vm.isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
