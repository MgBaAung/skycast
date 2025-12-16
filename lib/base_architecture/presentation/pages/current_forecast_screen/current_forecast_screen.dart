import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skycast/base_architecture/app_setting/custom_error_widget.dart';
import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_state.dart';
import 'package:skycast/base_architecture/presentation/bloc/implement/cureent_weather/cureent_forecast_bloc.dart';
import 'package:skycast/base_architecture/presentation/pages/common_widget/forecast_item.dart';

class CurrentForecastScreen extends StatefulWidget {
  const CurrentForecastScreen({super.key});

  @override
  State<CurrentForecastScreen> createState() => _CurrentForecastScreenState();
}

class _CurrentForecastScreenState extends State<CurrentForecastScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentForecastBloc, ApiState>(
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
          return ApiErrorWidget(onRetry: () {});
        }
        return SizedBox.shrink();
      },
    );
  }
}
