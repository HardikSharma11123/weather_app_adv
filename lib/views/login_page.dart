import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_adv/providers/auth_provider.dart';
import 'package:weather_app_adv/views/signup_page.dart';
import 'package:weather_app_adv/views/weather_screen.dart';
import 'package:weather_app_adv/widgets/form_feild.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    // Watch auth state for changes
    final authState = ref.watch(authStateProvider);
    final isLoading = authState.isLoading;

    // Listen for auth state changes
    ref.listen(authStateProvider, (previous, current) {
      // Show error messages
      if (current.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(current.errorMessage!)));
      }

      // Navigate to weather screen if authenticated
      if (current.user != null && previous?.user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WeatherScreen()),
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromRGBO(119, 228, 200, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                FormFeild(
                  hintText: "Email",
                  controller: emailController,
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Email cannot be empty' : null,
                ),
                const SizedBox(height: 20),
                FormFeild(
                  hintText: "Password",
                  controller: passwordController,
                  obscureText: true,
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Password cannot be empty' : null,
                ),
                const SizedBox(height: 30),
                isLoading
                    ? const CircularProgressIndicator()
                    : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(69, 53, 193, 1),
                            Color.fromRGBO(54, 194, 206, 1),
                          ],
                        ),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          fixedSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Call the sign in method from auth provider
                            ref
                                .read(authStateProvider.notifier)
                                .signIn(
                                  emailController.text,
                                  passwordController.text,
                                );
                          }
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpPage()),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Signup",
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
