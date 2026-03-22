import 'package:flutter/material.dart';
import 'package:practica_flutter/core/widgets/custom_bottom_nav_bar.dart';
import 'package:practica_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:practica_flutter/features/employees/presentation/pages/employees_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  NavItem _currentItem = NavItem.dashboard;

  final List<Widget> _pages = const [
    DashboardPage(),
    EmployeesPage(),
    Scaffold(body: Center(child: Text('Messages'))),
    Scaffold(body: Center(child: Text('Inventory'))),
    Scaffold(body: Center(child: Text('Profile'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: NavItem.values.indexOf(_currentItem),
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentItem: _currentItem,
        onItemSelected: (item) => setState(() => _currentItem = item),
      ),
    );
  }
}