import 'package:flutter/widgets.dart';

class WeatherTheme {
  static List<Color> getColors(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return [const Color(0xFFFFD200), const Color(0xFFF7971E)]; // Sunny
      case 'rain':
      case 'drizzle':
      case 'thunderstorm':
        return [const Color(0xFF203A43), const Color(0xFF2C5364)]; // Stormy
      case 'clouds':
        return [const Color(0xFF616161), const Color(0xFF9BC5C3)]; // Cloudy
      default:
        return [const Color(0xFF4A90E2), const Color(0xFF1B3B5F)]; // Default Night/Blue
    }
  }
}