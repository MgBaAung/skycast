import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skycast/base_architecture/core/api_end_point.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';
import 'package:skycast/base_architecture/domain/usecase/implement/current_weather_usecase.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_event.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_state.dart';
import 'package:skycast/base_architecture/presentation/bloc/base_bloc.dart';
class CurrentWeatherBloc extends BaseBloc<WeatherDataModel> {
  final CurrentWeatherUsecase currentWeatherUsecase;

  CurrentWeatherBloc({required this.currentWeatherUsecase})
    : super(crudUsecase: currentWeatherUsecase) {
    on<FetchFirstCachEvent<WeatherDataModel>>(_fetchCureentWeather);
  }

  void fetchCureentWeather() {
    add(
      FetchFirstCachEvent<WeatherDataModel>(
        endpoint: weatherUrl,
        parser: (json) => WeatherDataModel().fromMap(json),
        isList: false,
      ),
    );
  }

  Future<void> _fetchCureentWeather(
    FetchFirstCachEvent<WeatherDataModel> event,
    Emitter<ApiState> emit,
  ) async {
    WeatherDataModel parser(dynamic json) => WeatherDataModel().fromMap(json);

    final cacheResponse = await currentWeatherUsecase.get(
      endpoint: weatherUrl,
      parser: parser,
      isList: false,
    );

    if (cacheResponse.success && cacheResponse.data != null) {
      emit(ApiSuccess<WeatherDataModel>(cacheResponse.data!));

      final apiResponse = await currentWeatherUsecase.fetchFromApiOnly(
        endpoint: event.endpoint,
        parser: parser,
        isList: false,
      );

      if (apiResponse.success && apiResponse.data != null) {
        emit(ApiSuccess<WeatherDataModel>(apiResponse.data!));
      }
    } else {
      emit(const ApiLoading());

      final apiResponse = await currentWeatherUsecase.fetchFromApiOnly(
        endpoint: event.endpoint,
        parser: parser,
        isList: false,
      );

      if (apiResponse.success && apiResponse.data != null) {
        emit(ApiSuccess<WeatherDataModel>(apiResponse.data!));
      } else {
        emit(
          ApiFailure(
            apiResponse.message ??
                'Failed to load weather data. Cache is empty.',
          ),
        );
      }
    }
  }

}
