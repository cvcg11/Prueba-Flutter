import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'custom_card.dart';

class EmployeeListTile extends StatelessWidget {
  final String name;
  final String phone;
  final VoidCallback? onTap;
  final VoidCallback? onMorePressed;

  const EmployeeListTile({
    super.key,
    required this.name,
    required this.phone,
    this.onTap,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: CustomCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.person_outline,
                color: AppColors.textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    phone,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            if (onMorePressed != null)
              IconButton(
                icon: const Icon(Icons.more_vert, color: AppColors.textMuted),
                onPressed: onMorePressed,
              ),
          ],
        ),
      ),
    );
  }
}
