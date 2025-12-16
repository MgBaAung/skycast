import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:skycast/base_architecture/domain/usecase/baste_usecase.dart';

class CityForecastUsecase extends CrudUseCase<ForecastModel> {
  CityForecastUsecase({required super.repository});
}
