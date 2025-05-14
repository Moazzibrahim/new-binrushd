// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branches_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BranchResponseAdapter extends TypeAdapter<BranchResponse> {
  @override
  final int typeId = 0;

  @override
  BranchResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BranchResponse(
      message: fields[0] as String,
      data: (fields[1] as List).cast<Branch>(),
    );
  }

  @override
  void write(BinaryWriter writer, BranchResponse obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BranchResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BranchAdapter extends TypeAdapter<Branch> {
  @override
  final int typeId = 1;

  @override
  Branch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Branch(
      id: fields[0] as int,
      name: fields[1] as String,
      brief: fields[2] as String,
      address: fields[3] as String,
      latitude: fields[4] as double,
      longitude: fields[5] as double,
      worktimes: fields[6] as WorkTimes,
      email: fields[7] as String,
      image: fields[8] as String,
      doctors: (fields[9] as List).cast<Doctor>(),
    );
  }

  @override
  void write(BinaryWriter writer, Branch obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.brief)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.latitude)
      ..writeByte(5)
      ..write(obj.longitude)
      ..writeByte(6)
      ..write(obj.worktimes)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.doctors);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BranchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkTimesAdapter extends TypeAdapter<WorkTimes> {
  @override
  final int typeId = 2;

  @override
  WorkTimes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkTimes(
      sunday: fields[0] as String,
      monday: fields[1] as String,
      tuesday: fields[2] as String,
      wednesday: fields[3] as String,
      thursday: fields[4] as String,
      friday: fields[5] as String,
      saturday: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorkTimes obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.sunday)
      ..writeByte(1)
      ..write(obj.monday)
      ..writeByte(2)
      ..write(obj.tuesday)
      ..writeByte(3)
      ..write(obj.wednesday)
      ..writeByte(4)
      ..write(obj.thursday)
      ..writeByte(5)
      ..write(obj.friday)
      ..writeByte(6)
      ..write(obj.saturday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkTimesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DoctorAdapter extends TypeAdapter<Doctor> {
  @override
  final int typeId = 3;

  @override
  Doctor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Doctor(
      id: fields[0] as int,
      name: fields[1] as String?,
      gender: fields[2] as String,
      qualifications: (fields[3] as List).cast<String>(),
      experience: (fields[4] as List).cast<String>(),
      speciality: fields[5] as String,
      degree: fields[6] as String,
      phone: fields[7] as String?,
      email: fields[8] as String?,
      brief: fields[9] as String,
      image: fields[10] as String,
      highlighted: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Doctor obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.qualifications)
      ..writeByte(4)
      ..write(obj.experience)
      ..writeByte(5)
      ..write(obj.speciality)
      ..writeByte(6)
      ..write(obj.degree)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.email)
      ..writeByte(9)
      ..write(obj.brief)
      ..writeByte(10)
      ..write(obj.image)
      ..writeByte(11)
      ..write(obj.highlighted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
