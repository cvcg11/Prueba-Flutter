import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';
import 'package:practica_flutter/core/widgets/page_header.dart';
import 'package:practica_flutter/features/dashboard/presentation/widgets/dashboard_metrics_row.dart';
import 'package:practica_flutter/features/dashboard/presentation/widgets/dashboard_quick_actions.dart';
import 'package:practica_flutter/features/dashboard/presentation/widgets/dashboard_recent_employees.dart';
import 'package:practica_flutter/features/dashboard/presentation/widgets/dashboard_section_title.dart';
import 'package:practica_flutter/features/dashboard/presentation/widgets/dashboard_weekly_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('CGI.IMPORT'),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.divider, height: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(label: 'RESUMEN GENERAL', title: 'DASHBOARD'),
            const SizedBox(height: 10),

            // ── Métricas ─────────────────────────────────────────────────────
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DashboardMetricsRow(),
            ),

            const SizedBox(height: 28),

            // ── Actividad semanal ─────────────────────────────────────────────
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DashboardSectionTitle(title: 'ACTIVIDAD SEMANAL'),
            ),
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DashboardWeeklyChart(),
            ),

            const SizedBox(height: 28),

            // ── Personal reciente ─────────────────────────────────────────────
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DashboardSectionTitle(title: 'PERSONAL RECIENTE'),
            ),
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DashboardRecentEmployees(),
            ),

            const SizedBox(height: 28),

            // ── Accesos rápidos ───────────────────────────────────────────────
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DashboardSectionTitle(title: 'ACCESOS RÁPIDOS'),
            ),
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DashboardQuickActions(),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}