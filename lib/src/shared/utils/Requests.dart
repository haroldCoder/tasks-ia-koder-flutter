import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';

class Requests {
  final String baseUrl;

  Requests({required this.baseUrl});

  Future<http.Response> makeRequest(
      {required HttpMethod method,
      required String endpoint,
      Map<String, String>? headers,
      dynamic body,
      Map<String, String>? queryParameters}) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint')
          .replace(queryParameters: queryParameters);

      final defaultHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        ...?headers,
      };

      final encodedBody =
          body != null && body is! String ? jsonEncode(body) : body;

      http.Response response;
      switch (method) {
        case HttpMethod.get:
          response = await http.get(uri, headers: defaultHeaders);
          break;
        case HttpMethod.post:
          response =
              await http.post(uri, headers: defaultHeaders, body: encodedBody);
          break;
        case HttpMethod.put:
          response =
              await http.put(uri, headers: defaultHeaders, body: encodedBody);
          break;
        case HttpMethod.delete:
          response = await http.delete(uri,
              headers: defaultHeaders, body: encodedBody);
          break;
        case HttpMethod.patch:
          response =
              await http.patch(uri, headers: defaultHeaders, body: encodedBody);
          break;
      }

      return response;
    } catch (e) {
      throw HttpServiceException('Request failed: $e');
    }
  }

  Future<dynamic> request({
    required HttpMethod method,
    required String endpoint,
    Map<String, String>? headers,
    dynamic body,
    Map<String, String>? queryParameters,
  }) async {
    http.Response response = await makeRequest(
        method: method,
        endpoint: endpoint,
        headers: headers,
        body: body,
        queryParameters: queryParameters);
    return json.decode(response.body);
  }
}

class HttpServiceException implements Exception {
  final String message;

  HttpServiceException(this.message);

  @override
  String toString() => 'HttpServiceException: $message';
}
