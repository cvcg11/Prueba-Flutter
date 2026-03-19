import 'package:flutter/material.dart';

class SheetOption {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  SheetOption({
    required this.label,
    required this.icon,
    required this.onTap,
    this.color,
  });
}
