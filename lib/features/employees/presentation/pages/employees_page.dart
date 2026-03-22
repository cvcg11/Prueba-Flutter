import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';
import 'package:practica_flutter/core/utils/Menu/alert.dart';
import 'package:practica_flutter/core/utils/Menu/menu_option.dart';
import 'package:practica_flutter/core/utils/Menu/show_modal.dart';
import 'package:practica_flutter/core/widgets/custom_button.dart';
import 'package:practica_flutter/core/widgets/page_header.dart';
import 'package:practica_flutter/features/employees/data/services/employee_service.dart';
import 'package:practica_flutter/features/employees/domain/entities/employee_entity.dart';
import 'package:practica_flutter/features/employees/domain/repositories/employee_repository.dart';
import 'package:practica_flutter/features/employees/presentation/pages/employee_detail_page.dart';
import 'package:practica_flutter/features/employees/presentation/pages/employee_form_page.dart';
import 'package:practica_flutter/features/employees/presentation/widgets/employees_list.dart';
import 'package:practica_flutter/features/employees/presentation/widgets/employees_list_error.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  final EmployeeRepository _repo = EmployeeService();
  Future<List<EmployeeEntity>>? _employeesFuture;

  @override
  void initState() {
    super.initState();
    _refreshEmployees();
  }

  void _refreshEmployees() {
    setState(() {
      _employeesFuture = _repo.getEmployees();
    });
  }

  // ─── Navegación ────────────────────────────────────────────────────────────

  void _openDetail(EmployeeEntity employee) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EmployeeDetailPage(id: employee.id)),
    );
  }

  Future<void> _openEditForm(EmployeeEntity employee) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EmployeeFormPage(employee: employee)),
    );
    if (result == true) _refreshEmployees();
  }

  Future<void> _openAddForm() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EmployeeFormPage()),
    );
    if (result == true) _refreshEmployees();
  }

  // ─── Acciones ──────────────────────────────────────────────────────────────

  Future<void> _updateStatus(EmployeeEntity employee) async {
    final newStatus = employee.status == 'ACTIVE' ? 'INACTIVE' : 'ACTIVE';
    try {
      await _repo.updateStatus(employee.id, newStatus);
      if (!mounted) return;
      _refreshEmployees();
      Alert.show(context, message: 'Estado actualizado', isError: false);
    } catch (e) {
      if (mounted) Alert.show(context, message: 'Error: $e');
    }
  }

  void _showOptions(EmployeeEntity employee) {
    final isActive = employee.status == 'ACTIVE';
    ShowModal.showOptionsSheet(
      context: context,
      title: 'Opciones de ${employee.fullName}',
      options: [
        SheetOption(
          label: 'Ver Detalle',
          icon: Icons.visibility_outlined,
          onTap: () => _openDetail(employee),
        ),
        SheetOption(
          label: 'Actualizar',
          icon: Icons.edit_outlined,
          onTap: () => _openEditForm(employee),
        ),
        SheetOption(
          label: isActive ? 'Desactivar' : 'Activar',
          icon: isActive ? Icons.block_flipped : Icons.check_circle_outline,
          color: isActive ? AppColors.error : AppColors.primaryLight,
          onTap: () => _updateStatus(employee),
        ),
      ],
    );
  }

  // ─── Build ─────────────────────────────────────────────────────────────────

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(label: 'ADMINISTRACIÓN', title: 'PERSONAL'),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<EmployeeEntity>>(
              future: _employeesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return EmployeesListError(
                    error: snapshot.error,
                    onRetry: _refreshEmployees,
                  );
                }
                return EmployeesList(
                  employees: snapshot.data ?? [],
                  onTap: _showOptions,
                  onRefresh: () async => _refreshEmployees(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomButton(
          label: 'Agregar Personal',
          icon: Icons.add,
          onPressed: _openAddForm,
        ),
      ),
    );
  }
}
