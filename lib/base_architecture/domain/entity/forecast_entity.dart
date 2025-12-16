import 'package:hive_flutter/hive_flutter.dart';
import 'package:skycast/base_architecture/core/base_entity.dart';
import 'package:skycast/base_architecture/domain/entity/current_weather_entity.dart';
import 'package:skycast/base_architecture/domain/model/forecast_model.dart';
part 'forecast_entity.g.dart';

@HiveType(typeId: 9)
class ForecastEntity extends BaseEntity<ForecastModel, ForecastEntity>
    with HiveObjectMixin {
  @HiveField(0)
  List<ForecastListItemEntity>? list;

  @HiveField(1)
  CityEntity? city;

  ForecastEntity({this.list, this.city});

  @override
  ForecastEntity fromModel(ForecastModel model) {
    return ForecastEntity(
      list: model.list
          ?.map((item) => ForecastListItemEntity().fromModel(item))
          .toList(),
      city: model.city != null ? CityEntity().fromModel(model.city!) : null,
    );
  }

  @override
  ForecastModel toModel() {
    return ForecastModel(
      list: list?.map((entity) => entity.toModel()).toList(),
      city: city?.toModel(),
    );
  }

  static void register() {
    if (!Hive.isAdapterRegistered(9)) {
      Hive.registerAdapter(ForecastEntityAdapter());
      Hive.registerAdapter(ForecastListItemEntityAdapter());
      Hive.registerAdapter(CityEntityAdapter());
    }
  }
}

@HiveType(typeId: 8)
class ForecastListItemEntity extends BaseEntity<Lists, ForecastListItemEntity>
    with HiveObjectMixin {
  @HiveField(0)
  int? dt;
  @HiveField(1)
  MainEntity? main;
  @HiveField(2)
  List<WeatherEntity>? weather;
  @HiveField(3)
  CloudsEntity? clouds;
  @HiveField(4)
  WindEntity? wind;
  @HiveField(5)
  int? visibility;
  @HiveField(6)
  int? pop;
  @HiveField(7)
  SysEntity? sys;
  @HiveField(8)
  String? dtTxt;

  ForecastListItemEntity({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
  });

  @override
  ForecastListItemEntity fromModel(Lists model) {
    return ForecastListItemEntity(
      dt: model.dt,
      main: model.main != null ? MainEntity().fromModel(model.main!) : null,
      weather: model.weather?.map((w) => WeatherEntity().fromModel(w)).toList(),
      clouds: model.clouds != null
          ? CloudsEntity().fromModel(model.clouds!)
          : null,
      wind: model.wind != null ? WindEntity().fromModel(model.wind!) : null,
      visibility: model.visibility,
      pop: model.pop,
      sys: model.sys != null ? SysEntity().fromModel(model.sys!) : null,
      dtTxt: model.dtTxt,
    );
  }

  @override
  Lists toModel() {
    return Lists(
      dt: dt,
      main: main?.toModel(),
      weather: weather?.map((e) => e.toModel()).toList(),
      clouds: clouds?.toModel(),
      wind: wind?.toModel(),
      visibility: visibility,
      pop: pop,
      sys: sys?.toModel(),
      dtTxt: dtTxt,
    );
  }

  static void register() {
    if (!Hive.isAdapterRegistered(8)) {}
  }
}

@HiveType(typeId: 12)
class CityEntity extends BaseEntity<City, CityEntity> with HiveObjectMixin {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  CoordEntity? coord;

  @HiveField(3)
  String? country;

  @HiveField(4)
  int? population;

  @HiveField(5)
  int? timezone;

  @HiveField(6)
  int? sunrise;

  @HiveField(7)
  int? sunset;

  CityEntity({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  @override
  CityEntity fromModel(City model) {
    return CityEntity(
      id: model.id,
      name: model.name,
      coord: model.coord != null ? CoordEntity().fromModel(model.coord!) : null,
      country: model.country,
      population: model.population,
      timezone: model.timezone,
      sunrise: model.sunrise,
      sunset: model.sunset,
    );
  }

  @override
  City toModel() {
    return City(
      id: id,
      name: name,
      coord: coord?.toModel(),
      country: country,
      population: population,
      timezone: timezone,
      sunrise: sunrise,
      sunset: sunset,
    );
  }
}
