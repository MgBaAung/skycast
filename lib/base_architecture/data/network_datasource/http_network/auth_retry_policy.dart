import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:skycast/base_architecture/app_setting/key_util.dart';
import 'package:skycast/base_architecture/app_setting/navigation_service.dart';
import 'package:skycast/base_architecture/core/api_end_point.dart';
import 'package:skycast/base_architecture/data/local_datasource/token_manager.dart';
import 'package:http/http.dart' as http;

class AuthRetryPolicy extends RetryPolicy {
  AuthRetryPolicy() : super();
  final http.Client _httpClient = http.Client();

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if (response.statusCode == 401 || response.statusCode == 403) {
      BuildContext? context =
          NavigationService.instance.navigationKey.currentContext;
      TokenManager? tokenManager;
      if (context != null) {
        tokenManager = context.read<TokenManager>();
      }

      try {

        final url = Uri.parse(refreshUrl);
        final access = await tokenManager?.getToken(kAccess);
        final refresh = await tokenManager?.getToken(kRefresh);
        final response = await _httpClient.post(
          headers: {'content-type':'application/json'},
          url,
          body: jsonEncode({"accessToken": access, "refreshToken": refresh}),
        );
        if (response.statusCode == 200) {
        // final jsonResponse = jsonDecode(response.body);
        //  final newTokens = LoginModel().fromMap(jsonResponse);
        //   if (newTokens.accesstoken != null && newTokens.refreshToken != null) {
        //     tokenManager?.saveToken(kAccess, newTokens.accesstoken!);
        //     tokenManager?.saveToken(kRefresh, newTokens.refreshToken!);
        //     return true;
        //   }
        }
        return false;
      } catch (e) {

        return false;
      }
    }
    return super.shouldAttemptRetryOnResponse(response);
  }
}
