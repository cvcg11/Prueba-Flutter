import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';
import 'package:practica_flutter/core/utils/Menu/Alert.dart';
import 'package:practica_flutter/core/widgets/custom_button.dart';
import 'package:practica_flutter/core/widgets/custom_input_field.dart';
import 'package:practica_flutter/features/employees/data/services/employee_service.dart';
import 'package:practica_flutter/features/employees/domain/entities/employee_entity.dart';
import 'package:practica_flutter/features/employees/domain/repositories/employee_repository.dart';

class EmployeeFormPage extends StatefulWidget {
  final EmployeeEntity? employee;
  const EmployeeFormPage({super.key, this.employee});
  @override
  State<EmployeeFormPage> createState() => _EmployeeFormPageState();
}

class _EmployeeFormPageState extends State<EmployeeFormPage> {
  final fullNameCtrl = TextEditingController();
  final duiCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final userCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final EmployeeRepository _repo = EmployeeService();

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      fullNameCtrl.text = widget.employee!.fullName;
      duiCtrl.text = widget.employee!.dui;
      emailCtrl.text = widget.employee!.email;
      phoneCtrl.text = widget.employee!.phone;
      userCtrl.text = widget.employee!.username;
    }
  }

  Future<void> _saveEmployee() async {
    final employeeData = EmployeeEntity(
      id: widget.employee?.id ?? '',
      fullName: fullNameCtrl.text,
      dui: duiCtrl.text,
      email: emailCtrl.text,
      phone: phoneCtrl.text,
      username: userCtrl.text,
      password: passwordCtrl.text,
      status: widget.employee?.status ?? 'ACTIVE',
    );

    try {
      if (widget.employee == null) {
        await _repo.addEmployee(employeeData);
      } else {
        await _repo.updateEmployee(widget.employee!.id, employeeData);
      }
      if (mounted) {
        Navigator.pop(context, true); // Retornamos true para indicar éxito
        Alert.show(
          context,
          message: widget.employee == null
              ? '¡Empleado guardado con éxito!'
              : '¡Datos actualizados correctamente!',
          isError: false,
        );
      }
    } catch (e) {
      if (mounted) {
        Alert.show(context, message: e.toString(), isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.employee != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'ACTUALIZAR DATOS' : 'REGISTRO TÉCNICO'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.divider, height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
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
            const SizedBox(height: 32),
            _buildSection(
              title: 'IDENTIFICACIÓN PERSONAL',
              children: [
                CustomInputField(
                  label: 'NOMBRE COMPLETO',
                  controller: fullNameCtrl,
                ),
                CustomInputField(
                  label: 'DOCUMENTO DE IDENTIDAD (DUI)',
                  controller: duiCtrl,
                ),
              ],
            ),
            _buildSection(
              title: 'CANALES DE COMUNICACIÓN',
              children: [
                CustomInputField(
                  label: 'CORREO CORPORATIVO',
                  controller: emailCtrl,
                ),
                CustomInputField(
                  label: 'NÚMERO DE TELÉFONO',
                  controller: phoneCtrl,
                ),
              ],
            ),
            _buildSection(
              title: 'ACCESO AL SISTEMA',
              children: [
                CustomInputField(
                  label: 'NOMBRE DE USUARIO',
                  controller: userCtrl,
                ),
                if (!isEditing)
                  CustomInputField(
                    label: 'CONTRASEÑA',
                    controller: passwordCtrl,
                    obscureText: true,
                    icon: Icons.visibility_outlined,
                  ),
              ],
            ),
            const SizedBox(height: 32),
            CustomButton(
              label: isEditing ? 'GUARDAR CAMBIOS' : 'REGISTRAR OPERARIO',
              onPressed: _saveEmployee,
            ),
            const SizedBox(height: 24),
          ],
        ),
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
        decoration: BoxDecoration(color: theme.cardTheme.color),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                color: AppColors.primaryLight,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            for (int i = 0; i < children.length; i++) ...[
              children[i],
              if (i < children.length - 1) const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}
