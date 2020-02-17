// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_Organization.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataAdapter extends TypeAdapter<Data> {
  @override
  Data read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data(
      organization: (fields[0] as List)?.cast<Organization>(),
    );
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.organization);
  }
}

class OrganizationAdapter extends TypeAdapter<Organization> {
  @override
  Organization read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Organization(
      description: fields[2] as String,
      location: fields[1] as String,
      name: fields[0] as String,
      tag: fields[3] as String,
      website: fields[4] as String,
      orgId: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Organization obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.location)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.tag)
      ..writeByte(4)
      ..write(obj.website)
      ..writeByte(5)
      ..write(obj.orgId);
  }
}
