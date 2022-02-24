// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_save_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordSaveAdapter extends TypeAdapter<WordSave> {
  @override
  final int typeId = 0;

  @override
  WordSave read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordSave()
      ..word = fields[0] as String
      ..saveDate = fields[1] as DateTime;
  }

  @override
  void write(BinaryWriter writer, WordSave obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.saveDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordSaveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
