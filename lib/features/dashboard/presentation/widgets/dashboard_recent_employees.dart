import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';

class DashboardRecentEmployees extends StatelessWidget {
  const DashboardRecentEmployees({super.key});

  static const _employees = [
    (name: 'Ricardo Méndez',   role: 'Supervisor',    status: 'ACTIVO',   initials: 'RM'),
    (name: 'Carla Valladares', role: 'Analista',      status: 'ACTIVO',   initials: 'CV'),
    (name: 'Marcos Estrada',   role: 'Técnico',       status: 'INACTIVO', initials: 'ME'),
    (name: 'Sofía Hernández',  role: 'Coordinadora',  status: 'ACTIVO',   initials: 'SH'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _employees
          .map((e) => _EmployeeRow(
        name: e.name,
        role: e.role,
        status: e.status,
        initials: e.initials,
      ))
          .toList(),
    );
  }
}

class _EmployeeRow extends StatelessWidget {
  final String name;
  final String role;
  final String status;
  final String initials;

  const _EmployeeRow({
    required this.name,
    required this.role,
    required this.status,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = status == 'ACTIVO';
    final statusColor = isActive ? AppColors.primaryLight : AppColors.error;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Row(
        children: [
          // Avatar con iniciales
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              initials,
              style: theme.textTheme.labelLarge?.copyWith(
                color: AppColors.primaryLight,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Nombre y rol
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          // Badge de estado
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: isActive ? 0.12 : 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: statusColor.withValues(alpha: 0.3),
                width: 0.5,
              ),
            ),
            child: Text(
              status,
              style: theme.textTheme.labelLarge?.copyWith(
                fontSize: 9,
                letterSpacing: 0.8,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}