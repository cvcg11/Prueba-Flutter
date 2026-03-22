import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';
import 'package:practica_flutter/features/employees/data/services/employee_service.dart';
import 'package:practica_flutter/features/employees/domain/entities/employee_entity.dart';
import 'package:practica_flutter/features/employees/domain/repositories/employee_repository.dart';
import 'package:practica_flutter/features/employees/presentation/widgets/employee_detail_error.dart';
import 'package:practica_flutter/features/employees/presentation/widgets/employee_info_section.dart';
import 'package:practica_flutter/features/employees/presentation/widgets/employee_profile_header.dart';

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
    _loadEmployee();
  }

  void _loadEmployee() {
    _employeeFuture = _repo.getEmployeeById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
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
            return EmployeeDetailError(
              error: snapshot.error,
              onRetry: () => setState(_loadEmployee),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No se encontraron datos.'));
          }

          return _EmployeeDetailBody(employee: snapshot.data!);
        },
      ),
    );
  }
}

class _EmployeeDetailBody extends StatelessWidget {
  final EmployeeEntity employee;

  const _EmployeeDetailBody({required this.employee});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EmployeeProfileHeader(employee: employee),
          const SizedBox(height: 8),
          Text(
            'REVISIÓN DE LOS DATOS TÉCNICOS Y PERSONALES DEL COLABORADOR.',
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 32),
          EmployeeInfoSection(
            title: 'IDENTIFICACIÓN PERSONAL',
            fields: [
              (label: 'Nombre completo', value: employee.fullName),
              (label: 'Documento de identidad (DUI)', value: employee.dui),
            ],
          ),
          EmployeeInfoSection(
            title: 'CANALES DE COMUNICACIÓN',
            fields: [
              (label: 'Correo corporativo', value: employee.email),
              (label: 'Número de teléfono', value: employee.phone),
            ],
          ),
          EmployeeInfoSection(
            title: 'ACCESO AL SISTEMA',
            fields: [(label: 'Nombre de usuario', value: employee.username)],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
