import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skycast/base_architecture/app_setting/custom_error_widget.dart';
import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_state.dart';
import 'package:skycast/base_architecture/presentation/bloc/implement/city_weather/city_forecast_bloc.dart';
import 'package:skycast/base_architecture/presentation/pages/common_widget/forecast_item.dart';

class CityForecastWidget extends StatefulWidget {
  const CityForecastWidget({super.key});

  @override
  State<CityForecastWidget> createState() => _CityForecastWidgetState();
}

class _CityForecastWidgetState extends State<CityForecastWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityForecastBloc, ApiState>(
      buildWhen: (previous, current) {
        return current is ApiSuccess<ForecastModel> ||
            current is ApiLoading ||
            current is ApiFailure;
      },
      builder: (context, state) {
        if (state is ApiSuccess<ForecastModel>) {
          return DailyWeatherChart(fullList: state.data.list!);
        }

        if (state is ApiFailure) {
          return ApiErrorWidget(
            onRetry: () {
              context.read<CityForecastBloc>().getWeather();
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
