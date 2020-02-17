// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequestsAdapter extends TypeAdapter<Requests> {
  @override
  Requests read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Requests(
      requested: (fields[0] as List)?.cast<Organization>(),
    );
  }

  @override
  void write(BinaryWriter writer, Requests obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.requested);
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
      v: fields[5] as int,
      id: fields[0] as String,
      description: fields[4] as String,
      fullName: fields[1] as String,
      location: fields[2] as String,
      photoUrl: fields[3] as String,
      website: fields[6] as String,
      org_id: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Organization obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.photoUrl)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.v)
      ..writeByte(6)
      ..write(obj.website)
      ..writeByte(7)
      ..write(obj.org_id);
  }
}
