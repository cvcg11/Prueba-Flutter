import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum NavItem { dashboard, employees, messages, inventory, profile }

class CustomBottomNavBar extends StatefulWidget {
  final NavItem currentItem;
  final ValueChanged<NavItem> onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.currentItem,
    required this.onItemSelected,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with SingleTickerProviderStateMixin {
  static const double _barHeight = 72;
  static const double _circleSize = 54;
  static const double _circleElevation = 20; // cuánto sube sobre la barra

  late AnimationController _controller;
  late Animation<double> _circleX;
  double _lastX = -1;

  IconData _iconOf(NavItem item) {
    switch (item) {
      case NavItem.dashboard:  return Icons.home_outlined;
      case NavItem.employees:  return Icons.people_outline;
      case NavItem.messages:   return Icons.chat_bubble_outline;
      case NavItem.inventory:  return Icons.calendar_today_outlined;
      case NavItem.profile:    return Icons.person_outline;
    }
  }

  double _centerXOf(int slot, double totalWidth) {
    final slotW = totalWidth / NavItem.values.length;
    return slotW * slot + slotW / 2;
  }

  void _slideToSlot(int slot, double totalWidth) {
    final from = _circleX.value > 0 ? _circleX.value : _centerXOf(slot, totalWidth);
    final to = _centerXOf(slot, totalWidth);
    _circleX = Tween<double>(begin: from, end: to).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
    _controller.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _circleX = Tween<double>(begin: 0, end: 0).animate(_controller);
  }

  @override
  void didUpdateWidget(CustomBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentItem != widget.currentItem) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final w = context.size?.width ?? 400;
        _slideToSlot(NavItem.values.indexOf(widget.currentItem), w);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final currentSlot = NavItem.values.indexOf(widget.currentItem);
        final initX = _centerXOf(currentSlot, totalWidth);

        // Primera vez: posiciona sin animación
        if (_lastX < 0) {
          _lastX = initX;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            setState(() {
              _circleX = Tween<double>(begin: initX, end: initX)
                  .animate(_controller);
            });
          });
        }

        final circleTop = 0.0;

        return SizedBox(
          height: _barHeight + _circleElevation,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // ── Barra con notch cóncavo ──────────────────────────────────
              Positioned(
                top: _circleElevation,
                left: 0,
                right: 0,
                child: AnimatedBuilder(
                  animation: _circleX,
                  builder: (context, _) {
                    final cx = _circleX.value > 0 ? _circleX.value : initX;
                    return SizedBox(
                      height: _barHeight,
                      child: CustomPaint(
                        painter: _ConcaveBarPainter(
                          waveX: cx,
                          totalWidth: totalWidth,
                          barHeight: _barHeight,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ── Ítems de la barra (íconos + labels) ─────────────────────
              Positioned(
                top: _circleElevation,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: _barHeight,
                  child: Row(
                    children: NavItem.values.map((item) {
                      final isActive = widget.currentItem == item;
                      return Expanded(
                        child: InkWell(
                          onTap: () => widget.onItemSelected(item),
                          borderRadius: BorderRadius.circular(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // El ícono activo queda "debajo" del círculo
                              // visualmente — el círculo lo cubre con su color
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: isActive ? 0.0 : 1.0,
                                child: Icon(
                                  _iconOf(item),
                                  size: 22,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.name.toUpperCase(),
                                style: TextStyle(
                                  fontFamily: 'SpaceGrotesk',
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  color: isActive
                                      ? AppColors.primaryLight
                                      : AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // ── Círculo verde deslizante con ícono del ítem activo ───────
              AnimatedBuilder(
                animation: _circleX,
                builder: (context, _) {
                  final cx = _circleX.value > 0 ? _circleX.value : initX;
                  return Positioned(
                    top: circleTop,
                    left: cx - _circleSize / 2,
                    child: IgnorePointer(
                      ignoring: true,
                      child: Container(
                        width: _circleSize,
                        height: _circleSize,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.background,
                            width: 3,
                          ),
                        ),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              _iconOf(widget.currentItem),
                              key: ValueKey(widget.currentItem),
                              color: AppColors.primaryLight,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Painter: barra con notch cóncavo centrado en waveX
// ─────────────────────────────────────────────────────────────────────────────
class _ConcaveBarPainter extends CustomPainter {
  final double waveX;
  final double totalWidth;
  final double barHeight;

  static const double _bumpW = 52;
  static const double _bumpH = 26;

  const _ConcaveBarPainter({
    required this.waveX,
    required this.totalWidth,
    required this.barHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.surface
      ..style = PaintingStyle.fill;

    final border = Paint()
      ..color = AppColors.divider
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final cx = waveX;
    final x0 = cx - _bumpW;
    final x1 = cx + _bumpW;

    // Curva cóncava: baja en el centro creando el "hueco" para el círculo
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(x0, 0)
      ..cubicTo(x0 + _bumpW * 0.4, 0, x0 + _bumpW * 0.4, _bumpH, cx, _bumpH)
      ..cubicTo(x1 - _bumpW * 0.4, _bumpH, x1 - _bumpW * 0.4, 0, x1, 0)
      ..lineTo(totalWidth, 0)
      ..lineTo(totalWidth, barHeight)
      ..lineTo(0, barHeight)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, border);
  }

  @override
  bool shouldRepaint(_ConcaveBarPainter old) =>
      old.waveX != waveX || old.totalWidth != totalWidth;
}