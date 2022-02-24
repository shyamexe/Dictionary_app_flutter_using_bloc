import 'package:hive/hive.dart';
import '../models/word_save_model.dart';



class Boxes{
static Box<WordSave>getWordToBox()=>
    Hive.box<WordSave>('WordSave');
    
}