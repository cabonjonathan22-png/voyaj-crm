import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../tokens/dimensions.dart';

/// Ligne « libellé : valeur » d'une fiche (valeur absente : tiret).
class VInfoRow extends StatelessWidget {
  const VInfoRow(
    this.label,
    this.value, {
    super.key,
    this.child,
    this.labelWidth = 150,
  });

  final String label;
  final String? value;

  /// Contenu personnalisé (remplace [value]).
  final Widget? child;
  final double labelWidth;

  @override
  Widget build(BuildContext context) {
    final t = context.text;
    final empty = child == null && (value == null || value!.trim().isEmpty);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: VSpace.x1_5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: labelWidth,
            child: Text(label, style: t.small),
          ),
          Expanded(
            child:
                child ??
                SelectableText(
                  empty ? '—' : value!,
                  style: t.body.copyWith(
                    color: empty ? context.colors.textSubtle : null,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
