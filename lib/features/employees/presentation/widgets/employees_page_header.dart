import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';

class EmployeesPageHeader extends StatelessWidget {
  const EmployeesPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ADMINISTRACIÓN',
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppColors.primaryLight,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'PERSONAL',
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
