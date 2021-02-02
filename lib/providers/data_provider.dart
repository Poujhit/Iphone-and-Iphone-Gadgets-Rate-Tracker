import 'package:http/http.dart' as http;

class DataProvider {
  static Future<http.Response> getDataFromApi() async {
    const url = 'https://iphone-rate-tracker.herokuapp.com/data';
    final response = await http.get(url);
    print('done');
    return response;
  }
}
