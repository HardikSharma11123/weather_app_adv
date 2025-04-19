import 'package:flutter/material.dart';
import 'package:weather_app_adv/core/utils/decorations.dart';

class CityTempratureCard extends StatelessWidget {
  final String city;
  final bool isDaytime;
  final double temperature;
  final String condition;
  const CityTempratureCard({
    super.key,
    required this.isDaytime,
    required this.temperature,
    required this.condition,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 1),
      decoration: weatherBoxDecoration(isDaytime),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            city,
            style: TextStyle(
              fontSize: 40,
              color: !isDaytime ? Colors.black : Colors.white,
            ),
          ),
          Text(
            "$temperature°C | $condition",
            style: TextStyle(
              fontSize: 35,
              color: !isDaytime ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
