import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String _baseUrl = "http://localhost:8080/api";
  final http.Client _client = http.Client();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // ─── Métodos HTTP ───────────────────────────────────────────────────────────

  Future<http.Response> get(String endpoint) =>
      _client.get(Uri.parse('$_baseUrl/$endpoint'), headers: _headers);

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) =>
      _client.post(Uri.parse('$_baseUrl/$endpoint'),
          headers: _headers, body: json.encode(body));

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) =>
      _client.put(Uri.parse('$_baseUrl/$endpoint'),
          headers: _headers, body: json.encode(body));

  Future<http.Response> delete(String endpoint) =>
      _client.delete(Uri.parse('$_baseUrl/$endpoint'), headers: _headers);

  Future<http.Response> patch(String endpoint, Map<String, dynamic> body) =>
      _client.patch(Uri.parse('$_baseUrl/$endpoint'),
          headers: _headers, body: json.encode(body));

  // ─── Manejo de errores centralizado ────────────────────────────────────────

  /// Lanza una [Exception] con el mensaje de error del backend.
  /// Llámalo en cualquier datasource cuando el status no sea el esperado.
  Never throwApiException(http.Response response) {
    try {
      final errorData = jsonDecode(response.body);

      // Error con mapa de campos (validaciones)
      if (errorData['errors'] != null) {
        final Map<String, dynamic> errors = errorData['errors'];
        final message = errors.entries.map((e) => '- ${e.value}').join('\n');
        throw Exception(message);
      }

      // Error con mensaje general
      final message = errorData['message'] ?? 'Error desconocido';
      throw Exception(message);
    } on Exception {
      rethrow;
    } catch (_) {
      throw Exception('Error inesperado (${response.statusCode})');
    }
  }
}