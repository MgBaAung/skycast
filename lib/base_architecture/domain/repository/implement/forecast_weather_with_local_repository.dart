
import 'package:skycast/base_architecture/domain/entity/forecast_entity.dart';
import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:skycast/base_architecture/domain/repository/api_repository_with_local.dart';

class ForecastWeatherWithLocalRepository extends ApiRepositoryWithLocalStorage<ForecastModel,ForecastEntity>{
  ForecastWeatherWithLocalRepository({required super.networkClient, required super.localDataSource});
}