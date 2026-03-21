import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final TextEditingController? controller;
  final IconData? icon;
  final bool obscureText;

  const CustomInputField({
    super.key,
    required this.label,
    this.initialValue,
    this.controller,
    this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            obscureText: obscureText,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'EJ: ${label.toUpperCase()}',
              hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(
                fontSize: 14,
              ),
              suffixIcon: icon != null
                  ? Icon(icon, size: 20, color: theme.colorScheme.primary)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
