import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:under/feature/api/strings.dart';

class Http {
  final _client = http.Client();
  String uri;
  String fullUrl = '';
  String? token;
  Map<dynamic, dynamic>? body;

  Http({
    required this.uri,
    this.body,
    this.token,
  }) {
    fullUrl = StringsApi.baseUrl + uri;
  }

  Future<Response> get() async {
    final url = Uri.parse(fullUrl);

    return await _client.get(
      url,
      headers: getHeaderWithToken(),
    );
  }

  Future<Response> post() async {
    final url = Uri.parse(uri);
    final bodyEnconded = jsonEncode(body);

    return await _client.post(
      url,
      body: bodyEnconded,
      headers: getHeaderWithToken(),
    );
  }

  Map<String, String> _getHeader() {
    return {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  Map<String, String> getHeaderWithToken() {
    if (token != null) {
      return {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Authentication': 'Bearer $token'
      };
    }

    return _getHeader();
  }
}
