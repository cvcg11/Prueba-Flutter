import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';

class DashboardMetricsRow extends StatelessWidget {
  const DashboardMetricsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                label: 'EMPLEADOS',
                value: '24',
                delta: '+2 este mes',
                icon: Icons.people_outline,
                positive: true,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _MetricCard(
                label: 'ACTIVOS',
                value: '19',
                delta: '79% del total',
                icon: Icons.check_circle_outline,
                positive: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                label: 'INACTIVOS',
                value: '5',
                delta: '-1 este mes',
                icon: Icons.block_outlined,
                positive: false,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _MetricCard(
                label: 'INVENTARIO',
                value: '142',
                delta: '+8 nuevos',
                icon: Icons.inventory_2_outlined,
                positive: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String delta;
  final IconData icon;
  final bool positive;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.delta,
    required this.icon,
    required this.positive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deltaColor = positive ? AppColors.primaryLight : AppColors.error;

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
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontSize: 9,
                  letterSpacing: 1.0,
                  color: AppColors.textMuted,
                ),
              ),
              Icon(icon, size: 15, color: AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                positive ? Icons.arrow_upward : Icons.arrow_downward,
                size: 10,
                color: deltaColor,
              ),
              const SizedBox(width: 3),
              Text(
                delta,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: deltaColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}