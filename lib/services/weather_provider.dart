// lib/providers/weather_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_adv/services/weather_model.dart';
import '../services/weather_api_service.dart';

final weatherApiProvider = Provider((ref) => WeatherApiService());

final selectedCityProvider = StateProvider<String>((ref) => 'Mumbai');

final weatherDataProvider = FutureProvider<WeatherModel>((ref) async {
  final city = ref.watch(selectedCityProvider);
  final api = ref.watch(weatherApiProvider);
  return api.fetchWeather(city); // Now includes forecasts!
});
