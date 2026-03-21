import 'package:practica_flutter/features/employees/data/datasources/employee_datasource.dart';
import 'package:practica_flutter/features/employees/data/models/employee_model.dart';
import 'package:practica_flutter/features/employees/domain/entities/employee_entity.dart';
import 'package:practica_flutter/features/employees/domain/repositories/employee_repository.dart';

class EmployeeService implements EmployeeRepository {
  final EmployeeDatasource _datasource = EmployeeDatasource();

  @override
  Future<List<EmployeeEntity>> getEmployees() async {
    return _datasource.getEmployees();
  }

  @override
  Future<EmployeeEntity> getEmployeeById(String id) async {
    return _datasource.getEmployeeById(id);
  }

  @override
  Future<void> addEmployee(EmployeeEntity employee) async {
    final employeeModel = EmployeeModel.toJson(employee);
    return _datasource.addEmployee(employeeModel);
  }

  @override
  Future<void> updateEmployee(String id, EmployeeEntity employee) async {
    final employeeModel = EmployeeModel.toJson(employee);
    return _datasource.updateEmployee(id, employeeModel);
  }

  @override
  Future<void> updateStatus(String id, String status) async {
    return _datasource.updateStatus(id, status);
  }
}
