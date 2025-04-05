import 'package:flutter/material.dart';
import 'package:weather_app_adv/core/utils/decorations.dart';

class HourlyForecast extends StatelessWidget {
  final bool isDaytime;
  final double windSpeed;
  final List<Map<String, dynamic>> hourlyForecast;

  const HourlyForecast({
    super.key,
    required this.isDaytime,
    required this.windSpeed,
    required this.hourlyForecast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: weatherBoxDecoration(isDaytime),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hourly Forecast",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: !isDaytime ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  hourlyForecast.map((hourData) {
                    final time = hourData['time'] as DateTime;
                    final temp = hourData['temp'];
                    final iconCode = hourData['icon'];
                    final iconUrl =
                        'https://openweathermap.org/img/wn/$iconCode@2x.png';

                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          Text(
                            "${time.hour}:00",
                            style: TextStyle(
                              color: !isDaytime ? Colors.black : Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Image.network(iconUrl, width: 40, height: 40),
                          const SizedBox(height: 6),
                          Text(
                            "${temp.toStringAsFixed(0)}°",
                            style: TextStyle(
                              color: !isDaytime ? Colors.black : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
