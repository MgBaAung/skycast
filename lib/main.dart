import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skycast/base_architecture/app_setting/app_route.dart';
import 'package:skycast/base_architecture/app_setting/navigation_service.dart';
import 'package:skycast/base_architecture/app_setting/splash_loader.dart';
import 'package:skycast/base_architecture/data/local_datasource/hive_local_datasource.dart';
import 'package:skycast/base_architecture/data/local_datasource/token_manager.dart';
import 'package:skycast/base_architecture/data/network_datasource/http_network/http_network.dart';
import 'package:skycast/base_architecture/domain/entity/current_weather_entity.dart';
import 'package:skycast/base_architecture/domain/entity/forecast_entity.dart';
import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';
import 'package:skycast/base_architecture/domain/repository/implement/current_forecast_repository.dart';
import 'package:skycast/base_architecture/domain/repository/implement/current_location_repository.dart';
import 'package:skycast/base_architecture/domain/repository/implement/current_location_with_local_store_repository.dart';
import 'package:skycast/base_architecture/domain/repository/implement/forecast_weather_with_local_repository.dart';
import 'package:skycast/base_architecture/domain/repository/implement/location_repository.dart';
import 'package:skycast/base_architecture/domain/usecase/implement/current_weather_usecase.dart';
import 'package:skycast/base_architecture/domain/usecase/implement/forecast_local_usecase.dart';
import 'package:skycast/base_architecture/presentation/bloc/bloc_observer.dart';
import 'package:skycast/base_architecture/presentation/bloc/implement/cureent_weather/cureent_forecast_bloc.dart';
import 'package:skycast/base_architecture/presentation/bloc/implement/cureent_weather/cureent_weather_bloc.dart';
import 'package:skycast/injector.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  CurrentWeatherEntity.register();
  ForecastEntity.register();

  currentBox = await Hive.openBox<CurrentWeatherEntity>('weather');
  forecastBox = await Hive.openBox<ForecastEntity>('forecast');

  runApp(const SkyCastApp());
}

class SkyCastApp extends StatelessWidget {
  const SkyCastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TokenManager>(create: (_) => TokenManager()),
        RepositoryProvider<HttpNetworkClient>(
          create: (_) => HttpNetworkClient(),
        ),

        RepositoryProvider(
          create: (context) => CurrentLocationWithLocalStoreRepository(
            networkClient: context.read<HttpNetworkClient>(),
            localDataSource:
                HiveLocalDataSourceImpl<WeatherDataModel, CurrentWeatherEntity>(
                  entityFactory: () => CurrentWeatherEntity(),
                  box: currentBox,
                ),
          ),
        ),
        RepositoryProvider(
          create: (context) => ForecastWeatherWithLocalRepository(
            networkClient: context.read<HttpNetworkClient>(),
            localDataSource:
                HiveLocalDataSourceImpl<ForecastModel, ForecastEntity>(
                  entityFactory: () => ForecastEntity(),
                  box: forecastBox,
                ),
          ),
        ),
        RepositoryProvider(create: (context) => LocationRepository()),
        RepositoryProvider(
          create: (context) => CurrentLocationRepository(
            networkClient: context.read<HttpNetworkClient>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => CurrentForecastRepository(
            networkClient: context.read<HttpNetworkClient>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CurrentWeatherBloc(
              currentWeatherUsecase: CurrentWeatherUsecase(
                currentLocationRepository: context
                    .read<CurrentLocationRepository>(),
                repository: context
                    .read<CurrentLocationWithLocalStoreRepository>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => CurrentForecastBloc(
              forecastLocalUsecase: ForecastLocalUsecase(
                currentLocationRepository: context
                    .read<CurrentForecastRepository>(),
                forecastWeatherWithLocalRepository: context
                    .read<ForecastWeatherWithLocalRepository>(),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'SkyCast Weather',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            useMaterial3: true,
            fontFamily: 'Montserrat',
            scaffoldBackgroundColor: const Color(0xFF1E2139),
          ),
          navigatorKey: NavigationService.instance.navigationKey,
          onGenerateRoute: AppRoute.generateRoute,
          home: const SplashLoader(),
        ),
      ),
    );
  }
}
