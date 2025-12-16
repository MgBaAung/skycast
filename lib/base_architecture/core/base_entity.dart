
import 'package:skycast/base_architecture/core/master_object.dart';

abstract class BaseEntity<T extends MasterObject, E extends BaseEntity<T, E>> {
  T toModel();
  E fromModel(T model);
}
