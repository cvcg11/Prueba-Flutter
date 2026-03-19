import 'package:flutter/material.dart';
import 'package:practica_flutter/core/utils/Menu/menu_option.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/employee_list_tile.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/Menu/show_modal.dart';

class EmployeesPage extends StatelessWidget {
  EmployeesPage({super.key});
  final opcionesEmpleado = [
    SheetOption(
      label: 'Ver Detalle',
      icon: Icons.visibility_outlined,
      onTap: () => print('Navegando a detalle...'),
    ),
    SheetOption(
      label: 'Actualizar',
      icon: Icons.edit_outlined,
      onTap: () => print('Editando...'),
    ),
    SheetOption(
      label: 'Desactivar',
      icon: Icons.block_flipped,
      color: AppColors.error, // Usamos el rojo de tu diseño
      onTap: () => print('Desactivando...'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('CGI.IMPORT'),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'ADMINISTRACIÓN',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: AppColors.primaryLight),
            ),
            const SizedBox(height: 8),
            Text('PERSONAL', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 24),
            EmployeeListTile(
              name: 'Ricardo Antonio Méndez',
              phone: '+503 7844-9821',
              onTap: () {
                ShowModal.showOptionsSheet(
                  context: context,
                  title: 'Opciones de Empleado',
                  options: opcionesEmpleado,
                );
              },
            ),
            EmployeeListTile(
              name: 'Carla Sofía Valladares',
              phone: '+503 2241-8892',
              onTap: () {
                ShowModal.showOptionsSheet(
                  context: context,
                  title: 'Opciones de Empleado',
                  options: opcionesEmpleado,
                );
              },
            ),
            EmployeeListTile(
              name: 'Marcos Daniel Estrada',
              phone: '+503 6108-3341',
              onTap: () {
                ShowModal.showOptionsSheet(
                  context: context,
                  title: 'Opciones de Empleado',
                  options: opcionesEmpleado,
                );
              },
            ),
            const Spacer(),
            CustomButton(
              label: 'Agregar Personal',
              icon: Icons.add,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
          ],
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
