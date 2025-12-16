import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_state.dart';
import 'package:skycast/base_architecture/presentation/bloc/implement/cureent_weather/cureent_weather_bloc.dart';
import 'package:skycast/base_architecture/presentation/pages/common_widget/weather_widget.dart';

class CurrentWeatherScreen extends StatefulWidget {
  const CurrentWeatherScreen({super.key});

  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CurrentWeatherBloc>().fetchCureentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, ApiState>(
      buildWhen: (previous, current) {
        return current is ApiSuccess<WeatherDataModel> ||
            current is ApiLoading ||
            current is ApiFailure;
      },
      builder: (context, state) {
        if (state is ApiSuccess<WeatherDataModel>) {
          WeatherDataModel data = state.data;

          return WeatherWidget(data: data);
        }

        if (state is ApiLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ApiFailure) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return Center(
          child: Text(
            'Fetching weather for...',
            style: const TextStyle(color: Colors.white70),
          ),
        );
      },
    );
  }
}
