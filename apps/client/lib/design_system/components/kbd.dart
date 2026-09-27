import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Touche(s) de clavier affichée(s) (raccourcis). Les touches sont séparées
/// par des espaces : `Kbd('Ctrl K')`.
class Kbd extends StatelessWidget {
  const Kbd(this.keys, {super.key, this.onAccent = false});

  final String keys;
  final bool onAccent;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final parts = keys.split(' ');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final (i, key) in parts.indexed) ...[
          if (i > 0) const SizedBox(width: 3),
          Container(
            constraints: const BoxConstraints(minWidth: 18),
            height: 18,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: onAccent
                  ? Colors.white.withValues(alpha: 0.18)
                  : c.surfaceHover,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: onAccent
                    ? Colors.white.withValues(alpha: 0.25)
                    : c.border,
              ),
            ),
            child: Text(
              key,
              style: context.text.caption.copyWith(
                color: onAccent ? c.textOnAccent : c.textMuted,
                fontSize: 10.5,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
