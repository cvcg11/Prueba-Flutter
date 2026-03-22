import 'dart:convert';
import '../../../../core/network/api_client.dart';
import '../models/employee_model.dart';

class EmployeeDatasource {
  final ApiClient _apiClient = ApiClient();

  Future<List<EmployeeModel>> getEmployees() async {
    final response = await _apiClient.get('employees');

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      // Extraemos la lista de la propiedad 'content' que envía tu API
      final List<dynamic> data = body['content'] ?? [];
      return data.map((json) => EmployeeModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar empleados: ${response.statusCode}');
    }
  }

  Future<EmployeeModel> getEmployeeById(String id) async {
    final response = await _apiClient.get('employees/$id');
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      return EmployeeModel.fromJson(body);
    } else {
      throw Exception('Error al cargar empleado: ${response.statusCode}');
    }
  }

  Future<void> addEmployee(EmployeeModel employee) async {
    final response = await _apiClient.post('employees', employee.toJson());

    if (response.statusCode != 201 && response.statusCode != 200) {
      // Intentamos obtener el mensaje de error del backend
      try {
        final errorData = jsonDecode(response.body);
        if (errorData['errors'] != null) {
          final Map<String, dynamic> errors = errorData['errors'];

          // Convertimos el mapa en una lista de strings: "campo: mensaje"
          final errorMessages = errors.entries
              .map((e) => "- ${e.value}")
              .join('\n');
          throw Exception(errorMessages);
        }

        // 2. Si solo hay un mensaje general (ej. "DUI duplicado"):
        final message = errorData['message'] ?? 'Error desconocido';
        throw Exception(message);
      } catch (e) {
        if (e is Exception){
          rethrow;
        }
        throw Exception('Error inesperado (${response.statusCode})');
      }
    }
  }

  Future<void> updateEmployee(String id, EmployeeModel employee) async {
    final response = await _apiClient.put('employees/$id', employee.toJson());
    if (response.statusCode != 201 && response.statusCode != 200) {
      // Intentamos obtener el mensaje de error del backend
      try {
        final errorData = jsonDecode(response.body);
        if (errorData['errors'] != null) {
          final Map<String, dynamic> errors = errorData['errors'];

          // Convertimos el mapa en una lista de strings: "campo: mensaje"
          final errorMessages = errors.entries
              .map((e) => "- ${e.value}")
              .join('\n');
          throw Exception(errorMessages);
        }

        // 2. Si solo hay un mensaje general (ej. "DUI duplicado"):
        final message = errorData['message'] ?? 'Error desconocido';
        throw Exception(message);
      } catch (e) {
        if (e is Exception){
          rethrow; // Si ya es nuestra excepción con el mensaje, la lanzamos
        }
        throw Exception('Error inesperado (${response.statusCode})');
      }
    }
  }

  Future<void> updateStatus(String id, String status) async {
    final response = await _apiClient.patch('employees/$id/status', {
      'status': status,
    });
    if (response.statusCode != 200) {
      throw Exception('Error al cambiar estado: ${response.statusCode}');
    }
  }
}
