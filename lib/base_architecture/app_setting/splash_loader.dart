
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skycast/base_architecture/app_setting/app_route.dart';
import 'package:skycast/base_architecture/app_setting/navigation_service.dart';
import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_state.dart';
import 'package:skycast/base_architecture/presentation/bloc/implement/cureent_weather/cureent_forecast_bloc.dart';
import 'package:skycast/base_architecture/presentation/bloc/implement/cureent_weather/cureent_weather_bloc.dart';

class SplashLoader extends StatefulWidget {
  const SplashLoader({super.key});

  @override
  State<SplashLoader> createState() => _SplashLoaderState();
}

class _SplashLoaderState extends State<SplashLoader> {
  bool _isCurrentWeatherLoaded = false;
  bool _isForecastLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAndInitApp();
    });
  }

  Future<void> _fetchAndInitApp() async {
    context.read<CurrentWeatherBloc>().fetchCureentWeather();
    context.read<CurrentForecastBloc>().fetchCureentForecast();
  }

  void _checkAndNavigate() {
    if ( _isForecastLoaded) {
      NavigationService.instance.pushNamedAndRemoveUntil(AppRoute.searchScreen);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (value, type) {},

      child: MultiBlocListener(
        listeners: [
          BlocListener<CurrentWeatherBloc, ApiState>(
            listener: (context, state) {
              log("weather : ${state}");
              if (state is ApiSuccess<WeatherDataModel>) {
                _isCurrentWeatherLoaded = true;
                _checkAndNavigate();
              }
              if (state is ApiFailure) {
                _isCurrentWeatherLoaded = true;
                _checkAndNavigate();
              }
            },
          ),

          BlocListener<CurrentForecastBloc, ApiState>(
            listener: (context, state) {
                            log("forecast : ${state}");

              if (state is ApiSuccess<ForecastModel>) {
                _isForecastLoaded = true;
                _checkAndNavigate();
              }
              if (state is ApiFailure) {
                _isForecastLoaded = true;
                _checkAndNavigate();
              }
            },
          ),
        ],
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF1A1C38),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
