// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departments.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DepartmentsAdapter extends TypeAdapter<Departments> {
  @override
  final int typeId = 2;

  @override
  Departments read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Departments(
      departs: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Departments obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.departs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepartmentsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
