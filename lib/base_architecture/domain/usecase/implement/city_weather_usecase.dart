import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';
import 'package:skycast/base_architecture/domain/repository/implement/city_weather_reposity.dart';
import 'package:skycast/base_architecture/domain/usecase/baste_usecase.dart';

class CityWeatherUsecase extends CrudUseCase<WeatherDataModel> {
  final CityWeatherReposity cityWeatherReposity;
  CityWeatherUsecase({required this.cityWeatherReposity})
    : super(repository: cityWeatherReposity);
    
}
