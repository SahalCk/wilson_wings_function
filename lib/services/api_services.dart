import 'package:http/http.dart';
import 'package:wilson_wings/services/api_keys.dart';

class APIServices {
  final tmdbBaseUrl = 'https://api.themoviedb.org/3/';
  final jsonBaseUrl = 'https://jsonplaceholder.typicode.com/';

  Future<Response> tmdbGetApi(String url) async {
    final response = await get(Uri.parse(tmdbBaseUrl + url), headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json;charset=utf-8',
      'Authorization': 'Bearer $tmdbApiKey'
    });
    return response;
  }

  Future<Response> jsonPostApi(String url) async {
    final response = await post(Uri.parse(jsonBaseUrl + url));
    return response;
  }
}
