import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Deux panneaux côte à côte séparés par une poignée redimensionnable.
/// Double-clic sur la poignée : largeur par défaut.
class VSplitView extends StatefulWidget {
  const VSplitView({
    super.key,
    required this.primary,
    required this.secondary,
    this.showSecondary = true,
    this.initialSecondaryWidth = 380,
    this.minSecondaryWidth = 280,
    this.maxSecondaryFraction = 0.6,
    this.onSecondaryWidthChanged,
  });

  final Widget primary;
  final Widget secondary;
  final bool showSecondary;
  final double initialSecondaryWidth;
  final double minSecondaryWidth;
  final double maxSecondaryFraction;
  final ValueChanged<double>? onSecondaryWidthChanged;

  @override
  State<VSplitView> createState() => _VSplitViewState();
}

class _VSplitViewState extends State<VSplitView> {
  late double _width = widget.initialSecondaryWidth;
  bool _hovered = false;
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return LayoutBuilder(
      builder: (context, constraints) {
        final max = constraints.maxWidth * widget.maxSecondaryFraction;
        final width = _width.clamp(widget.minSecondaryWidth, max);
        if (!widget.showSecondary) return widget.primary;
        return Row(
          children: [
            Expanded(child: widget.primary),
            MouseRegion(
              cursor: SystemMouseCursors.resizeColumn,
              onEnter: (_) => setState(() => _hovered = true),
              onExit: (_) => setState(() => _hovered = false),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragStart: (_) => setState(() => _dragging = true),
                onHorizontalDragUpdate: (d) => setState(
                  () => _width = (width - d.delta.dx).clamp(
                    widget.minSecondaryWidth,
                    max,
                  ),
                ),
                onHorizontalDragEnd: (_) {
                  setState(() => _dragging = false);
                  widget.onSecondaryWidthChanged?.call(_width);
                },
                onDoubleTap: () {
                  setState(() => _width = widget.initialSecondaryWidth);
                  widget.onSecondaryWidthChanged?.call(_width);
                },
                child: SizedBox(
                  width: 5,
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 120),
                      width: _hovered || _dragging ? 2 : 1,
                      color: _hovered || _dragging ? c.accent : c.border,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: width, child: widget.secondary),
          ],
        );
      },
    );
  }
}
