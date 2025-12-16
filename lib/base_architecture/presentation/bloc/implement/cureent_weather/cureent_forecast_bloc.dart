import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skycast/base_architecture/core/api_end_point.dart';
import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:skycast/base_architecture/domain/usecase/implement/forecast_local_usecase.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_event.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_state.dart';
import 'package:skycast/base_architecture/presentation/bloc/base_bloc.dart';

ForecastModel _parseForecast(dynamic json) => ForecastModel().fromMap(json);

class CurrentForecastBloc extends BaseBloc<ForecastModel> {
  final ForecastLocalUsecase forecastLocalUsecase;
  CurrentForecastBloc({required this.forecastLocalUsecase})
    : super(crudUsecase: forecastLocalUsecase) {
    on<FetchFirstCachEvent<ForecastModel>>(
      _fetchCureentForecast,
      transformer: droppable(),
    );
  }

  void fetchCureentForecast() {
    add(
      FetchFirstCachEvent<ForecastModel>(
        endpoint: forecastUrl,
        parser: (json) => ForecastModel().fromMap(json),
        isList: false,
      ),
    );
  }

  Future<void> _fetchCureentForecast(
    FetchFirstCachEvent<ForecastModel> event,
    Emitter<ApiState> emit,
  ) async {
    final parser = _parseForecast;

    final cacheResponse = await forecastLocalUsecase.get(
      endpoint: event.endpoint,
      parser: parser,
      isList: false,
    );

    if (cacheResponse.success && cacheResponse.data != null) {
      log("Found in cache");
      emit(ApiSuccess<ForecastModel>(cacheResponse.data!));
      await _fetchFromApi(event.endpoint, parser, emit);
    } else {
      emit(const ApiLoading());
      await _fetchFromApi(event.endpoint, parser, emit);
    }
  }

  Future<void> _fetchFromApi(
    String endpoint,
    Function parser,
    Emitter emit,
  ) async {
    final apiResponse = await forecastLocalUsecase.fetchFromApiOnly(
      endpoint: endpoint,
      parser: _parseForecast,
      isList: false,
    );

    if (apiResponse.success && apiResponse.data != null) {
      emit(ApiSuccess<ForecastModel>(apiResponse.data!));
    } else if (state is! ApiSuccess) {
      emit(ApiFailure(apiResponse.message ?? 'Failed to load weather data.'));
    }
  }
}
