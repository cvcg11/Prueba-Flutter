import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';

class EmployeeFormSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const EmployeeFormSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: theme.cardTheme.color),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                color: AppColors.primaryLight,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            for (int i = 0; i < children.length; i++) ...[
              children[i],
              if (i < children.length - 1) const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}
