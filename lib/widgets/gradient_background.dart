import 'package:flutter/material.dart';
import '../core/utils/gradient_helper.dart';

class GradientBackground extends StatelessWidget {
  final String weatherCondition;
  final bool isDaytime;

  const GradientBackground({
    required this.weatherCondition,
    required this.isDaytime,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2), // Smooth transition
      decoration: BoxDecoration(
        gradient: getWeatherGradient(weatherCondition, isDaytime),
      ),
    );
  }
}
