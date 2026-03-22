import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';

class DashboardQuickActions extends StatelessWidget {
  const DashboardQuickActions({super.key});

  static const _actions = [
    (icon: Icons.person_add_outlined,  label: 'Agregar\nPersonal'),
    (icon: Icons.edit_document,        label: 'Nuevo\nReporte'),
    (icon: Icons.bar_chart_outlined,   label: 'Ver\nEstadísticas'),
    (icon: Icons.settings_outlined,    label: 'Configurar'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < _actions.length; i++) ...[
          Expanded(
            child: _QuickActionCard(
              icon: _actions[i].icon,
              label: _actions[i].label,
            ),
          ),
          if (i < _actions.length - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickActionCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider, width: 0.5),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryLight, size: 22),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelLarge?.copyWith(
                fontSize: 9,
                letterSpacing: 0.5,
                color: AppColors.textSecondary,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}