import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';
import 'package:practica_flutter/core/utils/Menu/alert.dart';
import 'package:practica_flutter/core/utils/Menu/menu_option.dart';
import 'package:practica_flutter/core/utils/Menu/show_modal.dart';
import 'package:practica_flutter/core/widgets/custom_button.dart';
import 'package:practica_flutter/core/widgets/employee_list_tile.dart';
import 'package:practica_flutter/features/employees/data/services/employee_service.dart';
import 'package:practica_flutter/features/employees/domain/repositories/employee_repository.dart';
import 'package:practica_flutter/features/employees/domain/entities/employee_entity.dart';
import 'package:practica_flutter/features/employees/presentation/pages/employee_detail_page.dart';
import 'package:practica_flutter/features/employees/presentation/pages/employee_form_page.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  final EmployeeRepository employeeRepository = EmployeeService();
  Future<List<EmployeeEntity>>? _employeesFuture;

  @override
  void initState() {
    super.initState();
    _refreshEmployees();
  }

  void _refreshEmployees() {
    setState(() {
      _employeesFuture = employeeRepository.getEmployees();
    });
  }

  void _viewEmployees(BuildContext context, EmployeeEntity employee) {
    ShowModal.showOptionsSheet(
      context: context,
      title: 'Opciones de ${employee.fullName}',
      options: employeeOptions(employee),
    );
  }

  void _updateStatus(EmployeeEntity employee) async {
    final isActive = employee.status == 'ACTIVE';
    final newStatus = isActive ? 'INACTIVE' : 'ACTIVE';
    try {
      await employeeRepository.updateStatus(employee.id, newStatus);
      if (!mounted) return;
      _refreshEmployees();
      Alert.show(context, message: 'Estado actualizado', isError: false);
    } catch (e) {
      Alert.show(context, message: 'Error: $e');
    }
  }

  List<SheetOption> employeeOptions(EmployeeEntity employee) {
    final isActive = employee.status == 'ACTIVE';
    return [
      SheetOption(
        label: 'Ver Detalle',
        icon: Icons.visibility_outlined,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeDetailPage(id: employee.id),
            ),
          );
        },
      ),
      SheetOption(
        label: 'Actualizar',
        icon: Icons.edit_outlined,
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeFormPage(employee: employee),
            ),
          );
          if (result == true) {
            _refreshEmployees();
          }
        },
      ),
      SheetOption(
        label: isActive ? 'Desactivar' : 'Activar',
        icon: isActive ? Icons.block_flipped : Icons.check_circle_outline,
        color: isActive ? AppColors.error : AppColors.primaryLight,
        onTap: () => _updateStatus(employee),
      ),
    ];
  }

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
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ADMINISTRACIÓN',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.primaryLight,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'PERSONAL',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<EmployeeEntity>>(
              future: _employeesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: AppColors.error,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${snapshot.error}',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            label: 'Reintentar',
                            onPressed: _refreshEmployees,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final employees = snapshot.data ?? [];

                if (employees.isEmpty) {
                  return const Center(
                    child: Text('No hay empleados registrados.'),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => _refreshEmployees(),
                  child: ListView.builder(
                    itemCount: employees.length,
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      final employee = employees[index];
                      return EmployeeListTile(
                        name: employee.fullName,
                        phone: employee.phone,
                        onTap: () => _viewEmployees(context, employee),
                      );
                    },
                  ),
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
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EmployeeFormPage()),
            );

            if (result == true) {
              _refreshEmployees();
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.build_outlined), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.computer), label: ''),
        ],
      ),
    );
  }
}
