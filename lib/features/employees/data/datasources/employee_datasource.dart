import 'dart:convert';
import '../../../../core/network/api_client.dart';
import '../models/employee_model.dart';

class EmployeeDatasource {
  final ApiClient _apiClient = ApiClient();

  Future<List<EmployeeModel>> getEmployees() async {
    final response = await _apiClient.get('employees');

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
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
    if (response.statusCode != 200 && response.statusCode != 201) {
      _apiClient.throwApiException(response);
    }
  }

  Future<void> updateEmployee(String id, EmployeeModel employee) async {
    final response = await _apiClient.put('employees/$id', employee.toJson());
    if (response.statusCode != 201 && response.statusCode != 200) {
      _apiClient.throwApiException(response);
    }
  }

  Future<void> updateStatus(String id, String status) async {
    final response = await _apiClient.patch('employees/$id/status', {'status': status});
    if (response.statusCode != 200) {
      _apiClient.throwApiException(response);
    }
  }
}
