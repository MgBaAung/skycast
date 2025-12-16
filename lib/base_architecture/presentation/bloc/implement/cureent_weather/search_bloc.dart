import 'package:skycast/base_architecture/core/api_end_point.dart';
import 'package:skycast/base_architecture/domain/model/city_model.dart';
import 'package:skycast/base_architecture/domain/usecase/implement/search_name_usecase.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_event.dart';
import 'package:skycast/base_architecture/presentation/bloc/base_bloc.dart';

class SearchBloc extends BaseBloc<CityModel> {
  final SearchNameUsecase searchNameUsecase;
  SearchBloc({required this.searchNameUsecase})
    : super(crudUsecase: searchNameUsecase);

  void search(String typing) {
    add(
      FetchDataEvent<CityModel>(
        endpoint: searchCityNameUrl,
        queryParams: {'name': typing},
        parser: (json) => CityModel().fromMap(json),
        isList: false,
      ),
    );
  }
}
