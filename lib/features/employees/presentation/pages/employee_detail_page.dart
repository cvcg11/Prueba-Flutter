import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';
import 'package:practica_flutter/features/employees/data/services/employee_service.dart';
import 'package:practica_flutter/features/employees/domain/entities/employee_entity.dart';
import 'package:practica_flutter/features/employees/domain/repositories/employee_repository.dart';

class EmployeeDetailPage extends StatefulWidget {
  final String id;

  const EmployeeDetailPage({super.key, required this.id});

  @override
  State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> {
  final EmployeeRepository _repo = EmployeeService();
  late Future<EmployeeEntity> _employeeFuture;

  @override
  void initState() {
    super.initState();
    _employeeFuture = _repo.getEmployeeById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETALLE DE EMPLEADO'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.divider, height: 1),
        ),
      ),
      body: FutureBuilder<EmployeeEntity>(
        future: _employeeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: theme.colorScheme.error,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar el empleado',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(snapshot.error.toString()),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _employeeFuture = _repo.getEmployeeById(widget.id);
                      });
                    },
                    child: const Text('REINTENTAR'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No se encontraron datos.'));
          }

          final employee = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'PERFIL DE: ',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      TextSpan(
                        text: employee.fullName.toUpperCase(),
                        style: const TextStyle(color: AppColors.primaryLight),
                      ),
                      TextSpan(
                        text:
                            ' (${employee.status.toUpperCase() == 'ACTIVE' ? 'ACTIVO' : 'INACTIVO'})',
                        style: TextStyle(
                          color: employee.status == 'ACTIVE'
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                  style: theme.textTheme.headlineLarge?.copyWith(
                    letterSpacing: 1.5,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'REVISIÓN DE LOS DATOS TÉCNICOS Y PERSONALES DEL COLABORADOR.',
                  style: theme.textTheme.labelLarge,
                ),
                const SizedBox(height: 32),
                _buildSection(
                  title: 'IDENTIFICACIÓN PERSONAL',
                  children: [
                    _buildInfoField(
                      label: 'Nombre completo',
                      value: employee.fullName,
                    ),
                    _buildInfoField(
                      label: 'Documento de identidad (DUI)',
                      value: employee.dui,
                    ),
                  ],
                ),
                _buildSection(
                  title: 'CANALES DE COMUNICACIÓN',
                  children: [
                    _buildInfoField(
                      label: 'Correo corporativo',
                      value: employee.email,
                    ),
                    _buildInfoField(
                      label: 'Número de teléfono',
                      value: employee.phone,
                    ),
                  ],
                ),
                _buildSection(
                  title: 'ACCESO AL SISTEMA',
                  children: [
                    _buildInfoField(
                      label: 'Nombre de usuario',
                      value: employee.username,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
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
            for (int i = 0; i < children.length; i++) ...[
              children[i],
              if (i < children.length - 1) ...[
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

  Widget _buildInfoField({required String label, required String value}) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
