import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';
import 'package:practica_flutter/features/employees/domain/entities/employee_entity.dart';

class EmployeeProfileHeader extends StatelessWidget {
  final EmployeeEntity employee;

  const EmployeeProfileHeader({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = employee.status.toUpperCase() == 'ACTIVE';

    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'PERFIL DE: ',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          TextSpan(
            text: employee.fullName.toUpperCase(),
            style: const TextStyle(color: AppColors.primaryLight),
          ),
          TextSpan(
            text: ' (${isActive ? 'ACTIVO' : 'INACTIVO'})',
            style: TextStyle(
              color: isActive ? AppColors.success : AppColors.error,
            ),
          ),
        ],
      ),
      style: theme.textTheme.headlineLarge?.copyWith(
        letterSpacing: 1.5,
        fontSize: 24,
      ),
    );
  }
}
