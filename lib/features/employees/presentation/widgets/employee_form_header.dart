import 'package:flutter/material.dart';

class EmployeeFormHeader extends StatelessWidget {
  final bool isEditing;

  const EmployeeFormHeader({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEditing ? 'EDICIÓN DE PERFIL' : 'ALTA DE OPERARIO',
          style: theme.textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          isEditing
              ? 'MODIFIQUE LOS DATOS DEL PERSONAL SEGÚN SEA NECESARIO.'
              : 'INGRESE LOS DATOS TÉCNICOS PARA LA CREACIÓN DEL PERFIL DE ACCESO AL TALLER.',
          style: theme.textTheme.labelLarge,
        ),
      ],
    );
  }
}
