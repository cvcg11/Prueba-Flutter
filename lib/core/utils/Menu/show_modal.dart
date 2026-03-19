import 'package:flutter/material.dart';
import 'package:practica_flutter/core/theme/app_colors.dart';
import 'package:practica_flutter/core/utils/Menu/menu_option.dart';

class ShowModal {
  static void showOptionsSheet({
    required BuildContext context,
    required String title,
    required List<SheetOption> options,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface, // Usamos el gris oscuro de la paleta
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // 2. Título de la sección
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 20),
              // 3. Mapeo de opciones
              ...options
                  .map((option) => _buildOptionTile(context, option))
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildOptionTile(BuildContext context, SheetOption option) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.pop(context); // Cerramos el menú
          option.onTap(); // Ejecutamos la acción
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.secondary, // Fondo oscuro de la opción
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(option.icon, color: option.color ?? AppColors.textPrimary),
              const SizedBox(width: 16),
              Text(
                option.label.toUpperCase(),
                style: TextStyle(
                  color: option.color ?? AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
