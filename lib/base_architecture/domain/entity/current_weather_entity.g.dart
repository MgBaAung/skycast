// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentWeatherEntityAdapter extends TypeAdapter<CurrentWeatherEntity> {
  @override
  final int typeId = 1;

  @override
  CurrentWeatherEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentWeatherEntity(
      coord: fields[0] as CoordEntity?,
      weather: (fields[1] as List?)?.cast<WeatherEntity>(),
      base: fields[2] as String?,
      main: fields[3] as MainEntity?,
      visibility: fields[4] as int?,
      wind: fields[5] as WindEntity?,
      clouds: fields[6] as CloudsEntity?,
      dt: fields[7] as int?,
      sys: fields[8] as SysEntity?,
      timezone: fields[9] as int?,
      id: fields[10] as int?,
      name: fields[11] as String?,
      cod: fields[12] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentWeatherEntity obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.coord)
      ..writeByte(1)
      ..write(obj.weather)
      ..writeByte(2)
      ..write(obj.base)
      ..writeByte(3)
      ..write(obj.main)
      ..writeByte(4)
      ..write(obj.visibility)
      ..writeByte(5)
      ..write(obj.wind)
      ..writeByte(6)
      ..write(obj.clouds)
      ..writeByte(7)
      ..write(obj.dt)
      ..writeByte(8)
      ..write(obj.sys)
      ..writeByte(9)
      ..write(obj.timezone)
      ..writeByte(10)
      ..write(obj.id)
      ..writeByte(11)
      ..write(obj.name)
      ..writeByte(12)
      ..write(obj.cod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentWeatherEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CoordEntityAdapter extends TypeAdapter<CoordEntity> {
  @override
  final int typeId = 2;

  @override
  CoordEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoordEntity(
      lon: fields[0] as double?,
      lat: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, CoordEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lon)
      ..writeByte(1)
      ..write(obj.lat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoordEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeatherEntityAdapter extends TypeAdapter<WeatherEntity> {
  @override
  final int typeId = 3;

  @override
  WeatherEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherEntity(
      id: fields[0] as int?,
      main: fields[1] as String?,
      description: fields[2] as String?,
      icon: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.main)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MainEntityAdapter extends TypeAdapter<MainEntity> {
  @override
  final int typeId = 4;

  @override
  MainEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainEntity(
      temp: fields[0] as double?,
      feelsLike: fields[1] as double?,
      tempMin: fields[2] as double?,
      tempMax: fields[3] as double?,
      pressure: fields[4] as int?,
      humidity: fields[5] as int?,
      seaLevel: fields[6] as int?,
      grndLevel: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MainEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.temp)
      ..writeByte(1)
      ..write(obj.feelsLike)
      ..writeByte(2)
      ..write(obj.tempMin)
      ..writeByte(3)
      ..write(obj.tempMax)
      ..writeByte(4)
      ..write(obj.pressure)
      ..writeByte(5)
      ..write(obj.humidity)
      ..writeByte(6)
      ..write(obj.seaLevel)
      ..writeByte(7)
      ..write(obj.grndLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WindEntityAdapter extends TypeAdapter<WindEntity> {
  @override
  final int typeId = 5;

  @override
  WindEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WindEntity(
      speed: fields[0] as double?,
      deg: fields[1] as int?,
      gust: fields[2] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, WindEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.speed)
      ..writeByte(1)
      ..write(obj.deg)
      ..writeByte(2)
      ..write(obj.gust);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WindEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CloudsEntityAdapter extends TypeAdapter<CloudsEntity> {
  @override
  final int typeId = 6;

  @override
  CloudsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CloudsEntity(
      all: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CloudsEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.all);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CloudsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SysEntityAdapter extends TypeAdapter<SysEntity> {
  @override
  final int typeId = 7;

  @override
  SysEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SysEntity(
      type: fields[0] as int?,
      id: fields[4] as int?,
      country: fields[1] as String?,
      sunrise: fields[2] as int?,
      sunset: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SysEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.country)
      ..writeByte(2)
      ..write(obj.sunrise)
      ..writeByte(3)
      ..write(obj.sunset)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SysEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
