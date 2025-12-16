import 'package:skycast/base_architecture/core/base_entity.dart';
import 'package:skycast/base_architecture/core/master_object.dart';

abstract class LocalDataSource<
  T extends MasterObject,
  E extends BaseEntity<T, E>
> {
  Future<List<T>> getAll();
  Future<T?> getById(String id);
  Future<void> save(T model);
  Future<void> delete(String id);
  Future<void> clear(); // Added for completeness
}
