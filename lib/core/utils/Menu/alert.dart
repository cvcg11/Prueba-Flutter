import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class Alert {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = true,
  }) {
    final color = isError
        ? Color(0xFFE9967A)
        : AppColors.primaryLight; // Color salmón/naranja

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF1A1717), // Fondo muy oscuro
            borderRadius: BorderRadius.circular(4),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Borde lateral de color
                Container(width: 6, color: color),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          isError
                              ? Icons.warning_amber_rounded
                              : Icons.check_circle_outline,
                          color: color,
                          size: 40,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.toUpperCase(),
                                style: TextStyle(
                                  color: color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.1,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'ENTENDIDO',
                                    style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
