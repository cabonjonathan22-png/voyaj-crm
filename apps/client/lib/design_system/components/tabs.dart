import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../tokens/dimensions.dart';
import 'pressable.dart';

/// Onglet d'une [VTabBar].
@immutable
final class VTab {
  const VTab(this.label, {this.icon, this.count});

  final String label;
  final IconData? icon;

  /// Nombre affiché à côté du libellé (masqué si `null`).
  final int? count;
}

/// Barre d'onglets soulignés (sections d'une fiche).
class VTabBar extends StatelessWidget {
  const VTabBar({
    super.key,
    required this.tabs,
    required this.index,
    required this.onChanged,
  });

  final List<VTab> tabs;
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: VSpace.x4),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: c.border)),
      ),
      child: Row(
        children: [
          for (final (i, tab) in tabs.indexed)
            Pressable(
              onPressed: () => onChanged(i),
              semanticLabel: tab.label,
              builder: (context, s) {
                final active = i == index;
                return AnimatedContainer(
                  duration: VMotion.fast,
                  margin: const EdgeInsets.only(right: VSpace.x1),
                  padding: const EdgeInsets.symmetric(horizontal: VSpace.x2),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: active
                            ? c.accent
                            : s.hovered
                            ? c.borderStrong
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    color: s.focused ? c.surfaceHover : Colors.transparent,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (tab.icon != null) ...[
                        Icon(
                          tab.icon,
                          size: 14,
                          color: active ? c.text : c.textMuted,
                        ),
                        const SizedBox(width: VSpace.x1_5),
                      ],
                      Text(
                        tab.label,
                        style: t.bodyStrong.copyWith(
                          color: active ? c.text : c.textMuted,
                        ),
                      ),
                      if (tab.count != null) ...[
                        const SizedBox(width: VSpace.x1_5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: active ? c.accentSubtle : c.backgroundSubtle,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${tab.count}',
                            style: t.caption.copyWith(
                              color: active ? c.accentText : c.textSubtle,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
