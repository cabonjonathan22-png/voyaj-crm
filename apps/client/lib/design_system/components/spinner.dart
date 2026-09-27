import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Indicateur d'activité compact.
class VSpinner extends StatelessWidget {
  const VSpinner({super.key, this.size = 16, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: CircularProgressIndicator(
      strokeWidth: size / 8,
      strokeCap: StrokeCap.round,
      color: color ?? context.colors.accent,
    ),
  );
}
