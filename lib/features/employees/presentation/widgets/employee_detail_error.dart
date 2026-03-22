import 'package:flutter/material.dart';

class EmployeeDetailError extends StatelessWidget {
  final Object? error;
  final VoidCallback onRetry;

  const EmployeeDetailError({
    super.key,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: theme.colorScheme.error, size: 60),
          const SizedBox(height: 16),
          Text(
            'Error al cargar el empleado',
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(error.toString()),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: onRetry, child: const Text('REINTENTAR')),
        ],
      ),
    );
  }
}
