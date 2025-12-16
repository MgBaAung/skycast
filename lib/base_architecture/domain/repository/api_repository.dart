import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:skycast/base_architecture/core/api_response.dart';
import 'package:skycast/base_architecture/core/master_object.dart';
import 'package:skycast/base_architecture/data/network_datasource/network_client.dart';
import 'package:skycast/base_architecture/core/api_end_point.dart';

class ApiRepository<T extends MasterObject<T>> {
  final NetworkClient networkClient;

  ApiRepository({required this.networkClient});

  ApiResponse<R> handleResponse<R>(
    http.Response response,
    R Function(dynamic) parser, {
    bool isList = false,
  }) {
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isNotEmpty) {
          final dynamic decodedJson = json.decode(response.body);
          return ApiResponse<R>(
            success: true,
            data: parser(decodedJson),
            statusCode: response.statusCode,
          );
        } else {
          return ApiResponse(
            success: true,
            data: parser({}), 
            statusCode: response.statusCode,
          );
        }
      } else {
        String errorMessage = 'An unknown error occurred';
        try {
          final Map<String, dynamic> errorJson = json.decode(response.body);
          errorMessage =
              errorJson['message'] ??
              errorJson['error'] ??
              errorJson['status_message'] ??
              errorMessage;
        } catch (_) {
          errorMessage = 'Failed with status code: ${response.statusCode}';
        }
        return ApiResponse(
          success: false,
          message: errorMessage,
          statusCode: response.statusCode,
        );
      }
    } on FormatException catch (e) {
      return ApiResponse(
        success: false,
        message: 'Data format error: $e',
        statusCode: response.statusCode,
      );
    } on SocketException {
       return ApiResponse(success: false,message: "No Internet",statusCode: 503);
    }on http.ClientException catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network request failed: ${e.message}',
        statusCode: 503,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'An unexpected parsing error occurred: $e',
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<T>> get<T>(
    String endPoint,
    T Function(dynamic) parser, {
    Map<String, dynamic>? queryParams,
    bool isList = false,
  }) async {
    try {

      return _handleAuthenticatedRequest<T>(
        () async => networkClient.get(
          Uri.parse('$baseUrl$endPoint').replace(queryParameters: queryParams),
        ),
        parser,
      );
    } catch (e) {
      return ApiResponse(success: false, message: "Network error: $e");
    }
  }

  Future<ApiResponse<TResponse>> post<TRequest, TResponse>(
    String endpoint,
    TRequest? data,
    TResponse Function(dynamic) parser,
  ) async {
    try {
      return _handleAuthenticatedRequest<TResponse>(
        () async => networkClient.post(
          Uri.parse('$baseUrl$endpoint'),
          body: json.encode((data as dynamic).toMap(data)),
        ),
        parser,
      );
    } catch (e) {
      return ApiResponse(success: false, message: "Network error: $e");
    }
  }

  Future<ApiResponse<TResponse>> postWithoutBody<TRequest, TResponse>(
    String endpoint,
    TRequest data,
    TResponse Function(dynamic) parser,
  ) async {
    try {
      return _handleAuthenticatedRequest<TResponse>(
        () async => networkClient.post(
          Uri.parse('$baseUrl$endpoint'),
        ),
        parser,
      );
    } catch (e) {
      return ApiResponse(success: false, message: "Network error: $e");
    }
  }

  Future<ApiResponse<TResponse>> put<TRequest, TResponse>(
    String endpoint,
    String id,
    TRequest data,
    TResponse Function(dynamic) parser,
  ) async {
    try {
      return _handleAuthenticatedRequest<TResponse>(
        () async => networkClient.post(
          Uri.parse('$baseUrl/$endpoint/$id'),
          body: json.encode((data as dynamic).toMap(data)),
        ),
        parser,
      );
    } catch (e) {
      return ApiResponse(success: false, message: 'Network error: $e');
    }
  }

  Future<ApiResponse<EmptyResponse>> delete(String endpoint, String id) async {
    try {
      return _handleAuthenticatedRequest<EmptyResponse>(
        () async => networkClient.post(
          Uri.parse('$baseUrl/$endpoint/$id'),
        ),
        (_) => EmptyResponse(),
      );
    } catch (e) {
      return ApiResponse(success: false, message: 'Network error: $e');
    }
  }

  void dispose() {
    networkClient.dispose();
  }

  Future<ApiResponse<TResponse>> _handleAuthenticatedRequest<TResponse>(
    Future<http.Response> Function() requestFunction,
    TResponse Function(dynamic) parser,
  ) async {
    http.Response response = await requestFunction();

    return handleResponse<TResponse>(response, parser);
  }
}

