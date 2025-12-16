import 'package:equatable/equatable.dart';

abstract class MasterObject<T> extends Equatable {
  final int id;

  const MasterObject({required this.id});

  T fromMap(dynamic dynamicData);

  Map<String, dynamic>? toMap(T object);

  List<T> fromMapList(List<dynamic> dynamicDataList);

  List<Map<String, dynamic>?> toMapList(List<T> objectList);

  @override
  List<Object?> get props => [id];
}
