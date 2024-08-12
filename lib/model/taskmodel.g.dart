// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 3;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      Tasktitle: fields[0] as String?,
      date: fields[1] as String?,
      startTime: fields[2] as String?,
      endTime: fields[3] as String?,
      reminder: fields[4] as bool?,
      repeat: fields[5] as String?,
      taskNote: fields[6] as String?,
      taskType: fields[7] as String?,
      isImportant: fields[8] as bool?,
      iscompleted: fields[9] as bool?,
      userKey: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.Tasktitle)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.reminder)
      ..writeByte(5)
      ..write(obj.repeat)
      ..writeByte(6)
      ..write(obj.taskNote)
      ..writeByte(7)
      ..write(obj.taskType)
      ..writeByte(8)
      ..write(obj.isImportant)
      ..writeByte(9)
      ..write(obj.iscompleted)
      ..writeByte(10)
      ..write(obj.userKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
