// lib/providers/location_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_adv/services/location_service.dart';

final locationProvider = FutureProvider<String?>((ref) async {
  final city = await LocationService.getCityName();
  return city;
});
