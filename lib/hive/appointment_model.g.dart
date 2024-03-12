// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentModelAdapter extends TypeAdapter<AppointmentModel> {
  @override
  final int typeId = 3;

  @override
  AppointmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppointmentModel(
      username: fields[0] as String,
      doctorName: fields[1] as String,
      doctorCategory: fields[2] as String,
      selectedDate: fields[3] as String,
      selectedTime: fields[4] as String,
      mobilenumber: fields[6] as String,
      name: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.doctorName)
      ..writeByte(2)
      ..write(obj.doctorCategory)
      ..writeByte(3)
      ..write(obj.selectedDate)
      ..writeByte(4)
      ..write(obj.selectedTime)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.mobilenumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
