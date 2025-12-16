import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:skycast/base_architecture/domain/repository/api_repository.dart';

class CurrentForecastRepository extends ApiRepository<ForecastModel> {
  CurrentForecastRepository({required super.networkClient});
}
