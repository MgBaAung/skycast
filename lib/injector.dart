// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive/hive.dart';
// import 'package:skycast/base_architecture/data/network_datasource/http_network/http_network.dart';
// import 'package:skycast/base_architecture/domain/entity/current_weather_entity.dart';
// import 'package:skycast/base_architecture/domain/repository/implement/current_location_with_local_store_repository.dart';
// import 'package:skycast/base_architecture/domain/repository/implement/location_repository.dart';
// import 'package:skycast/base_architecture/domain/usecase/implement/current_weather_usecase.dart';

// GetIt injector = GetIt.instance;
import 'package:hive/hive.dart';
import 'package:skycast/base_architecture/domain/entity/current_weather_entity.dart';
import 'package:skycast/base_architecture/domain/entity/forecast_entity.dart';

late final Box<CurrentWeatherEntity> currentBox;
late final Box<ForecastEntity> forecastBox;
// Future<void> intializeInjector() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();

//   //bloc
//   // injector.registerFactory(() => ProductBloc(injector(), injector()));
//   // injector.registerFactory(() => ShortTermBloc(injector()));
//   // injector.registerFactory(() => PublicLifeBloc(injector()));
//   // injector.registerFactory(() => StudentLifeBloc(injector()));
//   // injector.registerFactory(() => EducationLifeBloc(injector()));
//   // injector.registerFactory(() => PersonalAccidentBloc(injector()));
//   // injector.registerFactory(() => TravelBloc(injector()));
//   // injector.registerFactory(() => GroupLifeBloc(injector()));
//   // injector.registerFactory(() => HealthBloc(injector()));
//   // injector.registerFactory(() => FarmerLifeBloc(injector()));
//   // injector.registerFactory(() => SnakeBiteBloc(injector()));
//   // injector.registerFactory(() => SportsmanBloc(injector()));

//   //usecase

//   injector.registerLazySingleton(
//     () => CurrentWeatherUsecase(repository: injector(), injector()),
//   );

//   //repository
//   injector.registerLazySingleton(() => LocationRepository());
//   injector.registerLazySingleton(
//     () => CurrentLocationWithLocalStoreRepository(localDataSource: injector(),networkClient: injector()),
//   );

//   injector.registerLazySingleton(() => HttpNetworkClient());
//   //injector.registerLazySingleton(()=>HiveLocalDataSourceImpl(entityFactory: entityFactory, box: box));
// }
