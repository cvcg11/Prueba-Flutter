import '../../domain/entities/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  EmployeeModel({
    required super.id,
    required super.fullName,
    required super.dui,
    required super.email,
    required super.phone,
    required super.username,
    required super.password,
    required super.status,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      fullName: json['fullName'],
      dui: json['dui'] ?? '',
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      password: json['password'],
      status: json['status'],
    );
  }

  factory EmployeeModel.toJson(EmployeeEntity employee) {
    return EmployeeModel(
      id: '',
      fullName: employee.fullName,
      dui: employee.dui,
      email: employee.email,
      phone: employee.phone,
      username: employee.username,
      password: employee.password,
      status: employee.status,
    );
  }
}
