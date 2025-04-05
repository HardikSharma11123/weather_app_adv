import 'package:flutter/material.dart';
import 'package:weather_app_adv/core/utils/decorations.dart';

class WeeklyForecast extends StatelessWidget {
  final bool isDaytime;
  final List<Map<String, dynamic>> weeklyForecast;

  const WeeklyForecast({
    super.key,
    required this.isDaytime,
    required this.weeklyForecast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: weatherBoxDecoration(isDaytime),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "7-Day Forecast",
            style: TextStyle(
              color: isDaytime ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children:
                weeklyForecast.map((dayData) {
                  final date = dayData['day'] as DateTime;
                  final temp = dayData['temp'].toString();
                  final iconCode = dayData['icon'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getWeekday(date),
                          style: TextStyle(
                            color: isDaytime ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Image.network(
                              "https://openweathermap.org/img/wn/$iconCode@2x.png",
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "$temp°C",
                              style: TextStyle(
                                color: isDaytime ? Colors.white : Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  String _getWeekday(DateTime date) {
    const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return days[date.weekday % 7];
  }
}
