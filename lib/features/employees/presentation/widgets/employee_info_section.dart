import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';
import 'employee_info_field.dart';

class EmployeeInfoSection extends StatelessWidget {
  final String title;
  final List<({String label, String value})> fields;

  const EmployeeInfoSection({
    super.key,
    required this.title,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                color: AppColors.primaryLight,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            for (int i = 0; i < fields.length; i++) ...[
              EmployeeInfoField(label: fields[i].label, value: fields[i].value),
              if (i < fields.length - 1) ...[
                const SizedBox(height: 5),
                Divider(color: AppColors.divider.withValues(alpha: 0.1)),
                const SizedBox(height: 8),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
