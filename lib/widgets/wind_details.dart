import 'package:flutter/material.dart';
import 'package:weather_app_adv/core/utils/decorations.dart';
import 'package:weather_app_adv/widgets/wind_direction_widget.dart';

class WindDetails extends StatelessWidget {
  final bool isDaytime;
  final double windSpeed;
  final double direction;
  final double gust;
  const WindDetails({
    super.key,
    required this.isDaytime,
    required this.windSpeed,
    required this.direction,
    required this.gust,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: weatherBoxDecoration(isDaytime),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Wind",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: !isDaytime ? Colors.black : Colors.white,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.air,
                  color: !isDaytime ? Colors.black : Colors.white,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Wind Speed: $windSpeed km/h",
                      style: TextStyle(
                        color: !isDaytime ? Colors.black : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Gusts: $gust km/h",
                      style: TextStyle(
                        color: !isDaytime ? Colors.black : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Direction: $direction° WNW",
                      style: TextStyle(
                        color: !isDaytime ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),
                WindDirectionWidget(windDegree: 300, isDaytime: isDaytime),
                const SizedBox(width: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
