import 'package:skycast/base_architecture/core/api_response.dart';
import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:skycast/base_architecture/domain/repository/implement/current_forecast_repository.dart';
import 'package:skycast/base_architecture/domain/repository/implement/forecast_weather_with_local_repository.dart';
import 'package:skycast/base_architecture/domain/usecase/baste_usecase.dart';

class ForecastLocalUsecase extends CrudUseCase<ForecastModel> {
  final ForecastWeatherWithLocalRepository forecastWeatherWithLocalRepository;
  final CurrentForecastRepository currentLocationRepository;
  ForecastLocalUsecase({
    required this.currentLocationRepository,
    required this.forecastWeatherWithLocalRepository,
  }) : super(repository: forecastWeatherWithLocalRepository);


  Future<ApiResponse<ForecastModel>> fetchFromApiOnly<T>({
    required String endpoint,
    required ForecastModel Function(dynamic p1) parser,
    Map<String, dynamic>? queryParams,
    required bool isList,
  }) async {

    return currentLocationRepository.get(
      endpoint,
      parser,
      queryParams: queryParams,
      isList: isList,
    );
  }
}
