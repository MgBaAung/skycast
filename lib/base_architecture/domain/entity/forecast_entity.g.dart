// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForecastEntityAdapter extends TypeAdapter<ForecastEntity> {
  @override
  final int typeId = 9;

  @override
  ForecastEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForecastEntity(
      list: (fields[0] as List?)?.cast<ForecastListItemEntity>(),
      city: fields[1] as CityEntity?,
    );
  }

  @override
  void write(BinaryWriter writer, ForecastEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.list)
      ..writeByte(1)
      ..write(obj.city);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ForecastListItemEntityAdapter
    extends TypeAdapter<ForecastListItemEntity> {
  @override
  final int typeId = 8;

  @override
  ForecastListItemEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForecastListItemEntity(
      dt: fields[0] as int?,
      main: fields[1] as MainEntity?,
      weather: (fields[2] as List?)?.cast<WeatherEntity>(),
      clouds: fields[3] as CloudsEntity?,
      wind: fields[4] as WindEntity?,
      visibility: fields[5] as int?,
      pop: fields[6] as int?,
      sys: fields[7] as SysEntity?,
      dtTxt: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ForecastListItemEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.dt)
      ..writeByte(1)
      ..write(obj.main)
      ..writeByte(2)
      ..write(obj.weather)
      ..writeByte(3)
      ..write(obj.clouds)
      ..writeByte(4)
      ..write(obj.wind)
      ..writeByte(5)
      ..write(obj.visibility)
      ..writeByte(6)
      ..write(obj.pop)
      ..writeByte(7)
      ..write(obj.sys)
      ..writeByte(8)
      ..write(obj.dtTxt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastListItemEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CityEntityAdapter extends TypeAdapter<CityEntity> {
  @override
  final int typeId = 12;

  @override
  CityEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CityEntity(
      id: fields[0] as int?,
      name: fields[1] as String?,
      coord: fields[2] as CoordEntity?,
      country: fields[3] as String?,
      population: fields[4] as int?,
      timezone: fields[5] as int?,
      sunrise: fields[6] as int?,
      sunset: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CityEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.coord)
      ..writeByte(3)
      ..write(obj.country)
      ..writeByte(4)
      ..write(obj.population)
      ..writeByte(5)
      ..write(obj.timezone)
      ..writeByte(6)
      ..write(obj.sunrise)
      ..writeByte(7)
      ..write(obj.sunset);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
