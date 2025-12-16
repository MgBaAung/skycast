
import 'package:skycast/base_architecture/core/master_object.dart';

class LoginModel extends MasterObject<LoginModel>{
  const LoginModel({required super.id});

  @override
  LoginModel fromMap(dynamicData) {
    throw UnimplementedError();
  }

  @override
  List<LoginModel> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(LoginModel object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<LoginModel> objectList) {
    throw UnimplementedError();
  }
}