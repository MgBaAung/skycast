import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:skycast/base_architecture/domain/repository/api_repository.dart';

class CityForecastRepository extends ApiRepository<ForecastModel> {
  CityForecastRepository({required super.networkClient});
}
