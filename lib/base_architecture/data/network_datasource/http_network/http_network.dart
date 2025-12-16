
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:skycast/base_architecture/data/network_datasource/http_network/auth_header_interceptor.dart';
import 'package:skycast/base_architecture/data/network_datasource/http_network/auth_retry_policy.dart';
import 'package:skycast/base_architecture/data/network_datasource/http_network/cache_interceptor.dart';
import 'package:skycast/base_architecture/data/network_datasource/http_network/connectivity_interceptor.dart';
import 'package:skycast/base_architecture/data/network_datasource/http_network/logging_interceptor.dart';
import 'package:skycast/base_architecture/data/network_datasource/network_client.dart';


class HttpNetworkClient implements NetworkClient {
  
  late final http.Client _httpClient;

  HttpNetworkClient(
  ) {
    _httpClient = InterceptedClient.build(
      interceptors: [
         AuthHeaderInterceptor(),
         LoggingInterceptor(), 
         CachingInterceptor(),
         ConnectivityInterceptor()
      ],
      retryPolicy: AuthRetryPolicy(),
      client: http.Client(),
    );
  }


  @override
  Future<http.Response> delete(Uri uri,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return _httpClient.delete(uri,
        headers: headers, body: body, encoding: encoding);
  }

  @override
  void dispose() {
    _httpClient.close();
  }

  @override
  Future<http.Response> get(Uri uri, {Map<String, String>? headers}) {
    return _httpClient.get(uri, headers: headers); 
  }

  @override
  Future<http.Response> post(Uri uri,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return _httpClient.post(uri,
        headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<http.Response> put(Uri uri,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return _httpClient.put(uri,
        headers: headers, body: body, encoding: encoding);
  }
}