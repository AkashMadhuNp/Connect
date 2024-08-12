// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventModelAdapter extends TypeAdapter<EventModel> {
  @override
  final int typeId = 1;

  @override
  EventModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventModel(
      eventTitle: fields[0] as String?,
      eventDescription: fields[1] as String?,
      eventlocation: fields[2] as String?,
      eventDate: fields[3] as String?,
      eventTime: fields[4] as String?,
      eventImage: fields[5] as String?,
      userKey: fields[6] as String?,
      isImportant: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, EventModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.eventTitle)
      ..writeByte(1)
      ..write(obj.eventDescription)
      ..writeByte(2)
      ..write(obj.eventlocation)
      ..writeByte(3)
      ..write(obj.eventDate)
      ..writeByte(4)
      ..write(obj.eventTime)
      ..writeByte(5)
      ..write(obj.eventImage)
      ..writeByte(6)
      ..write(obj.userKey)
      ..writeByte(7)
      ..write(obj.isImportant);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
