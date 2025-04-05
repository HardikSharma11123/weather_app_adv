import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../core/utils/animation_helper.dart';

class WeatherAnimation extends StatelessWidget {
  final String weatherCondition;
  final bool isDaytime;

  const WeatherAnimation({
    required this.weatherCondition,
    required this.isDaytime,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        getWeatherAnimation(weatherCondition),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
