// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class WeatherModel {
  final String city;
  final double temperature;
  final double lat;
  final double lon;
  final String condition;
  final int humidity;
  final double windSpeed;
  final double direction;
  final double tempfeels;
  final double gust;
  final String sunrise;
  final String sunset;
  final String currentTime;
  final bool isDaytime;
  final List<Map<String, dynamic>> hourlyForecast;
  final List<Map<String, dynamic>> weeklyForecast;

  WeatherModel({
    required this.lat,
    required this.lon,
    required this.city,
    required this.temperature,
    required this.currentTime,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.direction,
    required this.tempfeels,
    required this.gust,
    required this.sunrise,
    required this.sunset,
    required this.isDaytime,
    required this.hourlyForecast,
    required this.weeklyForecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final timezoneOffset = json['timezone']; // in seconds
    final DateFormat timeFormat = DateFormat('hh:mm a');
    final DateFormat dayFormat = DateFormat('EEE');

    // Current time at searched location
    final utcTime = DateTime.now().toUtc();
    final localTime = utcTime.add(Duration(seconds: timezoneOffset));
    final formattedTime = timeFormat.format(localTime);

    final sunriseUnix = json['sys']['sunrise'] * 1000;
    final sunsetUnix = json['sys']['sunset'] * 1000;

    final sunrise = timeFormat.format(
      DateTime.fromMillisecondsSinceEpoch(
        sunriseUnix,
      ).toUtc().add(Duration(seconds: timezoneOffset)),
    );

    final sunset = timeFormat.format(
      DateTime.fromMillisecondsSinceEpoch(
        sunsetUnix,
      ).toUtc().add(Duration(seconds: timezoneOffset)),
    );

    final List<Map<String, dynamic>> hourlyForecast =
        (json['hourly'] ?? []).take(12).map<Map<String, dynamic>>((hour) {
          final hourTime = DateTime.fromMillisecondsSinceEpoch(
            hour['dt'] * 1000,
          ).toUtc().add(Duration(seconds: timezoneOffset));
          return {
            'time': timeFormat.format(hourTime),
            'temp': hour['temp'],
            'icon': hour['weather'][0]['icon'],
          };
        }).toList();

    final List<Map<String, dynamic>> weeklyForecast =
        (json['daily'] ?? []).take(7).map<Map<String, dynamic>>((day) {
          final dayTime = DateTime.fromMillisecondsSinceEpoch(
            day['dt'] * 1000,
          ).toUtc().add(Duration(seconds: timezoneOffset));
          return {
            'day': dayFormat.format(dayTime),
            'temp': day['temp']['day'],
            'icon': day['weather'][0]['icon'],
          };
        }).toList();

    return WeatherModel(
      city: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      tempfeels: (json['main']['feels_like'] as num).toDouble(),
      lat: (json['coord']['lat'] as num).toDouble(),
      lon: (json['coord']['lon'] as num).toDouble(),
      condition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      direction: (json['wind']['deg'] as num).toDouble(),
      gust: (json['wind']['gust'] as num?)?.toDouble() ?? 0.0,
      sunrise: sunrise,
      sunset: sunset,
      isDaytime: localTime.hour >= 6 && localTime.hour < 18,
      hourlyForecast: hourlyForecast,
      weeklyForecast: weeklyForecast,
      currentTime: formattedTime,
    );
  }
}
