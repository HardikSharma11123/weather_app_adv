String getWeatherAnimation(String condition) {
  switch (condition.toLowerCase()) {
    case 'clear':
      return 'assets/lottie/sunny.json';
    case 'clouds':
      return 'assets/lottie/cloudy.json';
    case 'rain':
      return 'assets/lottie/rain.json';
    case 'snow':
      return 'assets/lottie/snow.json';
    case 'thunderstorm':
      return 'assets/lottie/rain.json';
    default:
      return 'assets/lottie/sunny.json';
  }
}
