import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DataProvider with ChangeNotifier {
   Future<List> getDataFromApi() async {
    const url = 'https://iphone-rate-tracker.herokuapp.com/data';
    final response = await http.get(url);
    final jsondata = convert.jsonDecode(response.body);
    notifyListeners();
    return jsondata['alldata'] as List;
  }
}
