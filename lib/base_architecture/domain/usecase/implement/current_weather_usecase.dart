import 'package:geolocator/geolocator.dart';
import 'package:skycast/base_architecture/core/api_response.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';
import 'package:skycast/base_architecture/domain/repository/implement/current_location_repository.dart';
import 'package:skycast/base_architecture/domain/repository/implement/location_repository.dart';
import 'package:skycast/base_architecture/domain/usecase/baste_usecase.dart';

class CurrentWeatherUsecase extends CrudUseCase<WeatherDataModel> {
  final LocationRepository locationRepository;
  final CurrentLocationRepository currentLocationRepository;
  CurrentWeatherUsecase(
    this.locationRepository, {
    required super.repository,
    required this.currentLocationRepository,
  });

// fetch data first from cache, but if no have, fetch from api
  @override
  Future<ApiResponse<WeatherDataModel>> get({
    required String endpoint,
    required WeatherDataModel Function(dynamic p1) parser,
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

  // fetch only api
  Future<ApiResponse<WeatherDataModel>> fetchFromApiOnly<T>({
    required String endpoint,
    required WeatherDataModel Function(dynamic p1) parser,
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
