import 'package:skycast/base_architecture/core/master_object.dart';

// ignore: must_be_immutable
class WeatherDataModel extends MasterObject<WeatherDataModel> {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  String? name;
  int? cod;

  WeatherDataModel({
    int? id,
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
    this.name,
    this.cod,
  }) : super(id: id ?? 0);

  @override
  WeatherDataModel fromMap(dynamicData) {
    Coord? coord = dynamicData['coord'] != null
        ? Coord().fromMap(dynamicData['coord'])
        : null;
    List<Weather> weather = [];
    Main? main = dynamicData['main'] != null
        ? Main().fromMap(dynamicData['main'])
        : null;

    if (dynamicData['weather'] != null) {
      weather = <Weather>[];
      dynamicData['weather'].forEach((v) {
        weather.add(Weather().fromMap(v));
      });
    }
    Wind? wind = dynamicData['wind'] != null
        ? Wind().fromMap(dynamicData['wind'])
        : null;

    Clouds? clouds = dynamicData['clouds'] != null
        ? Clouds().fromMap(dynamicData['clouds'])
        : null;

    Sys? sys = dynamicData['sys'] != null
        ? Sys().fromMap(dynamicData['sys'])
        : null;

    return WeatherDataModel(
      id: dynamicData['id'],
      coord: coord,
      weather: weather,
      base: dynamicData['base'],
      main: main,
      visibility: dynamicData['visibility'],
      wind: wind,
      clouds: clouds,
      dt: dt = dynamicData['dt'],
      sys: sys,
      timezone: timezone = dynamicData['timezone'],
      name: dynamicData['name'],
      cod: dynamicData['cod'],
    );
  }

  @override
  List<WeatherDataModel> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(WeatherDataModel object) {
    return {
      'id': object.id,
      'coord': object.coord,
      'weather': object.weather,
      'base': object.base,
      'main': object.main,
      'visibility': object.visibility,
      'wind': object.wind,
      'clouds': object.clouds,
      'dt': object.dt,
      'sys': object.sys,
      'timezone': object.timezone,
      'name': object.name,
      'cod': object.cod,
    };
  }

  @override
  List<Object?> get props => [
    id,
    coord,
    weather,
    base,
    main,
    visibility,
    wind,
    clouds,
    dt,
    sys,
    timezone,
    name,
    cod,
  ];

  @override
  List<Map<String, dynamic>?> toMapList(List<WeatherDataModel> objectList) {
    throw UnimplementedError();
  }
}

// ignore: must_be_immutable
class Coord extends MasterObject<Coord> {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat}) : super(id: 0);

  @override
  Coord fromMap(dynamicData) {
    return Coord(lon: dynamicData['lon'], lat: dynamicData['lat']);
  }

  @override
  List<Coord> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Coord object) {
    return {'lon': object.lon, 'lat': object.lat};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Coord> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [lat, lon];
}

// ignore: must_be_immutable
class Weather extends MasterObject<Weather> {
  String? main;
  String? description;
  String? icon;

  Weather({int? id, this.main, this.description, this.icon})
    : super(id: id ?? 0);

  @override
  Weather fromMap(dynamicData) {
    return Weather(
      id: dynamicData['id'],
      main: dynamicData['main'],
      description: dynamicData['description'],
      icon: dynamicData['icon'],
    );
  }

  @override
  List<Weather> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Weather object) {
    return {
      'id': object.id,
      'main': object.main,
      'description': object.description,
      'icon': object.icon,
    };
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Weather> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [id, main, description, icon];
}

// ignore: must_be_immutable
class Main extends MasterObject<Main> {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;
  double? tempKf;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
    this.tempKf,
  }) : super(id: 0);

  @override
  Main fromMap(dynamicData) {
    return Main(
      temp: dynamicData['temp']?.toDouble(),
      feelsLike: dynamicData['feels_like']?.toDouble(),
      tempMin: dynamicData['temp_min']?.toDouble(),
      tempMax: dynamicData['temp_max']?.toDouble(),
      pressure: dynamicData['pressure'],
      humidity: dynamicData['humidity'],
      seaLevel: dynamicData['sea_level'],
      grndLevel: dynamicData['grnd_level'],
      tempKf: dynamicData['temp_kf']?.toDouble(),
    );
  }

  @override
  List<Main> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Main object) {
    return {
      'temp': object.temp,
      'feels_like': object.feelsLike,
      'temp_min': object.tempMin,
      'temp_max': object.tempMax,
      'pressure': object.pressure,
      'humidity': object.humidity,
      'sea_level': object.seaLevel,
      'grnd_level': object.grndLevel,
      'temp_kf': object.tempKf,
    };
  }

  @override
  List<Object?> get props => [
    temp,
    feelsLike,
    tempMin,
    tempMax,
    pressure,
    humidity,
    seaLevel,
    grndLevel,
    tempKf,
  ];

  @override
  List<Map<String, dynamic>?> toMapList(List<Main> objectList) {
    throw UnimplementedError();
  }
}

// ignore: must_be_immutable
class Wind extends MasterObject<Wind> {
  double? speed;
  int? deg;
  double? gust;

  Wind({this.speed, this.deg, this.gust}) : super(id: 0);

  @override
  Wind fromMap(dynamicData) {
    return Wind(
      speed: dynamicData['speed']?.toDouble(),
      deg: dynamicData['deg'],
      gust: dynamicData['gust']?.toDouble(),
    );
  }

  @override
  List<Wind> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Wind object) {
    return {'speed': object.speed, 'deg': object.deg, 'gust': object.gust};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Wind> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [speed, deg, gust];
}

// ignore: must_be_immutable
class Clouds extends MasterObject<Clouds> {
  int? all;

  Clouds({this.all}) : super(id: 0);

  @override
  Clouds fromMap(dynamicData) {
    return Clouds(all: dynamicData['all']);
  }

  @override
  List<Clouds> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Clouds object) {
    return {'all': object.all};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Clouds> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [all];
}

// ignore: must_be_immutable
class Sys extends MasterObject<Sys> {
  int? type;
  String? country;
  int? sunrise;
  int? sunset;
  String? pod;

  Sys({this.type, int? id, this.country, this.sunrise, this.sunset,this.pod})
    : super(id: id ?? 0);

  @override
  Sys fromMap(dynamicData) {
    return Sys(
      type: dynamicData['type'],
      id: dynamicData['id'],
      country: dynamicData['country'],
      sunrise: dynamicData['sunrise'],
      sunset: dynamicData['sunset'],
      pod: dynamicData['pod'],
    );
  }

  @override
  List<Sys> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Sys object) {
    return {
      'type': object.type,
      'id': object.id,
      'country': object.country,
      'sunrise': object.sunrise,
      'sunset': object.sunset,
      'pod':object.pod,
    };
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Sys> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [type, id, country, sunrise, sunset];
}
