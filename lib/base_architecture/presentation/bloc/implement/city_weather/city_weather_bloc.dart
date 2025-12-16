import 'package:skycast/base_architecture/core/api_end_point.dart';
import 'package:skycast/base_architecture/domain/model/city_model.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';
import 'package:skycast/base_architecture/domain/usecase/implement/city_weather_usecase.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_event.dart';
import 'package:skycast/base_architecture/presentation/bloc/base_bloc.dart';

class CityWeatherBloc extends BaseBloc<WeatherDataModel> {
  final CityWeatherUsecase cityWeatherUsecase;
  CityWeatherBloc({required this.cityWeatherUsecase})
    : super(crudUsecase: cityWeatherUsecase);

  Results? results;

  void getWeather({Results? model}) {
    results = model ?? results;
    add(
      FetchDataEvent(
        endpoint: weatherUrl,
        parser: (json) {
          return WeatherDataModel().fromMap(json);
        },
        isList: false,
        queryParams: {
          'lat': model?.latitude.toString(),
          'lon': model?.longitude.toString(),
        },
      ),
    );
  }
}
