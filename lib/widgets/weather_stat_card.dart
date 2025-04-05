import 'package:flutter/material.dart';

class WeatherStatCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isDaytime;

  const WeatherStatCard({
    required this.title,
    required this.value,
    required this.isDaytime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 160,
      decoration: getWeatherBoxDecoration(isDaytime),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDaytime ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                color: isDaytime ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

BoxDecoration getWeatherBoxDecoration(bool isDaytime) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color:
        isDaytime
            ? Colors.indigoAccent.withOpacity(0.59)
            : Colors.grey.withOpacity(0.59),
  );
}
