import 'package:flutter/material.dart';
import 'package:weather_app_adv/core/utils/decorations.dart';
import 'package:weather_app_adv/widgets/city_temprature_card.dart';
import 'package:weather_app_adv/widgets/hourly_forecast.dart';
import 'package:weather_app_adv/widgets/weekly_forecast.dart';
import 'package:weather_app_adv/widgets/wind_details.dart';

class WeatherInfo extends StatelessWidget {
  final bool isDaytime;
  final String city;
  final double temperature;
  final String condition;
  final int humidity;
  final double windSpeed;
  final String sunrise;
  final String sunset;
  final double tempfeels;
  final double direction;
  final double gust;
  final List<Map<String, dynamic>> hourlyForecast;
  final List<Map<String, dynamic>> weeklyForecast;

  const WeatherInfo({
    Key? key,
    required this.city,
    required this.weeklyForecast,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.isDaytime,
    required this.direction,
    required this.gust,
    required this.tempfeels,
    required this.hourlyForecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CityTempratureCard(
              isDaytime: isDaytime,
              temperature: temperature,
              condition: condition,
            ),
            const SizedBox(height: 20),
            _buildMapSection(),
            const SizedBox(height: 20),
            _buildInfoRow(),
            const SizedBox(height: 20),
            HourlyForecast(
              isDaytime: isDaytime,
              windSpeed: windSpeed,
              hourlyForecast: hourlyForecast,
            ),
            const SizedBox(height: 20),
            _buildAdditionalInfoRow(),
            const SizedBox(height: 20),
            WindDetails(
              isDaytime: isDaytime,
              windSpeed: windSpeed,
              direction: direction,
              gust: gust,
            ),
            const SizedBox(height: 20),
            WeeklyForecast(
              isDaytime: isDaytime,
              weeklyForecast: weeklyForecast,
            ),
          ],
        ),
      ),
    );
  }

  // City and temperature display card

  // Map section
  Widget _buildMapSection() {
    return Container(
      width: double.infinity,
      decoration: weatherBoxDecoration(isDaytime),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Map",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: !isDaytime ? Colors.black : Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Info cards in a row
  Widget _buildInfoRow() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            "Humidity",
            "$humidity%",
            Icons.water_drop_outlined,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            "Feels Like",
            "$tempfeels °C",
            Icons.thermostat,
          ),
        ),
      ],
    );
  }

  // Single info card
  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: weatherBoxDecoration(isDaytime),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: !isDaytime ? Colors.black : Colors.white),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: !isDaytime ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              color: !isDaytime ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Additional info row (Sunrise/Sunset)
  Widget _buildAdditionalInfoRow() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard("Sunrise", sunrise, Icons.wb_sunny_outlined),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard("Sunset", sunset, Icons.nightlight_outlined),
        ),
      ],
    );
  }

  // Weekly forecast
}
