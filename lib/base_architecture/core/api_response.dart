import 'package:equatable/equatable.dart';

class ApiResponse<T> extends Equatable {
  final bool success;
  final String? message;
  final int? statusCode;
  final T? data;

  const ApiResponse(
      {required this.success, this.message, this.statusCode, this.data});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse<T>(
      success: json['success'] as bool,
      message: json['message'] as String?,
      statusCode: json['statusCode']
          as int?, 
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  factory ApiResponse.fromListJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonItemT) {
    return ApiResponse<T>(
      success: json['success'] as bool,
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int?,
      data: json['data'] != null
          ? (json['data'] as List).map((e) => fromJsonItemT(e)).toList()
              as T 
          : null,
    );
  }

  @override
  List<Object?> get props => [success, message, statusCode, data];
}

class EmptyResponse extends Equatable {
  @override
  List<Object?> get props => [];
}