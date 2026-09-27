import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/app_theme.dart';
import '../tokens/dimensions.dart';
import 'badge.dart';
import 'pressable.dart';

/// Puce (tag appliqué, filtre) avec point de couleur et bouton de retrait
/// facultatifs.
class VChip extends StatelessWidget {
  const VChip(
    this.label, {
    super.key,
    this.color,
    this.icon,
    this.onPressed,
    this.onRemove,
  });

  final String label;
  final Color? color;
  final IconData? icon;
  final VoidCallback? onPressed;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    return Pressable(
      onPressed: onPressed,
      semanticLabel: label,
      builder: (context, s) => AnimatedContainer(
        duration: VMotion.fast,
        height: 24,
        padding: EdgeInsets.only(
          left: VSpace.x2,
          right: onRemove == null ? VSpace.x2 : 2,
        ),
        decoration: BoxDecoration(
          color: s.hovered ? c.surfaceHover : c.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: s.focused ? c.focusRing : c.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (color != null) ...[
              ColorDot(color!, size: 8),
              const SizedBox(width: VSpace.x1_5),
            ] else if (icon != null) ...[
              Icon(icon, size: 12, color: c.textMuted),
              const SizedBox(width: VSpace.x1_5),
            ],
            Text(label, style: t.small.copyWith(color: c.text)),
            if (onRemove != null)
              Pressable(
                onPressed: onRemove,
                semanticLabel: 'Retirer $label',
                builder: (context, rs) => Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.only(left: 2),
                  decoration: BoxDecoration(
                    color: rs.hovered ? c.backgroundSubtle : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(LucideIcons.x, size: 12, color: c.textSubtle),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
