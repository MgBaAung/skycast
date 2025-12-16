import 'package:geolocator/geolocator.dart';
import 'package:skycast/base_architecture/core/api_response.dart';
import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:skycast/base_architecture/domain/repository/implement/current_forecast_repository.dart';
import 'package:skycast/base_architecture/domain/repository/implement/forecast_weather_with_local_repository.dart';
import 'package:skycast/base_architecture/domain/repository/implement/location_repository.dart';
import 'package:skycast/base_architecture/domain/usecase/baste_usecase.dart';

class ForecastLocalUsecase extends CrudUseCase<ForecastModel> {
  final LocationRepository locationRepository;
  final ForecastWeatherWithLocalRepository forecastWeatherWithLocalRepository;
  final CurrentForecastRepository currentLocationRepository;
  ForecastLocalUsecase({
    required this.locationRepository,
    required this.currentLocationRepository,
    required this.forecastWeatherWithLocalRepository,
  }) : super(repository: forecastWeatherWithLocalRepository);

  @override
  Future<ApiResponse<ForecastModel>> get({
    required String endpoint,
    required ForecastModel Function(dynamic p1) parser,
    required bool isList,
    Map<String, dynamic>? queryParams,
  }) async {
    final Position position = await locationRepository.getCurrentLocation();
    final Map<String, dynamic> finalQueryParams = {
      'lat': position.latitude.toString(),
      'lon': position.longitude.toString(),
    };
    return super.get(
      endpoint: endpoint,
      parser: parser,
      queryParams: finalQueryParams,
      isList: isList,
    );
  }


  Future<ApiResponse<ForecastModel>> fetchFromApiOnly<T>({
    required String endpoint,
    required ForecastModel Function(dynamic p1) parser,
    Map<String, dynamic>? queryParams,
    required bool isList,
  }) async {
    final Position position = await locationRepository.getCurrentLocation();
    final Map<String, dynamic> finalQueryParams = {
      ...(queryParams ?? {}),
      'lat': position.latitude.toString(),
      'lon': position.longitude.toString(),
    };
    return currentLocationRepository.get(
      endpoint,
      parser,
      queryParams: finalQueryParams,
      isList: isList,
    );
  }
}
