
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skycast/base_architecture/core/api_end_point.dart';
import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:skycast/base_architecture/domain/usecase/implement/forecast_local_usecase.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_event.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_state.dart';
import 'package:skycast/base_architecture/presentation/bloc/base_bloc.dart';

class CurrentForecastBloc extends BaseBloc<ForecastModel> {
  final ForecastLocalUsecase forecastLocalUsecase;
  CurrentForecastBloc({required this.forecastLocalUsecase})
    : super(crudUsecase: forecastLocalUsecase) {
    on<FetchFirstCachEvent<ForecastModel>>(_fetchCureentForecast);
  }

  void fetchCureentForecast(Position position) {
    add(
      FetchFirstCachEvent<ForecastModel>(
        endpoint: forecastUrl,
        parser: (json) => ForecastModel().fromMap(json),
        isList: false,
        queryParams: {
          'lat': position.latitude.toString(),
          'lon': position.longitude.toString(),
        },
      ),
    );
  }

  Future<void> _fetchCureentForecast(
    FetchFirstCachEvent<ForecastModel> event,
    Emitter<ApiState> emit,
  ) async {
    final cacheResponse = await forecastLocalUsecase.get(
      endpoint: event.endpoint,
      parser: (json) => ForecastModel().fromMap(json),
      isList: false,
      queryParams: event.queryParams,
    );

    if (cacheResponse.success && cacheResponse.data != null) {
      emit(ApiSuccess<ForecastModel>(cacheResponse.data!));
      await _fetchFromApi(event.endpoint, emit, queryParams: event.queryParams);
    } else {
      emit(const ApiLoading());
      await _fetchFromApi(event.endpoint, emit, queryParams: event.queryParams);
    }
  }

  Future<void> _fetchFromApi(
    String endpoint,
    Emitter emit, {
    Map<String, dynamic>? queryParams,
  }) async {
    final apiResponse = await forecastLocalUsecase.fetchFromApiOnly(
      endpoint: endpoint,
      parser: (json) => ForecastModel().fromMap(json),
      isList: false,
      queryParams: queryParams,
    );
    if (apiResponse.success && apiResponse.data != null) {
      emit(ApiSuccess<ForecastModel>(apiResponse.data!));
    } else if (state is ApiFailure) {
      emit(ApiFailure(apiResponse.message ?? 'Failed to load weather data.'));
    }
  }
}
