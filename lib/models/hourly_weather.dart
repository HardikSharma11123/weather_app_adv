class HourlyWeather {
  final DateTime time;
  final double temperature;
  final String condition;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.condition,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: (json['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
    );
  }
}
