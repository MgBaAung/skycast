import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skycast/base_architecture/data/network_datasource/http_network/http_network.dart';
import 'package:skycast/base_architecture/domain/model/city_model.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';
import 'package:skycast/base_architecture/domain/repository/implement/city_forecast_repository.dart';
import 'package:skycast/base_architecture/domain/repository/implement/city_weather_reposity.dart';
import 'package:skycast/base_architecture/domain/usecase/implement/city_forecast_usecase.dart';
import 'package:skycast/base_architecture/domain/usecase/implement/city_weather_usecase.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_state.dart';
import 'package:skycast/base_architecture/presentation/bloc/implement/city_weather/city_forecast_bloc.dart';
import 'package:skycast/base_architecture/presentation/bloc/implement/city_weather/city_weather_bloc.dart';
import 'package:skycast/base_architecture/presentation/pages/city_screen/city_weather_screen/city_current_weather.dart';
import 'package:skycast/base_architecture/presentation/pages/city_screen/city_weather_screen/city_forecast_widget.dart';

class CityWeatherScreen extends StatefulWidget {
  final Results city;
  const CityWeatherScreen({super.key, required this.city});

  @override
  State<CityWeatherScreen> createState() => _CityWeatherScreenState();
}

class _CityWeatherScreenState extends State<CityWeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => CityWeatherReposity(
            networkClient: context.read<HttpNetworkClient>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => CityForecastRepository(
            networkClient: context.read<HttpNetworkClient>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CityWeatherBloc(
              cityWeatherUsecase: CityWeatherUsecase(
                cityWeatherReposity: context.read<CityWeatherReposity>(),
              ),
            )..getWeather(model: widget.city),
          ),
          BlocProvider(
            create: (context) => CityForecastBloc(
              cityForecastUsecase: CityForecastUsecase(
                repository: context.read<CityForecastRepository>(),
              ),
            )..getWeather(model: widget.city),
          ),
        ],
        child: Builder(
          builder: (context) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: BlocBuilder<CityWeatherBloc, ApiState>(
                  builder: (context, state) {
                    String weatherMain = 'default';
                    if (state is ApiSuccess<WeatherDataModel>) {
                      weatherMain = state.data.weather?.first.main ?? 'default';
                    }

                    final bgColors = _getBackgroundColors(weatherMain);
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [bgColors[0], bgColors[0]],
                        ),
                      ),
                      child: AppBar(
                        title: const Text(
                          ' Weather',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  },
                ),
              ),

              body: BlocBuilder<CityWeatherBloc, ApiState>(
                buildWhen: (previous, current) {
                  return current is ApiSuccess<WeatherDataModel> ||
                      current is ApiLoading ||
                      current is ApiFailure;
                },
                builder: (context, state) {
                  String weatherMain = 'default';

                  if (state is ApiSuccess<WeatherDataModel>) {
                    weatherMain = state.data.weather?.first.main ?? 'default';
                  }

                  if (state is ApiLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: _getBackgroundColors(weatherMain),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          children: [
                            CityCurrentWeather(),
                            CityForecastWidget(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  List<Color> _getBackgroundColors(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return [const Color(0xFF4facfe), const Color(0xFF00f2fe)];
      case 'clouds':
        return [const Color(0xFF606c88), const Color(0xFF3f4c6b)];
      case 'rain':
      case 'drizzle':
      case 'thunderstorm':
        return [const Color(0xFF141e30), const Color(0xFF243b55)];
      default:
        return [const Color(0xFF2D325A), const Color(0xFF1A1C38)];
    }
  }
}
