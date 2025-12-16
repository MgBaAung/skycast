import 'package:skycast/base_architecture/core/api_response.dart';
import 'package:skycast/base_architecture/core/master_object.dart';
import 'package:skycast/base_architecture/domain/repository/api_repository.dart';

class CrudUseCase<T extends MasterObject<T>> {
  final ApiRepository<T> repository;

  CrudUseCase({required this.repository});

  Future<ApiResponse<T>> getList<T>({
    required String endpoint,
    required T Function(dynamic) parser,
    Map<String, dynamic>? queryParams,
    bool isList = false,
  }) {
    return repository.get(
      endpoint,
      parser,
      isList: isList,
      queryParams: queryParams,
    );
  }

  Future<ApiResponse<T>> get({
    required String endpoint,
    required T Function(dynamic) parser,
    required bool isList,
    Map<String, dynamic>? queryParams,
  }) {
    return repository.get<T>(
      endpoint,
      parser,
      isList: isList,
      queryParams: queryParams,
    );
  }

  Future<ApiResponse<T>> create({
    required String endpoint,
    required T? data,
    required T Function(dynamic) parser,
  }) {
    return repository.post<T, T>(endpoint, data, parser);
  }

  Future<ApiResponse<T>> postWithoutBody({
    required String endpoint,
    required T data,
    required T Function(dynamic) parser,
  }) {
    return repository.postWithoutBody<T, T>(endpoint, data, parser);
  }

  Future<ApiResponse<T>> update({
    required String endpoint,
    required String id,
    required T data,
    required T Function(dynamic) parser,
  }) {
    return repository.put<T, T>(endpoint, id, data, parser);
  }

  Future<ApiResponse<void>> delete(String endpoint, String id) {
    return repository.delete(endpoint, id);
  }
}
