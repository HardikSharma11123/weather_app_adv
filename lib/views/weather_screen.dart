// lib/views/weather_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_adv/services/weather_provider.dart';
import '../widgets/gradient_background.dart';
import '../widgets/weather_animation.dart';
import '../widgets/weather_info.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherDataProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: weatherAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (weather) {
          return Stack(
            children: [
              GradientBackground(
                weatherCondition: weather.condition,
                isDaytime: weather.isDaytime,
              ),
              WeatherAnimation(
                weatherCondition: weather.condition,
                isDaytime: weather.isDaytime,
              ),
              SafeArea(
                child: ListView(
                  padding: const EdgeInsets.only(top: 20),
                  children: [
                    AppBar(
                      title: Text(
                        weather.city,
                        style: const TextStyle(
                          fontSize: 34,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      centerTitle: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: WeatherInfo(
                        weeklyForecast: weather.weeklyForecast,
                        hourlyForecast: weather.hourlyForecast,
                        direction: weather.direction,
                        gust: weather.gust,
                        isDaytime: weather.isDaytime,
                        city: weather.city,
                        temperature: weather.temperature,
                        condition: weather.condition,
                        humidity: weather.humidity,
                        windSpeed: weather.windSpeed,
                        sunrise: weather.sunrise,
                        sunset: weather.sunset,
                        tempfeels: weather.tempfeels,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
