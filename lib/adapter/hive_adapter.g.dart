// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleDBAdapter extends TypeAdapter<ScheduleDB> {
  @override
  final int typeId = 0;

  @override
  ScheduleDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleDB(
      dateTime: fields[0] as DateTime?,
      name: fields[1] as String?,
      id: fields[2] as int?,
      discriptions: fields[3] as String?,
      time: fields[4] as DateTime?,
      isSelect: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleDB obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.discriptions)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.isSelect);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DiaryDBAdapter extends TypeAdapter<DiaryDB> {
  @override
  final int typeId = 1;

  @override
  DiaryDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiaryDB(
      id: fields[4] as int?,
      dateTime: fields[0] as DateTime?,
      name: fields[1] as String?,
      category: fields[2] as String?,
      note: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DiaryDB obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InstructionsDBAdapter extends TypeAdapter<InstructionsDB> {
  @override
  final int typeId = 2;

  @override
  InstructionsDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InstructionsDB(
      image: fields[0] as Uint8List?,
      title: fields[1] as String?,
      text: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InstructionsDB obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstructionsDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContactDBAdapter extends TypeAdapter<ContactDB> {
  @override
  final int typeId = 3;

  @override
  ContactDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactDB(
      name: fields[0] as String?,
      number: fields[2] as String?,
      isFavourite: fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ContactDB obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isFavourite)
      ..writeByte(2)
      ..write(obj.number);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
