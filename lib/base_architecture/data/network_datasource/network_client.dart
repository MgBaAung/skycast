import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class NetworkClient {
  Future<http.Response> get(Uri uri, {Map<String, String>? headers});
  Future<http.Response> post(Uri uri,
      {Map<String, String>? headers, Object? body, Encoding? encoding});
  Future<http.Response> put(Uri uri,
      {Map<String, String>? headers, Object? body, Encoding? encoding});
  Future<http.Response> delete(Uri uri,
      {Map<String, String>? headers, Object? body, Encoding? encoding});
  void dispose();
}
