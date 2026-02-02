import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/login_view_model.dart';
import 'signup_view.dart';
import 'widgets/auth_widgets.dart';

class LoginView2 extends StatelessWidget {
  const LoginView2({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel2(),
      child: Scaffold(
        body: AuthBackground(
          child: Consumer<LoginViewModel2>(
            builder: (context, vm, _) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  const AuthLogo(),
                  const SizedBox(height: 60),
                  AuthTextField(label: 'Email', controller: vm.emailController, hint: 'Email', icon: Icons.email_outlined),
                  AuthTextField(
                    label: 'Password',
                    controller: vm.passwordController,
                    hint: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                    suffixIcon: const Icon(Icons.visibility_off_outlined, color: Colors.grey),
                  ),
                  Row(
                    children: [
                      Checkbox(value: vm.rememberMe, onChanged: vm.toggleRememberMe, activeColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                      const Text('Remember me', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (vm.errorMessage != null)
                    Padding(padding: const EdgeInsets.only(bottom: 16), child: Text(vm.errorMessage!, style: const TextStyle(color: Colors.red))),
                  AuthButton(
                    text: 'Log in',
                    isLoading: vm.isLoading,
                    onPressed: () async {
                      if (await vm.login()) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Successful')));
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(child: TextButton(onPressed: () {}, child: const Text('Forget Password', style: TextStyle(decoration: TextDecoration.underline, color: Colors.grey)))),
                  const SizedBox(height: 20),
                  AuthFooter(
                    text: "Don't have an account?",
                    actionText: 'Register',
                    onAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupView2())),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
