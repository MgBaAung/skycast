
import 'package:skycast/base_architecture/domain/entity/current_weather_entity.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';
import 'package:skycast/base_architecture/domain/repository/api_repository_with_local.dart';

class CurrentLocationWithLocalStoreRepository extends ApiRepositoryWithLocalStorage<WeatherDataModel,CurrentWeatherEntity>{
  CurrentLocationWithLocalStoreRepository({required super.networkClient, required super.localDataSource});
}