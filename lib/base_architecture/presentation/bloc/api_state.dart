import 'package:equatable/equatable.dart';

abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object?> get props => [];
}

class ApiInitial extends ApiState {
  const ApiInitial();
}

class ApiLoading extends ApiState {
  const ApiLoading();
}

class ApiSuccess<T> extends ApiState {
  final T data;

  const ApiSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class ApiFailure extends ApiState {
  final String message;
  final int? statusCode;

  const ApiFailure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class ApiOperationSuccess extends ApiState {
  final String message;
  const ApiOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ApiSuccessNoMoreData<T> extends ApiState {
  final T data;

  const ApiSuccessNoMoreData(this.data);

  @override
  List<Object?> get props => [data];
}
