import 'package:skycast/base_architecture/core/api_end_point.dart';
import 'package:skycast/base_architecture/domain/model/city_model.dart';
import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:skycast/base_architecture/domain/usecase/implement/city_forecast_usecase.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_event.dart';
import 'package:skycast/base_architecture/presentation/bloc/base_bloc.dart';

class CityForecastBloc extends BaseBloc<ForecastModel> {
  final CityForecastUsecase cityForecastUsecase;
  CityForecastBloc({required this.cityForecastUsecase})
    : super(crudUsecase: cityForecastUsecase);

  Results? results;

  void getWeather({Results? model}) {
    results = model??results;
    add(
      FetchDataEvent(
        endpoint: forecastUrl,
        parser: (json) => ForecastModel().fromMap(json),
        isList: false,
        queryParams: {
          'lat': model?.latitude.toString(),
          'lon': model?.longitude.toString(),
        },
      ),
    );
  }
}
