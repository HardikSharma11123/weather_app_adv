import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
  final double latitude;
  final double longitude;
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
    required this.latitude,
    required this.longitude,
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
              city: city,
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
              "Weather Map",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 200,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(latitude, longitude),
                    initialZoom: 7,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      // Note: subdomains may no longer be needed with newer versions
                      userAgentPackageName: 'com.example.app',
                    ),
                    // Weather overlay with your actual API key
                    TileLayer(
                      urlTemplate:
                          'https://tile.openweathermap.org/map/clouds_new/{z}/{x}/{y}.png?appid=538e384934e8f157d8305c0e35fabd65',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(latitude, longitude),
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Info cards row (Humidity & Feels Like)
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

  // Additional info row (Sunrise & Sunset)
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

  // Single Info Card widget
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
}
