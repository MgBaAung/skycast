import 'dart:async';
import 'dart:developer';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;

class LoggingInterceptor implements InterceptorContract {
  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) {
    log('---  HTTP Request ---', name: 'REQUEST');
    log('Method: ${request.method}', name: 'REQUEST');
    log('URI: ${request.url}', name: 'REQUEST');
    log('Headers: ${request.headers}', name: 'REQUEST');
    final authHeader = request.headers['Authorization'];
    print("token : ${authHeader}");

    if (request is http.Request) {
      if (request.body.isNotEmpty) {
        log('Body: ${request.body}', name: 'REQUEST BODY');
      }
    }
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    log('---  HTTP Response ---', name: 'RESPONSE');
    log('URI: ${response.request?.url}', name: 'RESPONSE');
    log('Status: ${response.statusCode}', name: 'RESPONSE');

    if (response is http.Response) {
      if (response.body.isNotEmpty) {
        if (response.statusCode >= 400) {
          log(' ERROR BODY: ${response.body}', name: 'RESPONSE ERROR');
        } else {
          log('data: ${response.body}');
        }
      }
    }
    return response;
  }

  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }

  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }
}
