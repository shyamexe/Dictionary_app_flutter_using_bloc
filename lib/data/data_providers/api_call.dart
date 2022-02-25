import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:one_dictionary/core/constants/strings.dart';
import 'package:one_dictionary/data/models/auto_word_model.dart';
import 'package:one_dictionary/data/models/model.dart';
import 'package:one_dictionary/data/models/random_quote_model.dart';

class ApiCallProvider {
  Future <RandomQuoteModel> getQuote() async {
    var response = await http.get(Uri.parse(Strings.quoteAPIUrl));

    // if (response.statusCode == 200) {
      final jsondata = jsonDecode(response.body);
      return RandomQuoteModel.fromJson(jsondata);
    // }
  }
  Future <DictionaryModel> getWord(String key) async {
    var response = await http.get(Uri.parse(Strings.searchAPIUrl+key));

    // if (response.statusCode == 200) {
      final jsondata = jsonDecode(response.body);
      return DictionaryModel.fromJson(jsondata[0]);
    // }
  }

  Future <AutoWordModel>getAutoData(String word)async{
    var response = await http.get(Uri.parse(Strings.dataAPTUrl+word));
    
    final jsondata = jsonDecode(response.body);
    return AutoWordModel.fromJson(jsondata);
  }
}