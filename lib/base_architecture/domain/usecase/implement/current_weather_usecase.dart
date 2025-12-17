import 'package:skycast/base_architecture/core/api_response.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';
import 'package:skycast/base_architecture/domain/repository/implement/current_location_repository.dart';
import 'package:skycast/base_architecture/domain/usecase/baste_usecase.dart';

class CurrentWeatherUsecase extends CrudUseCase<WeatherDataModel> {
  final CurrentLocationRepository currentLocationRepository;
  CurrentWeatherUsecase({
    required super.repository,
    required this.currentLocationRepository,
  });

  // fetch only api
  Future<ApiResponse<WeatherDataModel>> fetchFromApiOnly<T>({
    required String endpoint,
    required WeatherDataModel Function(dynamic p1) parser,
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
