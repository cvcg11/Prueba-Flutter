import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/employee_list_tile.dart';
import '../../../../core/theme/app_colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
            const EmployeeListTile(
              name: 'Ricardo Antonio Méndez',
              phone: '+503 7844-9821',
            ),
            const EmployeeListTile(
              name: 'Carla Sofía Valladares',
              phone: '+503 2241-8892',
            ),
            const EmployeeListTile(
              name: 'Marcos Daniel Estrada',
              phone: '+503 6108-3341',
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
