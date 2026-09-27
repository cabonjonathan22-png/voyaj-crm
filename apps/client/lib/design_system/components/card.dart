import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../tokens/colors.dart';
import '../tokens/dimensions.dart';

/// Carte / panneau encadré.
class VCard extends StatelessWidget {
  const VCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(VSpace.x4),
    this.title,
    this.description,
    this.actions,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final String? title;
  final String? description;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    return Container(
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: VRadius.mdAll,
        border: Border.all(color: c.border),
        boxShadow: VShadows.sm(dark: c.isDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                VSpace.x4,
                VSpace.x4,
                VSpace.x4,
                0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title!, style: t.heading),
                        if (description != null) ...[
                          const SizedBox(height: VSpace.x1),
                          Text(description!, style: t.small),
                        ],
                      ],
                    ),
                  ),
                  if (actions != null)
                    Wrap(spacing: VSpace.x2, children: actions!),
                ],
              ),
            ),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

/// Bannière d'information contextuelle.
class VBanner extends StatelessWidget {
  const VBanner({
    super.key,
    required this.message,
    this.tone = VTone.info,
    this.icon,
    this.action,
  });

  final String message;
  final VTone tone;
  final IconData? icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: VSpace.x3,
        vertical: VSpace.x2 + 2,
      ),
      decoration: BoxDecoration(
        color: c.toneBackground(tone),
        borderRadius: VRadius.smAll,
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: c.toneColor(tone)),
            const SizedBox(width: VSpace.x2),
          ],
          Expanded(
            child: Text(
              message,
              style: context.text.body.copyWith(color: c.text),
            ),
          ),
          if (action != null) ...[const SizedBox(width: VSpace.x2), action!],
        ],
      ),
    );
  }
}
