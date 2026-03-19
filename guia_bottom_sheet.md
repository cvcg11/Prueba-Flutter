# 📱 Guía: Creación de Menús Desplegables Reutilizables (Bottom Sheet)

Para lograr el menú de la imagen de forma elegante y reutilizable en Flutter, seguiremos estos pasos. Usaremos el modelo `SheetOption` que ya definiste.

---

## 1. El Concepto: `showModalBottomSheet`

En Flutter, los menús que suben desde abajo se activan con una función integrada llamada `showModalBottomSheet`. Esta función necesita:
1.  **Context**: El contexto de la pantalla actual.
2.  **Builder**: Una función que retorna los widgets que se verán dentro del menú.

---

## 2. Paso a Paso para la Construcción

### Paso A: Crear el Contenedor Reutilizable
No queremos repetir el diseño en cada pantalla. Lo mejor es crear una **Función Estática** o un **Helper** que reciba la lista de opciones.

**Ubicación sugerida**: `lib/core/utils/ui_helpers.dart` (o donde prefieras tus utilidades).

```dart
static void showOptionsSheet({
  required BuildContext context,
  required String title,
  required List<SheetOption> options,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.surface, // Usamos el gris oscuro de tu paleta
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Importante: que solo ocupe el espacio necesario
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // 1. Línea decorativa superior (Handle)
             Center(
               child: Container(
                 width: 40, height: 4,
                 margin: const EdgeInsets.only(bottom: 20),
                 decoration: BoxDecoration(
                   color: AppColors.divider, 
                   borderRadius: BorderRadius.circular(2),
                 ),
               ),
             ),
             // 2. Título de la sección
             Text(title.toUpperCase(), style: Theme.of(context).textTheme.labelLarge),
             const SizedBox(height: 20),
             // 3. Mapeo de opciones
             ...options.map((option) => _buildOptionTile(context, option)).toList(),
          ],
        ),
      );
    },
  );
}
```

### Paso B: Construir la "Fila" de Opción
Cada opción del menú debe verse como un botón oscuro con icono y texto.

```dart
static Widget _buildOptionTile(BuildContext context, SheetOption option) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: InkWell(
      onTap: () {
        Navigator.pop(context); // Cerramos el menú
        option.onTap();         // Ejecutamos la acción
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
```

---

## 3. Cómo Consumirlo (Ejemplo: Empleados)

Cuando quieras usarlo en tu `EmployeesPage`, solo tienes que definir la lista de acciones y llamar al helper:

```dart
// 1. Definimos las opciones para este apartado
final opcionesEmpleado = [
  SheetOption(
    label: 'Ver Detalle',
    icon: Icons.visibility_outlined,
    onTap: () => print('Navegando a detalle...'),
  ),
  SheetOption(
    label: 'Actualizar',
    icon: Icons.edit_outlined,
    onTap: () => print('Editando...'),
  ),
  SheetOption(
    label: 'Desactivar',
    icon: Icons.block_flipped,
    color: AppColors.error, // Usamos el rojo de tu diseño
    onTap: () => print('Desactivando...'),
  ),
];

// 2. Lo disparamos al tocar el icono de "mást" (...)
IconButton(
  icon: Icon(Icons.more_vert),
  onPressed: () {
    UIHelpers.showOptionsSheet(
      context: context,
      title: 'Opciones de Empleado',
      options: opcionesEmpleado,
    );
  },
)
```

---

## 4. Por qué hacerlo así
1.  **Desacoplamiento**: La interfaz del menú no sabe qué hace el botón "Actualizar", solo sabe dibujarlo.
2.  **Mantenibilidad**: Si mañana quieres que los bordes sean más redondos, cambias UN solo archivo (`ui_helpers.dart`) y se actualiza en toda la app.
3.  **Velocidad**: Para crear el menú de "Inventario", solo cambias el array de `SheetOption` y listo.

> [!TIP]
> Fíjate que en la imagen, el menú tiene un fondo translúcido detrás (el `barrier`). Flutter lo hace por ti automáticamente al llamar a `showModalBottomSheet`.
