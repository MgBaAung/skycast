import 'package:flutter/material.dart';
import 'package:skycast/base_architecture/domain/model/city_model.dart';
import 'package:skycast/base_architecture/presentation/pages/city_screen/city_search_screen.dart';
import 'package:skycast/base_architecture/presentation/pages/city_screen/city_weather_screen/city_weather_screen.dart';

class AppRoute {
  static dynamic callData;
  static const register = '/register';
  static const loginPage = '/login';
  static const searchScreen = '/search';
  static const cityWeatherScreen = '/city';

  static Route<Object>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case searchScreen:
        return MaterialPageRoute(
          builder: (context) => CitySearchScreen(),
          settings: settings,
        );

      case cityWeatherScreen:
        return MaterialPageRoute(
          builder: (context) =>
              CityWeatherScreen(city: settings.arguments as Results),
          settings: settings,
        );
      default:
        return null;
    }
  }
}
