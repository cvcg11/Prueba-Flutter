import 'package:flutter/material.dart';
import 'package:practica_flutter/core/widgets/employee_list_tile.dart';
import 'package:practica_flutter/features/employees/domain/entities/employee_entity.dart';

class EmployeesList extends StatelessWidget {
  final List<EmployeeEntity> employees;
  final void Function(EmployeeEntity) onTap;
  final Future<void> Function() onRefresh;

  const EmployeesList({
    super.key,
    required this.employees,
    required this.onTap,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (employees.isEmpty) {
      return const Center(child: Text('No hay empleados registrados.'));
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: employees.length,
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          final employee = employees[index];
          return EmployeeListTile(
            name: employee.fullName,
            phone: employee.phone,
            onTap: () => onTap(employee),
          );
        },
      ),
    );
  }
}
