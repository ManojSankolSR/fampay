// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleted_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeletedCardAdapter extends TypeAdapter<DeletedCard> {
  @override
  final int typeId = 1;

  @override
  DeletedCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeletedCard(
      cardGroupId: fields[0] as String,
      cardId: fields[1] as String,
      slugId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeletedCard obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cardGroupId)
      ..writeByte(1)
      ..write(obj.cardId)
      ..writeByte(2)
      ..write(obj.slugId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeletedCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
