// lib/services/weather_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app_adv/services/weather_model.dart';

class WeatherApiService {
  final currentHour = DateTime.now().hour;
  Future<WeatherModel> fetchWeather(String city) async {
    final apiKey = '538e384934e8f157d8305c0e35fabd65';
    final locationUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    final locationResponse = await http.get(Uri.parse(locationUrl));
    final locationData = jsonDecode(locationResponse.body);

    final lat = locationData['coord']['lat'];
    final lon = locationData['coord']['lon'];

    final oneCallUrl =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely,alerts&appid=$apiKey&units=metric';

    final forecastResponse = await http.get(Uri.parse(oneCallUrl));
    final forecastData = jsonDecode(forecastResponse.body);

    // Safely extract hourly forecast
    final List<Map<String, dynamic>> hourlyForecast =
        (forecastData['hourly'] as List?)
            ?.take(12)
            .map(
              (hour) => {
                'time': DateTime.fromMillisecondsSinceEpoch(hour['dt'] * 1000),
                'temp': hour['temp'],
                'icon': hour['weather'][0]['icon'],
              },
            )
            .toList() ??
        [];

    // Safely extract daily forecast
    final List<Map<String, dynamic>> weeklyForecast =
        (forecastData['daily'] as List?)
            ?.take(7)
            .map(
              (day) => {
                'day': DateTime.fromMillisecondsSinceEpoch(day['dt'] * 1000),
                'temp': day['temp']['day'],
                'icon': day['weather'][0]['icon'],
              },
            )
            .toList() ??
        [];

    return WeatherModel(
      city: locationData['name'],
      temperature: locationData['main']['temp'].toDouble(),
      condition: locationData['weather'][0]['main'],
      humidity: locationData['main']['humidity'],
      windSpeed: locationData['wind']['speed'].toDouble(),
      sunrise: _formatTime(locationData['sys']['sunrise']),
      sunset: _formatTime(locationData['sys']['sunset']),
      tempfeels: locationData['main']['feels_like'].toDouble(),
      direction: locationData['wind']['deg'].toDouble(),
      gust: locationData['wind']['gust']?.toDouble() ?? 0.0,
      hourlyForecast: hourlyForecast,
      weeklyForecast: weeklyForecast,
      isDaytime: currentHour >= 6 && currentHour < 18,
    );
  }

  String _formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}
