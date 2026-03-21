import '../entities/employee_entity.dart';

abstract class EmployeeRepository {
  Future<List<EmployeeEntity>> getEmployees();
  Future<EmployeeEntity> getEmployeeById(String id);
  Future<void> addEmployee(EmployeeEntity employee);
  Future<void> updateEmployee(String id, EmployeeEntity employee);
  Future<void> updateStatus(String id, String status);
}
