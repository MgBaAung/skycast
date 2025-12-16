// current_weather_entity.dart

import 'package:hive/hive.dart';
import 'package:skycast/base_architecture/core/base_entity.dart';
import 'package:skycast/base_architecture/domain/model/wealther_data_model.dart';
part 'current_weather_entity.g.dart';

@HiveType(typeId: 1)
class CurrentWeatherEntity
    extends BaseEntity<WeatherDataModel, CurrentWeatherEntity>
    with HiveObjectMixin {
  @HiveField(0)
  CoordEntity? coord;

  @HiveField(1)
  List<WeatherEntity>? weather;

  @HiveField(2)
  String? base;

  @HiveField(3)
  MainEntity? main;

  @HiveField(4)
  int? visibility;

  @HiveField(5)
  WindEntity? wind;

  @HiveField(6)
  CloudsEntity? clouds;

  @HiveField(7)
  int? dt;

  @HiveField(8)
  SysEntity? sys;

  @HiveField(9)
  int? timezone;

  @HiveField(10)
  int? id; // City ID

  @HiveField(11)
  String? name;

  @HiveField(12)
  int? cod;

  CurrentWeatherEntity({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  @override
  CurrentWeatherEntity fromModel(WeatherDataModel model) {
    List<WeatherEntity>? weather = [];
    if (model.weather != null) {
      for (var data in model.weather!) {
        weather.add(WeatherEntity().fromModel(data));
      }
    }

    return CurrentWeatherEntity(
      id: model.id,
      cod: model.cod,
      weather: weather,
      base: model.base,
      main: MainEntity().fromModel(model.main!),
      visibility: model.visibility,
      wind: WindEntity().fromModel(model.wind!),
      dt: model.dt,
      sys: SysEntity().fromModel(model.sys!),
      timezone: model.timezone,
      name: model.name,
      coord: CoordEntity().fromModel(model.coord!),
      clouds: CloudsEntity().fromModel(model.clouds!),
    );
  }

  @override
  WeatherDataModel toModel() {
    List<Weather>? weathers = [];
    if (weather != null) {
      for (var data in weather!) {
        weathers.add(data.toModel());
      }
    }
    return WeatherDataModel(
      id: id,
      cod: cod,
      weather: weathers,
      base: base,
      main: main?.toModel(),
      visibility: visibility,
      wind: wind?.toModel(),
      dt: dt,
      sys: sys?.toModel(),
      timezone: timezone,
      name: name,
      coord: coord?.toModel(),
    );
  }

  static void register() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CurrentWeatherEntityAdapter());
    }

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(CoordEntityAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(WeatherEntityAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(MainEntityAdapter());
    }
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(WindEntityAdapter());
    }
    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(CloudsEntityAdapter());
    }
    if (!Hive.isAdapterRegistered(7)) {
      Hive.registerAdapter(SysEntityAdapter());
    }
  }
}

@HiveType(typeId: 2)
class CoordEntity extends BaseEntity<Coord, CoordEntity> {
  @HiveField(0)
  double? lon;

  @HiveField(1)
  double? lat;

  CoordEntity({this.lon, this.lat});

  factory CoordEntity.fromJson(Map<String, dynamic> json) {
    return CoordEntity(
      lon: (json['lon'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'lon': lon, 'lat': lat};
  }

  @override
  CoordEntity fromModel(Coord model) {
    return CoordEntity(lat: model.lat, lon: model.lon);
  }

  @override
  Coord toModel() {
    return Coord(lat: lat, lon: lon);
  }
}

@HiveType(typeId: 3)
class WeatherEntity extends BaseEntity<Weather, WeatherEntity>
    with HiveObjectMixin {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? main;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? icon;

  WeatherEntity({this.id, this.main, this.description, this.icon});

  @override
  WeatherEntity fromModel(Weather model) {
    return WeatherEntity(
      icon: model.icon,
      main: model.main,
      description: model.description,
      id: model.id,
    );
  }

  @override
  Weather toModel() {
    return Weather(id: id, main: main, description: description, icon: icon);
  }
}

@HiveType(typeId: 4)
class MainEntity extends BaseEntity<Main, MainEntity> with HiveObjectMixin {
  @HiveField(0)
  double? temp;

  @HiveField(1)
  double? feelsLike;

  @HiveField(2)
  double? tempMin;

  @HiveField(3)
  double? tempMax;

  @HiveField(4)
  int? pressure;

  @HiveField(5)
  int? humidity;

  @HiveField(6)
  int? seaLevel;

  @HiveField(7)
  int? grndLevel;

  MainEntity({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  @override
  MainEntity fromModel(Main model) {
    return MainEntity(
      temp: model.temp,
      feelsLike: model.feelsLike,
      tempMax: model.tempMax,
      tempMin: model.tempMin,
      pressure: model.pressure,
      humidity: model.humidity,
      seaLevel: model.seaLevel,
      grndLevel: model.grndLevel,
    );
  }

  @override
  Main toModel() {
    return Main(
      temp: temp,
      feelsLike: feelsLike,
      tempMax: tempMax,
      tempMin: tempMin,
      pressure: pressure,
      humidity: humidity,
      seaLevel: seaLevel,
      grndLevel: grndLevel,
    );
  }
}

@HiveType(typeId: 5)
class WindEntity extends BaseEntity<Wind, WindEntity> with HiveObjectMixin {
  @HiveField(0)
  double? speed;

  @HiveField(1)
  int? deg;

  @HiveField(2)
  double? gust;

  WindEntity({this.speed, this.deg, this.gust});

  @override
  WindEntity fromModel(Wind model) {
    return WindEntity(speed: model.speed, deg: model.deg, gust: model.gust);
  }

  @override
  Wind toModel() {
    return Wind(speed: speed, deg: deg, gust: gust);
  }
}

@HiveType(typeId: 6)
class CloudsEntity extends BaseEntity<Clouds, CloudsEntity>
    with HiveObjectMixin {
  @HiveField(0)
  int? all;

  CloudsEntity({this.all});

  @override
  CloudsEntity fromModel(Clouds model) {
    return CloudsEntity(all: model.all);
  }

  @override
  Clouds toModel() {
    return Clouds(all: all);
  }
}

@HiveType(typeId: 7)
class SysEntity extends BaseEntity<Sys, SysEntity> with HiveObjectMixin {
  @HiveField(0)
  int? type;

  @HiveField(1)
  String? country;

  @HiveField(2)
  int? sunrise;

  @HiveField(3)
  int? sunset;

  @HiveField(4)
  int? id;

  SysEntity({this.type, this.id, this.country, this.sunrise, this.sunset});

  @override
  SysEntity fromModel(Sys model) {
    return SysEntity(
      type: model.type,
      country: model.country,
      sunrise: model.sunrise,
      sunset: model.sunset,
      id: model.id,
    );
  }

  @override
  Sys toModel() {
    return Sys(
      type: type,
      country: country,
      sunrise: sunrise,
      sunset: sunset,
      id: id,
    );
  }
}
