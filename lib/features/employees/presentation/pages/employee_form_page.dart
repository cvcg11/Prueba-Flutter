import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';
import 'package:practica_flutter/core/utils/Menu/alert.dart';
import 'package:practica_flutter/core/widgets/custom_button.dart';
import 'package:practica_flutter/core/widgets/custom_input_field.dart';
import 'package:practica_flutter/features/employees/data/services/employee_service.dart';
import 'package:practica_flutter/features/employees/domain/entities/employee_entity.dart';
import 'package:practica_flutter/features/employees/domain/repositories/employee_repository.dart';
import 'package:practica_flutter/features/employees/presentation/widgets/employee_form_header.dart';
import 'package:practica_flutter/features/employees/presentation/widgets/employee_form_section.dart';

class EmployeeFormPage extends StatefulWidget {
  final EmployeeEntity? employee;

  const EmployeeFormPage({super.key, this.employee});

  @override
  State<EmployeeFormPage> createState() => _EmployeeFormPageState();
}

class _EmployeeFormPageState extends State<EmployeeFormPage> {
  final _fullNameCtrl = TextEditingController();
  final _duiCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _userCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  final EmployeeRepository _repo = EmployeeService();

  bool get _isEditing => widget.employee != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _fullNameCtrl.text = widget.employee!.fullName;
      _duiCtrl.text = widget.employee!.dui;
      _emailCtrl.text = widget.employee!.email;
      _phoneCtrl.text = widget.employee!.phone;
      _userCtrl.text = widget.employee!.username;
    }
  }

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _duiCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _userCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveEmployee() async {
    final employeeData = EmployeeEntity(
      id: widget.employee?.id ?? '',
      fullName: _fullNameCtrl.text,
      dui: _duiCtrl.text,
      email: _emailCtrl.text,
      phone: _phoneCtrl.text,
      username: _userCtrl.text,
      password: _passwordCtrl.text,
      status: widget.employee?.status ?? 'ACTIVE',
    );

    try {
      if (_isEditing) {
        await _repo.updateEmployee(widget.employee!.id, employeeData);
      } else {
        await _repo.addEmployee(employeeData);
      }
      if (mounted) {
        Navigator.pop(context, true);
        Alert.show(
          context,
          message: _isEditing
              ? '¡Datos actualizados correctamente!'
              : '¡Empleado guardado con éxito!',
          isError: false,
        );
      }
    } catch (e) {
      if (mounted) Alert.show(context, message: e.toString(), isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'ACTUALIZAR DATOS' : 'REGISTRO TÉCNICO'),
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
            EmployeeFormHeader(isEditing: _isEditing),
            const SizedBox(height: 32),
            EmployeeFormSection(
              title: 'IDENTIFICACIÓN PERSONAL',
              children: [
                CustomInputField(
                  label: 'NOMBRE COMPLETO',
                  controller: _fullNameCtrl,
                ),
                CustomInputField(
                  label: 'DOCUMENTO DE IDENTIDAD (DUI)',
                  controller: _duiCtrl,
                ),
              ],
            ),
            EmployeeFormSection(
              title: 'CANALES DE COMUNICACIÓN',
              children: [
                CustomInputField(
                  label: 'CORREO CORPORATIVO',
                  controller: _emailCtrl,
                ),
                CustomInputField(
                  label: 'NÚMERO DE TELÉFONO',
                  controller: _phoneCtrl,
                ),
              ],
            ),
            EmployeeFormSection(
              title: 'ACCESO AL SISTEMA',
              children: [
                CustomInputField(
                  label: 'NOMBRE DE USUARIO',
                  controller: _userCtrl,
                ),
                if (!_isEditing)
                  CustomInputField(
                    label: 'CONTRASEÑA',
                    controller: _passwordCtrl,
                    obscureText: true,
                    icon: Icons.visibility_outlined,
                  ),
              ],
            ),
            const SizedBox(height: 32),
            CustomButton(
              label: _isEditing ? 'GUARDAR CAMBIOS' : 'REGISTRAR OPERARIO',
              onPressed: _saveEmployee,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
