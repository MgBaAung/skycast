import 'package:skycast/base_architecture/core/master_object.dart';

// ignore: must_be_immutable
class CityModel extends MasterObject<CityModel> {
  List<Results>? results;
  double? generationtimeMs;

  CityModel({this.results, this.generationtimeMs}) : super(id: 0);

  @override
  CityModel fromMap(dynamicData) {
    results = <Results>[];
    if (dynamicData['results'] != null) {
      dynamicData['results'].forEach((v) {
        results!.add(Results().fromMap(v));
      });
    }
    return CityModel(
      results: results,
      generationtimeMs: dynamicData['generationtime_ms'],
    );
  }

  @override
  List<CityModel> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(CityModel object) {
    return {
      'results': results != null
          ? object.results!.map((v) => v.toMap(v)).toList()
          : null,
      'generationtime_ms': object.generationtimeMs,
    };
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<CityModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [results, generationtimeMs];
}

// ignore: must_be_immutable
class Results extends MasterObject<Results> {
  String? name;
  double? latitude;
  double? longitude;

  String? country;

  Results({int? id, this.name, this.latitude, this.longitude, this.country})
    : super(id: id ?? 0);

  @override
  Results fromMap(dynamicData) {
    return Results(
      id: dynamicData['id'],
      name: dynamicData['name'],
      latitude: dynamicData['latitude'],
      longitude: dynamicData['longitude'],
      country: dynamicData['country'],
    );
  }

  @override
  List<Results> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Results object) {
    return {
      'id': object.id,
      'name': object.name,
      'latitude': object.latitude,
      'longitude': object.longitude,
      'country': object.country,
    };
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Results> objectList) {
    throw UnimplementedError();
  }
}
