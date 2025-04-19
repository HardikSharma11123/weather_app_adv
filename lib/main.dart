import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weather_app_adv/providers/auth_provider.dart';
import 'package:weather_app_adv/views/login_page.dart';
import 'package:weather_app_adv/views/signup_page.dart';
import 'package:weather_app_adv/views/weather_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zmiqyxdvxyblmkszkzpi.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InptaXF5eGR2eHlibG1rc3prenBpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ3OTI3MDUsImV4cCI6MjA2MDM2ODcwNX0.aK_pwmkTC8uLEqH3fc5SN7_B1F41mroKReWCcluRFLY',
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Auth wrapper to handle initial auth state
class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Add a loading state for initial auth check
    final authState = ref.watch(authStateProvider);

    // Check if we're still checking authentication
    if (authState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // If we have a user, go to the weather screen
    if (authState.user != null) {
      return const WeatherScreen();
    }

    // Otherwise, go to login
    return const LoginPage();
  }
}
