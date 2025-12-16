
import 'package:skycast/base_architecture/domain/model/city_model.dart';
import 'package:skycast/base_architecture/domain/repository/api_repository.dart';

class SearchNameRepository extends ApiRepository<CityModel>{
  SearchNameRepository({required super.networkClient});
}