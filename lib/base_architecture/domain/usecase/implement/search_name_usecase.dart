import 'package:skycast/base_architecture/domain/model/city_model.dart';
import 'package:skycast/base_architecture/domain/repository/implement/search_name_repository.dart';
import 'package:skycast/base_architecture/domain/usecase/baste_usecase.dart';

class SearchNameUsecase extends CrudUseCase<CityModel> {
  final SearchNameRepository searchNameRepository;
  SearchNameUsecase({required this.searchNameRepository}):super(repository: searchNameRepository);
}
