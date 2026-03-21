# 🚀 Guía de Desarrollo: Flutter + Arquitectura Profesional

Esta guía está diseñada para que **tú** construyas la aplicación paso a paso, aplicando los conceptos de arquitectura y el UI Kit que hemos configurado.

---

## 🏗️ 1. Arquitectura: Feature-First

Cada vez que crees un apartado nuevo (ej. Inventario, Sistemas), crea esta estructura de carpetas:

```text
lib/features/nombre_apartado/
├── data/           # (Modelos de la API de Spring)
├── domain/         # (Entidades de lógica de negocio)
└── presentation/   # (Interfaz y Estado)
    ├── pages/      # Pantallas completas
    └── widgets/    # Micro-widgets exclusivos de este apartado
```

---

## 🛠️ 2. Comandos de Rescate (Si la app no corre)

Si tienes errores al instalar en el emulador (`Uninstalling old version failed`):

1.  **Desinstala manualmente**: En el emulador, mantén presionada la app y dale a "Uninstall".
2.  **Limpieza profunda**: Ejecuta `flutter clean` en la terminal.
3.  **Reinstalar**: Ejecuta `flutter run` de nuevo.

---

## 🏗️ 3. Tutorial: Cómo construir un Apartado (Ej. Empleados)

No queremos código estático, queremos que entiendas el orden de construcción:

### Paso 1: Definir la Página Base
Crea el archivo en `presentation/pages/employees_page.dart`. Empieza con un `Scaffold` vacío.

```dart
class EmployeesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EMPLEADOS')),
      body: Container(), // Aquí irá tu contenido
    );
  }
}
```

### Paso 2: Usar el UI Kit (Consistencia)
En lugar de crear botones o tarjetas desde cero, **TÚ** debes llamar a los componentes compartidos:

*   **Para listas**: Usa `EmployeeListTile(name: "...", phone: "...")`.
*   **Para botones**: Usa `CustomButton(label: "...", onPressed: () {})`.
*   **Para colores**: Usa `AppColors.primaryLight` o `AppColors.textSecondary`.

### Paso 3: Tipografía y Espaciado
Usa el sistema de temas para que los textos se vean profesionales:
```dart
Text(
  'ADMINISTRACIÓN',
  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.primaryLight),
)
```

---

## 📦 4. El UI Kit a tu disposición

| Componente | Qué hace | Dónde está |
| :--- | :--- | :--- |
| `CustomButton` | Botón con estados de carga y 4 variantes. | `lib/core/widgets/` |
| `CustomCard` | Tarjeta con el radio y bordes sutiles del diseño. | `lib/core/widgets/` |
| `EmployeeListTile` | El diseño de fila con avatar y botón lateral. | `lib/core/widgets/` |
| `DetailItem` | Estilo para campos de ficha técnica (Label + Valor). | `lib/core/widgets/` |

---

---

## 🌐 5. Configuración de Red (Conexión al Backend)

Para que tu app se comunique con el servidor Spring en tu computadora, la configuración depende de dónde estés ejecutando la app:

### A. En Emulador/Simulador Local
Usa la IP especial que Google creó para apuntar a tu "localhost":
- **URL**: `http://10.0.2.2:8080/api`

### B. En Dispositivo Físico (Recomendado: ADB Reverse)
Si conectas tu celular por USB, puedes hacer que `localhost` funcione ejecutando un comando en tu PC:
1.  **Comando**: `adb reverse tcp:8080 tcp:8080`
2.  **URL en Código**: `http://localhost:8080/api`
*Nota: Este método también funciona en el emulador y es el más estable.*

### C. Por Wi-Fi (Sin Cables)
Ambos deben estar en la misma red Wi-Fi:
1.  **Busca tu IP**: Ejecuta `ipconfig` en Windows (ej. `192.168.0.13`).
2.  **URL en Código**: `http://192.168.0.13:8080/api`

> [!IMPORTANT]
> Si usas el método **B (ADB Reverse)**, puedes mantener `localhost` en tu código y funcionará tanto en el celular físico como en el emulador, siempre y cuando el comando `adb reverse` esté activo.

---

## 🔄 6. Tu Flujo de Aprendizaje

1.  **Modifica**: Abre `employees_page.dart` e intenta cambiar el orden de los elementos o agregar un nuevo `EmployeeListTile`.
2.  **Crea**: Intenta crear una nueva carpeta `lib/features/inventory/` y replica la estructura.
3.  **Conecta**: Cuando estés listo, te enseñaré a crear el `EmployeeModel` para recibir los datos reales de tu JSON de Spring.

> [!TIP]
> Si quieres que un apartado se llame distinto, cámbiale el nombre a la Clase y al archivo. Lo importante es que la estructura en `lib/features/` sea semántica.
