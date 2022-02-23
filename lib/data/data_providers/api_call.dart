import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:one_dictionary/core/constants/strings.dart';
import 'package:one_dictionary/data/models/model.dart';

class ApiCallProvider {
  // Future <QuotesModel> getQuote() async {
  //   var response = await http.get(Uri.parse(links().quotesAPIUrl));

  //   // if (response.statusCode == 200) {
  //     final jsondata = jsonDecode(response.body);
  //     return QuotesModel.fromJson(jsondata);
  //   // }
  // }
  Future <DictionaryModel> getWord(String key) async {
    var response = await http.get(Uri.parse(Strings.searchAPIUrl+key));

    // if (response.statusCode == 200) {
      final jsondata = jsonDecode(response.body);
      return DictionaryModel.fromJson(jsondata[0]);
    // }
  }

  
}