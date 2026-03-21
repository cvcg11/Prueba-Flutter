import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  // Para dispositivo físico con ADB reverse: http://localhost:8080/api
  // (Requiere ejecutar: adb reverse tcp:8080 tcp:8080)
  // final String _baseUrl = "http://10.0.2.2/api";
  final String _baseUrl = "http://localhost:8080/api";
  final http.Client _client = http.Client();

  // Cabeceras comunes para JSON
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<http.Response> get(String endpoint) {
    return _client.get(Uri.parse('$_baseUrl/$endpoint'), headers: _headers);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) {
    return _client.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: _headers,
      body: json.encode(body),
    );
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) {
    return _client.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: _headers,
      body: json.encode(body),
    );
  }

  Future<http.Response> delete(String endpoint) {
    return _client.delete(Uri.parse('$_baseUrl/$endpoint'), headers: _headers);
  }

  Future<http.Response> patch(String endpoint, Map<String, dynamic> body) {
    return _client.patch(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: _headers,
      body: json.encode(body),
    );
  }
}
