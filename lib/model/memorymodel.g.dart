// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memorymodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemoryModelAdapter extends TypeAdapter<MemoryModel> {
  @override
  final int typeId = 4;

  @override
  MemoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemoryModel(
      id: fields[0] as String,
      eventId: fields[1] as String,
      text: fields[2] as String,
      photoUrls: (fields[3] as List).cast<String>(),
      createdAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MemoryModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.eventId)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.photoUrls)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
