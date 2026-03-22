import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';

class PageHeader extends StatelessWidget {
  final String label;
  final String title;

  const PageHeader({
    super.key,
    required this.label,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppColors.primaryLight,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}