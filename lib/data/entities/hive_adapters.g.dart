// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class GameEntityAdapter extends TypeAdapter<GameEntity> {
  @override
  final typeId = 0;

  @override
  GameEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameEntity(
      id: fields[0] as String,
      name: fields[1] as String,
      createDate: fields[2] as DateTime,
      gameOptions: fields[3] as GameOptionsEntity,
      players: (fields[4] as List).cast<PlayerEntity>(),
      rounds: fields[5] == null
          ? const <RoundEntity>[]
          : (fields[5] as List).cast<RoundEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, GameEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createDate)
      ..writeByte(3)
      ..write(obj.gameOptions)
      ..writeByte(4)
      ..write(obj.players)
      ..writeByte(5)
      ..write(obj.rounds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PreferencesEntityAdapter extends TypeAdapter<PreferencesEntity> {
  @override
  final typeId = 1;

  @override
  PreferencesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PreferencesEntity(
      themeMode: fields[1] == null ? 'system' : fields[1] as String,
      language: fields[2] == null ? 'en' : fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PreferencesEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.themeMode)
      ..writeByte(2)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreferencesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GameOptionsEntityAdapter extends TypeAdapter<GameOptionsEntity> {
  @override
  final typeId = 2;

  @override
  GameOptionsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameOptionsEntity(
      maxScoreByRound: (fields[0] as num?)?.toInt(),
      maxScore: (fields[1] as num?)?.toInt(),
      maxRounds: (fields[2] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, GameOptionsEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.maxScoreByRound)
      ..writeByte(1)
      ..write(obj.maxScore)
      ..writeByte(2)
      ..write(obj.maxRounds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameOptionsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayerEntityAdapter extends TypeAdapter<PlayerEntity> {
  @override
  final typeId = 3;

  @override
  PlayerEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayerEntity(
      id: fields[0] as String,
      name: fields[1] as String,
      color: (fields[2] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, PlayerEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RoundEntityAdapter extends TypeAdapter<RoundEntity> {
  @override
  final typeId = 4;

  @override
  RoundEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoundEntity(
      id: fields[0] as String,
      index: (fields[1] as num).toInt(),
      playerByScores: fields[2] == null
          ? const <String, int>{}
          : (fields[2] as Map).cast<String, int>(),
    );
  }

  @override
  void write(BinaryWriter writer, RoundEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.playerByScores);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoundEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
