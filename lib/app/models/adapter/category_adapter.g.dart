// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapterAdapter extends TypeAdapter<CategoryAdapter> {
  @override
  final int typeId = 0;

  @override
  CategoryAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryAdapter(
      count: fields[0] as int?,
      next: fields[1] as String?,
      current: fields[2] as String?,
      previous: fields[3] as String?,
      name: fields[4] as String?,
      detail: (fields[5] as List?)?.cast<DetailAdapter>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryAdapter obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.next)
      ..writeByte(2)
      ..write(obj.current)
      ..writeByte(3)
      ..write(obj.previous)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.detail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DetailAdapterAdapter extends TypeAdapter<DetailAdapter> {
  @override
  final int typeId = 1;

  @override
  DetailAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailAdapter(
      name: fields[0] as String?,
      image: fields[1] as String?,
      url: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DetailAdapter obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
