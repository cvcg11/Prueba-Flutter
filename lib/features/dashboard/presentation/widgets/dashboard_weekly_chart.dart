import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';

class DashboardWeeklyChart extends StatelessWidget {
  const DashboardWeeklyChart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
    const values = [0.4, 0.7, 0.5, 0.9, 0.6, 0.3, 0.2];
    const today = 4;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Registros por día',
                style: theme.textTheme.headlineSmall,
              ),
              Text(
                'Mar 2025',
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(days.length, (i) {
                final isToday = i == today;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 64 * values[i],
                          decoration: BoxDecoration(
                            color: isToday
                                ? AppColors.primaryLight
                                : AppColors.primary.withValues(alpha: 0.65),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          days[i],
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontSize: 10,
                            fontWeight: isToday
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: isToday
                                ? AppColors.primaryLight
                                : AppColors.textMuted,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}