import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skycast/base_architecture/app_setting/custom_error_widget.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_state.dart';
import 'package:skycast/base_architecture/presentation/bloc/implement/city_weather/city_weather_bloc.dart';
import 'package:skycast/base_architecture/presentation/pages/common_widget/weather_widget.dart';

class CityCurrentWeather extends StatefulWidget {
  const CityCurrentWeather({super.key});

  @override
  State<CityCurrentWeather> createState() => _CityCurrentWeatherState();
}

class _CityCurrentWeatherState extends State<CityCurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityWeatherBloc, ApiState>(
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

        if (state is ApiFailure) {
          return ApiErrorWidget(
            onRetry: () {
              context.read<CityWeatherBloc>().getWeather();
            },
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
