class EmployeeEntity {
  final String id;
  final String fullName;
  final String dui;
  final String email;
  final String phone;
  final String username;
  final String status;
  final String? password;

  EmployeeEntity({
    required this.id,
    required this.fullName,
    required this.dui,
    required this.email,
    required this.phone,
    required this.username,
    required this.status,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'dui': dui,
      'email': email,
      'phone': phone,
      'username': username,
      'password': password,
      'status': status,
    };
  }
}
