import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../tokens/dimensions.dart';

/// En-tête de page : titre, description courte et actions.
class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.actions = const [],
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: VSpace.x5),
      decoration: BoxDecoration(
        color: c.background,
        border: Border(bottom: BorderSide(color: c.border)),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: c.textMuted),
            const SizedBox(width: VSpace.x2 + 2),
          ],
          Text(title, style: t.title),
          if (subtitle != null) ...[
            const SizedBox(width: VSpace.x3),
            // Expanded (et non Flexible + Spacer, qui partageraient l'espace
            // libre) : les actions restent alignées à droite.
            Expanded(
              child: Text(
                subtitle!,
                style: t.small,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ] else
            const Spacer(),
          for (final (i, action) in actions.indexed) ...[
            if (i > 0) const SizedBox(width: VSpace.x2),
            action,
          ],
        ],
      ),
    );
  }
}
