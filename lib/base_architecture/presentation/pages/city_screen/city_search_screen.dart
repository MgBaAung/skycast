import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skycast/base_architecture/app_setting/app_route.dart';
import 'package:skycast/base_architecture/app_setting/navigation_service.dart';
import 'package:skycast/base_architecture/data/network_datasource/http_network/http_network.dart';
import 'package:skycast/base_architecture/domain/model/city_model.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';
import 'package:skycast/base_architecture/domain/repository/implement/search_name_repository.dart';
import 'package:skycast/base_architecture/domain/usecase/implement/search_name_usecase.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_state.dart';
import 'package:skycast/base_architecture/presentation/bloc/implement/cureent_weather/cureent_weather_bloc.dart';
import 'package:skycast/base_architecture/presentation/bloc/implement/cureent_weather/search_bloc.dart';
import 'package:skycast/base_architecture/presentation/pages/cureent_weather_screen/current_weather_screen.dart';
import 'package:skycast/base_architecture/presentation/pages/current_forecast_screen/current_forecast_screen.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({super.key});

  @override
  State<CitySearchScreen> createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  final TextEditingController _cityController = TextEditingController();
  final GlobalKey<DropdownButton2State> dropdownKey =
      GlobalKey<DropdownButton2State>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => SearchNameRepository(
            networkClient: context.read<HttpNetworkClient>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SearchNameUsecase(
            searchNameRepository: context.read<SearchNameRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SearchBloc(
              searchNameUsecase: context.read<SearchNameUsecase>(),
            ),
          ),
        ],
        child: Builder(
          builder: (context) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(120.0),
                child: BlocBuilder<CurrentWeatherBloc, ApiState>(
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
                          'City Search',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(60.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: BlocConsumer<SearchBloc, ApiState>(
                                buildWhen: (previous, current) =>
                                    current is ApiSuccess<CityModel>,

                                listener: (context, state) {
                                  if (state is ApiSuccess<CityModel> &&
                                      state.data.results != null &&
                                      state.data.results!.isNotEmpty) {
                                    dropdownKey.currentState?.callTap();
                                  }
                                },

                                builder: (context, state) {
                                  List<Results> cityList = [];
                                  if (state is ApiSuccess<CityModel>) {
                                    cityList = state.data.results!;
                                  }

                                  return DropdownButton2<Results>(
                                    key: dropdownKey,
                                    isExpanded: true,
                                    customButton: TextField(
                                      controller: _cityController,
                                      decoration: InputDecoration(
                                        labelText: 'Enter City Name',
                                        prefixIcon: const Icon(
                                          Icons.location_city,
                                          color: Colors.blue,
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFF2D325A),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12.0,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      onSubmitted: (value) {
                                        context.read<SearchBloc>().search(
                                          value,
                                        );
                                      },
                                    ),
                                    items: cityList
                                        .map(
                                          (item) => DropdownMenuItem<Results>(
                                            value: item,
                                            child: Text(
                                              item.name ?? '',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      NavigationService.instance.pushNamed(
                                        AppRoute.cityWeatherScreen,
                                        args: value,
                                      );
                                    },
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: const Color(0xFF2D325A),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              body: BlocBuilder<CurrentWeatherBloc, ApiState>(
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
                            CurrentWeatherScreen(),
                            CurrentForecastScreen(),
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
