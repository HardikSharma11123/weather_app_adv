// ignore_for_file: public_member_api_docs, sort_constructors_first
// lib/models/weather_model.dart

class WeatherModel {
  final String city;
  final double temperature;
  final String condition;
  final int humidity;
  final double windSpeed;
  final double direction;
  final double tempfeels;
  final double gust;
  final String sunrise;
  final String sunset;
  final bool isDaytime;
  final List<Map<String, dynamic>> hourlyForecast;
  final List<Map<String, dynamic>> weeklyForecast;

  WeatherModel({
    required this.city,
    required this.temperature,
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
    final currentHour = DateTime.now().hour;
    final sunriseUnix = json['sys']['sunrise'] * 1000;
    final sunsetUnix = json['sys']['sunset'] * 1000;

    // fallback to empty list if hourly or daily not present
    final List<Map<String, dynamic>> hourlyForecast =
        (json['hourly'] ?? []).take(12).map<Map<String, dynamic>>((hour) {
          return {
            'time': DateTime.fromMillisecondsSinceEpoch(hour['dt'] * 1000),
            'temp': hour['temp'],
            'icon': hour['weather'][0]['icon'],
          };
        }).toList();

    final List<Map<String, dynamic>> weeklyForecast =
        (json['daily'] ?? []).take(7).map<Map<String, dynamic>>((day) {
          return {
            'day': DateTime.fromMillisecondsSinceEpoch(day['dt'] * 1000),
            'temp': day['temp']['day'],
            'icon': day['weather'][0]['icon'],
          };
        }).toList();

    return WeatherModel(
      city: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      tempfeels: (json['main']['feels_like'] as num).toDouble(),
      condition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      direction: (json['wind']['deg'] as num).toDouble(),
      gust: (json['wind']['gust'] as num?)?.toDouble() ?? 0.0,
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        sunriseUnix,
      ).toLocal().toString().split(' ')[1].substring(0, 5),
      sunset: DateTime.fromMillisecondsSinceEpoch(
        sunsetUnix,
      ).toLocal().toString().split(' ')[1].substring(0, 5),
      isDaytime: currentHour >= 6 && currentHour < 18,
      hourlyForecast: hourlyForecast,
      weeklyForecast: weeklyForecast,
    );
  }
}
