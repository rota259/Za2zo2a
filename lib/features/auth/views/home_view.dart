
import 'package:flutter/material.dart';
import 'package:flutter_tasks_mostafa/core/theme/app_colors.dart';
import 'package:flutter_tasks_mostafa/core/theme/app_styles.dart';
import 'package:flutter_tasks_mostafa/features/auth/views/login_view.dart';
import 'package:flutter_tasks_mostafa/features/auth/views/signup_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/photos/download.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          
          // Overlay to ensure text readability (Gradient)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3), // Lighter at top
                  Colors.black.withOpacity(0.7), // Darker at bottom
                ],
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo Area
                Row(
                  children: [
                   Image.asset(
                      'assets/photos/Frame 2095585454.png',
                      width: 120,)
                  ],
                ),
                
                const Spacer(),

                // Main Title
                Text(
                  'Your next job\nstarts here!',
                  style: AppStyles.title.copyWith(
                    color: AppColors.white,
                    fontSize: 42, // Larger as per design
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Subtitle
                Text(
                  'Join us and be ready',
                  style: AppStyles.subTitle.copyWith(
                    color: AppColors.white.withOpacity(0.8),
                    fontSize: 18,
                  ),
                ),
                
                const SizedBox(height: 48),

                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView())); },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => SignupView()));
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.white, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Create new account',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
