import 'package:flutter/material.dart';

LinearGradient getWeatherGradient(String weatherCondition, bool isDaytime) {
  if (!isDaytime) {
    // Night Gradients
    switch (weatherCondition.toLowerCase()) {
      case 'clear':
        return LinearGradient(
          colors: [Colors.deepPurple, Colors.black],
        ); // Clear Night
      case 'clouds':
        return LinearGradient(
          colors: [Colors.blueGrey.shade900, Colors.black],
        ); // Cloudy Night
      case 'rain':
        return LinearGradient(
          colors: [Colors.indigo.shade900, Colors.black],
        ); // Rainy Night
      case 'snow':
        return LinearGradient(
          colors: [Colors.grey.shade800, Colors.black],
        ); // Snowy Night
      case 'thunderstorm':
        return LinearGradient(
          colors: [Colors.black, Colors.grey.shade900],
        ); // Stormy Night
      default:
        return LinearGradient(
          colors: [Colors.black, Colors.blueGrey.shade900],
        ); // Default Night
    }
  } else {
    // Day Gradients
    switch (weatherCondition.toLowerCase()) {
      case 'clear':
        return LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade700],
        ); // Sunny Day
      case 'clouds':
        return LinearGradient(
          colors: [Colors.grey.shade700, Colors.grey.shade500],
        ); // Cloudy Day
      case 'rain':
        return LinearGradient(
          colors: [Colors.blueGrey, Colors.blue.shade900],
        ); // Rainy Day
      case 'snow':
        return LinearGradient(
          colors: [Colors.white, Colors.blueGrey],
        ); // Snowy Day
      case 'thunderstorm':
        return LinearGradient(
          colors: [Colors.black87, Colors.blueGrey.shade800],
        ); // Stormy Day
      default:
        return LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade700],
        ); // Default Day
    }
  }
}
