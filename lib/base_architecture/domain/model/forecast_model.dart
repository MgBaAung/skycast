import 'package:skycast/base_architecture/core/master_object.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';

// ignore: must_be_immutable
class ForecastModel extends MasterObject<ForecastModel> {
  String? cod;
  int? message;
  int? cnt;
  List<Lists>? list;
  City? city;

  ForecastModel({this.cod, this.message, this.cnt, this.list, this.city})
    : super(id: 0);

  @override
  ForecastModel fromMap(dynamicData) {
    list = <Lists>[];
    if (dynamicData['list'] != null) {
      dynamicData['list'].forEach((v) {
        list!.add(Lists().fromMap(v));
      });
    }

    final City? cityData = dynamicData['city'] != null
        ? City().fromMap(dynamicData['city'])
        : null;

    return ForecastModel(
      cod: dynamicData['cod'],
      message: dynamicData['message'],
      cnt: dynamicData['cnt'],
      city: cityData,
      list: list,
    );
  }

  @override
  List<ForecastModel> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(ForecastModel object) {
    return {
      'cod': object.cod,
      'message': object.message,
      'cnt': object.cnt,
      'list': object.list!.map((v) => v.toMap(v)).toList(),
      'city': City().toMap(object.city!),
    };
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ForecastModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [cod, message, cnt, list, city];
}

// ignore: must_be_immutable
class Lists extends MasterObject<Lists> {
  int? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  int? pop;
  Sys? sys;
  String? dtTxt;

  Lists({
    int? id,
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
  }) : super(id: id ?? 0);

  @override
  Lists fromMap(dynamicData) {
    weather = <Weather>[];

    if (dynamicData['weather'] != null) {
      dynamicData['weather'].forEach((v) {
        weather!.add(Weather().fromMap(v));
      });
    }
    return Lists(
      id: dynamicData['dt'],
      dt: dynamicData['dt'],
      main: dynamicData['main'] != null
          ? Main().fromMap(dynamicData['main'])
          : null,
      weather: weather,

      clouds: dynamicData['clouds'] != null
          ? Clouds().fromMap(dynamicData['clouds'])
          : null,
      wind: dynamicData['wind'] != null
          ? Wind().fromMap(dynamicData['wind'])
          : null,
      visibility: dynamicData['visibility'],
      pop: dynamicData['pop'],
      sys: dynamicData['sys'] != null
          ? Sys().fromMap(dynamicData['sys'])
          : null,
      dtTxt: dynamicData['dt_txt'],
    );
  }

  @override
  List<Lists> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Lists object) {
    return {
      'dt': object.dt,
      'main': Main().toMap(object.main!),
      'weather': object.weather!.map((v) => v.toMap(v)).toList(),
      'clouds': Clouds().toMap(object.clouds!),
      'wind': Wind().toMap(object.wind!),
      'visibility': object.visibility,
      'pop': object.pop,
      'sys': Sys().toMap(object.sys!),
      'dt_txt': object.dtTxt,
    };
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Lists> objectList) {
    throw UnimplementedError();
  }
}

// ignore: must_be_immutable
class City extends MasterObject<City> {
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City({
    int? id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  }) : super(id: id ?? 0);

  @override
  City fromMap(dynamicData) {
    return City(
      id: dynamicData['id'],
      name: dynamicData['name'],
      coord: dynamicData['coord'] != null
          ? Coord().fromMap(dynamicData['coord'])
          : null,
      country: dynamicData['country'],
      population: dynamicData['population'],
      timezone: dynamicData['timezone'],
      sunrise: dynamicData['sunrise'],
      sunset: dynamicData['sunset'],
    );
  }

  @override
  List<City> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(City object) {
    return {
      'id': object.id,
      'name': object.name,
      'coord': object.coord?.toMap(object.coord!),
      'country': object.country,
      'population': object.population,
      'timezone': object.timezone,
      'sunrise': object.sunrise,
      'sunset': object.sunset,
    };
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<City> objectList) {
    throw UnimplementedError();
  }
}
