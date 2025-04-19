import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app_adv/services/weather_model.dart';

class WeatherApiService {
  final String _apiKey = '538e384934e8f157d8305c0e35fabd65';

  Future<WeatherModel> fetchWeatherByCity(String cityName) async {
    final weatherUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$_apiKey&units=metric';

    final forecastUrl =
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$_apiKey&units=metric';

    final weatherResponse = await http.get(Uri.parse(weatherUrl));
    final forecastResponse = await http.get(Uri.parse(forecastUrl));

    if (weatherResponse.statusCode != 200 ||
        forecastResponse.statusCode != 200) {
      throw Exception('Failed to fetch weather data');
    }

    try {
      final currentData = jsonDecode(weatherResponse.body);
      final forecastData = jsonDecode(forecastResponse.body);

      final int timezoneOffset = currentData['timezone']; // seconds
      final int dt = currentData['dt'];
      final DateTime localTime = DateTime.fromMillisecondsSinceEpoch(
        (dt + timezoneOffset) * 1000,
        isUtc: true,
      );

      final hourlyForecast = _parseHourlyForecast(
        forecastData['list'],
        timezoneOffset,
      );
      final weeklyForecast = _parseWeeklyForecast(
        forecastData['list'],
        timezoneOffset,
      );

      return WeatherModel(
        city: currentData['name'],
        temperature: (currentData['main']['temp'] as num).toDouble(),
        condition: currentData['weather'][0]['main'],
        humidity: currentData['main']['humidity'],
        windSpeed: (currentData['wind']['speed'] as num).toDouble(),
        sunrise: _formatTimeWithOffset(
          currentData['sys']['sunrise'],
          timezoneOffset,
        ),
        sunset: _formatTimeWithOffset(
          currentData['sys']['sunset'],
          timezoneOffset,
        ),
        lat: (currentData['coord']['lat'] as num).toDouble(),
        lon: (currentData['coord']['lon'] as num).toDouble(),
        tempfeels: (currentData['main']['feels_like'] as num).toDouble(),
        direction: (currentData['wind']['deg'] as num).toDouble(),
        gust: (currentData['wind']['gust'] as num?)?.toDouble() ?? 0.0,
        hourlyForecast: hourlyForecast,
        weeklyForecast: weeklyForecast,
        currentTime: DateFormat('hh:mm a').format(localTime),
        isDaytime: localTime.hour >= 6 && localTime.hour < 18,
      );
    } catch (e) {
      throw Exception('Error parsing weather data: $e');
    }
  }

  List<Map<String, dynamic>> _parseHourlyForecast(
    List<dynamic> list,
    int timezoneOffset,
  ) {
    return list.take(12).map((entry) {
      final utcTime = DateTime.parse(entry['dt_txt']).toUtc();
      final localTime = utcTime.add(Duration(seconds: timezoneOffset));
      return {
        'time': localTime, // <-- DateTime object
        'temp': (entry['main']['temp'] as num).toDouble(),
        'icon': entry['weather']?[0]?['icon'] ?? '',
      };
    }).toList();
  }

  List<Map<String, dynamic>> _parseWeeklyForecast(
    List<dynamic> list,
    int timezoneOffset,
  ) {
    final Map<String, Map<String, dynamic>> dailyMap = {};

    for (var entry in list) {
      final utcTime = DateTime.parse(entry['dt_txt']).toUtc();
      final localTime = utcTime.add(Duration(seconds: timezoneOffset));
      final dayKey = DateFormat('yyyy-MM-dd').format(localTime);

      if (!dailyMap.containsKey(dayKey) || localTime.hour == 12) {
        dailyMap[dayKey] = {
          'day': localTime, // <-- DateTime object
          'temp': (entry['main']['temp'] as num).toDouble(),
          'icon': entry['weather'][0]['icon'],
        };
      }
    }

    return dailyMap.values.take(7).toList();
  }
}

String _formatTimeWithOffset(int timestamp, int timezoneOffset) {
  final date = DateTime.fromMillisecondsSinceEpoch(
    (timestamp + timezoneOffset) * 1000,
    isUtc: true,
  );
  return DateFormat('hh:mm a').format(date);
}
