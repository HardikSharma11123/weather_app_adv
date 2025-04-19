import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_adv/services/weather_model.dart';
import '../services/weather_api_service.dart';

// City selected by user (defaults to Mumbai)
final selectedCityProvider = StateProvider<String>((ref) => 'Mumbai');

// Weather API service instance
final weatherApiProvider = Provider((ref) => WeatherApiService());

// Fetches weather data for the selected city
final weatherDataProvider = FutureProvider<WeatherModel>((ref) async {
  final api = ref.watch(weatherApiProvider);
  final city = ref.watch(selectedCityProvider);
  return api.fetchWeatherByCity(city);
});
