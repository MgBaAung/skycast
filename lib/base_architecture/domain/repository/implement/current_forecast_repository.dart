import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:skycast/base_architecture/core/api_end_point.dart';
import 'package:skycast/base_architecture/core/api_response.dart';
import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
import 'package:skycast/base_architecture/domain/repository/api_repository.dart';


class CurrentForecastRepository extends ApiRepository<ForecastModel> {
  CurrentForecastRepository({required super.networkClient});

  @override
  Future<ApiResponse<T>> get<T>(
    String endPoint,
    T Function(dynamic p1) parser, {
    Map<String, dynamic>? queryParams,
    bool isList = false,
  }) async {
    try {
      final response = await networkClient.get(
        Uri.parse('$baseUrl$endPoint').replace(queryParameters: queryParams),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decodedJson = json.decode(response.body);

        final T data = await compute(_backgroundParser<T>, {
          'data': decodedJson,
          'parser': parser,
        });

        return ApiResponse<T>(
          success: true,
          data: data,
          statusCode: response.statusCode,
        );
      } else {
        return handleResponse(response, parser);
      }
    } catch (e) {
      return ApiResponse(success: false, message: "Parsing Error: $e");
    }
  }

  T _backgroundParser<T>(Map<String, dynamic> params) {
    final T Function(dynamic) parser = params['parser'];
    final dynamic data = params['data'];
    return parser(data);
  }
}
