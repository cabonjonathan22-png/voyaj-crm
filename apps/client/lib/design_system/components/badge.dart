import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../tokens/colors.dart';
import '../tokens/dimensions.dart';

/// Pastille de statut ou d'étiquette.
class VBadge extends StatelessWidget {
  const VBadge(
    this.label, {
    super.key,
    this.tone = VTone.neutral,
    this.icon,
    this.dotColor,
  });

  final String label;
  final VTone tone;
  final IconData? icon;

  /// Point de couleur libre (ex. couleur d'un tag).
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final fg = c.toneColor(tone);
    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: c.toneBackground(tone),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotColor != null) ...[
            ColorDot(dotColor!, size: 7),
            const SizedBox(width: 5),
          ] else if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: VSpace.x1),
          ],
          Text(label, style: context.text.caption.copyWith(color: fg)),
        ],
      ),
    );
  }
}

/// Point de couleur.
class ColorDot extends StatelessWidget {
  const ColorDot(this.color, {super.key, this.size = 10});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
    ),
  );
}

/// Convertit `#RRGGBB` en couleur (gris si invalide).
Color parseHexColor(String hex) {
  final value = int.tryParse(hex.replaceFirst('#', ''), radix: 16);
  return value == null ? const Color(0xFF94A3B8) : Color(0xFF000000 | value);
}
