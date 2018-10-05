import 'dart:async';
import 'dart:core';

import 'package:http/http.dart' as http;

class WebClient {
  const WebClient();

  static final String apiEndpoint = 'https://api.giphy.com';
  static final String apiKey = '<<< ADD YOUR API KEY HERE >>>';

  Future<dynamic> get(String path) async {
    return await http.Client().get(apiEndpoint + path + '?api_key=' + apiKey);
  }
}
