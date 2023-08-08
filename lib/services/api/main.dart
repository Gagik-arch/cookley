import 'package:http/http.dart' as http;
import 'dart:convert';

extension IsOk on http.Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}

class Api {
  String? baseUrl;
  bool? cleanRequest;

  Api({this.baseUrl = '', this.cleanRequest});

  Future<http.Response> get({String url = ''}) {
    return _configureRequest(url: url);
  }

  Future<http.Response> post({String url = '', body = Map<String, dynamic>}) {
    return _configureRequest(url: url, method: 'post', body: body);
  }

  Future<http.Response> delete({String url = '', body = Map<String, dynamic>}) {
    return _configureRequest(url: url, method: 'delete', body: body);
  }

  Future<http.Response> put({String url = '', body = Map<String, dynamic>}) {
    return _configureRequest(url: url, method: 'put', body: body);
  }

  Future<http.Response> _configureRequest({
    String url = '',
    String? method = 'get',
    body = Map<String, dynamic>,
  }) async {
    const String token = ''; //localStorage.getItem('token')
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token.isNotEmpty) headers['Authorization'] = token;
    url = cleanRequest == true
        ? '$baseUrl$url'
        : 'https://jsonplaceholder.typicode.com$baseUrl$url';

    late http.Response response;

    switch (method) {
      case 'get':
        response = await http.get(Uri.parse(url), headers: headers);
        break;
      case 'post':
        response = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
        break;
      case 'put':
        response = await http.put(Uri.parse(url), headers: headers);
        break;
      case 'delete':
        response = await http.delete(Uri.parse(url), headers: headers);
        break;
    }
    try {
      if (response.ok) {
        return response;
      } else {
        throw Exception('Request Error: ${response.statusCode}');
      }
    } on Exception {
      rethrow;
    }
  }
}
