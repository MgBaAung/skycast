import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';
import 'package:skycast/base_architecture/app_setting/key_util.dart';
import 'package:skycast/base_architecture/app_setting/navigation_service.dart';
import 'package:skycast/base_architecture/core/api_end_point.dart';
import 'package:skycast/base_architecture/data/local_datasource/token_manager.dart';

class AuthHeaderInterceptor implements InterceptorContract {
  AuthHeaderInterceptor();

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
    BuildContext? context =
        NavigationService.instance.navigationKey.currentContext;
    TokenManager? tokenManager;
    log("url : ${request.url.toString()}");

    if (context != null) {
      tokenManager = context.read<TokenManager>();
    }

    String? token = await tokenManager?.getToken(kAccess);
    request.headers['content-type'] = 'application/json';

    String fullUrlString = request.url.toString();
    if (fullUrlString.contains('https://geocoding-api.open-meteo.com')) {
      fullUrlString = fullUrlString.replaceFirst(
        'https://api.openweathermap.org/data/2.5',
        '',
      );
    }

    Uri currentUri = Uri.parse(fullUrlString);
    bool isGeocoding = fullUrlString.contains('open-meteo.com');

    final Map<String, String> currentQueryParams = Map.from(
      currentUri.queryParameters,
    );

    if (!isGeocoding) {
      currentQueryParams['appid'] = apiKey;
    }

    final Uri finalUri = currentUri.replace(
      queryParameters: currentQueryParams,
    );

    String urlPath = finalUri.path;
    bool isAuthRoute =
        urlPath.contains(loginUrl) || urlPath.contains(refreshUrl);

    if (token != null && token.isNotEmpty && !isAuthRoute && !isGeocoding) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    if (request is Request) {
      return Request(request.method, finalUri)
        ..headers.addAll(request.headers)
        ..bodyBytes = request.bodyBytes;
    } else if (request is StreamedRequest) {
      return StreamedRequest(request.method, finalUri)
        ..headers.addAll(request.headers);
    }

    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) =>
      response;

  @override
  FutureOr<bool> shouldInterceptRequest() => true;

  @override
  FutureOr<bool> shouldInterceptResponse() => true;
}
