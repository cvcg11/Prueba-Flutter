import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, tertiary, outlined }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isLoading;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: _buildButton(theme),
    );
  }

  Widget _buildButton(ThemeData theme) {
    if (type == ButtonType.outlined) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: theme.colorScheme.primary),
          foregroundColor: theme.colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: _buildContent(),
      );
    }

    Color bgColor;
    Color fgColor = theme.colorScheme.onPrimary;

    switch (type) {
      case ButtonType.secondary:
        bgColor = theme.colorScheme.secondary;
        fgColor = theme.colorScheme.onSecondary;
        break;
      case ButtonType.tertiary:
        bgColor = theme.colorScheme.error;
        fgColor = theme.colorScheme.onError;
        break;
      default:
        bgColor = theme.colorScheme.primary;
        fgColor = theme.colorScheme.onPrimary;
    }

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return bgColor.withValues(alpha: 0.5);
          return bgColor;
        }),
      ),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      );
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20),
          const SizedBox(width: 10),
        ],
        Text(label.toUpperCase(), 
          style: const TextStyle(
            letterSpacing: 1.1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
