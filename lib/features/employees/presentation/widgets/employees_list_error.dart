import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';
import 'package:practica_flutter/core/widgets/custom_button.dart';

class EmployeesListError extends StatelessWidget {
  final Object? error;
  final VoidCallback onRetry;

  const EmployeesListError({
    super.key,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 48),
            const SizedBox(height: 16),
            Text('Error: $error', textAlign: TextAlign.center),
            const SizedBox(height: 16),
            CustomButton(label: 'Reintentar', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
