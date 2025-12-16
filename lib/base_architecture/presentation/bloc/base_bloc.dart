
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skycast/base_architecture/core/master_object.dart';
import 'package:skycast/base_architecture/domain/usecase/baste_usecase.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_event.dart';
import 'package:skycast/base_architecture/presentation/bloc/api_state.dart';

class BaseBloc<T extends MasterObject<T>> extends Bloc<ApiEvent, ApiState> {
  final CrudUseCase<T> crudUsecase;

  BaseBloc({required this.crudUsecase}) : super(const ApiInitial()) {
    on<FetchDataEvent<List<T>>>(_onFetchAllData,);
    on<FetchDataEvent<T>>(_onFetch);
    on<CreateDataEvent<T, T>>(_onCreate);
    on<UpdateDataEvent<T, T>>(_onUpdate);
    on<DeleteDataEvent>(_onDelete);
    on<RequestEmptyEvent<T, T>>(_onRequestEmptyBody);
  }

  Future<void> _onFetchAllData(
    FetchDataEvent<List<T>> event,
    Emitter<ApiState> emit,
  ) async {
    final List<T> existingData = (state is ApiSuccess<List<T>>)
        ? (state as ApiSuccess<List<T>>).data
        : [];

    if (!event.shouldAppend) {
      emit(const ApiLoading());
    }

    try {
      final response = await crudUsecase.getList<List<T>>(
        endpoint: event.endpoint,
        parser: event.parser,
        queryParams: event.queryParams,
      );

      if (response.success && response.data != null) {
        List<T> newItems = response.data!;
        List<T> finalData = existingData;

        if (event.shouldAppend) {
          if (newItems.isEmpty) {
            emit(ApiSuccessNoMoreData<List<T>>(existingData));
            return;
          }
          finalData = List<T>.from(existingData)..addAll(newItems);
        } else {
          finalData = newItems;
        }
        emit(ApiSuccess<List<T>>(finalData));
      } else {
        emit(
          ApiFailure(
            response.message ?? 'failed to fetch data',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      emit(ApiFailure('Unexpect error: $e'));
    }
  }

  Future<void> _onFetch(FetchDataEvent<T> event, Emitter<ApiState> emit) async {
    emit(const ApiLoading());
    try {
      final response = await crudUsecase.get(
        endpoint: event.endpoint,
        parser: event.parser,
        isList: event.isList,
        queryParams: event.queryParams,
      );

      if (response.success && response.data != null) {
        emit(ApiSuccess<T>(response.data!));
      } else {
        emit(
          ApiFailure(
            response.message ?? 'failed to fetch data',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      emit(ApiFailure('Unexpect error: $e'));
    }
  }

  Future<void> _onCreate(
    CreateDataEvent<T, T> event,
    Emitter<ApiState> emit,
  ) async {
    emit(const ApiLoading());
    try {
      final response = await crudUsecase.create(
        endpoint: event.endpoint,
        data: event.data,
        parser: event.parser,
      );

      if (response.success && response.data != null) {
        emit(ApiSuccess<T>(response.data!));
      } else {
        emit(
          ApiFailure(
            response.message ?? 'failed to fetch data',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      emit(ApiFailure('Unexpected error: $e'));
    }
  }

  Future<void> _onRequestEmptyBody(
    RequestEmptyEvent<T, T> event,
    Emitter<ApiState> emit,
  ) async {
    emit(const ApiLoading());
    try {
      final response = await crudUsecase.postWithoutBody(
        endpoint: event.endpoint,
        data: event.data,
        parser: event.parser,
      );

      if (response.success && response.data != null) {
        emit(ApiSuccess<T>(response.data!));
      } else {
        emit(
          ApiFailure(
            response.message ?? 'failed to fetch data',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      emit(ApiFailure('Unexpected error: $e'));
    }
  }

  Future<void> _onUpdate(
    UpdateDataEvent<T, T> event,
    Emitter<ApiState> emit,
  ) async {
    try {
      final response = await crudUsecase.update(
        endpoint: event.endpoint,
        id: event.id,
        data: event.data,
        parser: event.parser,
      );

      if (response.success && response.data != null) {
        final updatedItem = response.data!;

        List<T> currentList = [];
        if (state is ApiSuccess<List<T>>) {
          currentList = List<T>.from((state as ApiSuccess<List<T>>).data);
        } else if (state is ApiSuccessNoMoreData<List<T>>) {
          currentList = List<T>.from(
            (state as ApiSuccessNoMoreData<List<T>>).data,
          );
        }

        final updatedList = currentList.map((item) {
          return item.id == updatedItem.id ? updatedItem : item;
        }).toList();

        if (currentList.isNotEmpty) {
          emit(ApiSuccess<List<T>>(updatedList));
          return;
        }
      } else {
        emit(
          ApiFailure(
            response.message ?? 'failed to update data',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      emit(ApiFailure('Unexpected error: $e'));
    }
  }

  Future<void> _onDelete(DeleteDataEvent event, Emitter<ApiState> emit) async {
    List<T> currentList = [];
    if (state is ApiSuccess<List<T>>) {
      currentList = List<T>.from((state as ApiSuccess<List<T>>).data);
    } else if (state is ApiSuccessNoMoreData<List<T>>) {
      currentList = List<T>.from((state as ApiSuccessNoMoreData<List<T>>).data);
    }

    try {
      final response = await crudUsecase.delete(event.endpoint, event.id);

      if (response.success) {
        final updatedList = currentList
            .where((item) => item.id != event.id)
            .toList();

        if (state is ApiSuccessNoMoreData<List<T>>) {
          emit(ApiSuccessNoMoreData<List<T>>(updatedList));
        } else {
          emit(ApiSuccess<List<T>>(updatedList));
        }
      } else {
        emit(
          ApiFailure(
            response.message ?? 'Failed to delete by ${event.id}',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      emit(ApiFailure('Unexpected error: $e'));
    }
  }
}
