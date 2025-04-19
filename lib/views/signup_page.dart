import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_adv/providers/auth_provider.dart';
import 'package:weather_app_adv/views/login_page.dart';
import 'package:weather_app_adv/views/weather_screen.dart';
import 'package:weather_app_adv/widgets/form_feild.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    // Watch the auth state for changes
    final authState = ref.watch(authStateProvider);
    final isLoading = authState.isLoading;

    // Listen for authentication state changes and show errors
    ref.listen(authStateProvider, (previous, current) {
      // If there's an error, show it
      if (current.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(current.errorMessage!)));
      }

      // If the user is authenticated, navigate to weather screen
      if (current.user != null && previous?.user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WeatherScreen()),
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromRGBO(119, 228, 200, 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                FormFeild(
                  hintText: "Name",
                  controller: nameController,
                  validator:
                      (value) => value!.isEmpty ? 'Name cannot be empty' : null,
                ),
                const SizedBox(height: 20),
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
                          value!.length < 6 ? 'Password too short' : null,
                ),
                const SizedBox(height: 20),
                FormFeild(
                  hintText: "Confirm Password",
                  controller: confirmPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
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
                            ref
                                .read(authStateProvider.notifier)
                                .signUp(
                                  emailController.text,
                                  passwordController.text,
                                  nameController.text,
                                );
                          }
                        },
                        child: const Text(
                          "Sign Up",
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
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    "Already have an account? Login",
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
