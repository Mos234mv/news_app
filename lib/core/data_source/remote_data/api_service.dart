import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/core/data_source/remote_data/api.config.dart';

class ApiService {
  Future<dynamic> get(String endPoint, {Map<String, dynamic>? params}) async {
    var url = Uri.http(ApiConfig.baseUrl, "v2/$endPoint", {'apiKey': ApiConfig.apiKey, ...?params});

    try {
      final response = await http.get(url);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed To Load Data');
    }
  }
}
