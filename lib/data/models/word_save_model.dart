import 'package:hive/hive.dart';

part 'word_save_model.g.dart';

@HiveType(typeId: 0)
class WordSave extends HiveObject{

  @HiveField(0)
  late String word;

  @HiveField(1)
  late DateTime saveDate;
}

