import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_theme.dart';
import 'package:practica_flutter/features/employees/presentation/pages/employees_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practica Flutter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: EmployeesPage(),
    );
  }
}
