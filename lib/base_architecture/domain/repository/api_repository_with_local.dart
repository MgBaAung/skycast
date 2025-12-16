import 'package:skycast/base_architecture/core/api_response.dart';
import 'package:skycast/base_architecture/core/base_entity.dart';
import 'package:skycast/base_architecture/core/master_object.dart';
import 'package:skycast/base_architecture/data/local_datasource/local_datasource.dart';
import 'package:skycast/base_architecture/domain/repository/api_repository.dart';

class ApiRepositoryWithLocalStorage<
  T extends MasterObject<T>,
  E extends BaseEntity<T, E>
>
    extends ApiRepository<T> {
  final LocalDataSource<T, E> localDataSource;

  ApiRepositoryWithLocalStorage({
    required super.networkClient,
    required this.localDataSource,
  });

  @override
  Future<ApiResponse<T>> get<T>(
    String endPoint,
    T Function(dynamic p1) parser, {
    Map<String, dynamic>? queryParams,
    bool isList = false,
  }) async {
    final List<T> cachedData = await localDataSource.getAll() as List<T>;

    if (cachedData.isNotEmpty) {
      if (!isList) {
        return ApiResponse(success: true, data: cachedData.first);
      }
      return ApiResponse(success: true, data: cachedData as T);
    }
    try {
      final apiResponse = await super.get(
        endPoint,
        parser,
        queryParams: queryParams,
        isList: isList,
      );

      if (apiResponse.success && apiResponse.data != null) {
        localDataSource.clear();
        if (isList) {
          final dataList = apiResponse.data as List;
          for (var data in dataList) {
            await localDataSource.save(data);
          }
        } else {
          await localDataSource.save(apiResponse.data! as dynamic);
        }
      }

      return apiResponse;
    } catch (e) {

      return ApiResponse(
        success: false,
        message: 'Network error: $e. Cache is empty.',
      );
    }
  }

  @override
  Future<ApiResponse<TResponse>> post<TRequest, TResponse>(
    String endpoint,
    TRequest? data,
    TResponse Function(dynamic p1) parser,
  ) async {
    final entity = data as T;

    try {
      final apiResponse = await super.post(endpoint, data, parser);
      if (apiResponse.success && apiResponse.data != null) {
        await localDataSource.save(entity);
        return apiResponse;
      } else {
        try {
          await localDataSource.save(entity);
          return ApiResponse(success: true, data: entity as TResponse);
        } catch (e) {
          return ApiResponse(
            success: false,
            message: 'API failed and cache adding failed',
          );
        }
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'API failed and cache adding failed',
      );
    }
  }

  @override
  Future<ApiResponse<TResponse>> put<TRequest, TResponse>(
    String endpoint,
    String id,
    TRequest data,
    TResponse Function(dynamic p1) parser,
  ) async {
    final entity = data as T;

    try {
      final apiResponse = await super.put(endpoint, id, data, parser);
      if (apiResponse.success && apiResponse.data != null) {
        await localDataSource.save(entity);
        return apiResponse;
      } else {
        await localDataSource.save(entity);
        return ApiResponse(success: true, data: entity as TResponse);
      }
    } catch (e) {
      try {
        await localDataSource.save(entity);
        return ApiResponse(success: true, data: entity as TResponse);
      } catch (cacheError) {
        return ApiResponse(
          success: false,
          message:
              'API failed and cache update failed. Error: $e, Cache error: $cacheError',
        );
      }
    }
  }

  @override
  Future<ApiResponse<EmptyResponse>> delete(String endpoint, String id) async {
    try {
      await localDataSource.delete(id);
      final apiResponse = await super.delete(endpoint, id);
      if (apiResponse.success && apiResponse.data != null) {
        await localDataSource.delete(id);
        return apiResponse;
      } else {
        await localDataSource.delete(id);
        return ApiResponse(success: true, message: "delete sucessfully");
      }
    } catch (e) {
      try {
        await localDataSource.delete(id);
        return ApiResponse(success: true);
      } catch (cacheError) {
        return ApiResponse(
          success: false,
          message:
              'API failed and cache delete failed. Error: $e, Cache error: $cacheError',
        );
      }
    }
  }
}
