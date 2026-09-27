import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'pressable.dart';

/// Lien textuel (email, téléphone, site web) aligné sur le texte courant.
class VLink extends StatelessWidget {
  const VLink(this.label, {super.key, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Align(
      alignment: Alignment.centerLeft,
      child: Pressable(
        onPressed: onPressed,
        semanticLabel: label,
        builder: (context, s) => Text(
          label,
          style: context.text.body.copyWith(
            color: c.accentText,
            decoration: s.hovered || s.focused
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: c.accentText,
          ),
        ),
      ),
    );
  }
}
