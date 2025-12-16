import 'package:flutter/material.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherDataModel data;
  const WeatherWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final double currentTemp = data.main?.temp ?? 0.0;
    final String weatherDescription = data.weather?.isNotEmpty == true
        ? data.weather!.first.description ?? 'N/A'
        : 'N/A';
    final int conditionId = data.weather?.isNotEmpty == true
        ? data.weather!.first.id
        : 800; 
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '${data.name}, ${data.sys?.country ?? 'N/A'}',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),

          Icon(
            _getWeatherIcon(conditionId),
            size: 100.0,
            color: Colors.yellow,
          ),
          const SizedBox(height: 10),
          Text(
            '${currentTemp.toStringAsFixed(1)}°C',
            style: const TextStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.w100,
              color: Colors.white,
            ),
          ),
          Text(
            weatherDescription,
            style: const TextStyle(fontSize: 24.0, color: Colors.white70),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(int conditionId) {
    if (conditionId < 300) return Icons.thunderstorm; 
    if (conditionId < 500) return Icons.cloudy_snowing;
    if (conditionId < 600) return Icons.umbrella;
    if (conditionId < 700) return Icons.snowing;
    if (conditionId < 800) return Icons.foggy;
    if (conditionId == 800) return Icons.wb_sunny;
    if (conditionId <= 804) return Icons.cloud;
    return Icons.device_thermostat;
  }
}
