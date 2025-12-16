
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';
import 'package:skycast/base_architecture/domain/repository/api_repository.dart';

class CityWeatherReposity extends ApiRepository<WeatherDataModel>{
  CityWeatherReposity({required super.networkClient});
}