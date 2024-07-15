// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_call_local_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorCallLocalDBAdapter extends TypeAdapter<DoctorCallLocalDB> {
  @override
  final int typeId = 0;

  @override
  DoctorCallLocalDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorCallLocalDB(
      doctorId: fields[0] as String?,
      hospitalId: fields[1] as String?,
      user1Id: fields[2] as String?,
      user2Id: fields[3] as String?,
      dateTime: fields[4] as String?,
      lat: fields[5] as String?,
      lon: fields[6] as String?,
      remarks: fields[7] as String?,
      products: (fields[8] as List?)?.cast<DoctorProductsLocalDB>(),
    );
  }

  @override
  void write(BinaryWriter writer, DoctorCallLocalDB obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.doctorId)
      ..writeByte(1)
      ..write(obj.hospitalId)
      ..writeByte(2)
      ..write(obj.user1Id)
      ..writeByte(3)
      ..write(obj.user2Id)
      ..writeByte(4)
      ..write(obj.dateTime)
      ..writeByte(5)
      ..write(obj.lat)
      ..writeByte(6)
      ..write(obj.lon)
      ..writeByte(7)
      ..write(obj.remarks)
      ..writeByte(8)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorCallLocalDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DoctorProductsLocalDBAdapter extends TypeAdapter<DoctorProductsLocalDB> {
  @override
  final int typeId = 1;

  @override
  DoctorProductsLocalDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorProductsLocalDB(
      productId: fields[0] as String?,
      sample: fields[1] as bool?,
      qty: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorProductsLocalDB obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.sample)
      ..writeByte(2)
      ..write(obj.qty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorProductsLocalDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
